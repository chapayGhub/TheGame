//
//  AdSageAdapterMobWin.m
//  AdSageSDK
//
//  Created by  on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AdSageAdapterMobWin.h"
#import "AdSageManager.h"
#import "AdSageView.h"
#import "MobWinBannerViewDelegate.h"


static NSInteger adSizeList(AdSageBannerAdViewSizeType bannerAdViewSize)
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if (bannerAdViewSize == AdSageBannerAdViewSize_320X50)
        {
            return MobWINBannerSizeIdentifier320x50;
        }
    }
    else
    {
        if (bannerAdViewSize == AdSageBannerAdViewSize_320X270)
        {
            return MobWINBannerSizeIdentifier300x250;
        }
        if (bannerAdViewSize == AdSageBannerAdViewSize_488X80)
        {
            return MobWINBannerSizeIdentifier468x60;
        }
        if (bannerAdViewSize == AdSageBannerAdViewSize_748X110)
        {
            return MobWINBannerSizeIdentifier728x90;
        }
    }
    return MobWINBannerSizeIdentifierUnknow;
}

@implementation AdSageAdapterMobWin

+ (AdSageAdapterType)adapterType {
	return AdSageAdapterTypeMobWin;
}

+ (void)load {
	[[AdSageManager getInstance] registerClass:self];
}

+ (BOOL)hasBannerSize:(AdSageBannerAdViewSizeType)bannerAdViewSize
{
    if (adSizeList(bannerAdViewSize) != MobWINBannerSizeIdentifierUnknow) {
        return YES;
    }
    return NO;
}

+ (BOOL)hasFullScreen
{
    return YES;
}

+ (BOOL)hasClickMessage
{
    return YES;
}

- (void)getBannerAd:(AdSageBannerAdViewSizeType)bannerAdViewSize
{
    if (![[self class] hasBannerSize:bannerAdViewSize]) {
        return;
    }
    
    timer = [[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
    
    adView = [[MobWinBannerView alloc] initMobWinBannerSizeIdentifier:adSizeList(bannerAdViewSize)];
    
    adView.adUnitID = [self getPublisherId];
    
    adView.rootViewController = [_adSageDelegate viewControllerForPresentingModalView];
    
    adView.delegate = self;
    
    adView.adGpsMode = [self isLocationOn];
    
    adView.adAlpha = 1.0;
    
    [adView startRequest];
    
    self.adNetworkView = adView;
}

- (void)stopBeingDelegate {
    [adView stopRequest];
    [adView setDelegate:nil];
}

- (void)dealloc {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
	[super dealloc];
}

- (void)stopTimer
{
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
}

- (void)bannerViewDidReceived{
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
//    [adView stopRequest];
    [_adSageView adapter:self didReceiveAdView:self.adNetworkView];
}

- (void)bannerViewFailToReceived{
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
//    [adView stopRequest];
    [_adSageView adapter:self didFailAd:self.adNetworkView];
}


// 全屏广告弹出时调用
//
// 详解:当广告栏被点击，弹出内嵌全屏广告时调用
- (void)bannerViewDidPresentScreen
{
    [self.adSageView adapter:self didClickAd:self.adNetworkView];
    [self helperNotifyDelegateOfFullScreenModal];
    
}

// 全屏广告关闭时调用
//
// 详解:当弹出内嵌全屏广告关闭，返回广告栏界面时调用
- (void)bannerViewDidDismissScreen
{
    [self helperNotifyDelegateOfFullScreenModalDismissal];
    
}

// 应用进入后台时调用
//
// 详解:当点击下载或者地图类型广告时，会调用系统程序打开，
// 应用将被自动切换到后台
- (void)bannerViewWillLeaveApplication
{
    [self.adSageView adapter:self didClickAd:self.adNetworkView];
}

- (void)loadAdTimeOut:(NSTimer*)theTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [self stopBeingDelegate];
    [_adSageView adapter:self didFailAd:nil];
}

@end
