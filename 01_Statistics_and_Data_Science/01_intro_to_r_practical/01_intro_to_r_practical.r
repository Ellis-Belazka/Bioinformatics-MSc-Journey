# ==============================================================================
# Statistics & Data Science - Practical 1: An Introduction to R
# Bioinformatics MSc
# ==============================================================================

# Note: Set your working directory manually or use an R project directory
# getwd()

# Writing a test file to see if it saves in the directory
# write(1:10, file = "test.txt")

# Getting help 
# help.start()

# Exiting R session (commented out for execution safety)
# q()

# ------------------------------------------------------------------------------
# Arithmetic & Basic Operations
# ------------------------------------------------------------------------------
3 + 5
123 / 135.6
2^9
pi
4 * pi * 2^3 / 3
4 * pi * (2^3) / 3
(4 * pi * 2)^3 / 3

x <- 3
y <- 5
z = x * y
print(z)

# ------------------------------------------------------------------------------
# Vectors & Sequences
# ------------------------------------------------------------------------------
v <- c(2, 7, 3, 10, -1) # defining vector v
w <- 1:5                # defining vector w

u = v * w
u # Multiplies vector v and w together 

# Applying functions to vector
exp(v) # All values in vector v were exp(v)
log(v)
exp(log(v))

# Using the seq() function to generate a sequence of numbers
x = seq(0, 10, 0.1)
x # x is a sequence of numbers from 0 to 10, going up in 0.1
?seq

# Accessing a particular element in a vector 
x = 5:10 # x goes from numbers 5 to 10 
x[2]    # Accesses the second element of x, which is 6

v = c(2, 7, 3, 10, -1)
v[v > 3] # selects the elements in v that are greater than the number 3

# Exercise 1.1: Explain the outputs for the following commands
v[v > 3]
sum(v > 3) 
# this produces the output 2 because True = 1 and False = 0, 0 + 1 + 0 + 1 + 0 = 2

which(v > 3) # Indicates the positions which satisfy condition of v > 3 (positions 2 and 4)

# Vectors can be combined into a single vector using concatenate function
v = 1:9
w = 101:109 
u = c(v, w)
u

# To make a vector empty
v = NULL

# To remove a data or function object 
rm(u) # removed u

# To list all user defined objects in the workspace 
ls()

# Removes all user defined variables in workspace (commented out for script safety)
# rm(list = ls())

# ------------------------------------------------------------------------------
# 1.3 Plots
# ------------------------------------------------------------------------------

# Producing a simple graph 
x <- seq(1, 10, 0.4) # creating a vector assigned to x 
y <- (x^3 - 4*x^2 - 35*x) # defining the equation of the graph
plot(x, y) # plotting the graph 

# Redo plot using a red line and changing vertical scale
plot(x, y, type = "l", col = "red", ylim = c(-200, 300))

# Redo plot using blue points overlayed by a line 
plot(x, y, type = "o", col = "blue", ylim = c(-200, 300))

# Adding a horizontal x-axis line at y = 0 
lines(c(0, 10), c(0, 0), col = "black")

# Adding additional lines to the graph
lines(x, (x^2 + 4*x + 9), col = "red", lty = 2)
lines(x, (-2*x^2 + 4*x + 14), col = "green", lty = 3)

# Adding a title to the graph 
title(main = "polynomial plot", col.main = "black", font.main = 14)

# ------------------------------------------------------------------------------
# 1.4 Box plots
# ------------------------------------------------------------------------------

# Reading the dataset into a data object
# Note: Ensure 'protein_interface_data.txt' is placed in your active working directory
interface_data <- read.table("protein_interface_data.txt")

# Assigning names to the three vectors of data in the dataset
names(interface_data) <- c("PDBcode", "protein_type", "area")

# Viewing the column names
colnames(interface_data)

# Extracting the "area" column vector
areas <- interface_data$area

# Exercise 1.2: Compute statistics & plot boxplot
original_par <- par() # Store original graphical parameters

# Changing parameters for display
par(pin = c(3, 1), font = 2, ps = 10, family = "sans")

# Plotting the horizontal boxplot
boxplot(areas, horizontal = TRUE, xlab = "crystal interface areas")

# Restore original parameters
suppressWarnings(par(original_par))

# Separate monomer and dimer areas
areas_dimer <- interface_data$area[interface_data$protein_type == "d"]
areas_monomer <- interface_data$area[interface_data$protein_type == "m"]

# Exercise 1.3: Produce side-by-side boxplots for monomers and dimers
par(mfrow = c(1, 2))

boxplot(areas_dimer, ylim = c(0, 6000), col = "transparent", lwd = 2)
title(ylab = "dimer crystal interface areas", font = 2, col.main = "black", font.main = 2)

boxplot(areas_monomer, ylim = c(0, 6000), col = "transparent", lwd = 2)
title(ylab = "monomer crystal interface areas", col.main = "black", font.main = 2)

# Summary statistics
summary(areas_dimer)
summary(areas_monomer)

# Reset grid layout
par(mfrow = c(1, 1))

# ------------------------------------------------------------------------------
# 1.5 Histograms
# ------------------------------------------------------------------------------

# Bins setup
my.breaks <- seq(0, 8000, by = 350)

# Exercise 1.4: Produce histograms for monomers and dimers
par(mfrow = c(1, 2))

hist(areas_monomer,
     breaks = my.breaks,
     lwd = 2,
     lwd.axis = 2,
     main = "Monomers",
     xlab = "Interface area (Angstroms)",
     ylab = "Frequency")

hist(areas_dimer,
     breaks = my.breaks,
     lwd = 2,
     lwd.axis = 2,
     main = "Dimers",
     xlab = "Interface area (Angstroms)",
     ylab = "Frequency")

par(mfrow = c(1, 1))

# ------------------------------------------------------------------------------
# Exporting Plots
# ------------------------------------------------------------------------------

# Example code for exporting plot to JPEG
# jpeg("monomer_vs_dimer_protein_interface_comparison.jpg", width = 800, height = 500)
# par(mfrow = c(1, 2))
# hist(areas_monomer, breaks = my.breaks, lwd = 2, lwd.axis = 2, main = "Monomers", xlab = "Interface area (Angstroms)", ylab = "Frequency")
# hist(areas_dimer, breaks = my.breaks, lwd = 2, lwd.axis = 2, main = "Dimers", xlab = "Interface area (Angstroms)", ylab = "Frequency")
# dev.off()
# par(mfrow = c(1, 1))