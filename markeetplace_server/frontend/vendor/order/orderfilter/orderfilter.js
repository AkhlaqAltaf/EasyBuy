const orders = [
    { id: 'INV-0019', customer: 'ACME SRL', amount: 55.50, status: 'PAID', date: '2024-02-01' },
    { id: 'INV-0020', customer: 'Blind Spots Inc.', amount: 150.00, status: 'PENDING', date: '2024-02-05' },
    { id: 'INV-0021', customer: 'Dispatcher Inc.', amount: 200.00, status: 'PAID', date: '2024-02-10' },
    { id: 'INV-0022', customer: 'Blind Spots Inc.', amount: 100.00, status: 'PENDING', date: '2024-02-12' },
  ];

  function updateOrdersDisplay(filteredOrders) {
    const paidOrdersSection = document.getElementById('paidOrders');
    const pendingOrdersSection = document.getElementById('pendingOrders');
    
    let paidOrdersHTML = '';
    let pendingOrdersHTML = '';

    filteredOrders.forEach(order => {
      const orderHTML = `
        <div class="flex items-center justify-between bg-white p-4">
          <div class="flex items-center space-x-4">
            <div class="flex items-center justify-center w-10 h-10 bg-[#0B5D51] text-white font-bold rounded-full">${order.customer.slice(0, 2)}</div>
            <div>
              <div class="text-sm font-medium">${order.id}</div>
              <div class="text-gray-600 text-sm">${order.customer}</div>
            </div>
          </div>
          <div class="text-sm font-semibold">$${order.amount.toFixed(2)}</div>
          <div class="text-gray-500 text-sm flex flex-col">
            <span>Issued:</span>
            <span>${order.date}</span>
          </div>
          <div class="ml-4">
            <span class="bg-${order.status === 'PAID' ? 'green-100' : 'red-100'} text-${order.status === 'PAID' ? 'green-600' : 'red-600'} text-xs px-3 py-1 rounded-full">${order.status}</span>
          </div>
        </div>
      `;

      if (order.status === 'PAID') {
        paidOrdersHTML += orderHTML;
      } else {
        pendingOrdersHTML += orderHTML;
      }
    });

    paidOrdersSection.innerHTML = `<h3 class="text-lg font-semibold">Paid (${filteredOrders.filter(o => o.status === 'PAID').length})</h3>${paidOrdersHTML}`;
    pendingOrdersSection.innerHTML = `<h3 class="text-lg font-semibold">Pending (${filteredOrders.filter(o => o.status === 'PENDING').length})</h3>${pendingOrdersHTML}`;
  }

  function filterOrders() {
    const orderNumber = document.getElementById('orderNumber').value.toLowerCase();
    const fromDate = document.getElementById('fromDate').value;
    const toDate = document.getElementById('toDate').value;
    const blindSpots = document.getElementById('blindSpots').checked;
    const dispatcherInc = document.getElementById('dispatcherInc').checked;

    const filteredOrders = orders.filter(order => {
      return (
        (!orderNumber || order.id.toLowerCase().includes(orderNumber)) &&
        (!fromDate || new Date(order.date) >= new Date(fromDate)) &&
        (!toDate || new Date(order.date) <= new Date(toDate)) &&
        (!blindSpots || order.customer === 'Blind Spots Inc.') &&
        (!dispatcherInc || order.customer === 'Dispatcher Inc.')
      );
    });

    updateOrdersDisplay(filteredOrders);
  }

  function togglePaid() {
    const paidOnly = document.getElementById('paidToggle').classList.contains('bg-[#939393]');
    if (paidOnly) {
      document.getElementById('paidToggle').classList.remove('bg-[#939393]');
      document.getElementById('paidToggle').classList.add('bg-[#0B5D51]');
    } else {
      document.getElementById('paidToggle').classList.remove('bg-[#0B5D51]');
      document.getElementById('paidToggle').classList.add('bg-[#939393]');
    }

    filterOrders();
  }

  function toggleGroupStatus() {
    const groupStatus = document.getElementById('groupStatusToggle').classList.contains('bg-[#939393]');
    if (groupStatus) {
      document.getElementById('groupStatusToggle').classList.remove('bg-[#939393]');
      document.getElementById('groupStatusToggle').classList.add('bg-[#0B5D51]');
    } else {
      document.getElementById('groupStatusToggle').classList.remove('bg-[#0B5D51]');
      document.getElementById('groupStatusToggle').classList.add('bg-[#939393]');
    }

    filterOrders();
  }

  // Initial filter when page loads
  window.onload = filterOrders;