//
//  PlayDisplayLayer.m
//  TheGame
//
//  Created by kcy1860 on 12/11/12.
//
//

#import "PlayDisplayLayer.h"
#import "Germ.h"

@interface PlayDisplayLayer(){

    CCLabelTTF* clockLabel;
    CCLabelTTF* scoreLabel;
    CCLabelTTF* passScore;
    
    CCSprite* pause;
    CCSprite* menu;
    CCSprite* restart;
    
    /*UserTools*/
    CCSprite* hint;
    CCSprite* heal;
    CCSprite* reload;
    
    int timeRemain;
    bool paused;
}

@end
@implementation PlayDisplayLayer

@synthesize score;


-(id)init{
    if([super init])
    {
        paused=NO;
        timeRemain = 90;
         CGSize winSize = [CCDirector sharedDirector].winSize;
        // 设置倒计时的位置
        clockLabel = [CCLabelTTF labelWithString:[self generateString] fontName:@"Arial" fontSize:15];
        clockLabel.position = ccp(winSize.width*0.33, winSize.height*0.92);
        clockLabel.color = ccc3(0,0,0);
        [self addChild:clockLabel];
        [self schedule:@selector(changeClock) interval:1];
        
        // 设置计分板
        score=1000;
        scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Arial" fontSize:15];
        scoreLabel.position = ccp(winSize.width*0.33, winSize.height*0.97);
        scoreLabel.color = ccc3(0,0,0);
        [self addChild:scoreLabel];
        
        
        self.isTouchEnabled = YES;
        
    }
    return self;
}

-(void) startClock{
    paused = NO;
}
-(void) stopClock{
    paused = YES;
}
-(void) changeClock
{
    if(paused||timeRemain<=0)
    {
        return;
    }else{
        timeRemain--;
        [clockLabel setString:[self generateString]];
    }
}

-(void) setScore:(int) value Content:(NSMutableArray *)content
{
    if(score == value)
    {
        return;
    }
    score=value;
    [scoreLabel setString:[NSString stringWithFormat:@"%d",score]];
    

    // 动画效果
    for (int i=0; i<[content count]; i++) {
        NSMutableArray *array = [content objectAtIndex:i];
        for(int j =0;j<[array count];j++)
        {
            Germ *g= [array objectAtIndex:j];
            if([g erased])
            {
                [g setErased:NO];
                CCAction *action = [CCSequence actions:[CCMoveBy actionWithDuration:1 position:ccp(0,20)],
                                    [CCCallFuncN actionWithTarget: self selector:@selector(removeLabel:)],
                                    nil];
                CCLabelTTF* tempLabel = [CCLabelTTF labelWithString:[self generateString] fontName:@"Arial" fontSize:15];
                tempLabel.color=ccc3(200, 50, 50);
                tempLabel.position=g.pixPosition;
                [tempLabel setString:[NSString stringWithFormat:@"+%d",15]];
                [self addChild:tempLabel];
                [tempLabel runAction:action];
            }
            
        }
    }
}

-(void) removeLabel: (id) sender{
	[self removeChild: sender cleanup:YES];
}


-(NSString*) generateString
{
    int minutes = timeRemain/60;
    int seconds = timeRemain%60;
    return [NSString stringWithFormat:@"%d:%d",minutes,seconds];
}

@end
