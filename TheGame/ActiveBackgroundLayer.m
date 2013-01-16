//
//  ActiveBackgroundLayer.m
//  TheGame
//
//  Created by kcy1860 on 12/12/12.
//
//

#import "ActiveBackgroundLayer.h"


@implementation ActiveBackgroundLayer

-(id) init{
    self=[super init];
    if(self)
    {
        [self setIsTouchEnabled:NO];
    }
    return self;
}

-(void) onEnterTransitionDidFinish{
    [self schedule:@selector(addObject) interval:2];
}
-(void) addObject
{
    // 随机出一种孢子
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    int start = 0.2*winSize.height;
    int range = 0.6*winSize.height;
    int kind = 4+ arc4random()%2;
    NSString *name = [NSString stringWithFormat:@"q%d.png",kind];
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:name];
   
    int size = (arc4random()%7)/10;
    sprite.scale = 0.5f + size;
    
    
    int orient = arc4random()%2;
    int y = arc4random()%range;
    
    float speed = 3.0 + (arc4random()%30)/10;
    
    CGPoint pleft = ccp(-sprite.contentSize.width/2,start+y);
    CGPoint pright = ccp(winSize.width+sprite.contentSize.width/2,start+y);
    
    CCAction *action = [CCSequence actions:[CCMoveTo actionWithDuration:speed position: orient==0?pright:pleft],
                        [CCCallFuncN actionWithTarget: self selector:@selector(removeSprite:)],
                        nil];
    
    sprite.position = orient==0?pleft:pright;
    sprite.flipX = (orient==0);
    [self addChild:sprite];
    [sprite runAction:action];
    
}

-(void)removeSprite:(id) sender
{
    [sender removeFromParentAndCleanup:YES];
}

@end
