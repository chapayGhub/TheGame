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
@synthesize erased;
@synthesize moving;
@synthesize bombCount;

-(id) initWithX: (int) posX Y: (int) posY{
	self = [super init];
	x = posX;
	y = posY;
    self.type = NormalGerm;
    centerFlag = NO;
    erased = NO;
    moving = NO;
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
	GermType tempType = type;
    self.sprite = otherGerm.sprite;
	self.value = otherGerm.value;
	self.type = otherGerm.type;
    
    otherGerm.sprite = tempSprite;
	otherGerm.value = tempValue;
    otherGerm.type = tempType;
	[tempSprite release];    
}


-(CGPoint) pixPosition{
    return ccp(kStartX + x * kTileSize +kTileSize/2.0f,kStartY + y * kTileSize +kTileSize/2.0f);
}

-(void)transform:(GermType)atype
{
    if(value == 0)
    {
        return;
    }
    [self setType:atype];
    CCSprite* asprite = nil;
    switch(atype)
    {
        case SuperGerm:
            asprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"q%d.png",value]];
            asprite.scale=0.5;
            [asprite setColor: ccc3(100, 100, 100)];
            break;
        case PoisonousGerm:
            asprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"q7.png"]];
            [self setValue:7];
            break;
        default:
            break;
    }
    
    [self setSprite:asprite];
    [sprite setPosition:self.pixPosition];
}
@end
