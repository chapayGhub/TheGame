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
    CCLabelTTF* passScoreLabel;
    
    CCSprite* pause;
    
    CCSprite* restart;
    
    CCSprite *title;
    
    CCSprite *clockLine;
    CCProgressTimer* timer;
    
    
    /*UserTools*/
    CCSprite* hint;
    CCSprite* heal;
    CCSprite* reload;
    
    
    NSMutableArray *starPictures;
    
    int timeRemain;
    GameType type;
}

@end
@implementation PlayDisplayLayer

@synthesize score,levelScore,time,star,life;

static PlayDisplayLayer* thisLayer;

+(PlayDisplayLayer*) sharedInstance:(BOOL) refresh
{
    if(thisLayer!=nil&&refresh)
    {
        [thisLayer release];
        thisLayer =nil;
    }
    if(thisLayer==nil)
    {
        thisLayer = [PlayDisplayLayer node];
    }
    
    return thisLayer;
}


-(id)init{
    self = [super init];
    if(self)
    {
        star = 0;
        life = 3;
        score=0;
        self.isTouchEnabled = YES;
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        //设置道具
        hint = [CCSprite spriteWithFile:@"t_hint.png"];
        hint.scale=0.5f;
        hint.position = ccp(winSize.width*0.2,winSize.height*0.17);
        
        heal = [CCSprite spriteWithFile:@"t_reset.png"];
        heal.scale=0.5f;
        heal.position = ccp(winSize.width*0.5,winSize.height*0.17);
        
        
        reload =[CCSprite spriteWithFile:@"t_rotate.png"];
        reload.scale=0.5f;
        reload.position = ccp(winSize.width*0.8,winSize.height*0.17);
        
        starPictures=[[NSMutableArray alloc] init];
        for(int i=1;i<=3;i++)
        {
            [starPictures addObject:[CCSprite spriteWithFile: [NSString stringWithFormat:@"star%d.png",i]]];
        }


        [self addChild:hint];
        [self addChild:heal];
        [self addChild:reload];
        

        
    }
    return self;
}

-(void)dealloc{
    [starPictures release];
    starPictures=nil;
    [super dealloc];
}
-(void) setWithContext:(GameContext*) context{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    type = context.type;
    if(type==Classic)
    {
        heal.color = ccc3(80,80,80);
        
        title = [CCSprite spriteWithFile:@"leveltitle.png"];
        title.scale=0.5f;
        title.position = ccp(winSize.width*0.5f,winSize.height-32);
        [self addChild:title];
        
        
        passScoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",levelScore] fontName:@"Arial" fontSize:15];
        passScoreLabel.position = ccp(winSize.width*0.62, winSize.height*0.97);
        passScoreLabel.color = ccc3(0,0,0);
        [self addChild:passScoreLabel];
        
        
        // 设置倒计时的位置
        clockLabel = [CCLabelTTF labelWithString:[self generateString] fontName:@"Arial" fontSize:15];
        clockLabel.position = ccp(winSize.width*0.33, winSize.height*0.92);
        clockLabel.color = ccc3(0,0,0);
        [self addChild:clockLabel];
        
        clockLine = [CCSprite spriteWithFile:@"clock_line.png"];
       // clockLine.position = ccp(winSize.width*0.16,winSize.height*0.882);
        clockLine.anchorPoint=ccp(0,0);
       // clockLine.color = ccc3(0,0,0);
        clockLine.scaleY=0.5f;
        clockLine.scaleX=0.51f;
        
        //[self addChild:clockLine];
        timer=[CCProgressTimer progressWithSprite:clockLine];
        [timer setPosition:ccp(winSize.width*0.161,winSize.height*0.884)];
        [timer setType:kCCProgressTimerTypeBar];
        [timer setMidpoint:ccp(0,0)];
        [timer setBarChangeRate:ccp(1,0)];
        [timer setAnchorPoint:ccp(0,0)];
        [timer setScale:0.5f];
        [self addChild:timer];
    
    }else{
        title = [CCSprite spriteWithFile:@"endlesstitle.png"];
        title.scale=0.5f;
        title.position = ccp(winSize.width*0.5f,winSize.height-32);
        [self addChild:title];
        
        

    }

    
    
    // 设置计分板
    scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Arial" fontSize:15];
    scoreLabel.position = ccp(winSize.width*0.33, winSize.height*0.97);
    scoreLabel.color = ccc3(0,0,0);
    
    [self addChild:scoreLabel];
    [self resetTime:[context time]];
    [self resetLevelScore:[context levelScore]];
    [self setType:[context type]];
}
-(void) onEnterTransitionDidFinish
{
    if(self.time!=0)
    {
        [self schedule:@selector(changeClock) interval:1];
        CCProgressTo* to = [CCProgressTo actionWithDuration:self.time+0.5f percent:100];
        [timer runAction:to];
    }
}

-(void) setType:(GameType)atype
{
    type=atype;
}

-(void) resetLevelScore:(int)alevelScore
{
    //如果是第一次设置，调用方法初始化label
    self.levelScore=alevelScore;
    if(type==Classic)
    {
        if(passScoreLabel!=nil)
        {
            [passScoreLabel setString:[NSString stringWithFormat:@"%d",levelScore]];
            return;
        }

    }
    

}
-(void) resetTime:(int)atime
{
    self.time=atime;
    timeRemain=atime;
}

-(void) changeClock
{
    if(type == TimeBomb)
    {
        NSMutableArray *content = [[[PlayLayer sharedInstance:NO] getBox] content];
        for (int i=[content count]-1; i>=0; i--) {
            NSMutableArray *array = [content objectAtIndex:i];
            for(int j =0;j<[array count];j++)
            {
                Germ *g= [array objectAtIndex:j];
                if(g.type==TimeBombGerm)
                {
                    GermFigure *sprite = g.sprite;
                    int i=[sprite nextValue];
                    if(i==0)
                    {
                        //炸弹爆炸 扣一格血
                    }
                }
                
            }
        }
    }


    if(timeRemain<=0)
    {
        timeRemain =0;
        return;
    }else{
        timeRemain--;
        [clockLabel setString:[self generateString]];
    }
}

-(void) setScore:(int) value
{
    score=value;
    [scoreLabel setString:[NSString stringWithFormat:@"%d",score]];
    
    if(score>=levelScore&&levelScore!=0)
    {
        if(type==Classic) //经典玩法中累计星星
        {
            while(star<3) //还没有拿到三颗星
            {
                [self addAStar];
                [self resetLevelScore:levelScore*getStarSpan];
                if(value<levelScore)
                {
                    break;
                }
            }
            if(star == 3)
            {  //拿到三颗星
                // 胜利
                // 跳到中间页面
                //[[PlayLayer sharedInstance:NO] toNextLevel:YES];
            }
        }
        
        else{ // 无限模式中直接增加级别
            PlayLayer* l = [PlayLayer sharedInstance:NO];
            GameContext* c = [[l context] getNextLevel];
            [l resetWithContext:c refresh:NO];
        }
    }
    

}

-(void) addAStar{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    float offset = 0.105f;
    
    //585
    //690
    //795
    CCSprite *astar = [starPictures objectAtIndex:star];
    astar.scale=0.0f;
    //astar.position = ccp(winSize.width*0.795f,winSize.height*0.92f);
    astar.position = ccp(winSize.width*0.5+star*offset ,winSize.height*0.7f);
    
    star++;
    CCAction *action;

    if(star==1)
    {
        action = [CCSequence actions:[CCSpawn actions:[CCScaleTo actionWithDuration:apearspeed scale:openScale],
                                        [CCMoveBy actionWithDuration:apearspeed position:ccp(-10,20)],
                                        nil],
                                    [CCSpawn actions:[CCScaleTo actionWithDuration:fixspeed scale:0.5f],
                                     [CCMoveTo actionWithDuration:fixspeed position:ccp(winSize.width*0.585f,winSize.height*0.92f)],
                                      nil],
                   nil];
        
        
         
    }else if(star==2)
    {
        action = [CCSequence actions:[CCSpawn actions:[CCScaleTo actionWithDuration:apearspeed scale:openScale],
                                      [CCMoveBy actionWithDuration:apearspeed position:ccp(-10,20)],
                                      nil],
                  [CCSpawn actions:[CCScaleTo actionWithDuration:fixspeed scale:0.5f],
                   [CCMoveTo actionWithDuration:fixspeed position:ccp(winSize.width*0.690f,winSize.height*0.92f)],
                   nil],
                  nil];
        
        
    }else{
        action = [CCSequence actions:[CCSpawn actions:[CCScaleTo actionWithDuration:apearspeed scale:openScale],
                                      [CCMoveBy actionWithDuration:apearspeed position:ccp(-10,20)],
                                      nil],
                  [CCSpawn actions:[CCScaleTo actionWithDuration:fixspeed scale:0.5f],
                   [CCMoveTo actionWithDuration:fixspeed position:ccp(winSize.width*0.795f,winSize.height*0.92f)],
                   nil],
                  nil];
        
    }
    [self addChild:astar];
    [astar runAction:action];
    
}

-(void) removeLabel: (id) sender{
    [self removeChild:sender cleanup:YES];
    
}

-(void) pauseGame{
    
    [self pauseSchedulerAndActions];
    [[PlayLayer sharedInstance:NO]  pauseGame];
}

-(void) resumeGame
{
    [self resumeSchedulerAndActions];
    [[PlayLayer sharedInstance:NO]  resumeGame];
}

-(NSString*) generateString
{
    int minutes = timeRemain/60;
    int seconds = timeRemain%60;
    return [NSString stringWithFormat:@"%d:%d",minutes,seconds];
}

-(void) showMultiHit:(int)hit{
    int randomx = arc4random()%90-45;
    int randomy = arc4random()%90-45;
    
    CCLabelTTF* tempLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d连击！！！",hit] fontName:@"Arial" fontSize:30];
    tempLabel.position = ccp(kStartX+kTileSize*kBoxWidth/2+randomx, kStartY+kTileSize*kBoxHeight/2+randomy);
    tempLabel.color = ccc3(0,0,0);
    [self addChild:tempLabel];
    
    CCAction *action = [CCSequence actions:[CCSpawn actions:
                                            [CCMoveBy actionWithDuration:0.5f position:ccp(0,20)],
                                            [CCScaleBy actionWithDuration:0.5f scale:1.3],nil],
                        [CCCallFuncN actionWithTarget: self selector:@selector(removeLabel:)],
                        nil];
    
    [tempLabel runAction:action];
}


@end
