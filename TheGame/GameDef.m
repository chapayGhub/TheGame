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
    //经典玩法的关卡设置
    GameContext *context = [[GameContext alloc] initWithValues:Classic Level:1 Score:200 Time:100 KindCound:5 Interval:0];
    GameContext *context1 = [[GameContext alloc] initWithValues:Classic Level:2 Score:300 Time:90 KindCound:5 Interval:0];
    GameContext *context2 = [[GameContext alloc] initWithValues:Classic Level:3 Score:500 Time:85 KindCound:5 Interval:0];
    
    GameContext *context3 = [[GameContext alloc] initWithValues:Classic Level:4 Score:1000 Time:80 KindCound:6 Interval:0];
    GameContext *context4 = [[GameContext alloc] initWithValues:Classic Level:5 Score:1200 Time:75 KindCound:6 Interval:0];
    GameContext *context5 = [[GameContext alloc] initWithValues:Classic Level:6 Score:1300 Time:70 KindCound:6 Interval:0];
    
    GameContext *context6 = [[GameContext alloc] initWithValues:Classic Level:7 Score:1400 Time:65 KindCound:7 Interval:0];
    GameContext *context7 = [[GameContext alloc] initWithValues:Classic Level:8 Score:1500 Time:60 KindCound:7 Interval:0];
    GameContext *context8 = [[GameContext alloc] initWithValues:Classic Level:9 Score:1600 Time:60 KindCound:7 Interval:0];
    
    
    
    //无尽模式的关卡设置
    GameContext *context10 = [[GameContext alloc] initWithValues:Poisonous Level:1 Score:200 Time:100 KindCound:5 Interval:2];
    
    GameContext *context20 = [[GameContext alloc] initWithValues:Bomb Level:1 Score:200 Time:100 KindCound:5 Interval:2];
    
    GameContext *context30 = [[GameContext alloc] initWithValues:TimeBomb Level:1 Score:200 Time:100 KindCound:5 Interval:2];
    
    [settings setValue:context forKey:[CommonUtils getKeyStringByGameTypeAndLevel:[context type] level:[context level]]];
    [settings setValue:context1 forKey:[CommonUtils getKeyStringByGameTypeAndLevel:[context1 type] level:[context1 level]]];
    [settings setValue:context2 forKey:[CommonUtils getKeyStringByGameTypeAndLevel:[context2 type] level:[context2 level]]];
    [settings setValue:context3 forKey:[CommonUtils getKeyStringByGameTypeAndLevel:[context3 type] level:[context3 level]]];
    [settings setValue:context4 forKey:[CommonUtils getKeyStringByGameTypeAndLevel:[context4 type] level:[context4 level]]];
    [settings setValue:context5 forKey:[CommonUtils getKeyStringByGameTypeAndLevel:[context5 type] level:[context5 level]]];
    [settings setValue:context6 forKey:[CommonUtils getKeyStringByGameTypeAndLevel:[context6 type] level:[context6 level]]];
    [settings setValue:context7 forKey:[CommonUtils getKeyStringByGameTypeAndLevel:[context7 type] level:[context7 level]]];
    [settings setValue:context8 forKey:[CommonUtils getKeyStringByGameTypeAndLevel:[context8 type] level:[context8 level]]];
    
    
    [settings setValue:context10 forKey:[CommonUtils getKeyStringByGameTypeAndLevel:[context10 type] level:[context10 level]]];
    [settings setValue:context20 forKey:[CommonUtils getKeyStringByGameTypeAndLevel:[context20 type] level:[context20 level]]];
    [settings setValue:context30 forKey:[CommonUtils getKeyStringByGameTypeAndLevel:[context30 type] level:[context30 level]]];
}



@end
