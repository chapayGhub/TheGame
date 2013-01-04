//
//  PauseLayer.m
//  TheGame
//
//  Created by kcy1860 on 12/27/12.
//
//

#import "PauseLayer.h"


@implementation PauseLayer

-(id) init{
    self = [super init];
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCSprite * back = [CCSprite spriteWithFile:@"stop_bg1.png"];
    back.position = ccp(winSize.width*0.5f,winSize.height*0.5f);
    [self  addChild:back];
    
    CCSprite *menu = [CCSprite spriteWithFile:@"stop_menu_bt.png"];
    CCSprite *goon = [CCSprite spriteWithFile:@"stop_goon_bt.png"];
    CCSprite *reset = [CCSprite spriteWithFile:@"stop_reset_bt.png"];
    menu.position = ccp(winSize.width*0.35f,winSize.height*0.515f);
    goon.position = ccp(winSize.width*0.5f,winSize.height*0.515f);
    reset.position = ccp(winSize.width*0.65f,winSize.height*0.515f);
    
    [self addChild:menu z:1 tag:menuTag];
    [self addChild:goon z:1 tag:continueTag];
    [self addChild:reset z:1 tag:redoTag];
    
    if(!isRetina)
    {
        back.scale=0.5f;
        menu.scale=0.5f;
        goon.scale=0.5f;
        reset.scale=0.5f;
    }
    self.isTouchEnabled=YES;
    return self;
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch* touch = [touches anyObject];
	CGPoint location = [touch locationInView: touch.view];
	location = [[CCDirector sharedDirector] convertToGL: location];
    
    CCNode* sprite = [self getChildByTag:menuTag];
    if(sprite!=nil && CGRectContainsPoint([sprite boundingBox], location)){
        GameType type= [[[PlayLayer sharedInstance:NO] context] type];
        if(type==Classic)
        {
            [SceneManager goLevelChoose];
        }else{
            [SceneManager goGameModeChoose];
        }
    }
    
    sprite = [self getChildByTag:continueTag];
    if(sprite!=nil && CGRectContainsPoint([sprite boundingBox], location)){
        [SceneManager removePauseLayer];
    }
    
    sprite = [self getChildByTag:redoTag];
    if(sprite!=nil && CGRectContainsPoint([sprite boundingBox], location)){
        GameType type= [[[PlayLayer sharedInstance:NO] context] type];
        [SceneManager goPlay:type level:1];
    }
}
@end
