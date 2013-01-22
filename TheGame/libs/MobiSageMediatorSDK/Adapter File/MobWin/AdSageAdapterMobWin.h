//
//  AdSageAdapterMobWin.h
//  AdSageSDK
//
//  Created by  on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

//MobWin 1.3.2

#import "AdSageAdapter.h"
#import "MobWinBannerViewDelegate.h"
#import "MobWinBannerView.h"


@interface AdSageAdapterMobWin : AdSageAdapter <MobWinBannerViewDelegate>{
    MobWinBannerView *adView;
    NSTimer *timer;
}

@end
