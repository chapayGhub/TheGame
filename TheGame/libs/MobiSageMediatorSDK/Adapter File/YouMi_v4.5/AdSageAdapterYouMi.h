//
//  AdSageAdapterYouMi.h
//  AdSageSDK
//
//  Created by  on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//YouMi v4.0
#import "AdSageAdapter.h"
#import "YouMiView.h"

@interface AdSageAdapterYouMi : AdSageAdapter<YouMiDelegate>
{
	NSTimer *timer;
}
@end
