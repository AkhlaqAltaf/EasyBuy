class StatsManager {
  constructor() {
    this.formatter = new Intl.NumberFormat("en-US", {
      style: "currency",
      currency: "USD",
      minimumFractionDigits: 0,
      maximumFractionDigits: 1,
      notation: "compact",
      compactDisplay: "short",
    });
  }

  // Fetch data from API
  async fetchStats() {
    try {
      // Replace this with your actual API endpoint
      const response = await fetch("your-api-endpoint/stats");
      const data = await response.json();
      return data;
    } catch (error) {
      console.error("Error fetching stats:", error);
      // Return mock data in case of error
      return {
        sales: { value: 152000, trend: 12.5 },
        cost: { value: 99700, trend: -5.2 },
        profit: { value: 32100, trend: 8.7 },
      };
    }
  }

  // Format numbers
  formatValue(value) {
    return this.formatter.format(value);
  }

  // Create trend HTML
  createTrendHTML(trend) {
    const isPositive = trend > 0;
    return `
            <span class="trend ${isPositive ? "up" : "down"}">
                ${isPositive ? "↑" : "↓"} ${Math.abs(trend)}%
            </span>
        `;
  }

  // Update stats in DOM
  updateStats(data) {
    Object.entries(data).forEach(([key, stat]) => {
      const valueElement = document.querySelector(`#${key}-value`);
      if (valueElement) {
        valueElement.innerHTML = `
                    ${this.formatValue(stat.value)}
                    ${this.createTrendHTML(stat.trend)}
                `;
      }
    });
  }

  // Initialize stats
  async initializeStats() {
    const data = await this.fetchStats();
    this.updateStats(data);
  }
}

// Initialize when DOM is loaded
document.addEventListener("DOMContentLoaded", () => {
  // Update your HTML structure to include IDs
  const statsCards = document.querySelectorAll(".stat-value");
  statsCards.forEach((card) => {
    const type = card.closest(".stat-card").classList[1].split("-")[0];
    card.id = `${type}-value`;
  });

  // Initialize stats
  const statsManager = new StatsManager();
  statsManager.initializeStats();
});

// Add click handler for sync button
document.querySelector(".sync-button").addEventListener("click", async () => {
  const statsManager = new StatsManager();
  await statsManager.initializeStats();
});
