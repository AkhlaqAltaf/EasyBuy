from dj_rest_auth.serializers import LoginSerializer
from dj_rest_auth.views import LoginView
from rest_framework import permissions, generics, status
from rest_framework.authtoken.models import Token
from rest_framework.generics import RetrieveUpdateAPIView
from rest_framework.response import Response

from src.services.accounts.serializers import UserSerializer, VerifyEmailSerializer, CustomLoginSerializer
from ...services.accounts.models import CustomUser
from ...apps.whisper.main import Mailing


class CustomLoginView(LoginView):
    serializer_class = CustomLoginSerializer

    def finalize_response(self, request, response, *args, **kwargs):
        response = super().finalize_response(request, response, *args, **kwargs)
        if request.user.is_authenticated:
            user = request.user
            Token.objects.filter(user=user).delete()

            new_token = Token.objects.create(user=user)
            response.data['email']=user.email
            response.data['key'] = new_token.key
        return response


class UserRetrieveChangeAPIView(RetrieveUpdateAPIView):
    serializer_class = UserSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_object(self):
        return self.request.user


from .serializers import UserSerializer
from django.contrib.auth import get_user_model

User = get_user_model()

class UserCreateView(generics.CreateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer

    def create(self, request, *args, **kwargs):
        email = request.data.get('email')
        password = request.data.get('password')

        # Attempt to create the user
        data = CustomUser.objects.create_user(email=email, password=password)
        if data.get('status_code')==600:

            return Response(data.get('message'), status=500)

        elif data.get('status_code')==700:
                user = data.get('user')
                serializer = self.get_serializer(user)
                code = user.verification_code
                mail = Mailing()
                mail.send_verification_code(to_email=[user.email], template="mails/verification_email.html", code=code)

                return Response(serializer.data, status=status.HTTP_201_CREATED)




class VerifyEmailView(generics.GenericAPIView):
    serializer_class = VerifyEmailSerializer
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({"message": "Email successfully verified"}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)







# class CustomLoginView(LoginView):
#     serializer_class = CustomLoginSerializer
