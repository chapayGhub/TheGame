#import "cocos2d.h"
#import "Box.h"
#import "PlayBackgroundLayer.h"

@interface PlayLayer : CCLayer
{
	Box *box;
	Germ *selected;
	Germ *firstOne;
}

-(void) changeWithTileA: (Germ *) a TileB: (Germ *) b sel : (SEL) sel;
-(void) check: (id) sender data: (id) data;
@end
