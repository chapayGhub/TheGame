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
	NSMutableArray *content;
	NSMutableSet *readyToRemove;
	BOOL lock;
	CCLayer *holder;
	Germ *boarderGerm;
}
@property(nonatomic, retain) CCLayer *holder;
@property(nonatomic, readonly) CGSize size;
@property(nonatomic) BOOL lock;

-(id) initWithSize: (CGSize) size factor: (int) facotr;
-(Germ *) objectAtX: (int) posX Y: (int) posY;

-(BOOL) check;
-(void) unlock;
-(void) removeSprite: (id) sender;
-(void) afterAllMoveDone;
-(BOOL) haveMore;
@end