
# -------- Description

# The following routines

require(av)
library(magick)
library(tesseract)

setwd("<DIRECTORY>")


# --------  convert avi to jpeg 

av_video_images("TLC00013.AVI", destdir = "jpeg_TLC00013")


# -------- read time stamp from jpeg

lim_top = 690
lim_bottom = 720
lim_left = 395
lim_right = 900

eng = tesseract(options = list(tessedit_char_whitelist = "0123456789/: "), language = "eng") # set vocab and limit possible characters to be extracted

all_pics = list.files("jpeg_TLC00015", full.names = T)
date_time = list()

for(pic in 1:length(all_pics)){
  input <- image_read(all_pics[pic]) %>%# image_convert(type = 'Grayscale') %>%
    .[[1]] %>% 
    as.numeric()
  input_cut = input[c(lim_top:lim_bottom),c(lim_left:lim_right),] # crop time stamp section
  input_cut = (abs(input_cut-1)) # convert to black font on white background
  input_cut[input_cut <= 0.3] = 0 # set threshold
  input_cut[input_cut > 0.3] = 1 # set threshold
  input_cut[1:15,,] = 1 # insert upper margin; enhances character detection
  input_cut = abind(input_cut, input_cut[1:12,,], along=1)  # insert lower margin; enhances character detection

  date_time[[pic]] = input_cut  %>% image_read() %>% image_resize("280x") %>% tesseract::ocr(engine = eng) # resizing enhances character detection (fine tuning can be necessary)
}

date_time = do.call(rbind, date_time)
date_time
# write.csv....

