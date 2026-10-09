# Module: Statistics & Data Science
# Practical 2: Probability and Distributions 

# ==============================================================================

# Cumulative binomial distribution 
barplot(pbinom(0:12, size = 12, prob = 0.8), names.arg = c(0:12), 
        cex.names = 0.8, ylab = "probability", xlab = "Recovered")
# pbinom(q, size, prob) -> Calculates cumulative probability P(X <= q)
# names.arg = 0:12      -> Sets custom bar labels under each bar
# cex.names = 0.8       -> Scales down x-axis bar label font size (80% of default)
# ylab = "..."          -> Sets vertical y-axis label
# xlab = "..."          -> Sets horizontal x-axis label

# Creating a probability mass plot (the binomial distribution is discrete) 
barplot(dbinom(0:12, size = 12, prob = 0.8), 
        names.arg = 0:12, 
        cex.names = 0.8, 
        ylab = "probability", 
        xlab = "Recovered")

# ------------------------------------------------------------------------------

# Exercise 2.1: RNA consists of a sequence of nucleotides A and G (the purines) and U and C 
# (the pyrimidines). If in a certain organism the probability of a purine equals 0.7, and the 
# Occurrence of purines and pyrimidines is, of course, mutually exclusive. ####

# For a microRNA of length 22
# (a) Show that the probability of 14 purines is ~ 14.23%

dbinom(14, size = 22, prob = 0.7)  # 0.1422919 or 14.2%

# (b) Plot the expected probability density for the number of purines 
barplot(dbinom(0:22, size = 22, prob = 0.7),
        names.arg = 0:22, 
        cex.names = 0.8,
        ylab = "probability",
        xlab = "number of purines")


# (c) Plot the expected cumulative distribution for the number of purines 
barplot(pbinom(0:22, size = 22, prob = 0.7), names.arg = c(0:22), 
        cex.names = 0.8, ylab = "Probability", xlab = "Number of purines")


# (d) Show that the probability of less than or equal to 13 purines is ~18.65% 
sum(dbinom(0:13, 22, 0.7))    #  0.1864574 or 18.6%


# (e) Show that the probability of strictly more than 10 purines is ~ 98.6% 
1- sum(dbinom(0:10, 22, 0.7))    # 0.9859649 or 98.6%


# (f) Re-plot the cumulative distribution function using plot( ) instead of barplot

x<- 0:22
plot(x, pbinom(x , size = 22, prob = 0.7),
     cex.axis = 0.8, ylab = "Probability", xlab = "Number of purines") 

# Add a line to the cumulative distribution plot to indicate the median value (50% probability) for the number of purines

abline(h = 0.5, col = "red", lty = 2, lwd = 2)
# h = 0.5   -> Horizontal line at 50% cumulative probability


# ------------------------------------------------------------------------------
# Binomial distribution: Inheritance ####

# Exercise 2.2: If both parents are carriers of the recessive gene causing cystic fibrosis, then 
# each of their children has a probability of 1/4 of being having the disease. 

# (a) What is the probability for exactly one child out of four to have cystic fibrosis?
dbinom(1, size = 4, prob = 0.25)    # Probability of 0.42

# (b) What is the probability that 3 or 4 children will have cystic fibrosis? 

# Here I will add the probabilities 3 children and 4 children together 
sum(dbinom(3, size = 4, prob =  0.25), dbinom(4, size = 4, prob =  0.25))   # Probability of 0.05

# (c) If many similar ‘dual carrier’ couples had a total of 100 children what is the most likely 
#     number of children to have the disease?
 
# To determine what the most likely number is we need to plot the binomial distribution 
barplot(dbinom(0:100, size = 100, prob = 0.25), 
        names.arg = 0:100, 
        cex.names = 0.8, 
        ylab = "probability", 
        xlab = "Number of children")

# From the result, it looks like around 26 children are most likely to have the disease
# Review note: my calculation below confirms 25 children; 26 is the vector position. 

# However, we can find the exact peak by calculating the mode

# Define your parameters (replace with your actual n and p values)
n <- 100
p <- 0.25

# Generate x range from 0 to n
x <- 0:n

# Calculate exact probabilities for every x
probs <- dbinom(x, size = n, prob = p)

# Find the value of x that has the highest probability
most_likely <- x[which.max(probs)]
print(most_likely) # The 26th entry has a value of 25 as the first value is 0 

# ------------------------------------------------------------------------------
# Poisson distribution: ####
# Note: the discrete binomial and Poisson plots show probability mass functions (PMFs),
# even where the exercise wording below calls them density functions (PDFs).

# Exercise 2.3:  The estimated frequency of sequence errors in a particular method of 
# sequencing is 1 error per 200,000 base pairs. The size of chromosome 21 (the smallest chromosome in the human genome)
# is 45 000 000 base pairs.  

# (a) What is the mean number of sequencing errors expected in chromosome 21?

# To calculate the mean, we must calculate lambda 
n <- 45000000 # The error rate is per base pair, so do not double the length for two strands 
p <- 1/200000
lambda = n*p
print(lambda) # 225

# (b) Plot of the probability density function (pdf) for the number of sequencing errors on 
#     chromosome 21. Place a vertical line at the average value.

# Plot a poisson distribution using lambda and take x to be a range around lambda
x <- 150:300
plot(x, dpois(x, lambda = 225), 
     type = "h",      # Draws needle-style vertical bars
     lwd = 2,                                 # Sets bar line thickness
     xlab = "Number of sequencing errors",    # Horizontal axis label
     ylab = "Probability",                    # Vertical axis label 
     main = "Poisson distribution")           # Main title 
# Add a vertical line at the average value 
abline(v = lambda, col = "red", lty = 2, lwd = 2) # v <- standing for vertical line 

# Plot the cumulative distribution function (cdf) for the number of sequencing errors on 
# chromosome 21 and indicate the 0.95 quantile on your plot. 
plot(x, ppois(x, lambda = 225, lower.tail = TRUE, log.p = FALSE),
     type = "h",      
     lwd = 2,
     xlab = "Number of sequencing errors",    
     ylab = "Probability",                     
     main = "Cumulative Poisson distribution")

# Indicating the 0.95 quantile on my cdf
quantile_95 <- qpois(0.95, lambda = 225)
abline(v = quantile_95, col = 'red', lty = 2, lwd = 2)

# If, in a new sequencing method, the error rate is 40% smaller, how do the pdf and cdf 
# plots change. 
n = 45000000 # Use the same length in base pairs for the new method
p = (1/200000)*0.6 # Sequencing error rate is now 40% lower with new sequencing method, so 60% of the old value 
lambda = n*p
print(lambda) # 135 

# pdf plot of new sequencing method 
x <- 70:200
plot(x, dpois(x, lambda = 135), 
     type = "h",      # Draws needle-style vertical bars
     lwd = 2,                                 # Sets bar line thickness
     xlab = "Number of sequencing errors",    # Horizontal axis label
     ylab = "Probability",                    # Vertical axis label 
     main = "Poisson distribution of new sequencing method")  
# From our new plot, we see that the mean sequecing error is lowe  (135), the plot has shifted towards the left 

# Lets try to plot both graphs side by side 
# 1. Define x-ranges and calculate Poisson probabilities
x1 <- 70:200
probs1 <- dpois(x1, lambda = 135)

x2 <- 150:300
probs2 <- dpois(x2, lambda = 225)

# 2. Plot the FIRST distribution (Sets up the coordinate space)
# xlim = c(70, 300) ensures both ranges fit on screen
# ylim = c(0, 0.04)  ensures the full height of both curves fits
plot(x1, probs1, 
     type = "h", 
     col = "blue", 
     lwd = 2,
     xlim = c(70, 300), 
     ylim = c(0, 0.04),
     xlab = "Number of sequencing errors", 
     ylab = "Probability",
     main = "Comparison of Poisson Distributions")

# 3. OVERLAY the SECOND distribution using lines()
lines(x2, probs2, 
      type = "h", 
      col = "red", 
      lwd = 2)

# 4. Add a legend to distinguish the two methods
legend("topright", 
       legend = c("New Method (lambda = 135)", "Old Method (lambda = 225)"),
       col = c("blue", "red"), 
       lwd = 2)
# Show that for the new sequencing method, the proportion of sequencing errors to exceed the 0.95 quantile is close to zero 
quantile_95 <- qpois(0.95, lambda = 225)
abline(v = quantile_95, col = 'red', lty = 2, lwd = 2) 
# Previous 95th quantile if far from distribution of new method- close to 0 

# ------------------------------------------------------------------------------
# Repeated operations in R: The for loop ####


original_par <- par()
# R, like other programming languages, has loops that allow us to repeat operations 
# The for loop has the form: 
# For (each number in i in a sequence of numbers)
#     {repeat the commands in curly brackets}

# Example: 
y <- numeric()     # Create an empty numeric vector 
for (i in 1:4) {   # {Creates continuation line on console
  y[i] <- i + 2
}
y

# Sampling and convergence of the sample mean 
# Lets randomly sample a uniform distribution between 0 and 1 and start by taking 10 samples 

mybreaks <- seq(0,1,0.05) # Generate bin cut points from 0 to 1 in steps of 0.05 (0, 0.05, 0.10, ..., 1.0)
uniform_data <- runif(10,0,1) # Draw 10 random floating-point numbers from a uniform distribution between 0 and 1
hist(uniform_data, breaks = mybreaks) # Plot a histogram using 'mybreaks' to force bins of width 0.05

# Does look very uniform 
# We can do the same thing many times 

for (i in 1:5) {    # Start a loop that runs 5 times (i takes the values 1, 2, 3, 4, 5)
  uniform_data <- runif(10,0,1)
  hist(uniform_data, breaks = mybreaks)
  Sys.sleep(1)    # Waits for 1 second
}
# Sys.sleep(1) pauses for one second so I can inspect each plot before the next one appears.
# It does not save or export the plots.

# Using the for loop in this situation meant that all of the code in the curly brackets repeated 5 times, drawing 
# 5 histograms with a 1 second break between each render 

# Each sample is a rather poor representation of the distribution, which should be constant between zero and one.
# We will need a lot more samples 

# Let’s double the number of samples each time through the loop 

for (i in 1:10) {
  uniform_data <- runif(10*(2^i), 0, 1) # The sample size doubles on every repeat of the code
  hist(uniform_data, breaks = mybreaks)
  Sys.sleep(1)
}
# Since we are generating much larger sample sizes every time we run our histogram, the histogram appears 
# to start matching our theoretical expectations. A small sample size is dominated by 'random noise' wheras
# a larger sample size starts to average out the sampling noise

# We can also calculate some statistics at each sample size: 

# 1. Initialize two empty numeric vectors to store results across loop iterations
samples <- numeric() # Generates an empty vector
mean_values <- numeric()
# 2. Run a loop 10 times (where 'i' goes from 1 to 10)
for (i in 1:10) {
  # 3. Generate a uniform sample where sample size DOUBLES each iteration:
  # i = 1: 10 * 2^1 = 20 numbers
  # i = 2: 10 * 2^2 = 40 numbers
  # ... up to i = 10: 10 * 2^10 = 10,240 numbers
  uniform_data <- runif(10*(2^i),0,1)
  # 4. Store the current sample size in the 'samples' vector at position i
  samples[i] <- 10*(2^i)
  # 5. Calculate and store the mean of the generated sample in 'mean_values'
  mean_values[i] <- mean(uniform_data)
  # 6. Plot a histogram of the sample using your custom bin boundaries 'mybreaks'
  hist(uniform_data, breaks = mybreaks)
  # 7. Pause execution for 1 second so you can visually inspect each plot
  Sys.sleep(1)
}

# This R for loop demonstrates the Law of Large Numbers by showing how increasing the sample size causes the calculated
# sample mean to stabilize around the true theoretical mean (which is 0.5 for a uniform distribution between $0$ and 1).


# ------------------------------------------------------------------------------
# Measurement error ####

# Modelling measurement error and the central limit theorem


# Change 'sources' to see shape transition: 1 (flat) -> 2 (triangle) -> 10+ (bell curve)
sources <- 10             # Number of independent error sources
n_measurements <- 1000    # Number of repeated measurements

total_error <- rep(0, n_measurements)

for (i in 1:sources) {
  # Add noise from each independent uniform source [-1, +1]
  total_error <- total_error + runif(n_measurements, -1, 1)
}

# As 'sources' grows, the distribution becomes approximately bell-shaped
hist(total_error, breaks = 30, main = paste("Total Error with", sources, "Sources"))

# This exercise demonstrates the Central Limit Theorem: 
# For independent, identically distributed variables with finite, non-zero variance,
# the centred and scaled sum approaches a standard Normal distribution as the number of variables increases.
# Here the independent uniform error sources satisfy these conditions, so their sum becomes approximately bell-shaped.
# Measurement error is not always normally distributed; it depends on the sources of error.















