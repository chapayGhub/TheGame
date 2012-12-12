//
//  Header.h
//  TheGame
//
//  Created by kcy1860 on 12/6/12.
//
//
#import "Definitions.h"

#ifndef TheGame_Constants_h
#define TheGame_Constants_h

/***这两个参数决定box的位置***/
#define kStartX 10
#define kStartY 118

/**box的大小*/
#define kBoxWidth 7
#define kBoxHeight 7

/**box中每个格子的大小*/
#define kTileSize 43.0f

#define kMoveTileTime 0.2f// 孢子交换的移动的时间
#define kTileDropTime 0.2f// 新孢子产生下落的时间
#define kShineFreq 0.3f//孢子被选中闪烁的速度
#define kConvergeTime 0.2f//孢子合并的时间
#define kFallDownDelayTime 0.3f//孢子下落之前的延迟时间

#define kKindCount 5


/*根据num计算分数的规则*/
// 孢子数*基础分
// （连击数-1）*奖励分
#define basicScore 10
#define bonusScore 20
// 基础间隔时间，如果两次消除的时间在这个时间以内那么算一次连击
#define leastTimeInteval 1.5f

#endif
