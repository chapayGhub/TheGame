//
//  UserProfile.h
//  TheGame
//
//  Created by kcy1860 on 12/10/12.
//
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "cocos2d.h"

@interface UserProfile : NSObject{
}

//道具数目 count代表连续登陆天数
@property (nonatomic) int tools_hint,tools_life,tools_refill,count,clickAd;
@property (nonatomic,retain) NSMutableDictionary* userRecord;
@property (nonatomic,retain) NSDate* lastTime;
@property (nonatomic) BOOL silence;

+(UserProfile*) sharedInstance;
+(BOOL) writeBackToFile;
-(int) getCountInARoll;//获得连续登陆的天数

-(NSString *)description;
-(void)encodeWithCoder:(NSCoder *)aCoder;
-(id)initWithCoder:(NSCoder *)aDecoder;
+(void) firstTimeFileInitialize;
-(void) addHint:(int)value;
-(void) addLife:(int)value;
-(void) addRefill:(int)value;
@end
