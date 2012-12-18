//
//  GermFigure.m
//  TheGame
//
//  Created by kcy1860 on 12/15/12.
//
//

#import "GermFigure.h"
#import "cocos2d.h"

@implementation GermFigure


@synthesize label;

static NSMutableArray* timeBombs;
static NSMutableArray* poisonous;
static NSMutableArray* bombs;


int currentNumber;
CCAction *tempAction;

-(CCAction*) runAction:(CCAction*) action{
    [super runAction:action];
    CCAction *tempAction = [[action copy] autorelease];
    if(label!=nil)
    {
        [label runAction:tempAction];
    }
    
    return action;
}

+(id)spriteWithFile:(NSString*)filename{
    self = [super spriteWithFile:filename];

    return self;
}

-(void) removeFromParentAndCleanup:(BOOL)cleanup
{
    [timeBombs removeObject:self];
    [poisonous removeObject:self];
    [bombs removeObject:self];
    if(label!=nil)
    {
        [label removeFromParentAndCleanup:YES];
    }
    [super removeFromParentAndCleanup:YES];
}

-(void) setLabelValue:(int) number{
    currentNumber=number;
    if(label!=nil)
    {
        [label release];
    }
    label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",number] fontName:@"Arial" fontSize:15];
    [self recorrectLabelPosition];
    [label setColor:ccc3(0, 0, 0)];
    
}
-(void) recorrectLabelPosition{
    CGPoint p = self.position;
    [label setPosition:ccp(p.x+10,p.y-10)];
}

-(int) nextValue{
    currentNumber--;
    [label setString:[NSString stringWithFormat:@"%d",currentNumber]];
    return currentNumber;
}

+(NSMutableArray*) getArrayByType:(GermType) type
{
    switch (type) {
        case BombGerm:
            if(bombs==nil)
            {
                bombs = [[NSMutableArray alloc] init];
            }
            return bombs;
        case TimeBombGerm:
            if(timeBombs==nil)
            {
                timeBombs = [[NSMutableArray alloc] init];
            }
            return timeBombs;
        case PoisonousGerm:
            if(poisonous==nil)
            {
                poisonous = [[NSMutableArray alloc] init];
            }
            return poisonous;
        default:
            return nil;
    }
}




@end
