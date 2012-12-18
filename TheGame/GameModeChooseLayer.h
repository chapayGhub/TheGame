//
//  GameModeChooseLayer.h
//  TheGame
//
//  Created by kcy1860 on 12/18/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"

@interface GameModeChooseLayer : CCLayer
{
    CCSprite* bomb;
    CCSprite* timeBomb;
    CCSprite* poison;
    CCLabelTTF *description;
}
-(id) init;
@end
