cmake_minimum_required(VERSION 2.8)
project( DisplayImage )
find_package( OpenCV 3 REQUIRED )
add_executable( harris_corner harris_corner.cpp )
target_link_libraries( harris_corner ${OpenCV_LIBS} )
