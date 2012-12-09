//
//  Header.h
//  TheGame
//
//  Created by kcy1860 on 12/6/12.
//
//

#ifndef TheGame_Constants_h
#define TheGame_Constants_h

/***这两个参数决定box的位置***/
#define kStartX 20
#define kStartY 30


#define kTileSize 40.0f
#define kMoveTileTime 0.3f
#define kBoxWidth 7
#define kBoxHeight 7


#define kMaxLevelNo 10
#define kMaxRecordCount 5
#define kKindCount 8

typedef enum {
	OrientationHori,
	OrientationVert,
} Orientation;


#endif
