//
//  Germ.m
//  TheGame
//
//  Created by kcy1860 on 12/6/12.
//
//

#import "Germ.h"

@implementation Germ
@synthesize x, y, value, sprite,type;
@synthesize centerFlag;

-(id) initWithX: (int) posX Y: (int) posY{
	self = [super init];
	x = posX;
	y = posY;
    self.type = NormalGerm;
    centerFlag = NO;
	return self;
}


-(BOOL) isNeighbor: (Germ *)otherGerm{
    if(otherGerm==nil)
    {
        return NO;
    }
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
    return ccp(kStartX + x * kTileSize +kTileSize/2.0f,kStartY + y * kTileSize +kTileSize/2.0f);
}

-(void)transform:(GermType)atype
{
    [self setType:atype];
    NSString *name = [NSString stringWithFormat:@"q8.png"];
    CCSprite *asprite = [CCSprite spriteWithFile:name];
    [self setSprite:asprite];
    [self setValue:8];
    [sprite setPosition:self.pixPosition];
}
@end
