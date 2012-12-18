//
//  CommonUtils.m
//  TheGame
//
//  Created by kcy1860 on 12/13/12.
//
//

#import "CommonUtils.h"


@implementation CommonUtils

+(NSString*) getKeyStringByGameTypeAndLevel:(GameType) type level:(int) level{
    NSString *typename = nil;
    switch (type) {
        case Classic: 
            typename= [NSString stringWithFormat:@"c%d",level];
            break;
        case Bomb:
            typename= [NSString stringWithFormat:@"b%d",level];
            break;
        case Poisonous:
            typename= [NSString stringWithFormat:@"p%d",level];
            break;
        case TimeBomb:
            typename= [NSString stringWithFormat:@"t%d",level];
            break;
        default:
            break;
    }
    return typename;
}


@end

