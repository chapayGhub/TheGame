//
//  MusicHandler.h
//  TheGame
//
//  Created by kcy1860 on 12/27/12.
//
//

#import <Foundation/Foundation.h>

@interface MusicHandler : NSObject

+(void) playMusic:(NSString*) file Loop:(BOOL) flag;
+(BOOL) silence;
+(void) setSilence:(BOOL) value;
@end
