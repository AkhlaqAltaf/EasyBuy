from django.contrib import messages
from django.contrib.auth import login
from django.contrib.auth.mixins import LoginRequiredMixin
from django.http import JsonResponse, HttpResponseBadRequest
from django.shortcuts import render, redirect, get_object_or_404
# Converting Title into Slug
from django.utils.text import slugify
from django.views import View
from django.views.generic import CreateView

from src.apps.product.forms import MediaForm, ProductForm
from src.apps.product.models import Category, CountryOrigin, Product, SubCategory, Tag, Media, Order
from src.apps.vendor.forms import  VendorForm
from src.apps.vendor.models import Vendor


# Create your views here.


def vendors(request):
    return render(request, 'vendor/vendors.html')


class BecomeVendorView(View):
    template_name = 'vendor/become_vendor.html'

    def get(self, request):
        if request.user.is_authenticated:
            vendor_form = VendorForm()
            return render(request, self.template_name, {'form': vendor_form})
        else:
            return redirect('accounts:login')

    def post(self, request):
        vendor_form = VendorForm(request.POST, request.FILES)

        if vendor_form.is_valid():
            user = request.user
            Vendor.objects.create(
                name=vendor_form.cleaned_data['name'],
                id_card_number=vendor_form.cleaned_data['id_card_number'],
                address=vendor_form.cleaned_data['address'],
                mobile_number=vendor_form.cleaned_data['mobile_number'],
                cr_file=vendor_form.cleaned_data['cr_file'],
                created_by=user,
            )

            login(request, user)
            return redirect('core:home')

        return render(request, self.template_name, {'form': vendor_form})


class CheckVendorMixin:
    """
    Mixin to check if the user is a vendor. Redirect to become-vendor if not.
    """
    def dispatch(self, request, *args, **kwargs):
        if not hasattr(request.user, 'vendor'):
            return redirect('vendor:become-vendor')
        return super().dispatch(request, *args, **kwargs)


class VendorAdminView(LoginRequiredMixin, CheckVendorMixin, View):
    template_name = 'vendor/vendor_admin.html'

    def get(self, request, *args, **kwargs):
        vendor = request.user.vendor
        products = vendor.products.all()
        orders = vendor.orders.all()

        for order in orders:
            order.vendor_amount = 0
            order.vendor_paid_amount = 0
            order.fully_paid = True

            for item in order.items.all():
                if item.vendor == vendor:
                    if item.vendor_paid:
                        order.vendor_paid_amount += item.get_total_price()
                    else:
                        order.vendor_amount += item.get_total_price()
                        order.fully_paid = False

        return render(request, self.template_name, {'vendor': vendor, 'products': products, 'orders': orders})


class EditVendorView(LoginRequiredMixin, CheckVendorMixin, View):
    template_name = 'vendor/edit_vendor.html'

    def get(self, request, *args, **kwargs):
        vendor = request.user.vendor
        return render(request, self.template_name, {'vendor': vendor})

    def post(self, request, *args, **kwargs):
        vendor = request.user.vendor
        name = request.POST.get('name', '')
        email = request.POST.get('email', '')

        if name:
            vendor.created_by.email = email
            vendor.created_by.save()
            vendor.name = name
            vendor.save()
            return redirect('vendor:vendor-admin')

        return render(request, self.template_name, {'vendor': vendor})


class VendorsView(View):
    template_name = 'vendor/vendors.html'

    def get(self, request, *args, **kwargs):
        vendors = Vendor.objects.all()
        return render(request, self.template_name, {'vendors': vendors})


class VendorDetailView(View):
    template_name = 'vendor/vendor.html'

    def get(self, request, vendor_id, *args, **kwargs):
        vendor = get_object_or_404(Vendor, pk=vendor_id)
        return render(request, self.template_name, {'vendor': vendor})
    
    
    
    
class UpdateOrderStatusView(View):
    def post(self, request, order_id):
        try:
            order = Order.objects.get(id=order_id)
        except Order.DoesNotExist:
            return HttpResponseBadRequest("Order does not exist.")

        new_status = request.POST.get('status')
        if new_status not in dict(Order.STATUS_CHOICES):
            return HttpResponseBadRequest("Invalid status.")

        order.status = new_status
        order.save()

        return JsonResponse({'success': True, 'new_status': order.status})
    
    
class AddProductView(CreateView):
    
    def get(self,request):     
        form = ProductForm()

        categories = Category.objects.all()
        origins = CountryOrigin.objects.all()
        return render(request, 'vendor/add_product/addproduct.html', context={"categories": categories, 'origins': origins,'form': form})
    
    def post(self,request):
        form = ProductForm(request.POST)
        if form.is_valid():
            product = form.save(commit=False)
            product.vendor = request.user.vendor
            product.save()
            images = request.FILES.getlist('images')
            if images:               
                for file in images:  
                    media = Media.objects.create(product=product, file=file)

            print("VALIDATED FORM")
            return redirect('core:home')  # Or the appropriate page

        else:
            print("AGAIN PASS FORM ..",form.errors)
            return render(request, 'vendor/add_product/addproduct.html', {'form': form})












class CreateProduct(View):
    # Template for GET request
    def get(self, request, *args, **kwargs):
        categories = Category.objects.all()
        origins = CountryOrigin.objects.all()
        return render(request, "vendor/add_product/addproduct.html", context={"categories": categories, 'origins': origins})

    # Handling POST request to create a product
    def post(self, request, *args, **kwargs):
        data = request.POST
        images = request.FILES.getlist('images')
        
        category_name = data.get("category")
        category_obj = Category.objects.filter(name=category_name).first()
        sub_category_obj = SubCategory.objects.filter(name=data.get("sub_category"), category=category_obj).first()

        # Validation Errors Dictionary
        errors = {}

        # Required fields
        required_fields = ['name', 'price', 'stock_quantity', 'category', 'sub_category', 'description']
        for field in required_fields:
            if not data.get(field):
                errors[field] = f"{field.replace('_', ' ').capitalize()} is required."

        # Validate price
        price = data.get('price')
        if price:
            try:
                price = float(price)
                if price <= 0:
                    errors['price'] = "Price must be greater than 0."
            except ValueError:
                errors['price'] = "Price must be a valid number."

        sku = data.get('sku')
        if Product.objects.filter(sku=sku).exists():
            errors['sku'] = "This SKU is already in use. Please choose a unique SKU."

        # Validate stock_quantity
        stock_quantity = data.get('stock_quantity')
        if stock_quantity:
            try:
                stock_quantity = int(stock_quantity)
                if stock_quantity < 0:
                    errors['stock_quantity'] = "Stock quantity must be 0 or more."
            except ValueError:
                errors['stock_quantity'] = "Stock quantity must be an integer."

        # Validate category
        if not Category.objects.filter(name=category_name).exists():
            errors['category'] = "Invalid category selected."

        # Validate sub_category
        sub_category_name = data.get('sub_category')
        if not SubCategory.objects.filter(name=sub_category_name, category=category_obj).exists():
            errors['sub_category'] = "Invalid subcategory selected for the chosen category."

        # If there are validation errors, return them
        if errors:
            return JsonResponse({'success': False, 'errors': errors}, status=400)

        # Proceed with product creation if no errors
        vendor = Vendor.objects.all().first()
        product = Product.objects.create(
            name=data.get("name"),
            description=data.get("description"),
            category=category_obj,
            sub_category=sub_category_obj,
            price=price,
            discount_price=data.get("discount_price"),
            stock_quantity=stock_quantity,
            sku=data.get("sku"),
            currency=data.get("currency"),
            content=data.get("content"),
            vendor=vendor
        )

        # Handling the uploaded images
        for file in images:
            media = Media.objects.create(product=product, file=file)

        # Handling tags
        if data.get("tags"):
            tag_string = data.get("tags")
            tag_objs = []
            tag_names = tag_string.split(",")
            for tag_name in tag_names:
                tag_obj, created = Tag.objects.get_or_create(name=tag_name)
                tag_objs.append(tag_obj)
            product.tags.set(tag_objs)

        # Handling the country of origin
        if data.get("country_of_origin"):
            origin_name = data.get("country_of_origin")
            origin_obj = CountryOrigin.objects.filter(name=origin_name).first()
            if origin_obj:
                product.country_of_origin.set([origin_obj])

        # Return success message
        return JsonResponse({'success': True, 'message': 'Product created successfully!'})
           
class GetSubCategory(View):
    def get(self, request, category):
        category_obj = Category.objects.filter(name=category).first()
        if not category_obj:
            return JsonResponse({"error": "Category not found"}, status=404)
        sub_categories = SubCategory.objects.filter(category=category_obj)
        # Simplify the response to include only id and name
        data = [{"id": sub.pk, "name": sub.name} for sub in sub_categories]

        return JsonResponse({"subcategories": data})
def addProductTest(request):
    return render(request,template_name="vendor/add_product/addproduct.html")



def Register(request):
    return render(request, 'vendor/registration/registration2.html')


def home(request):
    if request.user.is_authenticated and request.user.vendor:
       return render(request, 'vendor/Analytics.html')
    else:
        messages.error("Please Login As Vendor Or Contact With Admin")
        return redirect('login')
def storeAnalytics(request):
    return render(request, 'vendor/Analytics.html')
def OrderList(request):
    return render(request, 'vendor/order/orderlist.html')
def OrderDetails(request):
    return render(request, 'vendor/order/orderdetail.html')
def OrderStatus(request):
    return render(request, 'vendor/order/Status.html')
def InvoiceList(request):
    return render(request, 'vendor/invoice/invoicelist.html')
def InvoiceDetails(request):
    return render(request, 'vendor/invoice/invoicedetail.html')
def Calender(request):
    return render(request, 'vendor/calendar.html')
def ProductAdd(request):
    return render(request, 'vendor/products/createproduct.html')
def ProductList(request):
    return render(request, 'vendor/products/productlist.html')
def Account(request):
    return render(request, 'vendor/Account/base.html')
def General(request):
    return render(request, 'vendor/Account/General.html')
def Billing(request):
    return render(request, 'vendor/Account/Billing.html')
def Team(request):
    return render(request, 'vendor/Account/Team.html')
def Notification(request):
    return render(request, 'vendor/Account/Notifications.html')
def Secuirity(request):
    return render(request, 'vendor/Account/Secuirity.html')
def CustomerList(request):
    return render(request, 'vendor/customers/customerlist.html')
def CustomerDetails(request):
    return render(request, 'vendor/customers/customerdetail.html')


from django.contrib.auth.decorators import login_required

@login_required
def add_product(request):
    if request.method == 'POST':
        form = ProductForm(request.POST, request.FILES)

        if form.is_valid():
            product = form.save(commit=False) # Because we have not given vendor yet
            product.vendor = request.user.vendor
            product.slug = slugify(product.title)
            product.save() #finally save

            return redirect('vendor:vendor-admin')

    else:
        form = ProductForm

    return render(request, 'vendor/add_product.html', {'form': form})

from django.shortcuts import render, redirect
from django.views import View
from django.http import JsonResponse, HttpResponseBadRequest
from src.apps.product.models import Order, OrderItem, Product
from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import render
from django.views import View

class RemoveProductView(View):
    def post(self, request, product_id):
        # Get the product or return a 404 if it doesn't exist
        product = get_object_or_404(Product, id=product_id, vendor=request.user.vendor)
        # Delete the product
        product.delete()
        # Add a success message
        messages.success(request, 'Product removed successfully.')

        # Redirect to the product list page
        return redirect('vendor:vendor_product_list')
class VendorProductListView(View):
    def get(self, request):
        # Get products associated with the current vendor
        products = Product.objects.filter(vendor=request.user.vendor)
        print("PRODUCTS",products)
        return render(request, 'vendor/products/productlist.html', {'products': products})
# class EditProductView(View):
#     def get(self, request, product_id):
#         product = get_object_or_404(Product, id=product_id)
#         form = ProductForm(instance=product)
#         return render(request, 'vendor/products/edit_product.html', {'form': form})
#
#     def post(self, request, product_id):
#         product = get_object_or_404(Product, id=product_id)
#         form = ProductForm(request.POST, instance=product)
#
#         if form.is_valid():
#             form.save()
#             return redirect('vendor_product_list')
#         else:
#             return render(request, 'vendor/products/edit_product.html', {'form': form})
#
class OrderListView(LoginRequiredMixin, View):
    def get(self, request):
        # Get all products for the vendor
        vendor_products = Product.objects.filter(vendor=request.user.vendor)  # Assuming the user has a related Vendor
        # Get all orders that contain the vendor's products
        orders = Order.objects.filter(products__in=vendor_products).distinct()
        print("ORDERS ,",orders)

        return render(request, 'vendor/order/orderlist.html', {'orders': orders})

class OrderFilterView(LoginRequiredMixin, View):
    def get(self, request, status):
        # Get all products for the vendor
        vendor_products = Product.objects.filter(vendor=request.user.vendor)  # Assuming the user has a related Vendor
        # Filter orders based on status
        if status == 'ALL':
            orders = Order.objects.filter(products__in=vendor_products).distinct()
        else:
            orders = Order.objects.filter(products__in=vendor_products, status=status.lower()).distinct()
        return render(request, 'vendor/order/orderlist.html', {'orders': orders})

class UpdateOrderStatusView(LoginRequiredMixin, View):
    def post(self, request, order_id):
        new_status = request.POST.get('status')
        try:
            order = Order.objects.get(id=order_id)
            # Check if the order contains products from the vendor
            vendor_products = Product.objects.filter(vendor=request.user.vendor)
            if not order.products.filter(id__in=vendor_products).exists():
                messages.error(request, 'Product not found')
                return HttpResponseBadRequest("You do not have permission to update this order.")

            order.status = new_status
            order.save()
            messages.success(request, 'Your order has been updated.')
            return redirect('vendor:orders')
        except Order.DoesNotExist:
            messages.success(request, 'Your order does not exist.')
            return redirect("vendor:orders")





# CREATING 3d MODEL


import requests
import base64
from django.shortcuts import render, redirect
from django.http import HttpResponse
from .models import ThreeDModel
from datetime import datetime, timedelta

def list_models(request):
    models = ThreeDModel.objects.all()
    return render(request, 'vendor/3d/list_models.html', {'models': models})

def create_model(request):
    if request.method == 'POST':
        image = request.FILES['image']
        model = ThreeDModel(image=image)
        model.save()

        API_KEY = "msy_UHB6LVZqUdTmETLWZXlqNQ6tv9fF5ydQkrvP"
        API_URL = "https://api.meshy.ai/openapi/v1/image-to-3d"
        headers = {
            "Authorization": f"Bearer {API_KEY}"
        }

        with open(model.image.path, "rb") as image_file:
            base64_image = f"data:image/jpeg;base64,{base64.b64encode(image_file.read()).decode('utf-8')}"

        payload = {
            "image_url": base64_image,
            "enable_pbr": True,
            "should_remesh": True,
            "should_texture": True
        }

        response = requests.post(API_URL, headers=headers, json=payload)
        response.raise_for_status()
        response_data = response.json()
        print("response",response_data)
        model.task_id = response_data['result']
        model.save()

        return redirect('vendor:list_models')
    return render(request, 'vendor/3d/create_model.html')
from django.utils import timezone

def download_model(request, pk):
    model = ThreeDModel.objects.get(pk=pk)
    if model.downloaded or (timezone.now() - model.created_at).total_seconds() / 60 < 10:
        return HttpResponse("You can't download this model yet.")
    else:
        API_KEY = "msy_UHB6LVZqUdTmETLWZXlqNQ6tv9fF5ydQkrvP"
        API_URL = f"https://api.meshy.ai/openapi/v1/image-to-3d/{model.task_id}"
        headers = {
            "Authorization": f"Bearer {API_KEY}"
        }

        response = requests.get(API_URL, headers=headers)
        response.raise_for_status()
        response_data = response.json()

        preview_model_url = response_data["model_urls"]["glb"]
        preview_model_response = requests.get(preview_model_url)
        preview_model_response.raise_for_status()

        model.downloaded = True
        model.save()
        messages.success(request, "Model downloaded successfully.")

        response = HttpResponse(preview_model_response.content, content_type='model/gltf-binary')
        response['Content-Disposition'] = 'attachment; filename="model.glb"'
        return response