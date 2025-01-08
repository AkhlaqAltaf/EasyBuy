from django.core import signing
from django.core.exceptions import ObjectDoesNotExist
from rest_framework import viewsets
from rest_framework.decorators import action

from src.apps.accounts.models import CustomUser
from .serializers import CustomUserSerializer, CustomUserCreationSerializer
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from .serializers import LoginSerializer

class CustomUserViewSet(viewsets.ModelViewSet):
    queryset = CustomUser.objects.all()
    serializer_class = CustomUserSerializer

    def get_serializer_class(self):
        if self.action == 'create':
            return CustomUserCreationSerializer
        return super().get_serializer_class()

    @action(detail=False, methods=['post'], url_path='verify/(?P<token>.+)')
    def verify_email(self, request, token=None):
        try:
            data = signing.loads(token, salt='email-verification')
            user_id = data.get('user_id')
            user = CustomUser.objects.get(id=user_id)
            user.is_verified = True
            user.save()
            return Response({"message": "Email verified successfully!"})
        except signing.SignatureExpired:
            return Response({"message": "The verification link has expired."}, status=400)
        except ObjectDoesNotExist:
            return Response({"message": "User not found."}, status=400)

    @action(detail=False, methods=['post'], url_path='resend-verification')
    def resend_verification(self, request):
        email = request.data.get('email')
        try:
            user = CustomUser.objects.get(email=email)
            if user.is_verified:
                return Response({"message": "Email is already verified."})
            token = user.generate_verification_token(user)
            user.send_verification_email(user, token)
            return Response({"message": "Verification email resent."})
        except ObjectDoesNotExist:
            return Response({"message": "User with the provided email not found."}, status=400)


class LoginView(APIView):
    """
    User login view for authentication and returning token.
    """

    def post(self, request, *args, **kwargs):
        # Pass the request data to the LoginSerializer
        serializer = LoginSerializer(data=request.data)

        # Validate the data using the serializer
        if serializer.is_valid():
            return Response({
                'token': serializer.validated_data['token'],
                'user': {
                    'id': serializer.validated_data['user'].id,
                    'email': serializer.validated_data['user'].email,
                    'name': serializer.validated_data['user'].name,
                    'phone': serializer.validated_data['user'].phone,
                }
            }, status=status.HTTP_200_OK)

        # If serializer is invalid, return errors
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class LogoutView(APIView):
    """
    User logout view to delete the user's token.
    """
    def post(self, request, *args, **kwargs):
        try:
            # Get the token from the request header
            token = request.auth
            if token:
                token.delete()
                return Response({"message": "Successfully logged out."}, status=status.HTTP_200_OK)
            return Response({"error": "No token provided."}, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
