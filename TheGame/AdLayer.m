//
//  AdLayer.m
//  海底对对碰
//
//  Created by kcy1860 on 1/18/13.
//
//

#import "AdLayer.h"
#import "AdSageView.h"
#import "AppDelegate.h"
@implementation AdLayer


-(id) init{
    if( (self=[super init] )) {
    }
    return self;

}

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
- (UIViewController *)viewControllerForPresentingModalView
{
    return [CCDirector sharedDirector];
}

- (void)adSageDidFailToReceiveBannerAd:(AdSageView *)adSageView{
    NSString* string = [adSageView description];
    CCLOG(string);
}
@end
