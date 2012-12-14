//
//  PlayDisplayLayer.h
//  TheGame
//
//  Created by kcy1860 on 12/11/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
//用于显示游戏界面的各种label和按钮
@interface PlayDisplayLayer : CCLayer{

}


@property (nonatomic) int levelScore;
@property (nonatomic) int score;
@property (nonatomic) int time;

-(id) init;
-(void) startClock;
-(void) stopClock;
-(GameStatus) setScore:(int) value Content:(NSMutableArray*) array;
-(void) showMultiHit:(int) hit;
-(void) resetLevelScore:(int)alevelScore;
-(void) resetTime:(int)atime;
-(void) setType:(GameType)atype;
@end
