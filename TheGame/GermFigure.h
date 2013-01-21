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

@property (nonatomic) int shiftvalueX;
@property (nonatomic) int shiftvalueY;
@property (nonatomic) int figureShiftX;
@property (nonatomic) int figureShiftY;

-(void) setLabelValue:(int) number;
-(CCAction*) runAction:(CCAction*) action;
+(id)spriteWithFile:(NSString*)filename;
-(int) nextValue;//让label上的数字递减

-(void) removeFromParentAndCleanup:(BOOL)notNeedToRemoveLabelAndBomb;
-(void) setBombPictureWithFile:(NSString*) file;
-(void) setShiftValue:(int) type;
+(id)spriteWithFrame:(NSString*)frame;
-(void) resetPosition:(CGPoint)position;
-(void) setFreezePictureWithFile:(NSString*) file;
@end
