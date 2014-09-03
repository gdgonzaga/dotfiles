/* config.h for bipolarbar.c */
#ifndef CONFIG_H
#define CONFIG_H

#define TOP_BAR 0        // 0=Bar at top, 1=Bar at bottom
#define BAR_HEIGHT 18
#define BAR_WIDTH 1000      // 0=Full width or use num pixels
;// If font isn't found 'fixed" will be used
// #define FONT "-*-terminusmod.icons-medium-r-*-*-12-*-*-*-*-*-*-*,-*-stlarch-medium-r-*-*-12-*-*-*-*-*-*-*"
#define FONT "-*-dina-medium-r-*-*-*-*-*-*-*-*-*-*"
#define FONTS_ERROR 1      // 0 to have missing fonts error shown
// colours are for background and the text
#define colour0 "#000000"  // Background colour. The rest colour the text
#define colour1 "#0e69d6"  // &1 CURRENT
#define colour2 "#999999"  // &2 not current
#define colour3 "#bbbbbb"  // &3 tiling mode
#define colour4 "#ff0000"  // &4 urgent
#define colour5 "#664422"  // &5 separator
#define colour6 "#0e69d6"  // &6 conkey labels
#define colour7 "#bbbbbb"  // &7 conky values
#define colour8 "#997755"
#define colour9 "#00dd99"  // &9
#endif
