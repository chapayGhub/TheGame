//
//  Definitions.h
//  TheGame
//
//  Created by kcy1860 on 12/10/12.
//
//

#ifndef TheGame_Definitions_h
#define TheGame_Definitions_h

//检查方向
typedef enum {
	OrientationHori,
	OrientationVert,
} Orientation;

//孢子种类
typedef enum {
    SuperGerm,  //超级吃撑孢子
    BombGerm,   //计步数炸弹孢子
    PoisonousGerm,//毒药孢子
    TimeBombGerm, //计时炸弹孢子
    FixedGerm,    //固定孢子
    NormalGerm,   //普通孢子
} GermType;


typedef enum{
    Classic,
    Bomb,
    Poisonous,
    TimeBomb,
}GameType;


#endif
