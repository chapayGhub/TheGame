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
    GameContext *context2 = [[GameContext alloc] initWithValues:Classic Level:3 Score:1770 Time:60 KindCound:5 Interval:390 FixedRate:25];
    
    GameContext *context3 = [[GameContext alloc] initWithValues:Classic Level:4 Score:960 Time:60 KindCound:6 Interval:360 FixedRate:0];
    GameContext *context4 = [[GameContext alloc] initWithValues:Classic Level:5 Score:1020 Time:60 KindCound:6 Interval:360 FixedRate:25];
    GameContext *context5 = [[GameContext alloc] initWithValues:Classic Level:6 Score:1080 Time:60 KindCound:6 Interval:360 FixedRate:30];
    
    GameContext *context6 = [[GameContext alloc] initWithValues:Classic Level:7 Score:780 Time:60 KindCound:7 Interval:360 FixedRate:0];
    GameContext *context7 = [[GameContext alloc] initWithValues:Classic Level:8 Score:870 Time:60 KindCound:7 Interval:360 FixedRate:25];
    GameContext *context8 = [[GameContext alloc] initWithValues:Classic Level:9 Score:960 Time:60 KindCound:7 Interval:360 FixedRate:50];
    
    GameContext *context80 = [[GameContext alloc] initWithValues:Classic Level:10 Score:1260 Time:60 KindCound:5 Interval:360 FixedRate:0];
    GameContext *context81 = [[GameContext alloc] initWithValues:Classic Level:11 Score:1560 Time:60 KindCound:5 Interval:360 FixedRate:0];
    GameContext *context82 = [[GameContext alloc] initWithValues:Classic Level:12 Score:1770 Time:60 KindCound:5 Interval:390 FixedRate:25];
    
    GameContext *context83 = [[GameContext alloc] initWithValues:Classic Level:13 Score:960 Time:60 KindCound:6 Interval:360 FixedRate:0];
    GameContext *context84 = [[GameContext alloc] initWithValues:Classic Level:14 Score:1020 Time:60 KindCound:6 Interval:360 FixedRate:25];
    GameContext *context85 = [[GameContext alloc] initWithValues:Classic Level:15 Score:1080 Time:60 KindCound:6 Interval:360 FixedRate:30];
    
    GameContext *context86 = [[GameContext alloc] initWithValues:Classic Level:16 Score:780 Time:60 KindCound:7 Interval:360 FixedRate:0];
    GameContext *context87 = [[GameContext alloc] initWithValues:Classic Level:17 Score:870 Time:60 KindCound:7 Interval:360 FixedRate:25];
    GameContext *context88 = [[GameContext alloc] initWithValues:Classic Level:18 Score:960 Time:60 KindCound:7 Interval:360 FixedRate:50];
    
    GameContext *context90 = [[GameContext alloc] initWithValues:Classic Level:19 Score:1260 Time:60 KindCound:5 Interval:360 FixedRate:0];
    GameContext *context91 = [[GameContext alloc] initWithValues:Classic Level:20 Score:1560 Time:60 KindCound:5 Interval:360 FixedRate:0];
    GameContext *context92 = [[GameContext alloc] initWithValues:Classic Level:21 Score:1770 Time:60 KindCound:5 Interval:390 FixedRate:25];
    
    GameContext *context93 = [[GameContext alloc] initWithValues:Classic Level:22 Score:960 Time:60 KindCound:6 Interval:360 FixedRate:0];
    GameContext *context94 = [[GameContext alloc] initWithValues:Classic Level:23 Score:1020 Time:60 KindCound:6 Interval:360 FixedRate:25];
    GameContext *context95 = [[GameContext alloc] initWithValues:Classic Level:24 Score:1080 Time:60 KindCound:6 Interval:360 FixedRate:30];
    
    GameContext *context96 = [[GameContext alloc] initWithValues:Classic Level:25 Score:780 Time:60 KindCound:7 Interval:360 FixedRate:0];
    GameContext *context97 = [[GameContext alloc] initWithValues:Classic Level:26 Score:870 Time:60 KindCound:7 Interval:360 FixedRate:25];
    GameContext *context98 = [[GameContext alloc] initWithValues:Classic Level:27 Score:960 Time:60 KindCound:7 Interval:360 FixedRate:50];
    
    [tempArray addObject:context0];
    [tempArray addObject:context1];
    [tempArray addObject:context2];
    [tempArray addObject:context3];
    [tempArray addObject:context4];
    [tempArray addObject:context5];
    [tempArray addObject:context6];
    [tempArray addObject:context7];
    [tempArray addObject:context8];
    [tempArray addObject:context80];
    [tempArray addObject:context81];
    [tempArray addObject:context82];
    [tempArray addObject:context83];
    [tempArray addObject:context84];
    [tempArray addObject:context85];
    [tempArray addObject:context86];
    [tempArray addObject:context87];
    [tempArray addObject:context88];
    [tempArray addObject:context90];
    [tempArray addObject:context91];
    [tempArray addObject:context92];
    [tempArray addObject:context93];
    [tempArray addObject:context94];
    [tempArray addObject:context95];
    [tempArray addObject:context96];
    [tempArray addObject:context97];
    [tempArray addObject:context98];
    
    
    //无尽模式的关卡设置
    GameContext *context10 = [[GameContext alloc] initWithValues:Poisonous Level:1 Score:500 Time:0 KindCound:6 Interval:5 FixedRate:0];
    GameContext *context11 = [[GameContext alloc] initWithValues:Poisonous Level:2 Score:1000 Time:0 KindCound:6 Interval:5 FixedRate:0];
    GameContext *context12 = [[GameContext alloc] initWithValues:Poisonous Level:3 Score:1250 Time:0 KindCound:6 Interval:5 FixedRate:15];
    GameContext *context13 = [[GameContext alloc] initWithValues:Poisonous Level:4 Score:1500 Time:0 KindCound:6 Interval:4 FixedRate:25];
    GameContext *context14 = [[GameContext alloc] initWithValues:Poisonous Level:5 Score:2000 Time:0 KindCound:6 Interval:4 FixedRate:35];
    GameContext *context15 = [[GameContext alloc] initWithValues:Poisonous Level:6 Score:2500 Time:0 KindCound:7 Interval:3 FixedRate:45];
    GameContext *context16 = [[GameContext alloc] initWithValues:Poisonous Level:7 Score:3000 Time:0 KindCound:7 Interval:3 FixedRate:55];
    GameContext *context17 = [[GameContext alloc] initWithValues:Poisonous Level:8 Score:3300 Time:0 KindCound:7 Interval:2 FixedRate:65];
    GameContext *context18 = [[GameContext alloc] initWithValues:Poisonous Level:9 Score:3700 Time:0 KindCound:7 Interval:2 FixedRate:75];
    
    
    GameContext *context20 = [[GameContext alloc] initWithValues:Bomb Level:1 Score:1000 Time:0 KindCound:6 Interval:5 FixedRate:0];
    GameContext *context21 = [[GameContext alloc] initWithValues:Bomb Level:2 Score:1500 Time:0 KindCound:6 Interval:5 FixedRate:0];
    GameContext *context22 = [[GameContext alloc] initWithValues:Bomb Level:3 Score:2000 Time:0 KindCound:6 Interval:5 FixedRate:15];
    GameContext *context23 = [[GameContext alloc] initWithValues:Bomb Level:4 Score:2500 Time:0 KindCound:6 Interval:4 FixedRate:25];
    GameContext *context24 = [[GameContext alloc] initWithValues:Bomb Level:5 Score:3000 Time:0 KindCound:6 Interval:4 FixedRate:35];
    GameContext *context25 = [[GameContext alloc] initWithValues:Bomb Level:6 Score:3500 Time:0 KindCound:7 Interval:4 FixedRate:45];
    GameContext *context26 = [[GameContext alloc] initWithValues:Bomb Level:7 Score:4000 Time:0 KindCound:7 Interval:3 FixedRate:55];
    GameContext *context27 = [[GameContext alloc] initWithValues:Bomb Level:8 Score:4500 Time:0 KindCound:7 Interval:3 FixedRate:65];
    GameContext *context28 = [[GameContext alloc] initWithValues:Bomb Level:9 Score:5000 Time:0 KindCound:7 Interval:3 FixedRate:75];
    
    GameContext *context30 = [[GameContext alloc] initWithValues:TimeBomb Level:1 Score:1000 Time:0 KindCound:6 Interval:5 FixedRate:0];
    GameContext *context31 = [[GameContext alloc] initWithValues:TimeBomb Level:2 Score:1500 Time:0 KindCound:6 Interval:5 FixedRate:0];
    GameContext *context32 = [[GameContext alloc] initWithValues:TimeBomb Level:3 Score:2000 Time:0 KindCound:6 Interval:5 FixedRate:15];
    GameContext *context33 = [[GameContext alloc] initWithValues:TimeBomb Level:4 Score:2500 Time:0 KindCound:6 Interval:4 FixedRate:25];
    GameContext *context34 = [[GameContext alloc] initWithValues:TimeBomb Level:5 Score:3000 Time:0 KindCound:6 Interval:4 FixedRate:35];
    GameContext *context35 = [[GameContext alloc] initWithValues:TimeBomb Level:6 Score:3500 Time:0 KindCound:7 Interval:4 FixedRate:45];
    GameContext *context36 = [[GameContext alloc] initWithValues:TimeBomb Level:7 Score:4000 Time:0 KindCound:7 Interval:3 FixedRate:55];
    GameContext *context37 = [[GameContext alloc] initWithValues:TimeBomb Level:8 Score:4500 Time:0 KindCound:7 Interval:3 FixedRate:65];
    GameContext *context38 = [[GameContext alloc] initWithValues:TimeBomb Level:9 Score:5000 Time:0 KindCound:7 Interval:3 FixedRate:75];
    
    
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
    
    float factor1_3 = 1;
    float factor4_6 = 1.5;
    float factor7_9 = 2;
    for(GameContext *context in tempArray)
    {
        if(context.type==Classic&&context.level>5)
        {
            context.time=context.time*factor7_9;
            context.levelScore=context.levelScore*factor7_9;
            context.interval=context.interval*factor7_9;
        }else if(context.type==Classic&&context.level>2)
        {
            context.time=context.time*factor4_6;
            context.levelScore=context.levelScore*factor4_6;
            context.interval=context.interval*factor4_6;
        }else if(context.type==Classic){
            context.time=context.time*factor1_3;
            context.levelScore=context.levelScore*factor1_3;
            context.interval=context.interval*factor1_3;
        }
        
        [settings setValue:context forKey:[CommonUtils getKeyStringByGameTypeAndLevel:[context type] level:[context level]]];
    }
}



@end
