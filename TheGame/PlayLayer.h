#import "cocos2d.h"
#import "Box.h"
#import "PlayBackgroundLayer.h"

@interface PlayLayer : PlayBackgroundLayer
{
	Box *box;
	Germ *selectedTile;
	Germ *firstOne;
}
+(id) scene;
-(void) changeWithTileA: (Germ *) a TileB: (Germ *) b sel : (SEL) sel;
-(void) check: (id) sender data: (id) data;
@end
