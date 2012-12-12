#import "PlayLayer.h"

@interface PlayLayer()
-(void)afterOneShineTrun: (id) node;

@end

@implementation PlayLayer
@synthesize context = _context;
@synthesize display=_display;
int lastHit;
-(id) init{
	self = [super init];
	box = [[Box alloc] initWithSize:CGSizeMake(kBoxWidth,kBoxHeight) factor:6];
	box.holder = self;
	box.lock = YES;
    self.isTouchEnabled = YES;
    lastHit = 0;
	return self;
}

-(void) onEnterTransitionDidFinish{
	[box fill];
    [box check];
    [box unlock];
    [display startClock];
    [self schedule:@selector(renewScoreBoard) interval:0.1];
}

-(void) renewScoreBoard{
    [[self display] setScore:[box score] Content:[box content]];
    int hit = [box hitInARoll];
    if(hit == lastHit||hit<2)
    {
        lastHit = hit;
        return;
    }else{
        lastHit = hit;
        [[self display] showMultiHit:hit];
    }
}

-(void) hint
{
    CGPoint point = [box haveMore];
    Germ *tile = [box objectAtX:point.x Y:point.y];
    if(selected == tile)
    {
        return;
    }
    selected = tile;
    [self afterOneShineTrun:tile.sprite];
}


- (void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
	if ([box lock]) {
		return;
	}
	
	UITouch* touch = [touches anyObject];
	CGPoint location = [touch locationInView: touch.view];
	location = [[CCDirector sharedDirector] convertToGL: location];
	
    int difX = location.x -kStartX;
    int difY = location.y -kStartY;
    if(difX<0 || difY<0)
    {
        [self hint];
        return;
    }
	int x = difX / kTileSize;
	int y = difY / kTileSize;
    
	
	//如果两次选到的是同一个 直接返回
	if (selected && selected.x ==x && selected.y == y) {
		return;
	}
	
	Germ *tile = [box objectAtX:x Y:y];

	if (selected && [selected isNeighbor:tile]) {
		[box setLock:YES];
		[self changeWithTileA: selected TileB: tile sel: @selector(check:data:)];
		selected = nil;
	}else {
        //如果选择到的不是neighbor 相当于重新选择
		selected = tile;
		[self afterOneShineTrun:tile.sprite];
	}
}

-(void) changeWithTileA: (Germ *) a TileB: (Germ *) b sel : (SEL) sel{
	CCAction *actionA = [CCSequence actions:
						 [CCMoveTo actionWithDuration:kMoveTileTime position:[b pixPosition]],
						 [CCCallFuncND actionWithTarget:self selector:sel data: a],
						 nil
						 ];
	
	CCAction *actionB = [CCSequence actions:
						 [CCMoveTo actionWithDuration:kMoveTileTime position:[a pixPosition]],
						 [CCCallFuncND actionWithTarget:self selector:sel data: b],
						 nil
						 ];
	[a.sprite runAction:actionA];
	[b.sprite runAction:actionB];
	
	[a trade:b];
}

-(void) backCheck: (id) sender data: (id) data{
	if(nil == firstOne){
		firstOne = data;
		return;
	}
	firstOne = nil;
	[box setLock:NO];
}
// 检查转换是否有效，如果无效则换回来
-(void) check: (id) sender data: (id) data{
	if(nil == firstOne){
		firstOne = data;
		return;
	}
	BOOL result = [box check];
	if (result) {
		[box setLock:NO];	
	}else {
		[self changeWithTileA:(Germ *)data TileB:firstOne sel:@selector(backCheck:data:)]; 
		[self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:kMoveTileTime + 0.03f],
						 [CCCallFunc actionWithTarget:box selector:@selector(unlock)],
						 nil]];
	}

	firstOne = nil;
}


-(void)afterOneShineTrun: (id) node{
	if (selected && node == selected.sprite) {
		CCSprite *sprite = (CCSprite *)node;
		CCSequence *someAction = [CCSequence actions:
								  [CCScaleBy actionWithDuration:kShineFreq scale:0.5f],
								  [CCScaleBy actionWithDuration:kShineFreq scale:2.0f],
                                  
								  [CCCallFuncN actionWithTarget:self selector:@selector(afterOneShineTrun:)],//重新调用 持续闪烁
                                  
								  nil];
        
		[sprite runAction:someAction];
	}
    
}
@end
