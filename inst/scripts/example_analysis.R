# Example Mass Loss Analysis Script
# This script demonstrates how to use the Massloss package functions
# for compositional data analysis

# Load the package (after installation)
# library(Massloss)

# ============================================================================
# Example 1: Calculate Mass Loss for Compositional Data
# ============================================================================

# Dataset A: Initial composition (from Image 1 - mean values only)
data_A <- data.frame(
  Protein = 4.21,
  Lipid = 1.03,
  Ash = 31.05,
  Carbs = 63.72  # Carbohydrate/Carb
)

# Dataset B: Final composition (from Image 2 - mean values only)
data_B <- data.frame(
  Protein = 7.28,
  Lipid = 1.95,
  Ash = 16.61,
  Carbs = 74.16  # Carbohydrate
)

# Calculate mass loss for each element
mass_loss_result <- calculate_compositional_mass_loss(data_A, data_B, reference_row = 1)
print("Mass Loss Results (%):")
print(mass_loss_result)

# ============================================================================
# Example 2: Simulate Compositional Decrement and Find Best Match
# ============================================================================

# Using the same datasets A and B from Example 1 (from your images)
# Dataset A from Image 1 (mean values only)
data_A_single <- data_A  # Uses the same data_A from Example 1

# Dataset B from Image 2 (mean values only)
data_B_single <- data_B  # Uses the same data_B from Example 1

# Simulate with custom decrement steps (similar to your code)
result <- simulate_compositional_decrement(
  data_A = data_A_single,
  data_B = data_B_single,
  reference_row = 1,
  decrement_steps = c(Protein = 0.1, Lipid = 0.01, Ash = 1, Carbs = 1),
  tolerance = c(Protein = 0.5, Lipid = 0.1, Ash = 1, Carbs = 1),
  match_method = "exact"
)

# Display results
cat("\n=== Simulation Results ===\n")
cat("Number of combinations generated:", result$decrement_info$n_combinations, "\n")
cat("Number of matches found:", result$decrement_info$n_matches, "\n")
cat("\nBest Match:\n")
print(result$best_match)



