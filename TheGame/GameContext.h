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
@property (nonatomic) int levelScore; // 达标分数
@property (nonatomic) int BombNum;// 炸弹孢子数目
@property (nonatomic) int PoisonousNum; //毒药孢子数目
@property (nonatomic) int time; //时间（s），如果时间是0代表不倒计时

@end
