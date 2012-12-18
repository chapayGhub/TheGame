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
@property (nonatomic) int tools_hint,tools_life,tools_refill,count;
@property (nonatomic,retain) NSMutableDictionary* userRecord;
@property (nonatomic,retain) NSDate* lastTime;

+(UserProfile*) sharedInstance;
+(BOOL) writeBackToFile;
-(SeriesLoginCounts) getCountInARoll;//获得连续登陆的天数

-(NSString *)description;
-(void)encodeWithCoder:(NSCoder *)aCoder;
-(id)initWithCoder:(NSCoder *)aDecoder;
@end
