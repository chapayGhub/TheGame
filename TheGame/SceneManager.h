
#import "cocos2d.h"
#import "CCTransition.h"
#import "MobiSageSDK.h"
#import "MainMenuLayer.h"

@interface SceneManager : NSObject {

}

+(void) goPlay;  //跳转到游戏页面
+(void) goMainMenu;
+(MobiSageAdBanner*) getBanner;
@end
