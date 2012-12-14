//
//  GameContext.m
//  TheGame
//
//  Created by kcy1860 on 12/9/12.
//
//

#import "GameContext.h"

@implementation GameContext
@synthesize level,levelScore,type,time,kindCount;

-(id) initWithValues:(GameType)gameType Level:(int)levelcount Score:(int)levelscore Time:(int)atime KindCound:(int)kindcount Interval:(int)ainteval{
    self = [super init];
    self.level=levelcount;
    self.levelScore=levelscore;
    self.time = atime;
    self.type = gameType;
    self.kindCount = kindcount;
    self.interval=ainteval;
    
    return self;
}
@end
