
# -------- Description

# The following routines

require(av)
library(magick)
require(ggplot2)
library(tesseract)

setwd(<DIRECTORY>)


# --------  convert avi to jpeg 

av_video_images("TLC00012.AVI", destdir = "jpeg_TLC00012")
av_video_images("TLC00013.AVI", destdir = "jpeg_TLC00013")


# -------- read time stamp from jpeg

lim_top = 700
lim_bottom = 720
lim_left = 400
lim_right = 900
eng = tesseract("eng")

all_pics = list.files("jpeg_TLC00013", full.names = T)
date_time = list()

for(pic in 1:length(all_pics)){
  input <- image_read(all_pics[pic]) %>% 
    .[[1]] %>% 
    as.numeric()  # cause numerics are just easier to work with
  input_cut = input[c(lim_top:lim_bottom),c(lim_left:lim_right),]
  input_cut = (abs(input_cut-1)) # to black font on white background
  input_cut[input_cut <= 0.3] = 0 # set threshold
  input_cut[input_cut > 0.3] = 1 # set threshold
  date_time[[pic]] = input_cut  %>% image_read() %>% tesseract::ocr(engine = eng)
}

date_time = do.call(rbind, date_time)
# write.csv....

