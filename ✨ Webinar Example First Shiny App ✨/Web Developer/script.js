// Sample datasets
const dataset1 = [
  { Category: "A", Value: 30 },
  { Category: "B", Value: 50 },
  { Category: "C", Value: 20 }
];

const dataset2 = [
  { Category: "X", Value: 10 },
  { Category: "Y", Value: 60 },
  { Category: "Z", Value: 30 }
];

// Function to create a horizontal barplot
function createBarplot(dataset) {
  const width = 600;
  const height = 300;

  const svg = d3
    .select(".barplot-container") // Update the selector to target the correct container
    .append("svg")
    .attr("width", width)
    .attr("height", height);

  const xScale = d3
    .scaleLinear()
    .domain([0, d3.max(dataset, (d) => d.Value)])
    .range([0, width - 100]);

  const yScale = d3
    .scaleBand()
    .domain(dataset.map((d) => d.Category))
    .range([0, height])
    .padding(0.1);

  svg
    .selectAll("rect")
    .data(dataset)
    .enter()
    .append("rect")
    .attr("x", 100)
    .attr("y", (d) => yScale(d.Category))
    .attr("width", (d) => xScale(d.Value))
    .attr("height", yScale.bandwidth())
    .attr("fill", "#7346CB");

  svg
    .selectAll("text")
    .data(dataset)
    .enter()
    .append("text")
    .attr("x", (d) => xScale(d.Value) + 110)
    .attr("y", (d) => yScale(d.Category) + yScale.bandwidth() / 2)
    .attr("dy", "0.35em")
    .text((d) => d.Value)
    .attr("fill", "white");
}

// Initialize the barplot with the first dataset
createBarplot(dataset1);

// Event listener for the dataset select dropdown
document.getElementById("dataset-select").addEventListener("change", function () {
  const selectedValue = this.value;
  const selectedDataset = selectedValue === "dataset1" ? dataset1 : dataset2;

  // Remove the existing barplot
  d3.select(".barplot-container").select("svg").remove();

  // Create a new barplot with the selected dataset
  createBarplot(selectedDataset);
});
