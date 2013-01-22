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
#import "UserProfile.h"
#import "MobClick.h"
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


- (void)adSageViewPointInside:(AdSageView *)adsageView{
    UserProfile* profile = [UserProfile sharedInstance];
    int ad = [profile clickAd];
    [profile setClickAd:ad+1];
    [MobClick event:@"clickonad" label:[NSString stringWithFormat:@"%d",ad+1]];
}

@end
