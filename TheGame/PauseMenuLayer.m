//
//  PauseMenuLayer.m
//  TheGame
//
//  Created by kcy1860 on 12/16/12.
//
//

#import "PauseMenuLayer.h"


@implementation PauseMenuLayer
@synthesize menu;

-(id) init{
    self = [super init];
    // CGSize winSize = [CCDirector sharedDirector].winSize;
    // 设置暂停menu
    CCMenuItemFont* resumeLabel=[CCMenuItemFont itemWithString:@"继续游戏" target:self selector:@selector(resumeGame)];
    CCMenuItemFont* backLabel=[CCMenuItemFont itemWithString:@"回到菜单" target:self selector:@selector(backToMainMenu)];
    
    resumeLabel.color = ccc3(200, 200, 200);
    backLabel.color = ccc3(200, 200, 200);
    
    menu = [CCMenu menuWithItems:resumeLabel,backLabel, nil];
    [menu alignItemsHorizontallyWithPadding:30.0f];
    [self addChild:menu];
    return self;
}

-(void) backToMainMenu{
    [SceneManager goMainMenu];
}

-(void)resumeGame{
    [[PlayDisplayLayer sharedInstance:NO] resumeGame];
    [SceneManager popScene];
}

@end
