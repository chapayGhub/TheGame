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
#define kStartX 10
#define kStartY 120

/**box的大小*/
#define kBoxWidth 7
#define kBoxHeight 7

/**box中每个格子的大小*/
#define kTileSize 43.0f

#define kMoveTileTime 0.1f// 孢子移动的时间
#define kShineFreq 0.3f//孢子被选中闪烁的速度
#define kConvergeTime 0.2f//孢子合并的时间




#define kMaxLevelNo 10
#define kMaxRecordCount 5
#define kKindCount 4

typedef enum {
	OrientationHori,
	OrientationVert,
} Orientation;

typedef enum {
    SuperGerm,
    BombGerm,
    PoisonousGerm,
    NormalGerm,
} GermType;

#endif
