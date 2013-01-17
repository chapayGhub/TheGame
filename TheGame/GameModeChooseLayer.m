//
//  GameModeChooseLayer.m
//  TheGame
//
//  Created by kcy1860 on 12/18/12.
//
//

#import "GameModeChooseLayer.h"

@implementation GameModeChooseLayer

-(id) init{
    self = [super init];
    if(self)
    {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCSprite* background = [CCSprite spriteWithFile:@"endless_bg.png"];
        background.position=ccp(winSize.width*0.5f,winSize.height*0.5f);
        
        
        CCSprite *l = [CCSprite spriteWithFile:@"poison_bt.png"];
        CCSprite *ls = [CCSprite spriteWithFile:@"poison_bt.png"];
        
        CCSprite *i = [CCSprite spriteWithFile:@"timebomb_bt.png"];
        CCSprite *is = [CCSprite spriteWithFile:@"timebomb_bt.png"];
        
        CCSprite *m = [CCSprite spriteWithFile:@"numbomb_bt.png"];
        CCSprite *ms = [CCSprite spriteWithFile:@"numbomb_bt.png"];
        
        
        ls.color=ccc3(80,80,80);
        is.color=ccc3(80,80,80);
        ms.color=ccc3(80,80,80);
        
        
        CCMenuItemSprite *poison = [CCMenuItemSprite  itemWithNormalSprite:l selectedSprite:ls target:self selector:@selector(goPoison)];
        CCMenuItemSprite *timeBomb = [CCMenuItemSprite  itemWithNormalSprite:i selectedSprite:is target:self selector:@selector(goTimeBomb)];
        CCMenuItemSprite *bomb = [CCMenuItemSprite  itemWithNormalSprite:m selectedSprite:ms target:self selector:@selector(goBomb)];
    
        menu = [CCSprite spriteWithFile:@"stop_menu_bt.png"];
        menu.position=ccp(winSize.width*0.25,winSize.height*0.88);
        
        if(!isRetina)
        {
            background.scale=0.5f;
            poison.scale=0.5f;
            bomb.scale=0.5f;
            timeBomb.scale=0.5f;
            menu.scale=0.5f;
        }
        
        CCMenu *mainmenu = [CCMenu menuWithItems:poison, timeBomb, bomb, nil];
        mainmenu.position = ccp(winSize.width*0.5, winSize.height*0.55);
        [mainmenu alignItemsVerticallyWithPadding: winSize.height*0.01f];
        
        
        
        [self addChild:background];
        [self addChild:mainmenu];
        [self addChild:menu z:1 tag:menuTag];
        [self setIsTouchEnabled:YES];
    }
    return self;
}

-(void) goPoison{
    [MusicHandler playEffect:@"button.mp3"];
    [SceneManager goPlay:Poisonous level:1];
}

-(void) goTimeBomb{
    [MusicHandler playEffect:@"button.mp3"];
    [SceneManager goPlay:TimeBomb level:1];
}
-(void)goBomb{
    [MusicHandler playEffect:@"button.mp3"];
    [SceneManager goPlay:Bomb level:1];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
	CGPoint location = [touch locationInView: touch.view];
	location = [[CCDirector sharedDirector] convertToGL: location];
    
    CCNode *sprite = [self getChildByTag:menuTag];
    if(sprite!=nil&&  CGRectContainsPoint([sprite boundingBox], location))
    {
        [MusicHandler playEffect:@"button.mp3"];
        [SceneManager goMainMenu];
    }
}

@end
