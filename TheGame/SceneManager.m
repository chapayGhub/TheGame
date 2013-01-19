#import "SceneManager.h"
#import "PlayBackgroundLayer.h"
#import "PlayLayer.h"
#import "RewardLayer.h"
#import "LevelChooseLayer.h"
#import "UMUFPTableView.h"
#import "AppDelegate.h"
#import "UMTableViewController.h"
#import "HelpLayer.h"
#import "AdSageView.h"
#import "MobiSageSDK.h"

@interface SceneManager ()

@end


@implementation SceneManager
static MobiSageAdBanner* banner;
static UMTableViewController *controller;
static AdSageView *adView;

+(void) goMainMenu{
    
    CCDirector *director = [CCDirector sharedDirector];
    CCScene *newScene = [CCScene node];
    UserProfile * profile = [UserProfile sharedInstance];
    int count = [profile getCountInARoll];
    MainMenuLayer* menu = [MainMenuLayer node];
    

    [SceneManager getBanner];
    [[director view] addSubview:banner];
    [newScene addChild:menu z:0 tag:menuLayerTag];
    [newScene addChild:[ActiveBackgroundLayer node] z:2];
    if(count>1)
    {
        [menu enableMenu:NO];
        [newScene addChild:[RewardLayer node:3] z:2 tag:rewardLayerTag];
    }

    if ([director runningScene]) {
        [director replaceScene:[CCTransitionCrossFade transitionWithDuration: 0.5f scene: newScene]];
	}else {
		[director runWithScene:newScene];
	}
}


+(AdSageView*) getadBanner
{
    if(adView == nil)
    {
        AdLayer* tmp = [AdLayer node];
        adView = [AdSageView requestAdSageBannerAdView:tmp sizeType:AdSageBannerAdViewSize_320X50];

        [adView setFrame:CGRectMake(0,430, 320, 50)];
    }
    return adView;
}

+(void) goPlay:(GameType)type level:(int)level{
    CCDirector *director = [CCDirector sharedDirector];
    CCScene *newScene = [CCScene node];
    
    GameContext *context = [[[GameDef sharedInstance] settings] valueForKey:[CommonUtils getKeyStringByGameTypeAndLevel:type level:level]];
    PlayLayer *play = [PlayLayer sharedInstance:YES];
    PlayDisplayLayer *display = [PlayDisplayLayer sharedInstance:YES];
    [play resetWithContext:context refresh:YES];
    
    [newScene addChild:[PlayBackgroundLayer node] z:0];
    [newScene addChild:display z:2];
    [newScene addChild:play z:1];
    
    
    
    if ([director runningScene]) {
        [director replaceScene:[CCTransitionMoveInT transitionWithDuration: 0.5f scene: newScene]];
	}else {
		[director runWithScene:newScene];
	}
}


+(void) goRecommand{
    [[CCDirector sharedDirector] pause];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:[[CCDirector sharedDirector] view] cache:YES];
    
    [[[CCDirector sharedDirector] view] addSubview:[SceneManager getRecommand].view];
    [MusicHandler pauseBackground];
    [UIView commitAnimations];
    
}
+(UMTableViewController*) getRecommand{
    if(controller==nil)
    {
        controller = [[UMTableViewController alloc] init];
    }
    return controller;
}


+(void) addAdBanner
{
    CCDirector *director = [CCDirector sharedDirector];
    [director.view addSubview:[SceneManager getBanner]];
}

+(void) removeAdBanner
{
    [[SceneManager getBanner] removeFromSuperview];
}


+(MobiSageAdBanner*) getBanner
{
    if(banner == nil)
    {
        banner = [[MobiSageAdBanner alloc] initWithAdSize:Ad_320X50];
        [banner setInterval:Ad_Refresh_15];
        [banner setFrame:CGRectMake(0,430, 320, 50)];
        [banner setSwitchAnimeType: Ripple];
    }
    return banner;
}


+(void) pushScene:(CCScene*) scence{
    CCDirector *director = [CCDirector sharedDirector];
    [director pushScene:scence];
}

+(void) popScene{
    CCDirector *director = [CCDirector sharedDirector];
    [director popScene];
}


+(void) goGameModeChoose{
    CCDirector *director = [CCDirector sharedDirector];
    CCScene *newScene = [CCScene node];
    [newScene addChild:[GameModeChooseLayer node]];
    if ([director runningScene]) {
        [director replaceScene:[CCTransitionCrossFade transitionWithDuration: 0.5f scene: newScene]];
	}else {
		[director runWithScene:newScene];
	}

}

+(void) goLevelChoose{
    CCDirector *director = [CCDirector sharedDirector];
    CCScene *newScene = [CCScene node];
    [newScene addChild:[LevelChooseLayer node]];

    if ([director runningScene]) {
        [director replaceScene:[CCTransitionCrossFade transitionWithDuration: 0.5f scene: newScene]];
	}else {
		[director runWithScene:newScene];
	}
}

+(void) goRewardLayer:(int) num{
    CCDirector *director = [CCDirector sharedDirector];
    CCLayer* reward = [RewardLayer node:num];
    [[director runningScene] addChild:reward z:2 tag:rewardLayerTag];
}

+(void) removeRewardLayer{
    CCDirector *director = [CCDirector sharedDirector];
    [[director runningScene] removeChildByTag:rewardLayerTag cleanup:YES];
}
+(void) goPauseLayer{
    CCDirector *director = [CCDirector sharedDirector];
    CCLayer* reward = [PauseLayer node];
    [[director runningScene] addChild:reward z:2 tag:pauseLayerTag];
    [MusicHandler pauseBackground];
}

+(void) removePauseLayer{
    CCDirector *director = [CCDirector sharedDirector];
    [[director runningScene] removeChildByTag:pauseLayerTag cleanup:YES];
    [[PlayDisplayLayer sharedInstance:NO] resumeGame];
    [MusicHandler resumeBackgound];
}

+(void) goHelp{
    CCDirector *director = [CCDirector sharedDirector];
    CCScene *newScene = [CCScene node];
    [newScene addChild:[HelpLayer node]];
    if ([director runningScene]) {
        [director replaceScene:[CCTransitionCrossFade transitionWithDuration: 0.5f scene: newScene]];
	}else {
		[director runWithScene:newScene];
	}
}
@end
