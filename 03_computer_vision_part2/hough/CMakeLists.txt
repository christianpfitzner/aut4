cmake_minimum_required(VERSION 2.8)
project( cvHough )
find_package( OpenCV REQUIRED )
add_executable( hough  cv_hough.cpp )
target_link_libraries( hough ${OpenCV_LIBS} )
