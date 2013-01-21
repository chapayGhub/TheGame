//
//  GermFigure.m
//  TheGame
//
//  Created by kcy1860 on 12/15/12.
//
//

#import "GermFigure.h"

@implementation GermFigure


@synthesize label,currentNumber,bomb,shiftvalueX,shiftvalueY,figureShiftX,figureShiftY;

CCAction *tempAction;
CCAction *tempAction1;

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

    size=13;
    color=ccc3(255, 255, 255);

    return self;
}

+(id)spriteWithFrame:(NSString*)frame{
    self = [super spriteWithSpriteFrameName:frame];
    size=13;
    color=ccc3(255, 255, 255);
    return self;
}

-(void) setShiftValue:(int) type{
    if(type==1) // tools
    {
        shiftvalueX=12;
        shiftvalueY=10;
        size = 15;
        color = ccc3(1, 57, 109);
    }else if(type==2)
    {
        figureShiftX=0;
        figureShiftY=0;
    }else{
        shiftvalueX=10;//default values
        shiftvalueY=-12;
        figureShiftX=10;
        figureShiftY=10;
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
    [label setPosition:ccp(self.position.x+shiftvalueX,self.position.y+shiftvalueY)];
    [label setColor:color];
    
}


-(void) resetPosition:(CGPoint)position{
    [super setPosition:position];
    if(label!=nil)
    {
        [label setPosition:ccp(position.x+shiftvalueX,position.y+shiftvalueY)];
    }
    if(bomb!=nil){
        [bomb setPosition:ccp(position.x+figureShiftX,position.y-figureShiftY)];
    }
}
-(void) setBombPictureWithFile:(NSString*) file{
    bomb = [CCSprite spriteWithFile:file];
    CGPoint p = self.position;
    [bomb setPosition:ccp(p.x+figureShiftX,p.y-figureShiftY)];
    if(!isRetina)
    {
        [bomb setScale:0.7f];
    }else{
        [bomb setScale:1.3f];
    }
}

-(void) setFreezePictureWithFile:(NSString*) file{
    bomb = [CCSprite spriteWithFile:file];
    CGPoint p = self.position;
    [bomb setPosition:ccp(p.x,p.y)];
    figureShiftX=0;
    figureShiftY=0;
    if(!isRetina)
    {
        [bomb setScale:0.5f];
    }else{
        [bomb setScale:1];
    }
}

-(int) nextValue{
    if(currentNumber<=0)
    {
        return -1;
    }
    currentNumber--;
    [label setString:[NSString stringWithFormat:@"%d",currentNumber]];
    return currentNumber;
}

@end
