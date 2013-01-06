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
    
    GameContext *context6 = [[GameContext alloc] initWithValues:Classic Level:7 Score:810 Time:60 KindCound:7 Interval:240 FixedRate:0];
    GameContext *context7 = [[GameContext alloc] initWithValues:Classic Level:8 Score:900 Time:60 KindCound:7 Interval:240 FixedRate:25];
    GameContext *context8 = [[GameContext alloc] initWithValues:Classic Level:9 Score:1020 Time:60 KindCound:7 Interval:240 FixedRate:50];
    
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
    GameContext *context10 = [[GameContext alloc] initWithValues:Poisonous Level:1 Score:200 Time:0 KindCound:5 Interval:2 FixedRate:0];
    GameContext *context11 = [[GameContext alloc] initWithValues:Poisonous Level:2 Score:200 Time:0 KindCound:5 Interval:2 FixedRate:0];
    GameContext *context12 = [[GameContext alloc] initWithValues:Poisonous Level:3 Score:200 Time:0 KindCound:5 Interval:2 FixedRate:0];
    
    GameContext *context20 = [[GameContext alloc] initWithValues:Bomb Level:1 Score:200 Time:100 KindCound:5 Interval:2 FixedRate:0];
    
    GameContext *context30 = [[GameContext alloc] initWithValues:TimeBomb Level:1 Score:200 Time:100 KindCound:5 Interval:2 FixedRate:0];
    
    
    [tempArray addObject:context10];
    [tempArray addObject:context11];
    [tempArray addObject:context12];
    
    [tempArray addObject:context20];
    
    [tempArray addObject:context30];
    
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
