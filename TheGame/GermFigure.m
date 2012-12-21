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


@synthesize label,currentNumber,bomb;

CCAction *tempAction;
CCAction *tempAction1;
-(CCAction*) runAction:(CCAction*) action{
    [super runAction:action];
    
    
    if(label!=nil)
    {
        tempAction = [[action copy] autorelease];
        [label runAction:tempAction];
    }
    if(bomb!=nil)
    {
        tempAction1 = [[action copy] autorelease];
        [bomb runAction:tempAction1];
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
    if(bomb!=nil)
    {
        [bomb removeFromParentAndCleanup:YES];
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
    [label setColor:ccc3(255, 255, 255)];
    
}
-(void) recorrectLabelPosition{
    CGPoint p = self.position;
    [label setPosition:ccp(p.x+10,p.y-10)];
}

-(void) setBombPictureWithFile:(NSString*) file{
    bomb = [CCSprite spriteWithFile:file];
    CGPoint p = self.position;
    [bomb setPosition:ccp(p.x+10,p.y-10)];
    [bomb setScale:0.7f];
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
