from django import forms

from src.apps.product.models import Product, Media, SubCategory
from ckeditor.widgets import CKEditorWidget


# class AddToCartForm(forms.Form):
#     quantity = forms.IntegerField()


class MediaForm(forms.ModelForm):
    class Meta:
        model = Media
        fields = ['product','file']

class ProductForm(forms.ModelForm):
    # media = MediaForm()
    class Meta:
        model = Product
        fields = [
            'name', 'description', 'category', 'sub_category', 'tags',
            'price', 'discount_price', 'stock_quantity', 'sku', 'currency',
             'country_of_origin', 'content'
        ]
        widgets = {
            'description': forms.Textarea(attrs={'rows': 3}),
            'content': CKEditorWidget(attrs={'rows': 5}),  # Use CKEditorWidget for RichTextField
            'tags': forms.SelectMultiple(attrs={'class': 'form-control'}),
            'category': forms.Select(attrs={'class': 'form-control'}),
            'sub_category': forms.Select(attrs={'class': 'form-control'}),
        }
        help_texts = {
            'tags': 'Select multiple tags if applicable.',
            'country_of_origin': 'Select all applicable countries.',
        }


# Media Form (handling multiple files without ClearableFileInput)


# SubCategory Form (for inline creation)
class SubCategoryForm(forms.ModelForm):
    class Meta:
        model = SubCategory
        fields = ['name', 'category', 'image']
        widgets = {
            'name': forms.TextInput(attrs={'placeholder': 'Sub-category name'}),
            'category': forms.Select(attrs={'class': 'form-control'}),
        }
