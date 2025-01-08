// Add this function to handle dynamic product loading
function renderProducts(products) {
  const productsList = document.querySelector(".products-list");
  if (!productsList) return;

  productsList.innerHTML = products
    .map(
      (product, index) => `
        <li class="product-item">
            <div class="product-info">
                <img
                    src="${product.imageUrl}"
                    alt="${product.name}"
                    class="product-image"
                />
                <div class="product-details">
                    <h3>${product.name}</h3>
                    <p>${product.category}</p>
                </div>
            </div>
            <div class="sales-info">
                <h6>${product.sales}</h6>
                <p>in sales</p>
            </div>
            <div class="rank-badge">
                <span>#${index + 1}</span>
            </div>
        </li>
    `
    )
    .join("");
}

// Example usage with mock data
const mockProducts = [
  {
    name: "Healthcare Erbology",
    category: "in Accessories",
    sales: "13,153",
    imageUrl:
      "https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?w=150",
  },
  {
    name: "Makeup Lancome Rouge",
    category: "in Accessories",
    sales: "10,300",
    imageUrl:
      "https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=150",
  },
  {
    name: "Lounge Puff Fabric Slipper",
    category: "in Accessories",
    sales: "5,300",
    imageUrl:
      "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=150",
  },
  {
    name: "Skincare Necessaire",
    category: "in Accessories",
    sales: "1,203",
    imageUrl:
      "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=150",
  },
  {
    name: "Skincare Soja CO",
    category: "in Accessories",
    sales: "254",
    imageUrl:
      "https://images.unsplash.com/photo-1598662972299-5408ddb8a3dc?w=150",
  },
  {
    name: "Natural Herbs Collection",
    category: "in Healthcare",
    sales: "198",
    imageUrl: "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=150",
  },
];

document.addEventListener("DOMContentLoaded", () => {
  // Initialize the sales revenue chart
  const salesRevenueChart = new SalesRevenueChart("sales-revenue-chart");

  // Render the products
  renderProducts(mockProducts);
});
