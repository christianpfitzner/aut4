#include "opencv2/imgproc.hpp"
#include "opencv2/highgui.hpp"
#include <iostream>
using namespace cv;
using namespace std;

Mat src, erosion_dst, dilation_dst, opening_dst, opening_dst_tmp, closing_dst, closing_dst_tmp;
int erosion_elem = 0;
int erosion_size = 0;

int dilation_elem = 0;
int dilation_size = 0;

int opening_elem = 0; 
int opening_size = 0; 

int closing_elem = 0; 
int closing_size = 0; 

int const max_elem = 2;
int const max_kernel_size = 21;


void Erosion( int, void* );
void Dilation( int, void* );
void Opening( int, void* );
void Closing( int, void* );

int main( int argc, char** argv )
{

    if ( argc != 2 )
    {
        printf("usage: DisplayImage.out <Image_Path>\n");
        return -1;
    }

  src = imread( argv[1], 1 );



  if( src.empty() )
  {
    cout << "Could not open or find the image!\n" << endl;
    cout << "Usage: " << argv[0] << " <Input image>" << endl;
    return -1;
  }


  namedWindow( "Erosion Demo", WINDOW_AUTOSIZE );
  namedWindow( "Dilation Demo", WINDOW_AUTOSIZE );
  namedWindow( "Opening  Demo", WINDOW_AUTOSIZE );
  namedWindow( "Closing  Demo", WINDOW_AUTOSIZE );

  moveWindow(  "Dilation Demo", src.cols*1, 0 );
  moveWindow(  "Opening  Demo", src.cols*2, 0 );
  moveWindow(  "Closing  Demo", src.cols*3, 0); 

  createTrackbar( "Element:\n 0: Rect \n 1: Cross \n 2: Ellipse", "Erosion Demo",
          &erosion_elem, max_elem,
          Erosion );
  createTrackbar( "Kernel size:\n 2n +1", "Erosion Demo",
          &erosion_size, max_kernel_size,
          Erosion );

  createTrackbar( "Element:\n 0: Rect \n 1: Cross \n 2: Ellipse", "Dilation Demo",
          &dilation_elem, max_elem,
          Dilation );
  createTrackbar( "Kernel size:\n 2n +1", "Dilation Demo",
          &dilation_size, max_kernel_size,
          Dilation );

  createTrackbar( "Element:\n 0: Rect \n 1: Cross \n 2: Ellipse", "Opening Demo",
          &opening_elem, max_elem,
          Opening );
  createTrackbar( "Kernel size:\n 2n +1", "Opening Demo",
          &opening_size, max_kernel_size,
          Opening );

  createTrackbar( "Element:\n 0: Rect \n 1: Cross \n 2: Ellipse", "Closing Demo",
          &closing_elem, max_elem,
          Closing );
  createTrackbar( "Kernel size:\n 2n +1", "Closing Demo",
          &closing_size, max_kernel_size,
          Closing );

  Erosion( 0, 0 );
  Dilation( 0, 0 );
  Opening(0, 0); 
  Closing(0, 0); 
  waitKey(0);
  return 0;
}


void Erosion( int, void* )
{
  int erosion_type = 0;
  if( erosion_elem == 0 ){ erosion_type = MORPH_RECT; }
  else if( erosion_elem == 1 ){ erosion_type = MORPH_CROSS; }
  else if( erosion_elem == 2) { erosion_type = MORPH_ELLIPSE; }
  Mat element = getStructuringElement( erosion_type,
                       Size( 2*erosion_size + 1, 2*erosion_size+1 ),
                       Point( erosion_size, erosion_size ) );
  erode( src, erosion_dst, element );
  imshow( "Erosion Demo", erosion_dst );
}


void Dilation( int, void* )
{
  int dilation_type = 0;
  if( dilation_elem == 0 ){ dilation_type = MORPH_RECT; }
  else if( dilation_elem == 1 ){ dilation_type = MORPH_CROSS; }
  else if( dilation_elem == 2) { dilation_type = MORPH_ELLIPSE; }
  Mat element = getStructuringElement( dilation_type,
                       Size( 2*dilation_size + 1, 2*dilation_size+1 ),
                       Point( dilation_size, dilation_size ) );
  dilate( src, dilation_dst, element );
  imshow( "Dilation Demo", dilation_dst );
}


void Opening( int, void* )
{
  int opening_type = 0;
  if( opening_elem == 0 ){ opening_type = MORPH_RECT; }
  else if( opening_elem == 1 ){ opening_type = MORPH_CROSS; }
  else if( opening_elem == 2) { opening_type = MORPH_ELLIPSE; }
  Mat element = getStructuringElement( opening_type,
                       Size( 2*opening_size + 1, 2*opening_size+1 ),
                       Point( opening_size, opening_size ) );
  erode( src, opening_dst_tmp, element );
  dilate(erosion_dst, opening_dst, element);  
  imshow( "Opening Demo", opening_dst );
}


void Closing( int, void* )
{
  int closing_type = 0;
  if( closing_elem == 0 ){ closing_type = MORPH_RECT; }
  else if( closing_elem == 1 ){ closing_type = MORPH_CROSS; }
  else if( closing_elem == 2) { closing_type = MORPH_ELLIPSE; }
  Mat element = getStructuringElement( closing_type,
                       Size( 2*closing_size + 1, 2*closing_size+1 ),
                       Point( closing_size, closing_size ) );
  dilate( src, closing_dst_tmp, element );
  erode(dilation_dst, closing_dst, element);  
  imshow( "Closing Demo", closing_dst );
}

