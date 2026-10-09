# Practical 2 — Probability and Distributions

**Module:** Statistics and Data Science  
**Programme:** MSc Bioinformatics, Birkbeck, University of London  
**Completed:** October 2026

## Overview

This practical builds on my introduction to R by exploring probability distributions and repeated operations. The examples use nucleotide composition, inheritance and sequencing errors to practise probability calculations, followed by simulations of uniform samples and combined measurement error.

The script retains my working notes, comments and step-by-step experiments as a record of my learning. It is coursework practice rather than a finished research analysis.

## Skills practised

- Calculating binomial probabilities with `dbinom()` and `pbinom()`.
- Adding probabilities and using complements to answer questions about ranges of outcomes.
- Plotting probability mass functions and cumulative distributions.
- Using `which.max()` to find the most likely count.
- Calculating a Poisson mean from an error rate and chromosome length.
- Using `dpois()`, `ppois()` and `qpois()` to explore probabilities and quantiles.
- Overlaying distributions with `lines()` and adding reference lines and legends.
- Generating uniform random samples using `runif()`.
- Repeating operations with `for` loops and storing results in vectors.
- Exploring sample-size effects and the law of large numbers.
- Simulating sums of independent error sources to explore the central limit theorem.

## File

| File | Description |
| --- | --- |
| [02_R_Probability_and_Distributions.R](02_R_Probability_and_Distributions.R) | Coursework script with exercises, working notes, plots and simulations |

No external dataset is required. The script uses theoretical distributions and generates its own random samples.

## How to run

1. Open the script in R or RStudio.
2. Run each section from top to bottom so its variables are defined before they are used.
3. Inspect numerical results in the console and plots in the graphics window or RStudio Plots pane.

Only functions supplied with R are used; no additional packages are needed. There are no file-path dependencies.

Several loops include `Sys.sleep(1)` to allow time to inspect successive histograms. Together these pauses add about 25 seconds when running the whole script. Plots are displayed but not automatically exported. When sourcing the file, use `source("02_R_Probability_and_Distributions.R", echo = TRUE)` from this folder to display the expressions and their results.

## Notes on interpretation

The sequencing exercise uses the stated length of 45,000,000 base pairs and a rate of one error per 200,000 base pairs. This gives an expected count of 225 errors, reduced to 135 when the rate falls by 40%. The length is not doubled for two strands because the supplied rate is already per base pair.

The random simulations have no fixed seed, so the samples and plots vary between runs. Increasing sample size generally stabilises the sample mean around 0.5 for Uniform(0, 1); it does not guarantee that every successive estimate is closer.

## Review and learning record

The original work was reviewed with ChatGPT. Targeted corrections addressed the sequencing-error calculation and dependent plots, a uniform-sampling limit, plotting arguments and explanatory comments. The exercise structure and working style were retained.

Two follow-up tasks remain: adding the new sequencing method's cumulative-distribution plot and calculating its probability of exceeding the old method's 95th percentile. The current script explores the latter visually.

The reviewed version has not yet been verified by a full execution in R as part of this review.

## Context

Based on the Probability and Distributions practical for the Statistics and Data Science module. Biological examples are teaching exercises used to practise probability modelling.

[Back to Statistics and Data Science](../README.md)
