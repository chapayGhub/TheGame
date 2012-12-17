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
@synthesize tools_hint,tools_life,tools_refill,userRecord,count;

static UserProfile* instance;

+(UserProfile*) sharedInstance{
    if(instance == nil)
    {
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        if([fileManager fileExistsAtPath:@"user.dat"]) //如果存在则读取文件，如果不存在则初始化文件
        {
            [UserProfile readFile];
        }else{
            [UserProfile firstTimeFileInitialize];
            [UserProfile writeBackToFile];
        }
    }
    
    return instance;
}

//读取文件初始化
+(void) readFile
{
    NSData *data=[NSData dataWithContentsOfFile:@"user.dat"];
    instance=[NSKeyedUnarchiver unarchiveObjectWithData:data];
}

//写回文件
+(void) writeBackToFile
{
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:instance];
    //转成NSData类型后就可以写入本地磁盘了
    [data writeToFile:@"user.dat" atomically:YES];
}

+(void) firstTimeFileInitialize{
    instance = [[UserProfile alloc] init];
    [instance setTools_hint:0];
    [instance setTools_life:0];
    [instance setTools_refill:0];
    [instance setCount:0];
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
    
    [instance setUserRecord:dictionary];
}

-(NSString *)description
{
    NSString *des = [NSString stringWithFormat:@"user record"];
    return des;
}
-(void)encodeWithCoder:(NSCoder *)aCoder//要一一对应
{
    [aCoder encodeInt:tools_hint forKey:@"hint"];
    [aCoder encodeInt:tools_life forKey:@"life"];
    [aCoder encodeInt:tools_refill forKey:@"refill"];
    [aCoder encodeInt:count forKey:@"count"];
    [aCoder encodeObject:userRecord forKey:@"record"];
}
-(id)initWithCoder:(NSCoder *)aDecoder//和上面对应
{
    if (self=[super init]) {
        self.tools_hint=[aDecoder decodeIntForKey:@"hint"];
        self.tools_life=[aDecoder decodeIntForKey:@"life"];
        self.tools_refill=[aDecoder decodeIntForKey:@"refill"];
        self.count=[aDecoder decodeIntForKey:@"count"];
        self.userRecord=[aDecoder decodeObjectForKey:@"record"];
    }
    return self;
}

@end
