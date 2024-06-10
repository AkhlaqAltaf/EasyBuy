from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.urls import reverse
from django.views import View
from django.views.generic import TemplateView ,RedirectView

from src.apps.whisper.main import Mailing


class HomeView(TemplateView):
    template_name = "website/home.html"



class AboutUsView(TemplateView):
    template_name = "website/aboutus.html"


class ApiDocView(TemplateView):
    template_name = "website/apidoc.html"


class ContactUsView(View):
    def get(self, request):
        return render(request, 'website/contactus.html')

    def post(self, request):
        subject = request.POST.get('subject', '')
        email = request.POST.get('email', '')
        message = request.POST.get('message', '')

        mail = Mailing()
        mail.send_email_to_admin(
            subject=subject,from_mail=email , message=message
        )

        return HttpResponseRedirect(reverse('website:contactus'))



class ApiReverse(View):
    def get(self,request):
        return reverse('api:api/')