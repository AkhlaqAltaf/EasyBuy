from django.db import models
from django.db.models.fields.related import OneToOneField

from marketplace_server import settings

# Create your models here.

# class Vendor(models.Model):
#     name = models.CharField(max_length=255)
#     created_at = models.DateTimeField(auto_now_add=True)
#     created_by = models.OneToOneField(settings.AUTH_USER_MODEL, related_name='vendor', on_delete=models.CASCADE)

#     class Meta:
#         ordering = ['name']
    
#     def __str__(self):
#         return self.name

#     def get_balance(self):
#         items = self.items.filter(vendor_paid=False, order__vendors__in=[self.id])
#         return sum((item_card.product.price * item_card.quantity) for item_card in items)

#     def get_paid_amount(self):
#         items = self.items.filter(vendor_paid=True, order__vendors__in=[self.id])
#         return sum((item_card.product.price * item_card.quantity) for item_card in items)




def upload_to_cr(instance, filename):
    return f'vendor_files/{instance.id_card_number}/{filename}'

class Vendor(models.Model):
    name = models.CharField(max_length=255)
    cr_file = models.FileField(upload_to=upload_to_cr,blank=True,null=True)  # File upload for CR
    id_card_number = models.CharField(max_length=20, unique=True)
    address = models.TextField()
    mobile_number = models.CharField(max_length=15)
    created_by = models.OneToOneField(
        settings.AUTH_USER_MODEL, 
        related_name='vendor', 
        on_delete=models.CASCADE
    )
    verification_status = models.BooleanField(default=False) 
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['name']

    def __str__(self):
        return self.name

    
    def __str__(self):
        return self.name

    def get_balance(self):
        items = self.items.filter(vendor_paid=False, order__vendors__in=[self.id])
        return sum((item.product.price * item.quantity) for item in items)

    def get_paid_amount(self):
        items = self.items.filter(vendor_paid=True, order__vendors__in=[self.id])
        return sum((item.product.price * item.quantity) for item in items)


class ThreeDModel(models.Model):
    image = models.ImageField(upload_to='images/')
    task_id = models.CharField(max_length=255, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    downloaded = models.BooleanField(default=False)

    def __str__(self):
        return f"3D Model {self.id}"