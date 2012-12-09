//
//  Germ.m
//  TheGame
//
//  Created by kcy1860 on 12/6/12.
//
//

#import "Germ.h"

@implementation Germ
@synthesize x, y, value, sprite;


-(id) initWithX: (int) posX Y: (int) posY{
	self = [super init];
	x = posX;
	y = posY;
	return self;
}


-(BOOL) isNeighbor: (Germ *)otherGerm{
	return
	(x == otherGerm.x && abs(y - otherGerm.y)==1)
	||
	(y == otherGerm.y && abs(x - otherGerm.x)==1);
}


-(void) trade:(Germ *)otherGerm{
    CCSprite *tempSprite = [sprite retain];
	int tempValue = value;
	self.sprite = otherGerm.sprite;
	self.value = otherGerm.value;
	otherGerm.sprite = tempSprite;
	otherGerm.value = tempValue;
	[tempSprite release];    
}


-(CGPoint) pixPosition{
    //TODO 
	return ccp(0,0);
}

@end
