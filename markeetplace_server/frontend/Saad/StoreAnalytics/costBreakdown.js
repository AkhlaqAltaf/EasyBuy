class CostBreakdownChart {
  constructor(containerId) {
    this.containerId = containerId;
    this.chart = null;
    this.initializeChart();
  }

  async fetchData() {
    try {
      // Mock data for now
      return {
        datasets: [
          {
            data: [14859, 35690, 45120, 25486],
            labels: ["Strategy", "Outsourcing", "Marketing", "Others"],
            backgroundColor: ["#E5E7EB", "#6366F1", "#0B5D51", "#F79009"],
          },
        ],
      };
    } catch (error) {
      console.error("Error fetching cost breakdown data:", error);
      return null;
    }
  }

  updateTableData(data) {
    const tbody = document.querySelector(".cost-table tbody");
    if (!tbody) return;

    const {
      datasets: [{ data: values, labels }],
    } = data;
    const colors = ["#E5E7EB", "#6366F1", "#0B5D51", "#F79009"];

    tbody.innerHTML = labels
      .map(
        (label, index) => `
      <tr>
        <td>
          <div class="channel-info">
            <span class="dot" style="background-color: ${colors[index]}"></span>
            <p>${label}</p>
          </div>
        </td>
        <td>$${values[index].toLocaleString()}.00</td>
      </tr>
    `
      )
      .join("");
  }

  async initializeChart() {
    const ctx = document.getElementById(this.containerId).getContext("2d");
    const data = await this.fetchData();
    if (!data) return;

    this.chart = new Chart(ctx, {
      type: "doughnut",
      data: {
        labels: data.datasets[0].labels,
        datasets: [
          {
            data: data.datasets[0].data,
            backgroundColor: data.datasets[0].backgroundColor,
            borderWidth: 0,
            hoverOffset: 4,
            borderRadius: 4,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        cutout: "75%",
        layout: {
          padding: 20,
        },
        plugins: {
          legend: {
            display: false,
          },
          tooltip: {
            backgroundColor: "white",
            titleColor: "#111927",
            bodyColor: "#6C737F",
            bodyFont: {
              family: "Inter",
              size: 14,
            },
            padding: 12,
            boxWidth: 10,
            boxHeight: 10,
            boxPadding: 3,
            usePointStyle: true,
            callbacks: {
              label: function (context) {
                const value = context.raw;
                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                const percentage = ((value / total) * 100).toFixed(1);
                return ` $${value.toLocaleString()} (${percentage}%)`;
              },
            },
          },
        },
        animation: {
          animateScale: true,
          animateRotate: true,
        },
      },
    });

    this.updateTableData(data);
  }
}

// Initialize when DOM is loaded
document.addEventListener("DOMContentLoaded", () => {
  const costBreakdownChart = new CostBreakdownChart("cost-breakdown-chart");
});
