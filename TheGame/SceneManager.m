#import "SceneManager.h"
#import "PlayBackgroundLayer.h"
#import "PlayLayer.h"

//#import "AdSageView.h"

@interface SceneManager ()

@end


@implementation SceneManager
static MobiSageAdBanner* banner;

+(MobiSageAdBanner*) getBanner
{
    if(banner == nil)
    {
        banner = [[MobiSageAdBanner alloc] initWithAdSize:Ad_320X50];
        [banner setInterval:Ad_Refresh_15];
        [banner setFrame:CGRectMake(0,430, 320, 50)];
    }
    return banner;
}

+(void) goPlay{
    CCDirector *director = [CCDirector sharedDirector];
    CCScene *newScene = [CCScene node];
    
    [newScene addChild:[PlayBackgroundLayer node] z:0];
    [newScene addChild:[PlayLayer node] z:0];
    
    [SceneManager addAdBanner];
    
    if ([director runningScene]) {
        [director replaceScene:[CCTransitionPageTurn transitionWithDuration: 0.5f scene: newScene]];
	}else {
		[director runWithScene:newScene];
	}
}

+(void) addAdBanner
{
     CCDirector *director = [CCDirector sharedDirector];
    [[MobiSageManager getInstance] setPublisherID:@"ea1b5c3fa4b6434fa38b2e3d689b6169"];
    [director.view addSubview:[SceneManager getBanner]];
}

+(void) removeAdBanner
{
    [[SceneManager getBanner] removeFromSuperview];
}
@end
