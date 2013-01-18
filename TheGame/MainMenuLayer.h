#import "cocos2d.h"
#import "SceneManager.h"
#import "UserProfile.h"
#import "AdLayer.h"

// 主菜单
@interface MainMenuLayer :AdLayer{
    CCMenu *menu;
}

- (void)onStartNew:(id)sender;
- (void)onInfiniteMode:(id)sender;
- (void)onOtherGames:(id)sender;
- (void)onHelp:(id)sender;
-(void) enableMenu:(BOOL) flag;
@end
