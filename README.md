# Brinno_tlc200pro_avi_to_jpeg_meta
This script is intended to extract single frames with their respective acquisiton date from Brinno-TLC200 time lapse cameras (here TLC-200 Pro). The script should also work with TLC 200 (same resolution). These cameras record avi files that optionally contain a time stamp at the bottom. The first part of the scripts converts the .avi files from a to .jpeg into a defined folder. Secondly, the tesseract package is used to extract the time stamp from the section at the bottom of each image using a optical character recognition (OCR) based on Deep Neural networks (LSTM).

Fine tuning might be necessary for different settings (e.g. image_resize).

![Alt text](https://github.com/tejakattenborn/Brinno_tlc200pro_avi_to_jpeg_meta/blob/main/image_000007.jpg?raw=true)
Output: "2021/03/13 16:36:59\n"
