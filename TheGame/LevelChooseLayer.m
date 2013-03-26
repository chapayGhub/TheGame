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

double prevX;
int current;
CCSprite *page;

-(id) init{

    self = [super init];
    self.isTouchEnabled = YES;
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCSprite * back = [CCSprite spriteWithFile:@"level_bg.png"];
    back.position = ccp(winSize.width*0.5f,winSize.height*0.5f);

    menu = [CCSprite spriteWithFile:@"big_bt.png"];
    menu.position=ccp(winSize.width*0.25,winSize.height*0.88);
    
    if(!isRetina)
    {
        back.scale=0.5f;
        menu.scale=0.5f;
    }
    [self addChild:back];
    [self addChild:menu];

    
    levels = [[NSMutableArray alloc] initWithCapacity:9];
    UserProfile* profile = [UserProfile sharedInstance];
    NSMutableDictionary* record = [profile userRecord];
    
    NSMutableDictionary* context = [[GameDef sharedInstance] settings];
    
    float vertispan = 0.18;
    float horisban = 0.28;
    float middle = 0.55f;
    
    int count = 1;
    GameType type = Classic;
    BOOL flag = YES;
    for(int k=0;k<3;k++){
    for(int i=0;i<3;i++)
    {
        float posY = winSize.height* (middle - (i-1)*vertispan);
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:3];
        for(int j=0;j<3;j++)
        {
            CCSprite *sprite = nil;
            float posX = k*winSize.width+winSize.width*(0.5f + (j-1)*horisban);
            NSString* key = [CommonUtils getKeyStringByGameTypeAndLevel:type level:count];
            count++;
            int score = [[record valueForKey: key] integerValue];
            GameContext *c = [context valueForKey:key];
            int passScore = [c levelScore];
            int starSpan = [c interval];
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
                {   passScore = passScore+starSpan;
                    if(score>=passScore){ // second star
                        passScore = passScore+starSpan;
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
    }
    prevX=-1;
    current = 1;
    page = [CCSprite spriteWithFile:@"point1.png"];
    page.position=ccp(winSize.width*0.5,winSize.height*0.25);
    if(!isRetina){
        page.scale=0.5f;
    }
    [self addChild:page];
    return self;
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView: touch.view];
	location = [[CCDirector sharedDirector] convertToGL: location];
    if(prevX==-1)
    {
        prevX=location.x;
        return;
    }
    else{
        int x = location.x-prevX;
        prevX=location.x;
        for(int i=0;i<9;i++){
            for(int j=0;j<3;j++)
            {
                CCSprite *sprite = [[levels objectAtIndex:i] objectAtIndex:j];
                CGPoint pos=sprite.position;
                [sprite setPosition:ccp(pos.x+x,pos.y)];
            }
        }
    }
    
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    prevX=-1;
    // 检测是否应该翻页
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCSprite *s = [[levels objectAtIndex:0] objectAtIndex:0];
    float horisban = 0.28;
    float x=s.position.x;
    float xo = (1-current)*winSize.width + winSize.width*(0.5f + (0-1)*horisban);
    float diff= x-xo>0?x-xo:xo-x;
    
    if(x-xo>winSize.width*0.3&&current>1)// level--
    {
        current--;
        [page removeFromParentAndCleanup:YES];
        page=[CCSprite spriteWithFile:[NSString stringWithFormat:@"point%d.png",current]];
        page.position=ccp(winSize.width*0.5,winSize.height*0.25);
        if(!isRetina){
            page.scale=0.5f;
        }
        [self addChild:page];
        for(int i=0;i<9;i++){
            for(int j=0;j<3;j++)
            {
                CCSprite *sprite = [[levels objectAtIndex:i] objectAtIndex:j];
                CCAction *action = [CCMoveBy actionWithDuration:0.005*diff position:ccp(winSize.width-diff,0)];
                [sprite runAction:action];
            }
        }
        return;
    }else if(x-xo<-winSize.width*0.3&&current<3){ // level++
        current++;
        [page removeFromParentAndCleanup:YES];
        page=[CCSprite spriteWithFile:[NSString stringWithFormat:@"point%d.png",current]];
        page.position=ccp(winSize.width*0.5,winSize.height*0.25);
        if(!isRetina){
            page.scale=0.5f;
        }
        [self addChild:page];
        for(int i=0;i<9;i++){
            for(int j=0;j<3;j++)
            {
                CCSprite *sprite = [[levels objectAtIndex:i] objectAtIndex:j];
                CCAction *action = [CCMoveBy actionWithDuration:0.3f position:ccp(diff-winSize.width,0)];
                [sprite runAction:action];
            }
        }
        return;
    }
    

    // 返回原来的
    for(int i=0;i<9;i++){
        for(int j=0;j<3;j++)
        {
            CCSprite *sprite = [[levels objectAtIndex:i] objectAtIndex:j];
            CCAction *action = [CCMoveBy actionWithDuration:0.005*diff position:ccp(xo-x,0)];
            [sprite runAction:action];
        }
    }
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
	CGPoint location = [touch locationInView: touch.view];
	location = [[CCDirector sharedDirector] convertToGL: location];
    
    
    int count = 1;
    for(int i=0;i<9;i++)
    {
        NSMutableArray *array = [levels objectAtIndex:i];
        for(int j=0;j<3;j++)
        {
            CCSprite *sprite= [array objectAtIndex:j];
            if(CGRectContainsPoint([sprite boundingBox], location))
            {
               // if(sprite.tag!= - 1860)
                {
                    [SceneManager goPlay:Classic level:count];
                    
                    [MusicHandler playEffect:@"button.mp3"];
                }
//                else{
//                    [MusicHandler playEffect:@"disabled.mp3"];
//                }
                return;
            }
            count++;
        }
        
    }
    
    
    if(CGRectContainsPoint([menu boundingBox], location))
    {
        [MusicHandler playEffect:@"button.mp3"];
        [SceneManager goMainMenu];
    }
}

@end
