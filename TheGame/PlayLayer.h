#import "cocos2d.h"
#import "Box.h"
#import "PlayBackgroundLayer.h"
#import "GameContext.h"
#import "PlayDisplayLayer.h"
#import "SceneManager.h"

// 游戏界面
@interface PlayLayer : CCLayer
{
	Box *box;
	Germ *selected;
	Germ *firstOne;
}
@property (nonatomic,retain) GameContext* context;
@property (nonatomic) int stepCount;

-(void) changeWithTileA: (Germ *) a TileB: (Germ *) b sel : (SEL) sel;
-(void) check: (id) sender data: (id) data;
-(void) hint;
-(void) nextStep;
-(id) init;
-(void) resetWithContext:(GameContext *)context refresh:(BOOL) fresh;
+(PlayLayer*) sharedInstance:(BOOL) refresh;
-(Box*) getBox;
-(void) pauseGame;
-(void) resumeGame;
-(void) toNextLevel:(BOOL) refresh;
-(void) reload;
@end
