cmake_minimum_required(VERSION 2.8)
project( DisplayImage )
find_package( OpenCV REQUIRED )
add_executable( morph  cv_morph.cpp )
target_link_libraries( morph ${OpenCV_LIBS} )
