//
//  HelpLayer.m
//  TheGame
//
//  Created by kcy1860 on 1/15/13.
//
//

#import "HelpLayer.h"

@implementation HelpLayer

-(id)init{

    self = [super init];
    self.isTouchEnabled = YES;
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCSprite * back = [CCSprite spriteWithFile:@"help_bg.png"];
    back.position = ccp(winSize.width*0.5f,winSize.height*0.5f);
    
    menu = [CCSprite spriteWithFile:@"stop_menu_bt.png"];
    menu.position=ccp(winSize.width*0.25,winSize.height*0.86);
    
    if(!isRetina)
    {
        back.scale=0.5f;
        menu.scale=0.5f;
    }
    [self addChild:back];
    [self addChild:menu];
    
    return self;
}


-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
	CGPoint location = [touch locationInView: touch.view];
	location = [[CCDirector sharedDirector] convertToGL: location];
    
    
    if(CGRectContainsPoint([menu boundingBox], location))
    {
        [MusicHandler playEffect:@"button.mp3"];
        [SceneManager goMainMenu];
    }
}
@end
