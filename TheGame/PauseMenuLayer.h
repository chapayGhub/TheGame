//
//  PauseMenuLayer.h
//  TheGame
//
//  Created by kcy1860 on 12/16/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"

// 暂停菜单
@interface PauseMenuLayer : CCLayer

@property (nonatomic,retain) CCMenu *menu;

-(id) init;
@end
