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
ggplot(data = interviews_plotting,
       aes(x = no_membrs, y = number_items))

# add geom to specify how to plot the data
ggplot(data = interviews_plotting,
       aes(x = no_membrs, y = number_items)) +
      geom_point()

# split the instructions to save the base and then make amendments to the geom
interview_plot <- ggplot(data = interviews_plotting,
       aes(x = no_membrs, y = number_items))

interview_plot +
  geom_point()

# change transparency of points
ggplot(data = interviews_plotting,
       aes(x = no_membrs, y = number_items)) +
  geom_point(alpha = 0.5)

# add jitter so points aren't on top of each other 
ggplot(data = interviews_plotting,
       aes(x = no_membrs, y = number_items)) +
  geom_jitter(alpha = 0.5)

# adjust the amount of jitter: width is horizontal jiter, height is vertical jitter
ggplot(data = interviews_plotting,
       aes(x = no_membrs, y = number_items)) +
  geom_jitter(alpha = 0.5, width = 0.15, height = 0.15)

# save plot --> specify file to create, plot to save, dimensions, resolution
interviews_plot <- ggplot(data = interviews_plotting,
                          aes(x = no_membrs, y = number_items)) +
                          geom_jitter(alpha = 0.5, width = 0.15, height = 0.15)

ggsave("fig_output/membrs_item.png", interviews_plot, width = 15, height = 10, dpi = 300)







