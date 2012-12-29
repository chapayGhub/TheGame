//
//  GameContext.m
//  TheGame
//
//  Created by kcy1860 on 12/9/12.
//
//

#import "GameContext.h"
#import "GameDef.h"
@implementation GameContext
@synthesize level,levelScore,type,time,kindCount,interval,fixedGermRate;

-(id) initWithValues:(GameType)gameType Level:(int)levelcount Score:(int)levelscore Time:(int)atime KindCound:(int)kindcount Interval:(int)ainteval FixedRate:(int)rate{
    
    self = [super init];
    self.level=levelcount;
    self.levelScore=levelscore;
    self.time = atime;
    self.type = gameType;
    self.kindCount = kindcount;
    self.interval=ainteval;
    self.fixedGermRate=rate;
    return self;
}

-(GameContext*) getNextLevel
{
    NSMutableDictionary* settings = [[GameDef sharedInstance] settings];
    GameContext *g = [settings objectForKey:[CommonUtils getKeyStringByGameTypeAndLevel:[self type] level:([self level]+1)]];
    if(g==nil)
    {
        return self;
    }
    return g;
}
@end
