//
//  main.m
//  TheGame
//
//  Created by kcy1860 on 12/3/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdSageManager.h"

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    //[[MobiSageManager getInstance] setPublisherID:@"ea1b5c3fa4b6434fa38b2e3d689b6169"];
    [[AdSageManager getInstance] setAdSageKey:@"ea1b5c3fa4b6434fa38b2e3d689b6169"];

    int retVal = UIApplicationMain(argc, argv, nil, @"AppController");
    [pool release];
    return retVal;
}
