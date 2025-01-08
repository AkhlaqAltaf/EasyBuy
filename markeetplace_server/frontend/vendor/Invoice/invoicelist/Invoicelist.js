const orders = [
    { id: 'DEV-102', total: '$500.00', status: 'PENDING', date: 'JAN 31' },
    { id: 'DEV-101', total: '$324.50', status: 'COMPLETE', date: 'JAN 31' },
    { id: 'DEV-103', total: '$450.00', status: 'REJECTED', date: 'FEB 01' },
    // Add more orders as needed
  ];

  const rowsPerPage = 10;
  let currentPage = 1;
  let searchQuery = '';

  const renderOrders = () => {
    const filteredOrders = orders.filter(order => order.id.toLowerCase().includes(searchQuery.toLowerCase()));
    const indexOfLastOrder = currentPage * rowsPerPage;
    const indexOfFirstOrder = indexOfLastOrder - rowsPerPage;
    const currentOrders = filteredOrders.slice(indexOfFirstOrder, indexOfLastOrder);

    const ordersList = document.getElementById('orders-list');
    ordersList.innerHTML = '';

    currentOrders.forEach(order => {
      const orderElement = document.createElement('div');
      orderElement.classList.add('flex', 'justify-between', 'items-center', 'bg-white', 'p-4', 'hover:bg-gray-200', 'transition-colors');
      orderElement.innerHTML = `
        <div class="flex items-center space-x-4">
          <div class="bg-[#0B5D51] text-center py-2 px-4 rounded-3xl text-white">
            <span class="block text-sm">${order.date.split(' ')[0]}</span>
            <span class="block text-lg font-bold">${order.date.split(' ')[1]}</span>
          </div>
          <div>
            <h2 class="text-lg font-semibold text-black hover:text-black">${order.id}</h2>
            <p class="text-black hover:text-black">Total of ${order.total}</p>
          </div>
        </div>
        <div class="font-semibold ${order.status === 'PENDING' ? 'text-blue-500 bg-[#06AED41F]' : order.status === 'COMPLETE' ? 'text-[#0B5D51] bg-[#10b9813f]' : order.status === 'REJECTED' ? 'text-[#B42318] bg-[#F044381F]' : order.status === 'CANCELED' ? 'text-[#B54708] bg-[#F790091F]' : 'text-black'} px-3 rounded-3xl">
          ${order.status}
        </div>
      `;
      ordersList.appendChild(orderElement);
    });
  };

  const renderPagination = () => {
    const pagination = document.getElementById('pagination');
    pagination.innerHTML = '';

    const totalPages = Math.ceil(orders.length / rowsPerPage);
    const pageNumbers = [];

    for (let i = 1; i <= totalPages; i++) {
      pageNumbers.push(i);
    }

    pageNumbers.forEach(number => {
      const pageButton = document.createElement('button');
      pageButton.textContent = number;
      pageButton.classList.add('px-3', 'py-2', 'rounded-lg', 'bg-gray-200', 'hover:bg-[#0B5D51]', 'hover:text-white');
      pageButton.onclick = () => {
        currentPage = number;
        renderOrders();
        renderPagination();
      };
      pagination.appendChild(pageButton);
    });
  };

  const handleSearchChange = (event) => {
    searchQuery = event.target.value;
    currentPage = 1;
    renderOrders();
    renderPagination();
  };

  renderOrders();
  renderPagination();