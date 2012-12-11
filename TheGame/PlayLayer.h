#import "cocos2d.h"
#import "Box.h"
#import "PlayBackgroundLayer.h"
#import "GameContext.h"

@interface PlayLayer : CCLayer
{
	Box *box;
	Germ *selected;
	Germ *firstOne;
    GameContext *context;
}
@property (nonatomic,retain) GameContext* context;

-(void) changeWithTileA: (Germ *) a TileB: (Germ *) b sel : (SEL) sel;
-(void) check: (id) sender data: (id) data;
-(void) hint;
@end
