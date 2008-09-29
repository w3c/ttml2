
#include <windows.h>

#define ptrdiff(p,q) ((unsigned)((const BYTE *)p - (const BYTE *)q))

int main ( int argc, char ** argv )
{
  OUTLINETEXTMETRICW otm;
  printf ( "otmTextMetrics:           %4d\n", ptrdiff ( &otm.otmTextMetrics, &otm ) );
  printf ( "otmTextMetrics.tmCharSet: %4d\n", ptrdiff ( &otm.otmTextMetrics.tmCharSet, &otm ) );
  printf ( "otmFiller:                %4d\n", ptrdiff ( &otm.otmFiller, &otm ) );
  printf ( "otmPanoseNumber:          %4d\n", ptrdiff ( &otm.otmPanoseNumber, &otm ) );
  printf ( "otmfsSelection:           %4d\n", ptrdiff ( &otm.otmfsSelection, &otm ) );
  printf ( "otmrcFontBox:             %4d\n", ptrdiff ( &otm.otmrcFontBox, &otm ) );
  printf ( "otmMacAscent:             %4d\n", ptrdiff ( &otm.otmMacAscent, &otm ) );
  printf ( "otmpFullName:             %4d\n", ptrdiff ( &otm.otmpFullName, &otm ) );
  printf ( "sizeof(TEXTMETRICW):      %4d\n", sizeof(TEXTMETRICW) );
  return 0;
}
