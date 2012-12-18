
#import "cocos2d.h"
#import "CCTransition.h"
#import "MobiSageSDK.h"
#import "MainMenuLayer.h"
#import "PlayDisplayLayer.h"
#import "ActiveBackgroundLayer.h"
#import "GameDef.h"
#import "CommonUtils.h"
#import "PauseMenuLayer.h"
#import "GameModeChooseLayer.h"

@interface SceneManager : NSObject {

}

+(void) goPlay:(GameType)type level:(int)level;  //跳转到游戏页面
+(void) goMainMenu; //跳转到主菜单
+(void) pushScene:(CCScene*) scence;
+(void) popScene;
+(void) goPauseMenu;
+(void) goGameModeChoose;
@end
