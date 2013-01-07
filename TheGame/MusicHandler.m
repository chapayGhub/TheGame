//
//  MusicHandler.m
//  TheGame
//
//  Created by kcy1860 on 12/27/12.
//
//

#import "MusicHandler.h"
#import "SceneManager.h"
#import "SimpleAudioEngine.h"

@implementation MusicHandler

static bool silence;
+(void) playMusic:(NSString *)file Loop:(BOOL)flag
{
    if(!silence)
    {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:file loop:flag];
    }
}

+(void) playEffect:(NSString*) file{
    if(!silence)
    {
        [[SimpleAudioEngine sharedEngine] playEffect:file];
    }
}

+(BOOL) silence{
    return silence;
}

+(void) stopBackground{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
}

+(void) pauseBackground{
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
}

+(void) resumeBackgound{
    [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
}
+(void) setSilence:(BOOL) value{
    silence = value;
    if(!value)
    {
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    }else{
        [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
    }
}

@end
