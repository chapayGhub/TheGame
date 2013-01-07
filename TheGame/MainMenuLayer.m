#import "MainMenuLayer.h"


@implementation MainMenuLayer

-(id) init{
	self = [super init];
	CGSize winSize = [CCDirector sharedDirector].winSize;
    CCSprite* background = [CCSprite spriteWithFile:@"start_bg.png"];
    background.position=ccp(winSize.width*0.5f,winSize.height*0.5f);
    if(!isRetina)
    {
        background.scale=0.5f;
    }
    [self addChild:background];
    
	
    CCSprite *l = [CCSprite spriteWithFile:@"mn_level.png"];
    CCSprite *ls = [CCSprite spriteWithFile:@"mn_level.png"];
    
    CCSprite *i = [CCSprite spriteWithFile:@"mn_endless.png"];
    CCSprite *is = [CCSprite spriteWithFile:@"mn_endless.png"];
    
    CCSprite *m = [CCSprite spriteWithFile:@"mn_moregame.png"];
    CCSprite *ms = [CCSprite spriteWithFile:@"mn_moregame.png"];
    
    CCSprite *h = [CCSprite spriteWithFile:@"mn_help.png"];
    CCSprite *hs = [CCSprite spriteWithFile:@"mn_help.png"];

    ls.color=ccc3(80,80,80);
    is.color=ccc3(80,80,80);
    ms.color=ccc3(80,80,80);
    hs.color=ccc3(80,80,80);

    CCMenuItemSprite *startNew = [CCMenuItemSprite  itemWithNormalSprite:l selectedSprite:ls target:self selector:@selector(onStartNew:)];
    CCMenuItemSprite *resume = [CCMenuItemSprite  itemWithNormalSprite:i selectedSprite:is target:self selector:@selector(onInfiniteMode:)];
    CCMenuItemSprite *highscores = [CCMenuItemSprite  itemWithNormalSprite:m selectedSprite:ms target:self selector:@selector(onOtherGames:)];
    CCMenuItemSprite *mygerms = [CCMenuItemSprite  itemWithNormalSprite:h selectedSprite:hs target:self selector:@selector(onStartNew:)];

    if(!isRetina)
    {
        startNew.scale=0.5f;
        resume.scale=0.5f;
        highscores.scale=0.5f;
        mygerms.scale=0.5;
    }

	
	CCMenu *menu = [CCMenu menuWithItems:startNew, resume, highscores, mygerms, nil];
	
    float delayTime = 0.3f;
	for (CCMenuItemFont *each in [menu children]) {
		each.scale=0;
        CCAction *action = [CCSequence actions:
		 [CCDelayTime actionWithDuration: delayTime],
		 [CCScaleTo actionWithDuration:0.5F scale:0.5],
		 nil];
		delayTime += 0.2f;
		[each runAction: action];
	}

	menu.position = ccp(winSize.width*0.5, winSize.height*0.5);
    [menu alignItemsVerticallyWithPadding: 55.0f];
	[self addChild:menu z:1 tag:mainmenuTag];
	return self;
}

-(void) onEnterTransitionDidFinish{
    [MusicHandler playMusic:@"startbackground.wav" Loop:YES];
}

- (void)onStartNew:(id)sender{
    [MusicHandler playEffect:@"button.wav"];
    [SceneManager goLevelChoose];
}
- (void)onInfiniteMode:(id)sender{
    [MusicHandler playEffect:@"button.wav"];
	[SceneManager goGameModeChoose];
}

- (void)onOtherGames:(id)sender{

}
- (void)onHelp:(id)sender{
    
}

-(void) enableMenu:(BOOL) flag{
    CCMenu* menu = (CCMenu*)[self getChildByTag:mainmenuTag];
    menu.enabled=flag;
}
@end
