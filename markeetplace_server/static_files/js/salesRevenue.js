class SalesRevenueChart {
  constructor(containerId) {
    this.containerId = containerId;
    this.chart = null;
    this.currentMonth = "December";
    this.currentYear = "2023";
    this.gradients = {};
    this.initializeChart();
  }

  createGradients(ctx) {
    // Create gradient for current period
    const currentGradient = ctx.createLinearGradient(0, 0, 0, 400);
    currentGradient.addColorStop(0, "rgba(11, 93, 81, 0.2)");
    currentGradient.addColorStop(1, "rgba(11, 93, 81, 0.0)");

    // Create gradient for previous period
    const previousGradient = ctx.createLinearGradient(0, 0, 0, 400);
    previousGradient.addColorStop(0, "rgba(255, 165, 0, 0.15)");
    previousGradient.addColorStop(1, "rgba(255, 165, 0, 0.0)");

    return { currentGradient, previousGradient };
  }

  async fetchData() {
    try {
      const response = await fetch(
        `your-api-endpoint/sales-revenue?month=${this.currentMonth}&year=${this.currentYear}`
      );
      const data = await response.json();
      return data;
    } catch (error) {
      console.error("Error fetching sales revenue data:", error);
      return {
        labels: [
          "1 Dec",
          "3 Dec",
          "5 Dec",
          "7 Dec",
          "9 Dec",
          "11 Dec",
          "13 Dec",
          "15 Dec",
          "17 Dec",
          "19 Dec",
          "21 Dec",
          "23 Dec",
          "25 Dec",
          "27 Dec",
          "29 Dec",
          "31 Dec",
        ],
        datasets: [
          {
            label: "Current Period",
            data: [
              15000, 18000, 22000, 20000, 25000, 28000, 26000, 32000, 35000,
              33000, 38000, 42000, 45000, 48000, 50000, 52000,
            ],
            borderColor: "#0B5D51",
            backgroundColor:
              this.gradients?.currentGradient || "rgba(11, 93, 81, 0.1)",
            tension: 0.5,
            fill: true,
            pointRadius: 4,
            pointBackgroundColor: "#FFFFFF",
            pointBorderColor: "#0B5D51",
            pointBorderWidth: 2,
            pointHoverRadius: 8,
            pointHoverBackgroundColor: "#0B5D51",
            pointHoverBorderColor: "#FFFFFF",
            pointHoverBorderWidth: 2,
            borderWidth: 3,
            cubicInterpolationMode: "monotone",
            capBezierPoints: true,
          },
          {
            label: "Previous Period",
            data: [
              12000, 14000, 18000, 16000, 20000, 23000, 21000, 28000, 30000,
              27000, 32000, 35000, 38000, 40000, 41000, 42000,
            ],
            borderColor: "#FFA500",
            backgroundColor:
              this.gradients?.previousGradient || "rgba(255, 165, 0, 0.1)",
            tension: 0.5,
            fill: true,
            borderDash: [5, 5],
            pointRadius: 4,
            pointBackgroundColor: "#FFFFFF",
            pointBorderColor: "#FFA500",
            pointBorderWidth: 2,
            pointHoverRadius: 8,
            pointHoverBackgroundColor: "#FFA500",
            pointHoverBorderColor: "#FFFFFF",
            pointHoverBorderWidth: 2,
            borderWidth: 3,
            cubicInterpolationMode: "monotone",
            capBezierPoints: true,
          },
        ],
      };
    }
  }

  updateDateRange() {
    const dateRangeElement = document.querySelector(".current-period");
    if (dateRangeElement) {
      dateRangeElement.textContent = `Dec 1 - Dec 31, ${this.currentYear}`;
    }
  }

  getChartOptions() {
    const options = {
      responsive: true,
      maintainAspectRatio: false,
      interaction: {
        mode: "index",
        intersect: false,
      },
      plugins: {
        legend: {
          position: "top",
          align: "end",
          labels: {
            usePointStyle: true,
            padding: 20,
            font: {
              family: "'Inter', sans-serif",
              size: 12,
              weight: 500,
            },
            boxWidth: 8,
            boxHeight: 8,
            generateLabels: (chart) => {
              const datasets = chart.data.datasets;
              return datasets.map((dataset, i) => ({
                text: dataset.label,
                fillStyle: dataset.borderColor,
                strokeStyle: dataset.borderColor,
                lineWidth: 2,
                hidden: !chart.isDatasetVisible(i),
                index: i,
              }));
            },
          },
        },
        tooltip: {
          backgroundColor: "white",
          titleColor: "#111927",
          titleFont: {
            family: "'Inter', sans-serif",
            size: 14,
            weight: "600",
          },
          bodyColor: "#6c737f",
          bodyFont: {
            family: "'Inter', sans-serif",
            size: 12,
          },
          borderColor: "#e5e7eb",
          borderWidth: 1,
          padding: {
            top: 10,
            right: 15,
            bottom: 10,
            left: 15,
          },
          usePointStyle: true,
          callbacks: {
            label: function (context) {
              return `${
                context.dataset.label
              }: $${context.parsed.y.toLocaleString()}`;
            },
          },
          titleMarginBottom: 10,
          bodySpacing: 8,
          mode: "index",
          intersect: false,
          caretSize: 6,
          cornerRadius: 6,
          displayColors: false,
          enabled: true,
          animation: {
            duration: 150,
          },
        },
      },
      scales: {
        x: {
          grid: {
            display: false,
            drawBorder: false,
          },
          ticks: {
            font: {
              family: "'Inter', sans-serif",
              size: 12,
            },
            color: "#6c737f",
            padding: 8,
            maxRotation: 45,
            autoSkip: true,
            maxTicksLimit: 12,
          },
        },
        y: {
          beginAtZero: true,
          grid: {
            color: "rgba(229, 231, 235, 0.4)",
            drawBorder: false,
            borderDash: [5, 5],
          },
          ticks: {
            font: {
              family: "'Inter', sans-serif",
              size: 12,
            },
            color: "#6c737f",
            padding: 10,
            callback: function (value) {
              return "$" + value.toLocaleString();
            },
            maxTicksLimit: 6,
          },
          suggestedMin: 0,
          suggestedMax: function (context) {
            const max = Math.max(...context.chart.data.datasets[0].data);
            return max * 1.02;
          },
          grace: "2%",
        },
      },
      elements: {
        line: {
          tension: 0.5,
          borderJoinStyle: "round",
          borderCapStyle: "round",
        },
        point: {
          radius: 4,
          hoverRadius: 8,
          hoverBorderWidth: 2,
          backgroundColor: "#FFFFFF",
        },
      },
      hover: {
        mode: "index",
        intersect: false,
        animationDuration: 150,
      },
      animation: {
        duration: 1000,
        easing: "easeInOutQuart",
      },
    };
    return options;
  }

  async initializeChart() {
    const ctx = document.getElementById(this.containerId).getContext("2d");
    this.gradients = this.createGradients(ctx);
    const data = await this.fetchData();
    this.updateDateRange();

    this.chart = new Chart(ctx, {
      type: "line",
      data: data,
      options: this.getChartOptions(),
    });

    // Add hover effect for the entire chart
    const chartArea = document.getElementById(this.containerId);
    chartArea.addEventListener("mousemove", (e) => {
      const points = this.chart.getElementsAtEventForMode(e, "index", {
        intersect: false,
      });
      chartArea.style.cursor = points.length ? "pointer" : "default";
    });
  }

  async updateChart(month = "December", year = "2023") {
    this.currentMonth = month;
    this.currentYear = year;
    const newData = await this.fetchData();
    this.updateDateRange();

    // Animate the update
    this.chart.data.datasets.forEach((dataset, index) => {
      const newValues = newData.datasets[index].data;
      dataset.data = newValues;
    });

    this.chart.update("active");
  }
}

// Initialize when DOM is loaded
document.addEventListener("DOMContentLoaded", () => {
  const salesRevenueChart = new SalesRevenueChart("sales-revenue-chart");
});
