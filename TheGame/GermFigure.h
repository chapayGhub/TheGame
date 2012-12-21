//
//  GermFigure.h
//  TheGame
//
//  Created by kcy1860 on 12/15/12.
//
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"
#import "Constants.h"
// 重载CCSprite 方便做特殊孢子的效果
@interface GermFigure:CCSprite


@property (nonatomic,retain) CCLabelTTF* label;
@property (nonatomic,retain) CCSprite* bomb;
@property (atomic) int currentNumber;

-(void) setLabelValue:(int) number;
-(CCAction*) runAction:(CCAction*) action;
+(id)spriteWithFile:(NSString*)filename;
-(int) nextValue;//让label上的数字递减
-(void) recorrectLabelPosition;
-(void) removeFromParentAndCleanup:(BOOL)cleanup;
-(void) setBombPictureWithFile:(NSString*) file;
@end
