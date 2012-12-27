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

        
        
        
        poison =[CCSprite spriteWithFile:@"poison_bt.png"];
        poison.position = ccp(winSize.width*0.4f,winSize.height*0.75);
        
        
        timeBomb = [CCSprite spriteWithFile:@"timebomb_bt.png"];
        timeBomb.position = ccp(winSize.width*0.6f,winSize.height*0.58);
        
        
        bomb = [CCSprite spriteWithFile:@"numbomb_bt.png"];
        bomb.position = ccp(winSize.width*0.4f,winSize.height*0.45);
        

        
        description = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:20];
        description.position = ccp(winSize.width*0.5f,winSize.height*0.2);
        description.color = ccc3(180, 180, 180);
        [description setDimensions:CGSizeMake(winSize.width*0.8, winSize.height*0.2)];
        //[description setTextureRect:CGRectMake(winSize.width*0.1f, winSize.height*0.3, winSize.width*0.8f, winSize.width*0.2)];
        [self setLabelText:0];
        
        
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
        
        [self addChild:background];
        [self addChild:poison];
        [self addChild:bomb];
        [self addChild:timeBomb];
        [self addChild:description];
        [self addChild:menu];
        [self setIsTouchEnabled:YES];
    }
    return self;
}
- (void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView: touch.view];
	location = [[CCDirector sharedDirector] convertToGL: location];
    
    if(CGRectContainsPoint([poison boundingBox], location))
    {
        [self onselect:1 selected:YES];
    }
    
    
    if(CGRectContainsPoint([bomb boundingBox], location))
    {
        [self onselect:2 selected:YES];
    }
    
    if(CGRectContainsPoint([timeBomb boundingBox], location))
    {
        [self onselect:3 selected:YES];
    }
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView: touch.view];
	location = [[CCDirector sharedDirector] convertToGL: location];
    
    if(CGRectContainsPoint([poison boundingBox], location))
    {
        [self onselect:1 selected:YES];
        return;
    }
    else{
        [self onselect:1 selected:NO];
        
        
        if(CGRectContainsPoint([bomb boundingBox], location))
        {
            [self onselect:2 selected:YES];
            return;
        }else{
            [self onselect:2 selected:NO];
            
            if(CGRectContainsPoint([timeBomb boundingBox], location))
            {
                [self onselect:3 selected:YES];
            }else{
                [self onselect:3 selected:NO];
            }

        }
    }
}


-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!isRetina)
    {
        poison.scale = 0.5f;
        bomb.scale=0.5f;
        timeBomb.scale=0.5f;
    }else{
        poison.scale = 1;
        bomb.scale=1;
        timeBomb.scale=1;
    }
    
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView: touch.view];
	location = [[CCDirector sharedDirector] convertToGL: location];
    if(CGRectContainsPoint([poison boundingBox], location))
    {
        [SceneManager goPlay:Poisonous level:1];
    }
    
    if(CGRectContainsPoint([bomb boundingBox], location))
    {
        [SceneManager goPlay:Bomb level:1];
    }
    
    if(CGRectContainsPoint([timeBomb boundingBox], location))
    {
        [SceneManager goPlay:TimeBomb level:1];
    }
    
    
    if(CGRectContainsPoint([menu boundingBox], location))
    {
        [SceneManager goMainMenu];
    }
}

-(void) setLabelText:(int) choice{
    NSString* text = nil;
    switch(choice)
    {
        case 0:
            text=@"欢迎来到无尽的试炼！请移动到不同的图标上来获得相应的游戏说明~";
            break;
        case 1:
            text = @"充满了带毒鱼类的无尽关卡，每走一步，带毒的鱼类会向上移动一步，要在移动到顶端之前消灭它们！";
            break;
        case 2:
            text = @"有带炸弹了的鱼类混入了鱼群中，每走一步，就离爆炸近一点，要在炸弹爆炸之前消灭它们！";
            break;
        case 3:
            text = @"这回是计时的炸弹哦~ 滴答滴答，要在时间走完之前消灭它们！";
            break;
    }
    [description setString:text];
    
}

-(void) onselect:(int) choice selected:(BOOL) select{
    BOOL flag = isRetina;
    float selected = flag?1.1f:0.6f;
    float unselected = flag?1.0f:0.5f;
    switch(choice)
    {
        case 1:
            if(select)
            {
                poison.scale=selected;
            }else{
                poison.scale = unselected;
            }
            break;
        case 2:
            if(select)
            {
                bomb.scale=selected;
            }else{
                bomb.scale = unselected;
            }
            break;
        case 3:
            if(select)
            {
                timeBomb.scale=selected;
            }else{
                timeBomb.scale = unselected;
            }
    }
    
    if(select)
    {
        [self setLabelText:choice];
    }else{
        [self setLabelText:0];
    }

}
@end
