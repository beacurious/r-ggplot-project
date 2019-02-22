## Use this file to follow along with the live coding exercises.
## The csv file containing the data is in the 'data/' directory.
## If you want to save plots you created, place them in the 'figures/' directory.
## You can create additional R files in the 'scripts/' directory.

# load packages
library(tidyverse)

# import data --> use read_csv (tidyverse version) instead of read.csv (base R version)
interviews_plotting <- read_csv("data_output/interviews_plotting.csv")

# tell ggplot what data we want to use
ggplot(data = interviews_plotting)

# add  specifications for what should be on the x and y axes
ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items))

# add geom to specify how to plot the data
ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items)) +
      geom_point()

# split the instructions to save the base and then make amendments to the geom
interview_plot <- ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items))

interview_plot +
  geom_point()

# change transparency of points
ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items)) +
  geom_point(alpha = 0.5)

# add jitter so points aren't on top of each other 
ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items)) +
  geom_jitter(alpha = 0.5)

# adjust the amount of jitter: width is horizontal jiter, height is vertical jitter
ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items)) +
  geom_jitter(alpha = 0.5, width = 0.15, height = 0.15)

# save plot --> specify file to create, plot to save, dimensions, resolution
interviews_plot <- ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items)) +
  geom_jitter(alpha = 0.5, width = 0.15, height = 0.15)

ggsave("fig_output/membrs_item.png", interviews_plot, width = 15, height = 10, dpi = 300)

# Exercise 3
# It may be possible to enhance the appearance of the plot further by changing the size of the points. 
# Use the size argument to change the point size. Combine this with the width and height arguments to adjust the jitter.
# Try a few different values. Which one do you like best?
  
ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items)) +
  geom_jitter(alpha = 0.5, size = 3, width = 0.2, height = 0.2)

# colour points by a third variable
ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items)) +
  geom_jitter(aes(colour = village), alpha = 0.5, size = 3, width = 0.2, height = 0.2)

# if add colour in the geom means only the points will be coloured, not other elements (only one )
ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items)) +
  geom_jitter(aes(colour = village), alpha = 0.5, size = 3, width = 0.2, height = 0.2) +
  geom_smooth(method = "lm")

# add colour in ggplot function means all future elements will use these colours
ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items, colour = village)) +
  geom_jitter(alpha = 0.5, size = 3, width = 0.2, height = 0.2) +
  geom_smooth(method = "lm")

# save the plot (override the previous file) and git commit
interviews_plot <- ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items, colour = village)) +
  geom_jitter(alpha = 0.5, size = 3, width = 0.2, height = 0.2) +
  geom_smooth(method = "lm")

ggsave("fig_output/membrs_item.png", interviews_plot, width = 15, height = 10)

# Exercise 6
# Use what you just learned to create a scatter plot of rooms by village with the respondent_wall_type 
# showing in different colors. Is this a good way to show this type of data?

ggplot(data = interviews_plotting, aes(x = village, y = rooms, colour = respondent_wall_type)) +
  geom_jitter(alpha = 0.5, size = 2, width = 0.2, height = 0.2)

ggplot(data = interviews_plotting, aes(x = village, y = rooms, fill = respondent_wall_type)) +
  geom_col(position = "dodge")

# create frequency histogram
ggplot(interviews_plotting, aes(x = no_membrs)) +
  geom_histogram(binwidth = 1)

# add white borders around bars
ggplot(interviews_plotting, aes(x = no_membrs)) +
geom_histogram(binwidth = 1, colour = "white")

# colour by a third variable
ggplot(interviews_plotting, aes(x = no_membrs, fill = village)) +
  geom_histogram(binwidth = 1, colour = "white")

# change to frequency polygon (switch fill to colour)
ggplot(interviews_plotting, aes(x = no_membrs, colour = village)) +
  geom_freqpoly(binwidth = 1)

# change to relative frequency (proportions of data collected rather than absolute counts)
ggplot(interviews_plotting, aes(x = no_membrs, y = stat(density), colour = village)) +
  geom_freqpoly(binwidth = 1)

# change to density plot
ggplot(interviews_plotting, aes(x = no_membrs, fill = village, colour = village)) +
  geom_density(alpha = 0.5)

# make a bar chart for categorial data
ggplot(data = interviews_plotting, aes(x = respondent_wall_type)) +
  geom_bar()

# colour by a third variable --> get a stacked bar chart
ggplot(data = interviews_plotting, aes(x = respondent_wall_type, fill = village)) +
  geom_bar()

# make an unstacked bar chart --> can't easily change the column appearance 
ggplot(data = interviews_plotting, aes(x = respondent_wall_type, fill = village)) +
  geom_bar(position = "dodge")

# make an unstacked bar chart with gaps for zero value --> need to do a work around by making a data frame first
counts <- data.frame(table(interviews_plotting$village, interviews_plotting$respondent_wall_type))
counts
ggplot(data = counts, aes(x = Var1, y = Freq, fill = Var2)) +
  geom_col(position = "dodge")

# make separate plots for the 
ggplot(data = interviews_plotting, aes(x = respondent_wall_type, fill = village)) +
  geom_bar(position = "dodge") +
  facet_wrap(~ village)

# make a filled bar chart (shows proportions instead of absolute counts) and change the y axis label
ggplot(data = interviews_plotting, aes(x = respondent_wall_type, fill = village)) +
  geom_bar(position = "fill") +
  ylab("proportion")

#add number labels to the middle of the bars 
ggplot(data = interviews_plotting, aes(x = respondent_wall_type, fill = village)) +
  geom_bar(position = "fill") +
  ylab("proportion") +
  stat_count(geom = "text", aes(label = stat(count)), position = position_fill(vjust = 0.5), colour = "white")

# Exercise 8
# So far you’ve looked at how the different wall types are distributed across the villages. 
# A more interesting question might be what the makeup of wall types within each of the villages is 
# and how they compare to each other.
# Create a plot that shows the proportion of wall types by village. What differences do you notice?
  
ggplot(data = interviews_plotting, aes(x = respondent_wall_type, fill = village)) +
  geom_bar(position = "fill") +
  ylab("proportion") +
  stat_count(geom = "text", aes(label = stat(count)), position = position_fill(vjust = 0.5), colour = "white")

# make a box plot
ggplot(data = interviews_plotting, aes(x = respondent_wall_type, y = rooms)) +
  geom_boxplot()

# add jitter to boxplot with all points one colour
ggplot(data = interviews_plotting, aes(x = respondent_wall_type, y = rooms)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.5, width = 0.2, height = 0.2, colour = "tomato")

# add jitter to boxplot with points coloured by a third variable
ggplot(data = interviews_plotting, aes(x = respondent_wall_type, y = rooms)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.5, width = 0.2, height = 0.2, aes(colour = village))

# Exercise 10
# So far, we’ve looked at the distribution of room number within wall type. 
# Try making a new plot to explore the distribution of another variable within wall type.
# Create a boxplot for liv_count for each wall type. Overlay the boxplot layer on a jitter 
# layer to show actual measurements.
# Add color to the data points on your boxplot according to whether the respondent is a 
# member of an irrigation association (memb_assoc).

ggplot(data = interviews_plotting, aes(x = respondent_wall_type, y = liv_count)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.5, width = 0.2, height = 0.2)

ggplot(data = interviews_plotting, aes(x = respondent_wall_type, y = liv_count)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.5, width = 0.2, height = 0.2, aes(colour = memb_assoc))

# split the box plot by a third variable
ggplot(data = interviews_plotting, aes(x = respondent_wall_type, y = liv_count, colour = memb_assoc )) +
  geom_boxplot(alpha = 0.5) +
  geom_jitter(alpha = 0.5, width = 0.2, height = 0.2)

# split the points to match up with the related box plots (and fill box plot by third variable)
ggplot(data = interviews_plotting, aes(x = respondent_wall_type, y = liv_count, colour = memb_assoc, fill = memb_assoc)) +
  geom_boxplot(alpha = 0.5) +
  geom_point(alpha = 0.5, position = position_jitterdodge(jitter.width = 0.1, jitter.height = 0.1))

## customise plots

# change x & y axis labels and add title
ggplot(data = interviews_plotting, aes(fill = respondent_wall_type, x = village)) +
  geom_bar(position = "fill") +
  stat_count(geom = "text", aes(label = stat(count)), position = position_fill(vjust = 0.5), colour = "white") +
  labs(y = "Proportion", x = "Village", title = "Wall type by village")

# change legend header
ggplot(data = interviews_plotting, aes(fill = respondent_wall_type, x = village)) +
  geom_bar(position = "fill") +
  stat_count(geom = "text", aes(label = stat(count)), position = position_fill(vjust = 0.5), colour = "white") +
  labs(y = "Proportion", x = "Village", title = "Wall type by village") +
  guides(fill = guide_legend(title = "Wall type"))

# change variable names in legend
ggplot(data = interviews_plotting, aes(fill = respondent_wall_type, x = village)) +
  geom_bar(position = "fill") +
  stat_count(geom = "text", aes(label = stat(count)), position = position_fill(vjust = 0.5), colour = "white") +
  labs(y = "Proportion", x = "Village", title = "Wall type by village") +
  scale_fill_discrete(labels = c("Burnt brick", "Cement", "Mud daub", "Sun bricks")) +
  guides(fill = guide_legend(title = "Wall type"))

# make a grid of smaller plots
ggplot(data = interviews_plotting, aes(fill = memb_assoc, x = respondent_wall_type)) +
  geom_bar(position = "fill") +
  stat_count(geom = "text", aes(label = stat(count)), position = position_fill(vjust = 0.5), colour = "white") +
  labs(x = "Wall type", y = "Proportion") +
  facet_wrap(~village, nrow = 2)

# change labels for the x axis variable names
ggplot(data = interviews_plotting, aes(fill = memb_assoc, x = respondent_wall_type)) +
  geom_bar(position = "fill") +
  stat_count(geom = "text", aes(label = stat(count)), position = position_fill(vjust = 0.5), colour = "white") +
  labs(x = "Wall type", y = "Proportion") +
  scale_x_discrete(labels = c("Burnt brick", "Cement", "Mud daub", "Sun bricks")) +
  facet_wrap(~village, nrow = 2)

# rotate variable names so they don't overlap
ggplot(data = interviews_plotting, aes(fill = memb_assoc, x = respondent_wall_type)) +
  geom_bar(position = "fill") +
  stat_count(geom = "text", aes(label = stat(count)), position = position_fill(vjust = 0.5), colour = "white") +
  labs(x = "Wall type", y = "Proportion") +
  scale_x_discrete(labels = c("Burnt brick", "Cement", "Mud daub", "Sun bricks")) +
  facet_wrap(~village, nrow = 2) +
  theme(axis.text.x = element_text(angle = 45))

# change alignment of variable names
ggplot(data = interviews_plotting, aes(fill = memb_assoc, x = respondent_wall_type)) +
  geom_bar(position = "fill") +
  stat_count(geom = "text", aes(label = stat(count)), position = position_fill(vjust = 0.5), colour = "white") +
  labs(x = "Wall type", y = "Proportion") +
  scale_x_discrete(labels = c("Burnt brick", "Cement", "Mud daub", "Sun bricks")) +
  facet_wrap(~village, nrow = 2) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# change background theme
ggplot(data = interviews_plotting, aes(fill = memb_assoc, x = respondent_wall_type)) +
  geom_bar(position = "fill") +
  stat_count(geom = "text", aes(label = stat(count)), position = position_fill(vjust = 0.5), colour = "white") +
  labs(x = "Wall type", y = "Proportion") +
  scale_x_discrete(labels = c("Burnt brick", "Cement", "Mud daub", "Sun bricks")) +
  facet_wrap(~village, nrow = 2) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# add plot title
# change legend heading and wrap text
# change size of x and y axis variable text
# change variable names in legend (including wrapping variable name)
# change values at which tick marks occur
ggplot(data = interviews_plotting, aes(fill = memb_assoc, x = respondent_wall_type)) +
  geom_bar(position = "fill") +
  stat_count(geom = "text", aes(label = stat(count)), position = position_fill(vjust = 0.5), colour = "white") +
  labs(x = "Wall type", y = "Proportion") +
  scale_x_discrete(labels = c("Burnt brick", "Cement", "Mud daub", "Sun bricks")) +
  facet_wrap(~village, nrow = 2) +
  theme_bw() +
  ggtitle("Plot title") +
  guides(fill = guide_legend(title = "Member\nAssociation")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10), 
        axis.text.y = element_text(size = 10),
        plot.title = element_text(hjust = 0.5)) +
  scale_fill_discrete(labels = c("No", "Yes", "No\nAnswer")) +
  scale_y_continuous(breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1))







