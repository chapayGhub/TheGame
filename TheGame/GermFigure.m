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
    return self;
}

+(id)spriteWithFrame:(NSString*)frame{
    self = [super spriteWithSpriteFrameName:frame];
    shiftvalueX=10;//default values
    shiftvalueY=-12;
    size=13;
    color=ccc3(255, 255, 255);
    figureShiftX=10;
    figureShiftY=10;
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
-(void) recorrectLabelPosition{
    // CGPoint p = self.position;
   // [label setPosition:ccp(p.x+shiftvalueX,p.y+shiftvalueY)];
   // [bomb setPosition:ccp(p.x+figureShiftX,p.y-figureShiftY)];

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
    [bomb setPosition:ccp(p.x+figureShiftX,p.y-figureShiftY)];
    if(!isRetina)
    {
        [bomb setScale:0.5f];
    }else{
        [bomb setScale:1];
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
