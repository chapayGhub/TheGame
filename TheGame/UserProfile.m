//
//  UserProfile.m
//  TheGame
//
//  Created by kcy1860 on 12/10/12.
//
//

#import "UserProfile.h"
#import "CommonUtils.h"
@implementation UserProfile
@synthesize tools_hint,tools_life,tools_refill,userRecord,count,lastTime;

static UserProfile* userprofile;

+(UserProfile*) sharedInstance{
    if(userprofile == nil)
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:[UserProfile getConfigurationFilePath] isDirectory:NO]) //如果存在则读取文件，如果不存在则初始化文件
        {
            [UserProfile readFile];
        }else{
            [UserProfile firstTimeFileInitialize];
            [UserProfile writeBackToFile];
        }
    }
    
    return userprofile;
}

//读取文件初始化
+(void) readFile
{
    NSData *data=[NSData dataWithContentsOfFile:[UserProfile getConfigurationFilePath]];
    userprofile=[[NSKeyedUnarchiver unarchiveObjectWithData:data] retain];
}

//写回文件
+(BOOL) writeBackToFile
{
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:userprofile];
    //转成NSData类型后就可以写入本地磁盘了
    BOOL result = [data writeToFile:[UserProfile getConfigurationFilePath] atomically:YES];
    return result;
}

+(NSString*) getConfigurationFilePath{
    ccResolutionType resolution;
    NSString *fullpath = [[CCFileUtils sharedFileUtils] fullPathFromRelativePath:@"user.dat" resolutionType:&resolution];
    return fullpath;
}

+(void) firstTimeFileInitialize{
    userprofile = [[[UserProfile alloc] init] retain];
    [userprofile setTools_hint:0];
    [userprofile setTools_life:0];
    [userprofile setTools_refill:0];
    [userprofile setCount:1];
    [userprofile setLastTime:[[NSDate alloc] init]];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];

    GameType type = Classic;
    int levels  = 10;
    for(int i=1;i<=levels;i++)
    {
        [dictionary setValue:0 forKey:[CommonUtils getKeyStringByGameTypeAndLevel:type level:i]];
    }
    
    type = Bomb;
    [dictionary setValue:0 forKey:[CommonUtils getKeyStringByGameTypeAndLevel:type level:1]];
    
    type = Poisonous;
    [dictionary setValue:0 forKey:[CommonUtils getKeyStringByGameTypeAndLevel:type level:1]];
    
    type = TimeBomb;
    [dictionary setValue:0 forKey:[CommonUtils getKeyStringByGameTypeAndLevel:type level:1]];
    
    [userprofile setUserRecord:dictionary];
}

-(NSString *)description
{
    NSString *des = [NSString stringWithFormat:@"user record"];
    return des;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:tools_hint forKey:@"hint"];
    [aCoder encodeInt:tools_life forKey:@"life"];
    [aCoder encodeInt:tools_refill forKey:@"refill"];
    [aCoder encodeInt:count forKey:@"count"];
    [aCoder encodeObject:userRecord forKey:@"record"];
    [aCoder encodeObject:lastTime forKey:@"lasttime"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.tools_hint=[aDecoder decodeIntForKey:@"hint"];
        self.tools_life=[aDecoder decodeIntForKey:@"life"];
        self.tools_refill=[aDecoder decodeIntForKey:@"refill"];
        self.count=[aDecoder decodeIntForKey:@"count"];
        self.userRecord=[aDecoder decodeObjectForKey:@"record"];
        self.lastTime=[aDecoder decodeObjectForKey:@"lasttime"];
    }
    return self;
}


-(SeriesLoginCounts) getCountInARoll{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSInteger unitFlags =NSMonthCalendarUnit|NSDayCalendarUnit;

    //int week=0;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    int month = [comps month];
    int day = [comps day];
    
    comps = [calendar components:unitFlags fromDate:lastTime];
    int last_month = [comps month];
    int last_day = [comps day];
    
    
    //这里判断比较简单 是有BUG的 但是就这样吧
    if(day==last_day && month == last_month)//同一天登陆
    {
        return SameDay;
    }else if((month == last_month && day==last_day+1)||(month==last_month+1 && day==1))//连续第N天的登陆
    {
        count = count+1;
        
        self.lastTime = date;
        [UserProfile writeBackToFile];
        if(count==2)
        {
            return TwoDay;
        }
        if(count >=3)
        {
            if(count%3==0)
            {
                return ThreeDay;
            }else
            {
                return TwoDay;
            }
        }
    }else{ //连续登陆日期终端
        count = 1;
        
        self.lastTime = date;
        [UserProfile writeBackToFile];
        return OneDay;
    }
    return OneDay;
}

@end
