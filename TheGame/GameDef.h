//
//  GameDef.h
//  TheGame
//
//  Created by kcy1860 on 12/13/12.
//
//

#import <Foundation/Foundation.h>

@interface GameDef : NSObject
@property (nonatomic,retain) NSMutableDictionary* settings;

+(GameDef*) sharedInstance;
-(void) refresh;
-(void) writeBackToFile;
@end
