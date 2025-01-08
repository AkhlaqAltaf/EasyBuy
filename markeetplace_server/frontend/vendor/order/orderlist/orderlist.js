const orders = [
    { id: 'DEV-102', total: '$500.00', status: 'PENDING', date: 'JAN 31' },
    { id: 'DEV-101', total: '$324.50', status: 'COMPLETE', date: 'JAN 31' },
    { id: 'DEV-103', total: '$450.00', status: 'REJECTED', date: 'FEB 01' },
    { id: 'DEV-104', total: '$524.00', status: 'COMPLETE', date: 'FEB 02' },
    { id: 'DEV-105', total: '$230.50', status: 'REJECTED', date: 'FEB 03' },
    { id: 'DEV-106', total: '$300.00', status: 'CANCELED', date: 'FEB 04' },
    { id: 'DEV-107', total: '$400.00', status: 'PENDING', date: 'FEB 05' },
    { id: 'DEV-108', total: '$250.00', status: 'COMPLETE', date: 'FEB 06' },
    { id: 'DEV-109', total: '$600.00', status: 'REJECTED', date: 'FEB 07' },
    { id: 'DEV-110', total: '$700.00', status: 'CANCELED', date: 'FEB 08' },
  ];

  const rowsPerPage = 5;
  let currentPage = 1;
  let searchQuery = '';
  let currentFilter = 'ALL';

  function filterOrders(filter) {
    currentFilter = filter;
    currentPage = 1;
    renderOrders();
  }

  function handleSearchChange() {
    searchQuery = document.getElementById('searchInput').value.toLowerCase();
    currentPage = 1;
    renderOrders();
  }

  function renderOrders() {
    const filteredOrders = orders.filter(order =>
      (currentFilter === 'ALL' || order.status === currentFilter) &&
      order.id.toLowerCase().includes(searchQuery)
    );

    const indexOfLastOrder = currentPage * rowsPerPage;
    const indexOfFirstOrder = indexOfLastOrder - rowsPerPage;
    const currentOrders = filteredOrders.slice(indexOfFirstOrder, indexOfLastOrder);

    const ordersTable = document.getElementById('ordersTable');
    ordersTable.innerHTML = currentOrders.map(order => `
      <tr class="border-b text-sm">
        <td class="p-4">${order.id}</td>
        <td class="p-4">${order.total}</td>
        <td class="p-4">${order.status}</td>
        <td class="p-4">${order.date}</td>
      </tr>
    `).join('');

    renderPagination(filteredOrders.length);
  }

  function renderPagination(totalOrders) {
    const totalPages = Math.ceil(totalOrders / rowsPerPage);
    const pagination = document.getElementById('pagination');
    pagination.innerHTML = '';

    for (let i = 1; i <= totalPages; i++) {
      const button = document.createElement('button');
      button.textContent = i;
      button.className = `px-4 py-2 border rounded ${i === currentPage ? 'bg-teal-700 text-white' : 'bg-white text-teal-700'}`;
      button.onclick = () => {
        currentPage = i;
        renderOrders();
      };
      pagination.appendChild(button);
    }
  }

  renderOrders();