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


@synthesize label,currentNumber;

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
    if(currentNumber<=0)
    {
        return 0;
    }
    currentNumber--;
    [label setString:[NSString stringWithFormat:@"%d",currentNumber]];
    return currentNumber;
}






@end
