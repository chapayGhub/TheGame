#import "cocos2d.h"
#import "SceneManager.h"
#import "UserProfile.h"

// 主菜单
@interface MainMenuLayer :CCLayer{
}

- (void)onStartNew:(id)sender;
- (void)onInfiniteMode:(id)sender;
- (void)onOtherGames:(id)sender;
- (void)onHelp:(id)sender;
@end
