#import "MainMenuLayer.h"


@implementation MainMenuLayer

-(id) init{
	self = [super init];
		
	CCLabelTTF *titleLeft = [CCLabelTTF labelWithString:@"孢子 " fontName:@"Marker Felt" fontSize:48];
	CCLabelTTF *titleRight = [CCLabelTTF labelWithString:@" 大战" fontName:@"Marker Felt" fontSize:48];
	
    CCMenuItemFont *startNew = [CCMenuItemFont itemFromString:@"经典模式" target:self selector: @selector(onStartNew:)];

	CCMenuItemFont *resume = [CCMenuItemFont itemFromString:@"无限闯关" target:self selector: @selector(onResume:)];

	CCMenuItemFont *highscores = [CCMenuItemFont itemFromString:@"得分榜" target:self selector: @selector(onHighscores:)];

	CCMenuItemFont *mygerms = [CCMenuItemFont itemFromString:@"我的孢子" target:self selector: @selector(onMyGerms:)];
	
	CCMenu *menu = [CCMenu menuWithItems:startNew, resume, highscores, mygerms, nil];
	
	float delayTime = 0.3f;
	
	for (CCMenuItemFont *each in [menu children]) {
		each.scaleX = 0.0f;
		each.scaleY = 0.0f;
		CCAction *action = [CCSequence actions:
		 [CCDelayTime actionWithDuration: delayTime],
		 [CCScaleTo actionWithDuration:0.5F scale:1.0],
		 nil];
		delayTime += 0.2f;
		[each runAction: action];
	}
	
	titleLeft.position = ccp(-80, 340);
	CCAction *titleLeftAction = [CCSequence actions:
			[CCDelayTime actionWithDuration: delayTime],
			[CCEaseBackOut actionWithAction:
			 [CCMoveTo actionWithDuration: 1.0 position:ccp(120,340)]],
			nil];
	[self addChild: titleLeft];
	[titleLeft runAction: titleLeftAction];
	
	titleRight.position = ccp(400, 340);
	CCAction *titleRightAction = [CCSequence actions:
								 [CCDelayTime actionWithDuration: delayTime],
								 [CCEaseBackOut actionWithAction:
								  [CCMoveTo actionWithDuration: 1.0 position:ccp(200,340)]],
								 nil];
	[self addChild: titleRight];
	[titleRight runAction: titleRightAction];
	
	menu.position = ccp(160, 240);
	[menu alignItemsVerticallyWithPadding: 40.0f];
	[self addChild:menu z: 2];

	return self;
}

- (void)onStartNew:(id)sender{
	[SceneManager goPlay:Classic level:1];
}
- (void)onResume:(id)sender{
	[SceneManager goPlay:Classic level:3];
}

- (void)onHighscores:(id)sender{
	//[SceneManager goHighScores];
}
- (void)onMyGerms:(id)sender{
	//[SceneManager goCredits];
}
@end
