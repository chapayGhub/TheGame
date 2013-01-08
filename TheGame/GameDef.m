//
//  GameDef.m
//  TheGame
//
//  Created by kcy1860 on 12/13/12.
//
//

#import "GameDef.h"

@implementation GameDef
@synthesize settings;//dictionary中的key是用GameType和level调用CommonUtil中的方法生成的，Value是一个GameContext对象

static GameDef* def;

+(GameDef*) sharedInstance{
    if(!def)
    {
        def = [[GameDef alloc] init];
        [def refresh];
    }
    return def;
}


-(void) refresh{
    if(settings)
    {
        [settings removeAllObjects];
        [settings release];
    }
    settings = [[NSMutableDictionary alloc] init];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    //经典玩法的关卡设置
    GameContext *context0 = [[GameContext alloc] initWithValues:Classic Level:1 Score:1260 Time:60 KindCound:5 Interval:360 FixedRate:0];
    GameContext *context1 = [[GameContext alloc] initWithValues:Classic Level:2 Score:1560 Time:60 KindCound:5 Interval:360 FixedRate:0];
    GameContext *context2 = [[GameContext alloc] initWithValues:Classic Level:3 Score:1620 Time:60 KindCound:5 Interval:360 FixedRate:25];
    
    GameContext *context3 = [[GameContext alloc] initWithValues:Classic Level:4 Score:960 Time:60 KindCound:6 Interval:300 FixedRate:0];
    GameContext *context4 = [[GameContext alloc] initWithValues:Classic Level:5 Score:1020 Time:60 KindCound:6 Interval:300 FixedRate:25];
    GameContext *context5 = [[GameContext alloc] initWithValues:Classic Level:6 Score:1080 Time:60 KindCound:6 Interval:300 FixedRate:30];
    
    GameContext *context6 = [[GameContext alloc] initWithValues:Classic Level:7 Score:810 Time:60 KindCound:7 Interval:300 FixedRate:0];
    GameContext *context7 = [[GameContext alloc] initWithValues:Classic Level:8 Score:900 Time:60 KindCound:7 Interval:300 FixedRate:25];
    GameContext *context8 = [[GameContext alloc] initWithValues:Classic Level:9 Score:1020 Time:60 KindCound:7 Interval:300 FixedRate:50];
    
    [tempArray addObject:context0];
    [tempArray addObject:context1];
    [tempArray addObject:context2];
    [tempArray addObject:context3];
    [tempArray addObject:context4];
    [tempArray addObject:context5];
    [tempArray addObject:context6];
    [tempArray addObject:context7];
    [tempArray addObject:context8];
    
    
    
    //无尽模式的关卡设置
    GameContext *context10 = [[GameContext alloc] initWithValues:Poisonous Level:1 Score:500 Time:0 KindCound:6 Interval:5 FixedRate:0];
    GameContext *context11 = [[GameContext alloc] initWithValues:Poisonous Level:2 Score:1000 Time:0 KindCound:6 Interval:5 FixedRate:0];
    
    GameContext *context12 = [[GameContext alloc] initWithValues:Poisonous Level:3 Score:1500 Time:0 KindCound:6 Interval:5 FixedRate:15];
    GameContext *context13 = [[GameContext alloc] initWithValues:Poisonous Level:4 Score:2000 Time:0 KindCound:6 Interval:4 FixedRate:25];
    GameContext *context14 = [[GameContext alloc] initWithValues:Poisonous Level:5 Score:2500 Time:0 KindCound:6 Interval:4 FixedRate:35];
    GameContext *context15 = [[GameContext alloc] initWithValues:Poisonous Level:6 Score:3000 Time:0 KindCound:7 Interval:3 FixedRate:45];
    GameContext *context16 = [[GameContext alloc] initWithValues:Poisonous Level:7 Score:3500 Time:0 KindCound:7 Interval:3 FixedRate:55];
    GameContext *context17 = [[GameContext alloc] initWithValues:Poisonous Level:8 Score:4000 Time:0 KindCound:7 Interval:2 FixedRate:65];
    GameContext *context18 = [[GameContext alloc] initWithValues:Poisonous Level:9 Score:4500 Time:0 KindCound:7 Interval:2 FixedRate:75];
    
    
    GameContext *context20 = [[GameContext alloc] initWithValues:Bomb Level:1 Score:500 Time:0 KindCound:6 Interval:5 FixedRate:0];
    GameContext *context21 = [[GameContext alloc] initWithValues:Bomb Level:2 Score:1000 Time:0 KindCound:6 Interval:2 FixedRate:0];
    GameContext *context22 = [[GameContext alloc] initWithValues:Bomb Level:3 Score:1500 Time:0 KindCound:6 Interval:5 FixedRate:15];
    GameContext *context23 = [[GameContext alloc] initWithValues:Bomb Level:4 Score:2000 Time:0 KindCound:6 Interval:4 FixedRate:25];
    GameContext *context24 = [[GameContext alloc] initWithValues:Bomb Level:5 Score:2500 Time:0 KindCound:6 Interval:4 FixedRate:35];
    GameContext *context25 = [[GameContext alloc] initWithValues:Bomb Level:6 Score:3000 Time:0 KindCound:7 Interval:3 FixedRate:45];
    GameContext *context26 = [[GameContext alloc] initWithValues:Bomb Level:7 Score:3500 Time:0 KindCound:7 Interval:3 FixedRate:55];
    GameContext *context27 = [[GameContext alloc] initWithValues:Bomb Level:8 Score:4000 Time:0 KindCound:7 Interval:2 FixedRate:65];
    GameContext *context28 = [[GameContext alloc] initWithValues:Bomb Level:9 Score:4500 Time:0 KindCound:7 Interval:2 FixedRate:75];
    
    GameContext *context30 = [[GameContext alloc] initWithValues:TimeBomb Level:1 Score:500 Time:0 KindCound:6 Interval:5 FixedRate:0];
    GameContext *context31 = [[GameContext alloc] initWithValues:TimeBomb Level:2 Score:1000 Time:0 KindCound:6 Interval:5 FixedRate:0];
    GameContext *context32 = [[GameContext alloc] initWithValues:TimeBomb Level:3 Score:1500 Time:0 KindCound:6 Interval:5 FixedRate:15];
    GameContext *context33 = [[GameContext alloc] initWithValues:TimeBomb Level:4 Score:2000 Time:0 KindCound:6 Interval:4 FixedRate:25];
    GameContext *context34 = [[GameContext alloc] initWithValues:TimeBomb Level:5 Score:2500 Time:0 KindCound:6 Interval:4 FixedRate:35];
    GameContext *context35 = [[GameContext alloc] initWithValues:TimeBomb Level:6 Score:3000 Time:0 KindCound:7 Interval:3 FixedRate:45];
    GameContext *context36 = [[GameContext alloc] initWithValues:TimeBomb Level:7 Score:3500 Time:0 KindCound:7 Interval:3 FixedRate:55];
    GameContext *context37 = [[GameContext alloc] initWithValues:TimeBomb Level:8 Score:4000 Time:0 KindCound:7 Interval:2 FixedRate:65];
    GameContext *context38 = [[GameContext alloc] initWithValues:TimeBomb Level:9 Score:4500 Time:0 KindCound:7 Interval:2 FixedRate:75];
    
    
    [tempArray addObject:context10];
    [tempArray addObject:context11];
    [tempArray addObject:context12];
    [tempArray addObject:context13];
    [tempArray addObject:context14];
    [tempArray addObject:context15];
    [tempArray addObject:context16];
    [tempArray addObject:context17];
    [tempArray addObject:context18];
    
    [tempArray addObject:context20];
    [tempArray addObject:context21];
    [tempArray addObject:context22];
    [tempArray addObject:context23];
    [tempArray addObject:context24];
    [tempArray addObject:context25];
    [tempArray addObject:context26];
    [tempArray addObject:context27];
    [tempArray addObject:context28];
    
    [tempArray addObject:context30];
    [tempArray addObject:context31];
    [tempArray addObject:context32];
    [tempArray addObject:context33];
    [tempArray addObject:context34];
    [tempArray addObject:context35];
    [tempArray addObject:context36];
    [tempArray addObject:context37];
    [tempArray addObject:context38];
    
    for(GameContext *context in tempArray)
    {
        //这段代码仅在测试的时候使用
//        if(context.type==Classic)
//        {
//            context.time=context.time/3;
//            context.levelScore=context.levelScore/3;
//            context.interval=context.interval/3;
//        }
        
        [settings setValue:context forKey:[CommonUtils getKeyStringByGameTypeAndLevel:[context type] level:[context level]]];
    }
}



@end
