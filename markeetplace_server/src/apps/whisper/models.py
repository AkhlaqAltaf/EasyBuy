from django.db import  models


class HostInfo(models.Model):
    host_email= models.CharField(max_length=100)
    password = models.CharField(max_length=100)
