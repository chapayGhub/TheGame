
#import "cocos2d.h"
#import "CCTransition.h"
#import "MobiSageSDK.h"
#import "MainMenuLayer.h"
#import "PlayDisplayLayer.h"
#import "ActiveBackgroundLayer.h"
@interface SceneManager : NSObject {

}

+(void) goPlay;  //跳转到游戏页面
+(void) goMainMenu; //跳转到主菜单

@end
