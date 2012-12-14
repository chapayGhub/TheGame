//
//  GameDef.h
//  TheGame
//
//  Created by kcy1860 on 12/13/12.
//
//

#import <Foundation/Foundation.h>
#import "GameContext.h"
#import "CommonUtils.h"
@interface GameDef : NSObject
@property (nonatomic,retain) NSMutableDictionary* settings;

+(GameDef*) sharedInstance;
@end
