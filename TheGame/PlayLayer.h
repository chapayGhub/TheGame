#import "cocos2d.h"
#import "Box.h"
#import "PlayBackgroundLayer.h"
#import "GameContext.h"
#import "PlayDisplayLayer.h"

@interface PlayLayer : CCLayer
{
	Box *box;
	Germ *selected;
	Germ *firstOne;
}
@property (nonatomic,retain) GameContext* context;
@property (nonatomic,retain) PlayDisplayLayer* display;
@property (nonatomic) int stepCount;

-(void) changeWithTileA: (Germ *) a TileB: (Germ *) b sel : (SEL) sel;
-(void) check: (id) sender data: (id) data;
-(void) hint;
-(void) nextStep;
-(id) init;
-(void) resetWithContext:(GameContext *)context;
@end
