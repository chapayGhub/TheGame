//
//  Germ.m
//  TheGame
//
//  Created by kcy1860 on 12/6/12.
//
//

#import "Germ.h"
#import "PlayLayer.h"
@implementation Germ
@synthesize x, y, value, sprite,type;
@synthesize centerFlag;
@synthesize bombCount;

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
    GermFigure *tempSprite = [sprite retain];
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
    PlayLayer *layer = [PlayLayer sharedInstance:NO];
    if(value == 0)
    {
        return;
    }
    [self setType:atype];
    [self.sprite removeFromParentAndCleanup:YES];
    
    GermFigure* asprite = nil;
    asprite = [GermFigure spriteWithFile:[NSString stringWithFormat:@"q%d.png",value]];
    asprite.scale=0.5f;
    [asprite setPosition:self.pixPosition];

    switch(atype)
    {
        case SuperGerm:         
            [asprite setColor: ccc3(100, 100, 100)];
            [layer addChild:asprite];
            break;
        case PoisonousGerm:
            [asprite setBombPictureWithFile:@"poison.png"];
            [layer addChild:asprite];
            [layer addChild:asprite.bomb];
            break;
        case BombGerm:
            [asprite setBombPictureWithFile:@"bomb.png"];
            [asprite setLabelValue:10];
            [layer addChild:asprite];
            [layer addChild:asprite.bomb];
            [layer addChild:asprite.label];
            break;
        case TimeBombGerm:
            [asprite setBombPictureWithFile:@"bomb.png"];
            [asprite setLabelValue:30];
            [layer addChild:asprite];
            [layer addChild:asprite.bomb];
            [layer addChild:asprite.label];
            break;
        default:
            break;
    }
    
    [self setSprite:asprite];
    
    
}

@end
