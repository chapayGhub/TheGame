//
//  PlayDisplayLayer.h
//  TheGame
//
//  Created by kcy1860 on 12/11/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
//用于显示游戏界面的各种label和按钮
@interface PlayDisplayLayer : CCLayer{

    int score;
}



@property (nonatomic) int score;

-(id) init;
-(void) startClock;
-(void) stopClock;
-(void) setScore:(int) value Content:(NSMutableArray*) array;
@end
