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
int shiftvalueX;
int shiftvalueY;
int figureShiftX;
int figureShiftY;
int size;
ccColor3B color;
-(CCAction*) runAction:(CCAction*) action{
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
    
    [super runAction:action];
    return action;
}

+(id)spriteWithFile:(NSString*)filename{
    self = [super spriteWithFile:filename];
    shiftvalueX=10;//default values
    shiftvalueY=-12;
    size=13;
    color=ccc3(255, 255, 255);
    figureShiftX=10;
    figureShiftY=10;
    if(isRetina)
    {
        shiftvalueX*=2;
        shiftvalueY*=2;
        figureShiftX*=2;
        figureShiftY*=2;
    }
    return self;
}

+(id)spriteWithFrame:(CCSpriteFrame*)frame{
    self = [super spriteWithSpriteFrame:frame];
    shiftvalueX=10;//default values
    shiftvalueY=-12;
    size=13;
    color=ccc3(255, 255, 255);
    figureShiftX=10;
    figureShiftY=10;
    if(isRetina)
    {
        shiftvalueX*=2;
        shiftvalueY*=2;
        figureShiftX*=2;
        figureShiftY*=2;
    }
    return self;
}

-(void) setShiftValue:(int) type{
    if(type==1) // tools
    {
        shiftvalueX=12;
        shiftvalueY=10;
        size = 20;
        color = ccc3(60, 60, 60);
    }else if(type==2)
    {
        figureShiftX=0;
        figureShiftY=0;
    }
}

-(void) removeFromParentAndCleanup:(BOOL)notNeedToRemoveLabelAndBomb
{

    if(!notNeedToRemoveLabelAndBomb)
    {
        if([self bomb]!=nil)
        {
            [[self bomb] removeFromParentAndCleanup:YES];
        }
        
        if([self label]!=nil)
        {
            [[self label] removeFromParentAndCleanup:YES];
        }
    }
    [super removeFromParentAndCleanup:YES];

}

-(void) setLabelValue:(int) number{
    currentNumber=number;
    if(label!=nil)
    {
        [label release];
    }
    label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",number] fontName:@"Arial-BoldMT" fontSize:size];
    [self recorrectLabelPosition];
    [label setColor:color];
    
}
-(void) recorrectLabelPosition{
    CGPoint p = self.position;
    if (isRetina) {
        [label setPosition:ccp(p.x+2*shiftvalueX,p.y+2*shiftvalueY)];
        [bomb setPosition:ccp(p.x+2*figureShiftX,p.y-2*figureShiftY)];
    }else{
        [label setPosition:ccp(p.x+shiftvalueX,p.y+shiftvalueY)];
        [bomb setPosition:ccp(p.x+figureShiftX,p.y-figureShiftY)];
    }
}
-(void) setBombPictureWithFile:(NSString*) file{
    bomb = [CCSprite spriteWithFile:file];
    CGPoint p = self.position;
    [bomb setPosition:ccp(p.x+figureShiftX,p.y-figureShiftY)];
    if(!isRetina)
    {
        [bomb setScale:0.7f];
    }
}
-(int) nextValue{
    if(currentNumber==0)
    {
        return -1;
    }
    currentNumber--;
    [label setString:[NSString stringWithFormat:@"%d",currentNumber]];
    return currentNumber;
}

@end
