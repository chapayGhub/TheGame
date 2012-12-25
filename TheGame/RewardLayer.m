//
//  RewardLayer.m
//  TheGame
//
//  Created by kcy1860 on 12/24/12.
//
//

#import "RewardLayer.h"
#import "SceneManager.h"
@implementation RewardLayer

+(id) node:(int) num{
    return [[[RewardLayer alloc] init:num] autorelease];
}

-(id) init:(int) num{
    self = [super init];
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"连续登陆%d天",num] fontName:@"Arial-BoldMT" fontSize:20];
    label.position=ccp(winSize.width*0.5,winSize.height*0.5);
    [self addChild:label];    
    return self;
}

-(void) onEnterTransitionDidFinish{
    [self scheduleOnce:@selector(doTransmit) delay:1];
}

-(void) doTransmit{
    [SceneManager goGameModeChoose];
}

@end
