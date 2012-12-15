//
//  GermFigure.h
//  TheGame
//
//  Created by kcy1860 on 12/15/12.
//
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"

// 重载CCSprite 方便做特殊孢子的效果
@interface GermFigure:CCSprite
-(CCAction*) runAction:(CCAction*) action;
+(id)spriteWithFile:(NSString*)filename;
@end
