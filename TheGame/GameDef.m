//
//  GameDef.m
//  TheGame
//
//  Created by kcy1860 on 12/13/12.
//
//

#import "GameDef.h"

@implementation GameDef
@synthesize settings;

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
    //TODO 读取文件，填充dictionary
    //dictionary中的key是用GameType和level调用CommonUtil中的方法生成的，Value是一个GameContext对象
    
}

-(void) writeBackToFile{
    //TODO 用当前的dictionary中的信息更新文件
    
}
@end
