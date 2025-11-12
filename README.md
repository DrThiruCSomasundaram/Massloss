# Massloss R Package

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17586165.svg)](https://doi.org/10.5281/zenodo.17586165)

An R package for analyzing mass loss data. This package provides functions for processing, analyzing, and visualizing mass loss measurements.

## Installation

### From GitHub

```r
# Install devtools if you haven't already
if (!require("devtools")) {
  install.packages("devtools")
}

# Install the package from GitHub
devtools::install_github("DrThiruCSomasundaram/Massloss")
```

### From Source

```r
# Download and extract the package, then:
install.packages("path/to/Massloss", repos = NULL, type = "source")
```

## Usage

```r
library(Massloss)

# Example 1: Calculate mass loss for compositional data
data_A <- data.frame(Protein = 20, Lipid = 10, Ash = 5, Carbs = 65)
data_B <- data.frame(Protein = 15, Lipid = 8, Ash = 4, Carbs = 73)

# Calculate mass loss for each element
mass_loss <- calculate_compositional_mass_loss(data_A, data_B)
print(mass_loss)

# Example 2: Simulate compositional decrement and find best match
result <- simulate_compositional_decrement(
  data_A = data_A,
  data_B = data_B,
  decrement_steps = c(Protein = 0.1, Lipid = 0.01, Ash = 0.1, Carbs = 1)
)

# View best match
print(result$best_match)
```

## Example Script

See `inst/scripts/example_analysis.R` for a complete example of how to use the package functions.

## Functions

- `calculate_compositional_mass_loss()`: Calculate mass loss percentage for each element when transitioning from compositional dataset A to B
- `simulate_compositional_decrement()`: Simulate decrement of compositional data from A to zero, calculate compositional values, and find best matching row that matches B's composition

## Citation

If you use this package in your research, please cite it as:

```
@software{massloss2025,
  author = {Soma, Thiru and Francis, Dave},
  title = {Massloss: An R Package for Mass Loss Analysis},
  version = {0.1.0},
  year = {2025},
  doi = {10.5281/zenodo.17586165},
  url = {https://github.com/DrThiruCSomasundaram/Massloss}
}
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This package is licensed under the MIT License. See the `LICENSE` file for details.

## Contact

For questions or issues, please open an issue on [GitHub](https://github.com/DrThiruCSomasundaram/Massloss/issues).
