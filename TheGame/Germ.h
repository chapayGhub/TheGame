//
//  Germ.h
//  TheGame
//
//  Created by kcy1860 on 12/6/12.
//
//

#import "cocos2d.h"
#import "Constants.h"
@interface Germ : NSObject{
    int x, y, value;
    CCSprite *sprite;
}

@property (nonatomic, readonly) int x, y;
@property (nonatomic) int value;
@property (nonatomic, retain) CCSprite *sprite;


-(id) initWithX: (int) posX Y: (int) posY;
-(BOOL) isNeighbor: (Germ *)otherGerm;
-(void) trade:(Germ *)otherGerm;
-(CGPoint) pixPosition;


@end
