# Generated by Django 4.2.13 on 2024-06-27 20:36

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customuser',
            name='verification_code',
            field=models.CharField(blank=True, max_length=32, null=True),
        ),
    ]
