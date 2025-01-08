from django.shortcuts import render
from django.views.generic import TemplateView

from src.apps.product.models import Category, Product, Media, TopPageProduct


# Create your views here.



class FrontPageView(TemplateView):
    template_name = "home/home.html"
    def get(self,request):

        products = Product.objects.all()[0:6]

        categories = Category.objects.all()[0:8]
        top_sale = TopPageProduct.objects.filter(order=1).first()
        print(top_sale)
        top_sale2 = TopPageProduct.objects.filter(order=2).first()
        top_sale3 = TopPageProduct.objects.filter(order=3).first()
        top_sale4 = TopPageProduct.objects.filter(order=4).first()
        top_sale5 = TopPageProduct.objects.filter(order=5).first()
        top_sale6 = TopPageProduct.objects.filter(order=6).first()
        top_sale7 = TopPageProduct.objects.filter(order=6).first()
        context = {
            'products': products,
            'categories': categories,
            'top_sale': top_sale.product if top_sale else None,
            'top_sale2': top_sale2.product if top_sale2 else None,
            'top_sale3': top_sale3.product if top_sale3 else None,
            'top_sale4': top_sale4.product if top_sale4 else None,
            'top_sale5': top_sale5.product if top_sale5 else None,
            'top_sale6': top_sale6.product if top_sale6 else None,
            'top_sale7': top_sale7.product if top_sale7 else None,

        }

        return render(request, self.template_name, context)


def frontpage(request):
    newest_products = Product.objects.all()[0:8]
    categories = Category.objects.all()[0:8]

    context = {
        'newest_products': newest_products,
        'categories':categories
    }
    return render(request, 'home/home.html', context)


def contactpage(request):
    return render(request, 'core/contact.html')