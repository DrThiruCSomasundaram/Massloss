# Massloss v0.1.0 - Initial Release

## Overview

Massloss is an R package for analyzing mass loss in compositional data. This package provides functions for calculating mass loss percentages and simulating compositional decrements to find optimal matches between initial and final compositional datasets (e.g., protein, lipid, ash, carbohydrate percentages).

## Features

### 1. Calculate Compositional Mass Loss
- Calculate the total mass loss required by each element when transitioning from dataset A to B
- Works with compositional data that sum to 100 (percent) or 1000 (mg per g)
- Formula: `(1 - (A[reference_row, col] / B[, col])) * 100`

### 2. Simulate Compositional Decrement
- Simulate decrementing each element from initial composition down to zero
- Calculate compositional percentages for each decrement step
- Find the best matching row that matches target composition when decrement is small
- Supports exact matching and range-based matching (e.g., mean ± SD)

### 3. Filter by Compositional Ranges
- Helper function to filter simulated data based on ranges
- Useful for working with mean ± SD data

## Installation

```r
# Install from GitHub
if (!require("devtools")) install.packages("devtools")
devtools::install_github("DrThiruCSomasundaram/Massloss")
```

## Quick Start

```r
library(Massloss)

# Example data
data_A <- data.frame(
  Protein = 4.21,
  Lipid = 1.03,
  Ash = 31.05,
  Carbs = 63.72
)

data_B <- data.frame(
  Protein = 7.28,
  Lipid = 1.95,
  Ash = 16.61,
  Carbs = 74.16
)

# Calculate mass loss
mass_loss <- calculate_compositional_mass_loss(data_A, data_B)

# Simulate decrement and find best match
result <- simulate_compositional_decrement(
  data_A = data_A,
  data_B = data_B,
  decrement_steps = c(Protein = 0.1, Lipid = 0.01, Ash = 1, Carbs = 1)
)
```

## Documentation

- See `README.md` for full documentation
- Example script: `inst/scripts/example_analysis.R`
- Usage guide: `USAGE_GUIDE.md`

## Requirements

- R (>= 4.0.0)
- No external dependencies (uses base R only)

## Citation

If you use this package in your research, please cite it as:

```
@software{massloss2025,
  author = {Soma, Thiru and Francis, Dave},
  title = {Massloss: An R Package for Mass Loss Analysis},
  version = {0.1.0},
  year = {2025},
  doi = {10.5281/zenodo.XXXXXXX},
  url = {https://github.com/DrThiruCSomasundaram/Massloss}
}
```

*Note: Replace XXXXXXX with your actual Zenodo DOI after the release is processed.*

## License

MIT License - see LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## Contact

For questions or issues, please open an issue on [GitHub](https://github.com/DrThiruCSomasundaram/Massloss/issues).
