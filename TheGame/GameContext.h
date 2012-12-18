//
//  GameContext.h
//  TheGame
//
//  Created by kcy1860 on 12/9/12.
//
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface GameContext : NSObject

@property (nonatomic) GameType type; //当前游戏类型
@property (nonatomic) int level; // 当前关卡数
@property (nonatomic) int levelScore; // 达标分数,如果为0代表没有levelScore

@property (nonatomic) int time; //时间（s），如果时间是0代表不倒计时
@property (nonatomic) int kindCount; //孢子种类数
@property (nonatomic) int interval; //刷新炸弹/毒药孢子的间隔步数/时间

-(id) initWithValues:(GameType)gameType Level:(int)levelcount Score:(int)levelscore Time:(int)atime KindCound:(int)kindcount Interval:(int)ainteval;
-(GameContext*) getNextLevel;
@end
