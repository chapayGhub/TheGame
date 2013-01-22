//
//  AdSageAdapterYouMi.m
//  AdSageSDK
//
//  Created by  on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AdSageAdapterYouMi.h"
#import "AdSageView.h"
#import "AdSageManager.h"

static YouMiBannerContentSizeIdentifier adSizeList(AdSageBannerAdViewSizeType bannerAdViewSize)
{
    switch (bannerAdViewSize) {
        case AdSageBannerAdViewSize_320X50:
            return YouMiBannerContentSizeIdentifier320x50;
            break;
        case AdSageBannerAdViewSize_320X270:
            return YouMiBannerContentSizeIdentifier300x250;
            break;
        case AdSageBannerAdViewSize_488X80:
            return YouMiBannerContentSizeIdentifier468x60;
            break;
        case AdSageBannerAdViewSize_748X110:
            return YouMiBannerContentSizeIdentifier728x90;
            break;
        default:
            return YouMiBannerContentSizeIdentifierUnknow;
            break;
    }
}

@implementation AdSageAdapterYouMi
+ (void)load {
    [[AdSageManager getInstance] registerClass:self];
}

+ (AdSageAdapterType)adapterType {
  return AdSageAdapterTypeYouMi;
}

+ (BOOL)hasBannerSize:(AdSageBannerAdViewSizeType)bannerAdViewSize
{
    if (adSizeList(bannerAdViewSize) > YouMiBannerContentSizeIdentifierUnknow) {
        return YES;
    }
    return NO;
}

+ (BOOL)hasFullScreen
{
    return NO;
}

- (NSString *)getYouMi_AppId
{
    NSString *keys = [self getPublisherId];
    /* These methods return length==0 if the target string is not found. So, to check for containment: ([str rangeOfString:@"target"].length > 0).  Note that the length of the range returned by these methods might be different than the length of the target string, due composed characters and such.
     */
    NSRange range = [keys rangeOfString:@"|,|"];
    if (range.length == 0) {
        return nil;
    }
    NSString *appId = [keys substringToIndex:range.location];
    return appId;
}

- (NSString *)getYouMi_AppSecret
{
    NSString *keys = [self getPublisherId];
    NSRange range = [keys rangeOfString:@"|,|"];
    if (range.length == 0) {
        return nil;
    }
    NSString *appSecret = [keys substringFromIndex:(range.location+3)];
    return appSecret;
}

- (void)getBannerAd:(AdSageBannerAdViewSizeType)bannerAdViewSize
{
    if (![[self class] hasBannerSize:bannerAdViewSize]) {
        return;
    }
    
    timer = [[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
    
//    [YouMiView setShouldCacheImage:NO];
    [YouMiView setShouldGetLocation:NO];
    
    YouMiView *adView = [[YouMiView alloc] initWithContentSizeIdentifier:adSizeList(bannerAdViewSize) delegate:self];
    
    adView.appID = [self getYouMi_AppId];
    adView.appSecret = [self getYouMi_AppSecret];
    
    
    if ([self isTestMode]) {
        adView.testing = YES;
    }
    else {
        adView.testing = NO;
    }
    
    adView.indicateRounded = YES;
    
    [adView start];
    
    self.adNetworkView = adView;
    
    [adView release];
    
}

- (void)stopBeingDelegate {
	YouMiView *adView = (YouMiView *)self.adNetworkView;
    adView.delegate = nil;
}

- (void)stopTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
}

- (void)dealloc {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
	[super dealloc];
}

- (void)loadAdTimeOut:(NSTimer*)theTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [self stopBeingDelegate];
    [_adSageView adapter:self didFailAd:self.adNetworkView];
}

#pragma mark YouMiView Delegate 
- (void)didReceiveAd:(YouMiView *)adView {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [_adSageView adapter:self didReceiveAdView:adView];
}

- (void)didFailToReceiveAd:(YouMiView *)adView  error:(NSError *)error {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [_adSageView adapter:self didFailAd:adView];
}

- (void)didPresentScreen:(YouMiView *)adView {
    [self helperNotifyDelegateOfFullScreenModal];
}

- (void)didDismissScreen:(YouMiView *)adView {
    [self helperNotifyDelegateOfFullScreenModalDismissal];
}

@end
