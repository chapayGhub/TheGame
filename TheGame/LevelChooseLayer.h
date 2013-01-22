//
//  LevelChooseLayer.h
//  TheGame
//
//  Created by kcy1860 on 12/25/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"

@interface LevelChooseLayer :AdLayer
{
    CCSprite* menu;
}
@property (nonatomic,retain) NSMutableArray* levels;
-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
@end
