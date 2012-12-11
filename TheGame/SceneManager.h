
#import "cocos2d.h"
#import "CCTransition.h"
#import "MobiSageSDK.h"

@interface SceneManager : NSObject {

}

+(void) goPlay;  //跳转到游戏页面
+(MobiSageAdBanner*) getBanner;
@end
