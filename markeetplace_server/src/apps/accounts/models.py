# accounts/models.py

import random
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager
from django.db import models

from src.apps.whisper.main import Mailing
from django.core import signing


class CustomUserManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        if not email:
            raise ValueError('The Email field must be set')
        email = self.normalize_email(email)

        # Delete existing unverified user with the same email
        try:
            existing_user = self.get(email=email)
            if not existing_user.is_verified:
                existing_user.delete()
            if existing_user.is_verified:
                return {'user':existing_user,'status_code':600,'message':"Email Already Registered"}


        except CustomUser.DoesNotExist:
            pass

        user = self.model(email=email, **extra_fields)
        user.verification_code = self.generate_verification_code()
        user.set_password(password)
        user.save(using=self._db)

        token = self.generate_verification_token(user)
        self.send_verification_email(user, token)



        return  user
    
    def send_verification_email(self, user, token):
        """
        Sends a verification email with a link that contains the token
        """
        verification_link = f"https://8601-2400-adcc-913-1e00-3854-5cfa-f276-68f4.ngrok-free.app/accounts/verify/{token}/"
        context = {'user': user, 'verification_link': verification_link}

        # You would send the email here (using your mailing logic)
        mail = Mailing()
        mail.send_email(template="mails/verification_email.html", to_email=[user.email], context=context)



    def generate_verification_token(self, user):
        """
        Generates a token for email verification using Django's signing module
        """
        return signing.dumps({'user_id': user.id}, salt='email-verification')

    def create_superuser(self, email, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superuser must have is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')

        return self.create_user(email, password, **extra_fields)

    def get_by_natural_key(self, email):
        return self.get(email=email)

    def generate_verification_code(self):
        while True:
            code = '{:04d}'.format(random.randint(0, 9999))
            if not CustomUser.objects.filter(verification_code=code).exists():
                return code


class CustomUser(AbstractBaseUser):
    name  = models.CharField(max_length=50,blank=True,null=True)
    phone = models.IntegerField(blank=True,null=True)
    email = models.EmailField(unique=True)
    verification_code = models.CharField(max_length=32, unique=False, blank=True, null=True)
    is_verified = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    date_joined = models.DateTimeField(auto_now_add=True)
    objects = CustomUserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    def __str__(self):
        return self.email

    def has_perm(self, perm, obj=None):
        return self.is_superuser

    def has_module_perms(self, app_label):
        return self.is_superuser
