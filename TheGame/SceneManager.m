#import "SceneManager.h"
#import "PlayBackgroundLayer.h"
#import "PlayLayer.h"


@interface SceneManager ()
@end


@implementation SceneManager

+(void) goPlay{
    CCDirector *director = [CCDirector sharedDirector];
    CCScene *newScene = [CCScene node];
    
    [newScene addChild:[PlayBackgroundLayer node] z:-1];
    [newScene addChild:[PlayLayer node] z:0];
    
    if ([director runningScene]) {
        [director replaceScene:[CCTransitionFlipY transitionWithDuration: 1.0f scene: newScene]];
	}else {
		[director runWithScene:newScene];
	}
}


@end
