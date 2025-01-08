from django.shortcuts import redirect, render
from django.views import View

from src.apps.whisper.main import Mailing
from src.apps.accounts.forms import CustomLoginForm, UserRegistrationForm
from django.contrib.auth import login , logout
from django.contrib.auth import get_user_model
from django.core.exceptions import SuspiciousOperation
from django.core import signing



def verify_email(request, token):
    try:
        # Attempt to decode the token
        data = signing.loads(token, salt='email-verification', max_age=3600)  # Token expires in 1 hour
        user_id = data.get('user_id')

        # Get the user from the database
        user = get_user_model().objects.get(id=user_id)

        # Mark the user as verified
        user.is_verified = True
        user.save()

        return redirect('core:home')  # Redirect to home page after successful verification

    except signing.SignatureExpired:
        # Token expired
        return render(request, 'accounts/verification_failed.html', {'error': 'Verification link has expired.'})

    except (signing.BadSignature, get_user_model().DoesNotExist):
        # Invalid token or user doesn't exist
        raise SuspiciousOperation("Invalid verification link.")


class LoginView(View):
    def post(self, request):
        form = CustomLoginForm(request.POST)
        if form.is_valid():
            user = form.cleaned_data['user']
            login(request, user)
            return redirect('core:home')
        return render(request, 'accounts/accounts.html', {'signin_form': form})


class UserRegistrationView(View):
    def post(self, request):
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            user = form.save()
            return redirect('accounts:accounts')
        return render(request, 'accounts/accounts.html', {'signup_form': form})
    

class LogoutView(View):
    def get(self, request):
        logout(request)  # Log out the user
        return redirect('core:home')  # Redirect to /the home page or desired URL


class AccountsView(View):
    template_name = 'accounts/accounts.html'
    def get(self,request):
        sigin_form = CustomLoginForm()
        signup_form = UserRegistrationForm()
        return render(request, self.template_name, {'signin_form': sigin_form, 'signup_form': signup_form })
