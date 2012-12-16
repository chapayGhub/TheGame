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

int currentNumber;

-(CCAction*) runAction:(CCAction*) action{
    [super runAction:action];
    CCAction *actionCopy = [action copy];
    if(label!=nil)
    {
        [label runAction:actionCopy];
    }
    
    return action;
}

+(id)spriteWithFile:(NSString*)filename{
    self = [super spriteWithFile:filename];

    return self;
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

@end
