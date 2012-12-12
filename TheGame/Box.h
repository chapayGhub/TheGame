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

@interface Box : NSObject {
	id first, second;
	CGSize size;
	
	NSMutableArray *readyToRemoveHori;
    NSMutableArray *readyToRemoveVerti;
	BOOL lock;
	Germ *boarderGerm;
}

@property(nonatomic, retain) CCLayer *holder;
@property(nonatomic, readonly) CGSize size;
@property(nonatomic) BOOL lock;
@property(nonatomic,readonly) Germ *boarderGerm;
@property(nonatomic, retain) NSMutableArray *content;
@property(atomic) int score,maxHit;
@property(nonatomic) int hitInARoll;
@property(nonatomic) double lastTime;

-(id) initWithSize: (CGSize) size factor: (int) facotr;
-(Germ *) objectAtX: (int) posX Y: (int) posY;

-(void) fill;
-(BOOL) check;
-(void) unlock;
-(void) removeSprite: (id) sender;
-(void) afterAllMoveDone;
-(CGPoint) haveMore;
-(int) repair;
-(void) restart;
@end