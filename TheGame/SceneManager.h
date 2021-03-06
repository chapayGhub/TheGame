
#import "cocos2d.h"
#import "CCTransition.h"
#import "MainMenuLayer.h"
#import "PlayDisplayLayer.h"
#import "ActiveBackgroundLayer.h"
#import "GameDef.h"
#import "CommonUtils.h"
#import "GameModeChooseLayer.h"
#import "PauseLayer.h"
#import "MobClick.h"
#import "AdSageDelegate.h"
#import "AdLayer.h"

@interface SceneManager : NSObject{

}

+(void) goPlay:(GameType)type level:(int)level;  //跳转到游戏页面
+(void) goMainMenu; //跳转到主菜单
+(void) pushScene:(CCScene*) scence;
+(void) popScene;
+(void) goGameModeChoose;
+(void) goLevelChoose;
+(void) goRewardLayer:(int) num;
+(void) removeRewardLayer;
+(void) goPauseLayer;
+(void) removePauseLayer;
+(void) goRecommand;
+(void) goHelp;
@end
