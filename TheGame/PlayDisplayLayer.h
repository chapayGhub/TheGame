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
#import "AdLayer.h"
//用于显示游戏界面的各种label和按钮
@interface PlayDisplayLayer :AdLayer{
}


@property (nonatomic) int levelScore;
@property (nonatomic) int score,life;
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
-(void) setWithContext:(GameContext*) context;
-(BOOL) subLife;
-(void) gameOver;
-(void) showExplosion:(CGPoint) pos;
@end
