//
//  Germ.h
//  TheGame
//
//  Created by kcy1860 on 12/6/12.
//
//

#import "cocos2d.h"
#import "Constants.h"
#import "GermFigure.h"

@interface Germ : NSObject{
}

@property (nonatomic, readonly) int x, y;
@property (nonatomic) GermType type;
@property (nonatomic) int value;
@property (nonatomic) bool moving;
@property (nonatomic) bool centerFlag;
@property (nonatomic) int bombCount;
@property (nonatomic, retain) GermFigure *sprite;


-(id) initWithX: (int) posX Y: (int) posY;
-(BOOL) isNeighbor: (Germ *)otherGerm;
-(void) trade:(Germ *)otherGerm;
-(CGPoint) pixPosition;
-(void) transform:(GermType)type;

@end
