//
//  CommonUtils.h
//  TheGame
//
//  Created by kcy1860 on 12/13/12.
//
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface CommonUtils : NSObject

+(NSString*) getKeyStringByGameTypeAndLevel:(GameType) type level:(int) level;

@end
