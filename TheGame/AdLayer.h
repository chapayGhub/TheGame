//
//  AdLayer.h
//  海底对对碰
//
//  Created by kcy1860 on 1/18/13.
//
//
#import "AdSageDelegate.h"
//#import "MobiSageRecommendSDK.h"
#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
@interface AdLayer :  CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate, AdSageDelegate>

@end
