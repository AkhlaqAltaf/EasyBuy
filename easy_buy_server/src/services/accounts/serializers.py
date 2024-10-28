from django.contrib.auth import get_user_model
from src.services.accounts.models import CustomUser
from src.apps.whisper.main import Mailing
from dj_rest_auth.serializers import LoginSerializer as DefaultLoginSerializer
from django.utils.translation import gettext_lazy as _
from rest_framework import serializers

User = get_user_model()


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'email', 'password')
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        user = CustomUser.objects.create_user(
            email=validated_data['email'],
            password=validated_data['password']
        )
        code = user.verification_code
        mail = Mailing()
        mail.send_verification_code(to_email=[user.email],template="mails/verification_email.html",code=code)

        return user




class VerifyEmailSerializer(serializers.Serializer):
    email = serializers.EmailField()
    verification_code = serializers.CharField(max_length=4)

    def validate(self, data):
        email = data.get('email')
        code = data.get('verification_code')
        try:
            user = User.objects.get(email=email)
        except User.DoesNotExist:
            raise serializers.ValidationError("Invalid email address")

        if user.verification_code != code:
            raise serializers.ValidationError("Invalid verification code")

        return data

    def save(self):
        email = self.validated_data.get('email')
        user = User.objects.get(email=email)
        user.is_verified = True
        user.verification_code = ''
        user.save()
        return user






class CustomLoginSerializer(DefaultLoginSerializer):
    def validate(self, attrs):
        email = attrs.get('email')
        password = attrs.get('password')

        if email and password:
            user = self.authenticate(email=email, password=password)
            if user:
                # Skip the allauth email verification check
                if not user.is_active:
                    msg = _('User account is disabled.')
                    raise serializers.ValidationError(msg)
                elif not user.is_verified:
                    msg = _('User Email is Not Verified.')
                    raise serializers.ValidationError(msg)

            else:
                msg = _('Unable to log in with provided credentials.')
                raise serializers.ValidationError(msg)
        else:
            msg = _('Must include "email" and "password".')
            raise serializers.ValidationError(msg)

        attrs['user'] = user
        return attrs

    def authenticate(self, **kwargs):
        from django.contrib.auth import authenticate
        return authenticate(**kwargs)








