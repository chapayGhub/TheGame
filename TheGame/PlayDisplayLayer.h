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
#import "PlayLayer.h"

//用于显示游戏界面的各种label和按钮
@interface PlayDisplayLayer : CCLayer{

}


@property (nonatomic) int levelScore;
@property (nonatomic) int score;
@property (nonatomic) int time,star;

-(id) init;
-(void) setScore:(int) value;
-(void) showMultiHit:(int) hit;
-(void) resetLevelScore:(int)alevelScore;
-(void) resetTime:(int)atime;
-(void) setType:(GameType)atype;
+(PlayDisplayLayer*) sharedInstance:(BOOL) refresh;
-(void) pauseGame;
-(void) resumeGame;
@end
