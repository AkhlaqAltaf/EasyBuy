from symtable import Class

from django.contrib import messages
from django.views import View
from django.views.generic import ListView, CreateView, UpdateView, DeleteView, DetailView
from django.urls import reverse_lazy
from django.shortcuts import get_object_or_404, redirect, render
from django.http import JsonResponse, HttpResponseBadRequest

from ..cart import cart
from ..cart.cart import Cart
from ..vendor.models import Vendor

from .models import Category, CountryOrigin, Product, Media, SubCategory, Tag, WishListProduct, Order, OrderItem
from .forms import ProductForm, SubCategoryForm
from django.db.models import Q

# List View for Products
class ProductListView(ListView):
    model = Product
    template_name = "products/product_list.html"
    context_object_name = "products"

class ProductCreateView(CreateView):
    model = Product
    form_class = ProductForm
    template_name = "products/product_form.html"
    success_url = reverse_lazy('product_list')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        # context['media_form'] = MediaForm()  # Add the MediaForm to the context
        return context

    def form_valid(self, form):
        response = super().form_valid(form)

        # Handle multiple file uploads
        # media_form = MediaForm(self.request.POST, self.request.FILES)
        # if media_form.is_valid():
        #     files = self.request.FILES.getlist('files')  # Get the list of files
        #     for file in files:
        #         Media.objects.create(product=self.object, file=file)  # Save each file

        return response

# Product Update View
class ProductUpdateView(UpdateView):
    model = Product
    form_class = ProductForm
    template_name = "products/product_form.html"
    success_url = reverse_lazy('product_list')

# Product Delete View
class ProductDeleteView(DeleteView):
    model = Product
    template_name = "products/product_confirm_delete.html"
    success_url = reverse_lazy('product_list')

# Product Detail View

class ProductDetailView(DetailView):
    model = Product
    template_name = "products/product_detail/product_detail.html"
    context_object_name = "product"

    def get_context_data(self, **kwargs):
        # Get the context from the superclass
        context = super().get_context_data(**kwargs)

        # Serialize all products to JSON format
        products = Product.objects.all()
        print(len(products))
        products_json = serialize('json', products)

        product = self.get_object()
        reviews = product.reviews.all()  # Assuming a related name `reviews` for the Product-Review relationship
        total_reviews = reviews.count()

        # Calculate rating percentages
        rating_distribution = {rating: 0 for rating in range(1, 6)}  # Initialize for ratings 1 to 5

        for review in reviews:
            print("REVIEW : ",review.rating)
            rating_distribution[review.rating] += 1  # Assuming `rating` is an attribute of Review

        rating_percentages = {
            rating: (count / total_reviews) * 100 if total_reviews > 0 else 0
            for rating, count in rating_distribution.items()
        }
        print(rating_percentages)
        # Add data to context
        context['rating_percentages'] = rating_percentages
        context['total_reviews'] = total_reviews
        # Add the JSON data to the context
        context['products'] = products_json
        return context

# SubCategory Inline Creation View (AJAX)
def create_subcategory(request):
    if request.method == "POST":
        form = SubCategoryForm(request.POST, request.FILES)
        if form.is_valid():
            subcategory = form.save()
            return JsonResponse({'id': subcategory.id, 'name': subcategory.name}, status=201)
        else:
            return JsonResponse({'errors': form.errors}, status=400)
    return JsonResponse({'error': 'Invalid request'}, status=400)





class CreateProduct(CreateView):
    def get(self, request, *args, **kwargs):
        
        categories = Category.objects.all()
        origins = CountryOrigin.objects.all()
        
        
        return render(request,template_name="vendor/add_product/addproduct.html",context={"categories":categories,'origins':origins})
    def post(self, request, *args, **kwargs):
        product = Product.objects.filter(name="cage").first()
        if product:
            print(product.tags.all())   
        else:
            print("Product not found")
        data = request.POST
        category_name = data.get("category")
        category_obj = Category.objects.filter(name=category_name).first()
        sub_category_obj = SubCategory.objects.filter(name=data.get("sub_category"), category=category_obj).first()
        # Validation Errors Dictionary
        
        errors = {}

        # Required fields
        required_fields = [
            'name', 'price', 'stock_quantity', 'category', 'sub_category', 'description'
        ]

        # Check for missing fields
        for field in required_fields:
            if not data.get(field):
                errors[field] = f"{field.replace('_', ' ').capitalize()} is required."

        # Validate price (must be a positive number)
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
        # Validate stock_quantity (must be an integer)
        stock_quantity = data.get('stock_quantity')
        if stock_quantity:
            try:
                stock_quantity = int(stock_quantity)
                if stock_quantity < 0:
                    errors['stock_quantity'] = "Stock quantity must be 0 or more."
            except ValueError:
                errors['stock_quantity'] = "Stock quantity must be an integer."

        # Validate category (must exist)
        if not Category.objects.filter(name=category_name).exists():
            errors['category'] = "Invalid category selected."

        # Validate sub_category (must exist in the selected category)
        sub_category_name = data.get('sub_category')
        if not SubCategory.objects.filter(name=sub_category_name, category=category_obj).exists():
            errors['sub_category'] = "Invalid subcategory selected for the chosen category."

        # Check if there are validation errors
        if errors:
            return JsonResponse({'success': False, 'errors': errors}, status=400)

        # If data is valid, proceed with database insertion
        vendor = Vendor.objects.all().first()
        # Create the product
        product = Product.objects.create(
        name=data.get("name"),
        description=data.get("description"),
        category=category_obj,  # Make sure to use the category object, not just the name
        sub_category=sub_category_obj,  # You can get the subcategory object
        price=price,  # Ensure price is a float or None if validation passed
        discount_price=data.get("discount_price"),
        stock_quantity=stock_quantity,  # Ensure stock_quantity is an integer
        sku=data.get("sku"),
        currency=data.get("currency"),
        content=data.get("content"),
        vendor = vendor
        )
        
        if data.get("tags"):
         tag_string = data.get("tags")  # Assume this is an array of tag names
         tag_objs = []  # List to store Tag objects
         tag_names = tag_string.split(",")

        for tag_name in tag_names:         
        #  print(tag_name)
        # Check if the tag exists, otherwise create a new one
         tag_obj, created = Tag.objects.get_or_create(name=tag_name)
        # Append the tag object to the list
         tag_objs.append(tag_obj)

        # Set the tags for the product
        if tag_objs:
            product.tags.set(tag_objs)

        if data.get("country_of_origin"):
            origin_name = data.get("country_of_origin")  # Assuming country is passed as a single country name
            origin_obj = CountryOrigin.objects.filter(name=origin_name).first()  # Get the country object by name
        if origin_obj:
            product.country_of_origin.set([origin_obj]) 
        
        # # Assign the vendor after product creation
        # # product.vendor = vendor  # Ensure vendor is a valid Vendor object

        # # Assign tags and country_of_origin if available
        # if data.get("tags"):
       
        # if data.get("country_of_origin"):


        # Return success message
        return JsonResponse({'success': True, 'message': 'Product created successfully!'})
    
from django.core.serializers import serialize

        
class GetSubCategory(View):
    def get(self, request, category):
        category_obj = Category.objects.filter(name=category).first()
        if not category_obj:
            return JsonResponse({"error": "Category not found"}, status=404)

        sub_categories = SubCategory.objects.filter(category=category_obj)
        # Simplify the response to include only id and name
        data = [{"id": sub.pk, "name": sub.name} for sub in sub_categories]

        return JsonResponse({"subcategories": data})



class ProductDetail3DView(DetailView):
    model = Product
    template_name = "products/product_detail/3d_model.html"
    context_object_name = "product"

    def get_context_data(self, **kwargs):
        # Get the context from the superclass
        context = super().get_context_data(**kwargs)

        # Serialize all products to JSON format
        products = Product.objects.all()
        print(len(products))
        products_json = serialize('json', products)

        product = self.get_object()
        reviews = product.reviews.all()  # Assuming a related name `reviews` for the Product-Review relationship
        total_reviews = reviews.count()

        # Calculate rating percentages
        rating_distribution = {rating: 0 for rating in range(1, 6)}  # Initialize for ratings 1 to 5

        for review in reviews:
            print("REVIEW : ",review.rating)
            rating_distribution[review.rating] += 1  # Assuming `rating` is an attribute of Review

        rating_percentages = {
            rating: (count / total_reviews) * 100 if total_reviews > 0 else 0
            for rating, count in rating_distribution.items()
        }
        print(rating_percentages)
        # Add data to context
        context['rating_percentages'] = rating_percentages
        context['total_reviews'] = total_reviews
        # Add the JSON data to the context
        context['products'] = products_json
        return context



class AddToCartView(View):

    def get(self, request,id):
        pass
    def post(self, request, id,quantity):
        product = get_object_or_404(Product, id=id)
        print(product)

        cart = Cart(request)
        cart.add(product_id=product.id, quantity=quantity, update_quantity=False)
        return  JsonResponse({'success': True})




class AllProductsView(View):
    def get(self, request):
        products = Product.objects.all()
        context = {'products': products}
        return render(request, "products/all_products.html", context)

class CategoryProductsView(View):
    def get(self, request,id):
        category = get_object_or_404(Category, id=id)
        products = Product.objects.filter(category=category)
        context = {'products': products}
        return render(request, "products/all_products.html", context)


def search(request):
    query = request.GET.get('query', '') # second is default parameter which is empty
    products = Product.objects.filter(Q(title__icontains=query) | Q(description__icontains=query))

    return render(request, 'product/search.html', {'products':products, 'query': query})


class WishListProductsCreateView(View):
    def post(self, request, id):
        user = request.user
        # Get the product object
        try:
            product = Product.objects.get(id=id)
        except Product.DoesNotExist:
            return HttpResponseBadRequest("Product does not exist.")

        # Check if the product is already in the user's wishlist
        if not WishListProduct.objects.filter(user=user, products=product).exists():
            # If not, create a new wishlist entry
            wishlist, created = WishListProduct.objects.get_or_create(user=user)
            wishlist.products.add(product)  # Add the product to the wishlist
        messages.success(request, "Your action was successful!")

        # Return a success response
        return JsonResponse({'success': True})

class WishListProductsView(View):
    def get(self,request):
        user = request.user
        wishlists = WishListProduct.objects.filter(user=user)
        products = [wishlist.products.all() for wishlist in wishlists]
        print(products[0])
        context = {'products':products[0]}

        return render(request,'products/wishlist/wishlist.html',context)

from django.contrib.auth.mixins import LoginRequiredMixin

class RemoveFromWishlistView(LoginRequiredMixin, View):
    def post(self, request, product_id):
        wishlist = get_object_or_404(WishListProduct, user=request.user)
        product = get_object_or_404(Product, id=product_id)

        # Remove the product from the wishlist
        wishlist.products.remove(product)
        messages.success(request, "Your action was successful!")
        return redirect('product:wishlist')


class PlaceOrderView(View):
    def post(self, request):
        cart = Cart(request)  # Initialize the cart
        user = request.user
        address = request.POST.get('addressInput')
        street = request.POST.get('street')
        city = request.POST.get('city')
        country = request.POST.get('country')
        postal_code = request.POST.get('postalCode')
        payment_method = request.POST.get('payment_method')  # Assuming you have a way to get this

        # Validate the input
        if not all([address, street, city, country, postal_code, payment_method]):
            return HttpResponseBadRequest("All fields are required.")

        # Create the order
        order = Order.objects.create(
            user=user,
            address=address,
            city=city,
            country=country,
            postal_code=postal_code,
            payment_method=payment_method
        )
        order.save()
        print("ORDER SAVED...........")
        # Process each item in the cart
        for product_id, item in cart.cart.items():
            quantity = item['quantity']  # Get the quantity from the cart

            try:
                product = Product.objects.get(id=product_id)  # Get the product
                if product.stock_quantity < quantity:
                    return HttpResponseBadRequest(f"Not enough stock for product ID {product_id}. Available: {product.stock_quantity}")

                # Create order item
                order_item = OrderItem.objects.create(order=order, product=product, quantity=quantity)
                order_item.save()
                print("ORDER SAVED.......")
                # Update the stock quantity
                product.stock_quantity -= quantity
                product.save()  # Save the updated product

            except Product.DoesNotExist:
                return HttpResponseBadRequest(f"Product with ID {product_id} does not exist.")

        # Clear the cart after placing the order
        cart.clear()  # Use the clear method from the Cart class
        messages.success(request, "Your order was successful!")
        return redirect('/')

class OrderDetailView(View):
    def get(self, request, order_id):
        try:
            order = Order.objects.get(id=order_id, user=request.user)
        except Order.DoesNotExist:
            messages.error(request, "Order does not exist.")
            return HttpResponseBadRequest("Order does not exist or you do not have permission to view it.")

        # Render a template with order details
        return render(request, 'order_detail.html', {'order': order})



from django.shortcuts import render, redirect
from django.views import View
from django.http import JsonResponse, HttpResponseBadRequest
from .models import Order
from django.contrib.auth.mixins import LoginRequiredMixin

class UserOrderListView(LoginRequiredMixin, View):
    def get(self, request):
        # Get all orders for the logged-in user
        orders = Order.objects.filter(user=request.user)
        return render(request, 'order/order_list.html', {'orders': orders})

class CancelOrderView(LoginRequiredMixin, View):
    def post(self, request, order_id):
        try:
            order = Order.objects.get(id=order_id, user=request.user)
            if order.status == 'pending':  # Allow cancellation only if the order is pending
                order.status = 'cancelled'
                order.save()
                messages.success(request, "Your order has been cancelled.")
                return redirect('product:user_order_list')
            else:
                messages.success(request, "Your order has been cancelled.")
                return redirect('product:user_order_list')
        except Order.DoesNotExist:
            messages.error(request, "Your order does not exist.")
            return redirect('product:user_order_list')



class ProductSearchView(View):
    def get(self, request):
        query = request.GET.get('q', '')
        products = Product.objects.filter(name__icontains=query)  # Adjust the field as necessary
        return render(request, 'products/all_products.html', {'products': products, 'query': query})
