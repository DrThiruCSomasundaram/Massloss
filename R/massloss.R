#' Calculate Mass Loss for Compositional Data
#'
#' Calculate the total mass loss required by each element when transitioning 
#' from compositional dataset A to B. Both datasets should sum to 100 (percent) 
#' or 1000 (mg per g).
#'
#' @param data_A Data frame or matrix of initial compositional data (rows = samples, columns = elements).
#' @param data_B Data frame or matrix of final compositional data (rows = samples, columns = elements).
#' @param reference_row Integer indicating which row in data_A to use as reference (default: 1).
#' @return Data frame with mass loss percentages for each element.
#' @export
#' @examples
#' # Example with percentage data (sums to 100)
#' data_A <- data.frame(Protein = c(20, 18, 22), 
#'                      Lipid = c(10, 9, 11),
#'                      Ash = c(5, 4, 6),
#'                      Carbs = c(65, 69, 61))
#' data_B <- data.frame(Protein = c(15, 14, 16),
#'                      Lipid = c(8, 7, 9),
#'                      Ash = c(4, 3, 5),
#'                      Carbs = c(73, 76, 70))
#' result <- lost_mass(data_A, data_B)
lost_mass <- function(data_A, data_B, reference_row = 1) {
  # Convert to data frame if needed
  if (!is.data.frame(data_A)) {
    data_A <- as.data.frame(data_A)
  }
  if (!is.data.frame(data_B)) {
    data_B <- as.data.frame(data_B)
  }
  
  # Check dimensions
  if (ncol(data_A) != ncol(data_B)) {
    stop("data_A and data_B must have the same number of columns")
  }
  
  if (reference_row < 1 || reference_row > nrow(data_A)) {
    stop("reference_row must be a valid row index in data_A")
  }
  
  # Check for zero or negative values in reference row
  if (any(data_A[reference_row, ] <= 0)) {
    stop("Reference row in data_A must contain only positive values")
  }
  
  # Initialize result data frame
  result <- data_B
  
  # Calculate mass loss for each column
  for (col in 1:ncol(data_B)) {
    col_name <- colnames(data_B)[col]
    if (col_name == "") {
      col_name <- paste0("Element_", col)
    }
    
    # Calculate: (1 - (A[reference_row, col] / B[, col])) * 100
    result[, col] <- (1 - (data_A[reference_row, col] / data_B[, col])) * 100
  }
  
  # Add column names if missing
  if (is.null(colnames(result))) {
    colnames(result) <- colnames(data_B)
    if (any(colnames(result) == "")) {
      colnames(result)[colnames(result) == ""] <- paste0("Element_", 
                                                          which(colnames(result) == ""))
    }
  }
  
  return(result)
}

#' Simulate Compositional Decrement and Find Best Match
#'
#' Simulate the decrement of compositional dataset A to zero for each element,
#' calculate compositional values for each decrement, and find the best matching
#' row that matches dataset B's composition when the decrement is small.
#'
#' @param data_A Data frame or matrix of initial compositional data (rows = samples, columns = elements).
#' @param data_B Data frame or matrix of target compositional data (single row or multiple rows).
#' @param reference_row Integer indicating which row in data_A to use as reference (default: 1).
#' @param decrement_steps Numeric vector of decrement step sizes for each element. 
#'   If a single value, it will be applied to all elements. If NULL, auto-calculated.
#' @param tolerance Numeric vector of tolerance ranges for matching (default: NULL, uses exact match).
#' @param match_method Character string: "exact" for exact match, "range" for range-based matching (default: "exact").
#' @return List containing:
#'   \item{best_match}{Data frame with the best matching row(s)}
#'   \item{simulated_data}{Data frame with all simulated combinations}
#'   \item{match_indices}{Row indices of best matches}
#'   \item{decrement_info}{Information about decrement steps used}
#' @export
#' @examples
#' # Example with percentage data
#' data_A <- data.frame(Protein = 20, Lipid = 10, Ash = 5, Carbs = 65)
#' data_B <- data.frame(Protein = 15, Lipid = 8, Ash = 4, Carbs = 73)
#' 
#' # With custom decrement steps
#' result <- simulate_decrement(
#'   data_A, data_B, 
#'   decrement_steps = c(Protein = 0.1, Lipid = 0.01, Ash = 0.1, Carbs = 1)
#' )
simulate_decrement <- function(data_A, data_B, 
                                             reference_row = 1,
                                             decrement_steps = NULL,
                                             tolerance = NULL,
                                             match_method = "exact") {
  
  # Convert to data frame if needed
  if (!is.data.frame(data_A)) {
    data_A <- as.data.frame(data_A)
  }
  if (!is.data.frame(data_B)) {
    data_B <- as.data.frame(data_B)
  }
  
  # Check dimensions
  if (ncol(data_A) != ncol(data_B)) {
    stop("data_A and data_B must have the same number of columns")
  }
  
  if (reference_row < 1 || reference_row > nrow(data_A)) {
    stop("reference_row must be a valid row index in data_A")
  }
  
  # Get reference values from data_A
  ref_values <- as.numeric(data_A[reference_row, ])
  names(ref_values) <- colnames(data_A)
  
  # Get target values from data_B (use first row if multiple)
  target_values <- as.numeric(data_B[1, ])
  names(target_values) <- colnames(data_B)
  
  # Auto-calculate decrement steps if not provided
  if (is.null(decrement_steps)) {
    # Use 1% of initial value as default step, with minimum of 0.01
    decrement_steps <- pmax(ref_values * 0.01, 0.01)
    names(decrement_steps) <- names(ref_values)
  } else if (length(decrement_steps) == 1) {
    # Apply single value to all elements
    decrement_steps <- rep(decrement_steps, length(ref_values))
    names(decrement_steps) <- names(ref_values)
  } else {
    # Ensure names match
    if (is.null(names(decrement_steps))) {
      names(decrement_steps) <- names(ref_values)
    }
  }
  
  # Create sequences from reference values down to 0
  sequences <- list()
  for (i in 1:length(ref_values)) {
    elem_name <- names(ref_values)[i]
    start_val <- ref_values[i]
    step <- decrement_steps[elem_name]
    sequences[[elem_name]] <- seq(start_val, 0, by = -step)
  }
  
  # Generate all combinations using expand.grid
  combinations <- expand.grid(sequences)
  colnames(combinations) <- names(ref_values)
  
  # Calculate total for each row
  combinations$total <- rowSums(combinations)
  
  # Remove rows where total is zero (all elements depleted)
  combinations <- combinations[combinations$total > 0, ]
  
  # Calculate compositional percentages
  for (i in 1:length(ref_values)) {
    elem_name <- names(ref_values)[i]
    pc_col_name <- paste0("pc_", tolower(elem_name))
    combinations[, pc_col_name] <- (combinations[, elem_name] / combinations$total) * 100
  }
  
  # Find best matches
  if (match_method == "exact") {
    # Find rows where compositional percentages match target (within small tolerance)
    if (is.null(tolerance)) {
      tolerance <- rep(0.01, length(target_values))  # 0.01% default tolerance
      names(tolerance) <- names(target_values)
    } else if (length(tolerance) == 1) {
      tolerance <- rep(tolerance, length(target_values))
      names(tolerance) <- names(target_values)
    }
    
    match_conditions <- rep(TRUE, nrow(combinations))
    for (i in 1:length(target_values)) {
      elem_name <- names(target_values)[i]
      pc_col_name <- paste0("pc_", tolower(elem_name))
      target_pc <- target_values[i] / sum(target_values) * 100
      
      match_conditions <- match_conditions & 
        (abs(combinations[, pc_col_name] - target_pc) <= tolerance[elem_name])
    }
    
    matched_rows <- combinations[match_conditions, ]
    
  } else if (match_method == "range") {
    # Range-based matching (if tolerance ranges provided)
    if (is.null(tolerance)) {
      stop("tolerance must be provided for range-based matching")
    }
    
    match_conditions <- rep(TRUE, nrow(combinations))
    for (i in 1:length(target_values)) {
      elem_name <- names(target_values)[i]
      pc_col_name <- paste0("pc_", tolower(elem_name))
      target_pc <- target_values[i] / sum(target_values) * 100
      
      if (length(tolerance[[elem_name]]) == 2) {
        match_conditions <- match_conditions & 
          (combinations[, pc_col_name] >= (target_pc - tolerance[[elem_name]][1])) &
          (combinations[, pc_col_name] <= (target_pc + tolerance[[elem_name]][2]))
      } else {
        stop("tolerance must be a list of 2-element vectors for range matching")
      }
    }
    
    matched_rows <- combinations[match_conditions, ]
    
  } else {
    stop("match_method must be 'exact' or 'range'")
  }
  
  # If no exact matches, find closest match by minimizing sum of squared differences
  if (nrow(matched_rows) == 0) {
    # Calculate compositional percentages for target
    target_total <- sum(target_values)
    target_pc <- (target_values / target_total) * 100
    
    # Calculate distance for each row
    distances <- numeric(nrow(combinations))
    for (i in 1:length(target_values)) {
      elem_name <- names(target_values)[i]
      pc_col_name <- paste0("pc_", tolower(elem_name))
      distances <- distances + (combinations[, pc_col_name] - target_pc[i])^2
    }
    
    # Find row with minimum distance
    best_idx <- which.min(distances)
    matched_rows <- combinations[best_idx, , drop = FALSE]
  }
  
  # Sort by total (descending) to get rows with smallest decrement
  matched_rows <- matched_rows[order(matched_rows$total, decreasing = TRUE), ]
  
  # Prepare result
  result <- list(
    best_match = matched_rows[1, , drop = FALSE],
    all_matches = matched_rows,
    simulated_data = combinations,
    match_indices = which(rownames(combinations) %in% rownames(matched_rows)),
    decrement_info = list(
      reference_values = ref_values,
      target_values = target_values,
      decrement_steps = decrement_steps,
      n_combinations = nrow(combinations),
      n_matches = nrow(matched_rows)
    )
  )
  
  return(result)
}

#' Filter Simulated Data by Compositional Ranges
#'
#' Filter simulated compositional data based on ranges (e.g., mean ± SD).
#' This is a helper function that works with the output of 
#' \code{simulate_decrement()}.
#'
#' @param simulated_data Data frame with simulated combinations (from 
#'   \code{simulate_decrement()$simulated_data}).
#' @param ranges Named list of ranges. Each element should be a named vector 
#'   with 'min' and 'max' values, or a data frame with min/max columns.
#' @return Filtered data frame matching the specified ranges.
#' @export
#' @examples
#' # After running simulate_decrement()
#' # result <- simulate_decrement(data_A, data_B)
#' # 
#' # Define ranges (e.g., mean ± SD)
#' # ranges <- list(
#' #   Protein = c(min = 3.0, max = 5.0),
#' #   Lipid = c(min = 0.7, max = 1.2),
#' #   Ash = c(min = 28.0, max = 34.0),
#' #   NFE = c(min = 60.0, max = 67.0)
#' # )
#' # 
#' # filtered <- filter_by_compositional_ranges(result$simulated_data, ranges)
filter_by_compositional_ranges <- function(simulated_data, ranges) {
  if (!is.data.frame(simulated_data)) {
    stop("simulated_data must be a data frame")
  }
  
  if (!is.list(ranges)) {
    stop("ranges must be a named list")
  }
  
  # Start with all rows
  filtered <- simulated_data
  row_mask <- rep(TRUE, nrow(simulated_data))
  
  # Apply each range filter
  for (elem_name in names(ranges)) {
    range_vals <- ranges[[elem_name]]
    
    # Handle different input formats
    if (is.data.frame(range_vals)) {
      # If it's a data frame, look for min/max columns
      if ("min" %in% colnames(range_vals) && "max" %in% colnames(range_vals)) {
        min_val <- range_vals$min[1]
        max_val <- range_vals$max[1]
      } else if (length(colnames(range_vals)) >= 2) {
        min_val <- range_vals[1, 1]
        max_val <- range_vals[1, 2]
      } else {
        stop(paste("Cannot determine min/max for", elem_name))
      }
    } else if (is.numeric(range_vals) && length(range_vals) == 2) {
      min_val <- min(range_vals)
      max_val <- max(range_vals)
    } else if (!is.null(names(range_vals)) && "min" %in% names(range_vals) && "max" %in% names(range_vals)) {
      min_val <- range_vals["min"]
      max_val <- range_vals["max"]
    } else {
      stop(paste("Invalid range format for", elem_name))
    }
    
    # Find the percentage column name
    pc_col_name <- paste0("pc_", tolower(elem_name))
    
    # If percentage column doesn't exist, use absolute column
    if (pc_col_name %in% colnames(filtered)) {
      col_to_filter <- pc_col_name
    } else if (elem_name %in% colnames(filtered)) {
      col_to_filter <- elem_name
    } else {
      warning(paste("Column for", elem_name, "not found, skipping"))
      next
    }
    
    # Apply filter
    row_mask <- row_mask & 
      (filtered[, col_to_filter] >= min_val) & 
      (filtered[, col_to_filter] <= max_val)
  }
  
  filtered <- filtered[row_mask, ]
  
  return(filtered)
}
