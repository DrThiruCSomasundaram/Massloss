# How to Test and Run the Massloss Package Locally

## Prerequisites

Make sure you have the following R packages installed:
```r
install.packages(c("devtools", "roxygen2"))
```

## Step 1: Generate Documentation

First, generate the documentation files from roxygen comments:

```r
library(devtools)
library(roxygen2)

# Set working directory to package root
setwd("/Users/thiru.somasundaram/Library/CloudStorage/OneDrive-DeakinUniversity/NuSea.Lab/Associate Research Fellow/Massloss")

# Generate .Rd files from roxygen comments
document()
```

## Step 2: Load the Package for Development

Load the package so you can test functions:

```r
# Load the package (reloads on changes)
load_all()

# Or install it locally
install()
```

## Step 3: Test the Functions

```r
library(Massloss)

# Test with your data
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

# Test Function 1: Calculate mass loss
mass_loss <- calculate_compositional_mass_loss(data_A, data_B)
print(mass_loss)

# Test Function 2: Simulate decrement
result <- simulate_compositional_decrement(
  data_A = data_A,
  data_B = data_B,
  decrement_steps = c(Protein = 0.1, Lipid = 0.01, Ash = 1, Carbs = 1)
)
print(result$best_match)
```

## Step 4: Run the Example Script

```r
# Source the example script
source("inst/scripts/example_analysis.R")
```

## Step 5: Check the Package

Run R CMD check to verify everything works:

```r
# Check the package (comprehensive testing)
check()

# Quick check (faster)
check(cran = FALSE)
```

## Step 6: Build the Package

Build the package source file:

```r
# Build source package
build()

# This creates: Massloss_0.1.0.tar.gz
```

## Common Commands Summary

```r
library(devtools)
setwd("path/to/Massloss")

# Development workflow
document()      # Generate documentation
load_all()      # Load package for testing
test()          # Run tests (if you have testthat tests)
check()         # Full package check
build()         # Build package file

# Install locally
install()       # Install package locally
```

## Troubleshooting

1. **If `document()` fails**: Make sure roxygen2 is installed and you're in the package root directory.

2. **If functions aren't found**: Run `load_all()` or `install()` again.

3. **If NAMESPACE has issues**: Delete NAMESPACE and run `document()` again (it will regenerate).

4. **To see package help**:
   ```r
   ?calculate_compositional_mass_loss
   ?simulate_compositional_decrement
   ```
