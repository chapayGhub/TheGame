//
//  Box.h
//  TheGame
//
//  Created by kcy1860 on 12/8/12.
//
//

#import "Germ.h"
#import "CCLayer.h"
#import "Constants.h"
//#import "PlayDisplayLayer.h"

@interface Box : NSObject {
	id first, second;	
	NSMutableArray *readyToRemoveHori;
    NSMutableArray *readyToRemoveVerti;
}

@property(nonatomic, retain) CCLayer *holder;
@property(nonatomic, readonly) CGSize size;
@property(atomic) BOOL lock,paused;
@property(nonatomic,readonly) Germ *boarderGerm;
@property(nonatomic, retain) NSMutableArray *content;
@property(atomic) int score,maxHit,kind;
@property(nonatomic) int hitInARoll;
@property(nonatomic) double lastTime;

-(id) initWithSize: (CGSize) size factor: (int) facotr;
-(Germ *) objectAtX: (int) posX Y: (int) posY;

-(void) fill;
-(BOOL) check: (BOOL) nextstep;
-(void) unlock;
-(void) removeSprite: (id) sender;
-(void) afterAllMoveDone;
-(CGPoint) haveMore;
-(int) repair;
-(void) restart;
@end