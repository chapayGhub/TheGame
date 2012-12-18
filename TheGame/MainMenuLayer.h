#import "cocos2d.h"
#import "SceneManager.h"
#import "UserProfile.h"

// 主菜单
@interface MainMenuLayer :CCLayer{
}

- (void)onStartNew:(id)sender;
- (void)onResume:(id)sender;
- (void)onHighscores:(id)sender;
- (void)onMyGerms:(id)sender;
@end
