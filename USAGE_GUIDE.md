# Massloss Package - Usage Guide

This guide shows how to use the Massloss package functions with your compositional data workflow.

## Function 1: Calculate Compositional Mass Loss

This function calculates the mass loss percentage for each element when transitioning from dataset A to B.

### Basic Usage

```r
library(Massloss)

# Your initial composition (dataset A)
data_A <- data.frame(
  Protein = 4.21,
  Lipid = 0.97,
  Ash = 31.05,
  NFE = 63.72
)

# Your final composition (dataset B)
data_B <- data.frame(
  Protein = 3.5,
  Lipid = 0.8,
  Ash = 28.0,
  NFE = 67.7
)

# Calculate mass loss
mass_loss <- lost_mass(data_A, data_B, reference_row = 1)
print(mass_loss)
```

### Working with Multiple Rows

If you have multiple samples in data_A and data_B:

```r
# Multiple samples
data_A_multi <- data.frame(
  Protein = c(4.21, 4.15, 4.30),
  Lipid = c(0.97, 0.95, 1.00),
  Ash = c(31.05, 30.50, 31.20),
  NFE = c(63.72, 64.40, 63.50)
)

data_B_multi <- data.frame(
  Protein = c(3.5, 3.4, 3.6),
  Lipid = c(0.8, 0.75, 0.85),
  Ash = c(28.0, 27.5, 28.5),
  NFE = c(67.7, 68.35, 67.05)
)

# Use first row of A as reference, calculate for all rows of B
mass_loss_multi <- lost_mass(data_A_multi, data_B_multi, reference_row = 1)
```

## Function 2: Simulate Compositional Decrement and Find Best Match

This function simulates decrementing each element from dataset A down to zero, calculates compositional percentages, and finds the best match with dataset B.

### Basic Usage

```r
# Single row example
data_A <- data.frame(Protein = 4.21, Lipid = 0.97, Ash = 31.05, NFE = 63.72)
data_B <- data.frame(Protein = 3.5, Lipid = 0.8, Ash = 28.0, NFE = 67.7)

# Simulate with custom decrement steps (like your code)
result <- simulate_decrement(
  data_A = data_A,
  data_B = data_B,
  reference_row = 1,
  decrement_steps = c(Protein = 0.1, Lipid = 0.01, Ash = 1, NFE = 1),
  tolerance = c(Protein = 0.5, Lipid = 0.1, Ash = 1, NFE = 1),
  match_method = "exact"
)

# View results
print(result$best_match)        # Best matching row
print(result$all_matches)        # All matching rows
print(result$simulated_data)    # All simulated combinations
print(result$decrement_info)    # Information about the simulation
```

### Working with Ranges (Mean ± SD)

If you have ranges like in your code (mean ± SD):

```r
# After calculating means and SDs (like your Prox_comp_HT_mean and Prox_comp_HT_sd)
# Define ranges
Protein_range <- data.frame(Pr_min = 3.0, Pr_max = 5.0)
Lip_rng <- data.frame(lip_min = 0.7, lip_max = 1.2)
NFE_rng <- data.frame(nfe_min = 60.0, nfe_max = 67.0)
ASH_rng <- data.frame(ash_min = 28.0, ash_max = 34.0)

# Run simulation
result <- simulate_decrement(
  data_A = data_A,
  data_B = data_B,
  decrement_steps = c(Protein = 0.1, Lipid = 0.01, Ash = 1, NFE = 1)
)

# Filter by ranges using the helper function
ranges <- list(
  Protein = c(min = Protein_range$Pr_min, max = Protein_range$Pr_max),
  Lipid = c(min = Lip_rng$lip_min, max = Lip_rng$lip_max),
  NFE = c(min = NFE_rng$nfe_min, max = NFE_rng$nfe_max),
  Ash = c(min = ASH_rng$ash_min, max = ASH_rng$ash_max)
)

filtered_data <- filter_by_compositional_ranges(result$simulated_data, ranges)

# Or use range-based matching directly
tolerance_ranges <- list(
  Protein = c(1.0, 1.0),  # ±1.0
  Lipid = c(0.2, 0.2),    # ±0.2
  Ash = c(2.0, 2.0),      # ±2.0
  NFE = c(3.0, 3.0)       # ±3.0
)

result_range <- simulate_decrement(
  data_A = data_A,
  data_B = data_B,
  decrement_steps = c(Protein = 0.1, Lipid = 0.01, Ash = 1, NFE = 1),
  tolerance = tolerance_ranges,
  match_method = "range"
)
```

## Complete Workflow Example

Here's how to replicate your workflow:

```r
library(Massloss)
# library(dplyr)  # if you're using dplyr for data manipulation

# Step 1: Prepare your data (assuming you have Prox_comp_HT)
# Prox_comp_HT_mean <- Prox_comp_HT %>% 
#   filter(Factor1 == '82C' & Factor2 == '250') %>%
#   summarise_if(is.numeric, mean)
# 
# Prox_comp_HT_sd <- Prox_comp_HT %>% 
#   filter(Factor1 == '82C' & Factor2 == '250') %>%
#   summarise_if(is.numeric, sd)

# Step 2: Convert to data frame
# mean_HT <- as.data.frame(Prox_comp_HT_mean)

# Step 3: Calculate mass loss (if you have a target composition)
# target_HT <- data.frame(Protein = 3.5, Lipid = 0.8, Ash = 28.0, NFE = 67.7)
# mass_loss_HT <- lost_mass(mean_HT, target_HT, reference_row = 1)

# Step 4: Simulate decrements
# result <- simulate_decrement(
#   data_A = mean_HT,
#   data_B = target_HT,
#   reference_row = 1,
#   decrement_steps = c(Protein = 0.1, Lipid = 0.01, Ash = 1, NFE = 1)
# )

# Step 5: Filter by ranges (if needed)
# PC_HT_msd <- cbind("Factor1" = "82C", "Factor2" = "250", 
#                    Prox_comp_HT_mean, Prox_comp_HT_sd)
# 
# Protein_range <- PC_HT_msd %>%
#   dplyr::select(Factor1, Factor2, Protein, pr) %>%
#   mutate(Pr_min = Protein - pr, Pr_max = Protein + pr)
# 
# # Similar for other elements...
# 
# ranges <- list(
#   Protein = c(min = Protein_range$Pr_min, max = Protein_range$Pr_max),
#   Lipid = c(min = Lip_rng$lip_min, max = Lip_rng$lip_max),
#   NFE = c(min = NFE_rng$nfe_min, max = NFE_rng$nfe_max),
#   Ash = c(min = ASH_rng$ash_min, max = ASH_rng$ash_max)
# )
# 
# filtered_sim <- filter_by_compositional_ranges(result$simulated_data, ranges)

# Step 6: Extract best matches (like your max_sim_82)
# best_match <- result$best_match
# max_protein <- max(filtered_sim$Protein)
# max_lipid <- max(filtered_sim$Lipid)
# max_nfe <- max(filtered_sim$NFE)
# max_ash <- max(filtered_sim$Ash)
```

## Notes

1. **Decrement Steps**: Choose appropriate step sizes. Smaller steps = more combinations but slower computation. Your example uses:
   - Protein: 0.1
   - Lipid: 0.01
   - Ash: 1
   - NFE: 1

2. **Tolerance**: For exact matching, tolerance determines how close the match needs to be. For range matching, provide min/max ranges.

3. **Performance**: With many elements and small decrement steps, you can generate millions of combinations. Consider:
   - Using larger decrement steps for initial exploration
   - Filtering early in your workflow
   - Using range-based matching instead of generating all combinations

4. **Data Format**: Both functions work with data frames where:
   - Rows = samples/observations
   - Columns = elements (Protein, Lipid, Ash, NFE/Carbs)
   - Values can be percentages (sum to 100) or absolute values (e.g., mg/g, sum to 1000)
