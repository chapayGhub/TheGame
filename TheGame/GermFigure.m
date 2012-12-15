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

-(CCAction*) runAction:(CCAction*) action{
    [super runAction:action];
    
    return action;
}

+(id)spriteWithFile:(NSString*)filename{
    self = [super spriteWithFile:filename];
    return self;
}

@end
