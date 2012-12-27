//
//  LevelChooseLayer.m
//  TheGame
//
//  Created by kcy1860 on 12/25/12.
//
//

#import "LevelChooseLayer.h"
#import "CommonUtils.h"
@implementation LevelChooseLayer
@synthesize levels;

-(id) init{
    self = [super init];
    self.isTouchEnabled = YES;
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCSprite * back = [CCSprite spriteWithFile:@"level_bg.png"];
    back.position = ccp(winSize.width*0.5f,winSize.height*0.5f);

    menu = [CCSprite spriteWithFile:@"menu_bt.png"];
    menu.position=ccp(winSize.width*0.25,winSize.height*0.88);
    
    if(!isRetina)
    {
        back.scale=0.5f;
        menu.scale=0.5f;
    }
    [self addChild:back];
    [self addChild:menu];

    
    levels = [[NSMutableArray alloc] initWithCapacity:3];
    UserProfile* profile = [UserProfile sharedInstance];
    NSMutableDictionary* record = [profile userRecord];
    
    NSMutableDictionary* context = [[GameDef sharedInstance] settings];
    
    float vertispan = 0.18;
    float horisban = 0.28;
    float middle = 0.55f;
    
    int count = 1;
    GameType type = Classic;
    BOOL flag = YES;
    for(int i=0;i<3;i++)
    {
        float posY = winSize.height* (middle - (i-1)*vertispan);
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:3];
        for(int j=0;j<3;j++)
        {
            CCSprite *sprite = nil;
            float posX = winSize.width*(0.5f + (j-1)*horisban);
            NSString* key = [CommonUtils getKeyStringByGameTypeAndLevel:type level:count];
            count++;
            int score = [[record valueForKey: key] integerValue];
            int passScore = [[context valueForKey:key] levelScore];
            if(score==-1)
            {
                if(flag == YES) // 已经解锁但是还没玩
                {
                    sprite = [CCSprite spriteWithFile:@"crab0.png"];
                    flag = NO;
                }else{ // 还没解锁
                    sprite = [CCSprite spriteWithFile:@"lock.png"];
                    sprite.tag = -1860;
                }
            }else{
                if(score >= passScore)
                {   passScore = passScore*getStarSpan;
                    if(score>=passScore){ // second star
                        passScore = passScore*getStarSpan;
                        if(score>=passScore) // third star
                        {
                            sprite = [CCSprite spriteWithFile:@"crab3.png"];
                        }else
                        {
                            sprite = [CCSprite spriteWithFile:@"crab2.png"];
                        }
                    }else{
                        sprite = [CCSprite spriteWithFile:@"crab1.png"];
                    }
                }else{ // 没过关
                    sprite = [CCSprite spriteWithFile:@"crab0.png"];
                }
            }
            if(!isRetina)
            {
                sprite.scale = 0.5f;
            }
            sprite.position = ccp(posX,posY);
            [array addObject:sprite];
            [self addChild:sprite];
        }
        [levels addObject:array];
    }
    
    CCSprite * w = [CCSprite spriteWithFile:@"words.png"];
    if(!isRetina)
    {
        w.scale=0.6f;
    }
    w.position = ccp(winSize.width*0.5,winSize.height*0.2);
    [self addChild:w];
    return self;
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
	CGPoint location = [touch locationInView: touch.view];
	location = [[CCDirector sharedDirector] convertToGL: location];
    
    
    int count = 1;
    for(int i=0;i<3;i++)
    {
        NSMutableArray *array = [levels objectAtIndex:i];
        for(int j=0;j<3;j++)
        {
            CCSprite *sprite= [array objectAtIndex:j];
            if(CGRectContainsPoint([sprite boundingBox], location))
            {
                if(sprite.tag!= - 1860)
                {
                    [SceneManager goPlay:Classic level:count];
                }
                return;
            }
            count++;
        }
        
    }
    
    
    if(CGRectContainsPoint([menu boundingBox], location))
    {
        [SceneManager goMainMenu];
    }
}

@end
