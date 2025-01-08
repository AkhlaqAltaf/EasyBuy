from django.core.mail import send_mail
from django.template.loader import render_to_string
from django.utils.html import strip_tags

from marketplace_server import settings
from src.apps.whisper.models import HostInfo


class Mailing:
    def __init__(self):
        self.host =HostInfo.objects.last()

        self.host_email =settings.EMAIL_HOST_USER

    def send_email_to_admin(self,subject,message,from_mail):
        subject = subject
        html_message = render_to_string("mails/toadmin.html", {'message': message,'email':from_mail,'subject':subject})
        plain_message = strip_tags(html_message)
        from_email = self.host_email
        to = [self.host_email]
        send_mail(subject, plain_message, from_email, to, html_message=html_message)





    def send_email(self,template,to_email,context):

        subject = 'Verify your email'
        html_message = render_to_string(template, context)
        plain_message = strip_tags(html_message)
        from_email = self.host_email
        to = to_email
        send_mail(subject, plain_message, from_email, to, html_message=html_message)

    def send_verification_code(self, template, to_email,code):
        subject = 'Verify your email'
        html_message = render_to_string(template, {'verification_code': code})
        plain_message = strip_tags(html_message)
        from_email = self.host_email
        to = to_email
        send_mail(subject, plain_message, from_email, to, html_message=html_message)


