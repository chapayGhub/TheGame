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
    [self.sprite removeFromParentAndCleanup:NO];
    if(value == 0)
    {
        return;
    }
    [self setType:atype];

    
    GermFigure *figure = [GermFigure spriteWithFrame:[NSString stringWithFormat:atype==SuperGerm?@"fb%d.png":@"q%d.png",value]];
    [figure setPosition:[self pixPosition]];
    switch(atype)
    {
        case SuperGerm:
            [layer addChild:figure];
            break;
        case PoisonousGerm:
            [figure setBombPictureWithFile:@"poison.png"];
            [layer addChild:figure];
            [layer addChild:figure.bomb];
            [MusicHandler playEffect:@"poisonappear.mp3"];
            break;
        case BombGerm:
            [figure setBombPictureWithFile:@"bomb.png"];
            [figure setLabelValue:stepBombCount];
            [layer addChild:figure];
            [layer addChild:figure.bomb];
            [layer addChild:figure.label];
            [MusicHandler playEffect:@"bombappear.mp3"];
            break;
        case TimeBombGerm:
            [figure setBombPictureWithFile:@"bomb.png"];
            [figure setLabelValue:timeBombCount];
            [layer addChild:figure];
            [layer addChild:figure.bomb];
            [layer addChild:figure.label];
            [MusicHandler playEffect:@"bombappear.mp3"];
            break;
        case NormalGerm:
            [layer addChild:figure];
            break;
        case FixedGerm:
            [figure setShiftValue:2];
            [figure setBombPictureWithFile:@"freeze.png"];
            
            if(!isRetina)
            {
                [[figure bomb] setScale:0.5f];
            }
            [layer addChild:figure];
            [layer addChild:figure.bomb];
            break;
        default:
            break;
    }
    if(!isRetina)
    {
        [figure setScale:0.5f];
    }
    [self setSprite:figure];

}

@end
