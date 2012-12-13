#import "PlayLayer.h"

@interface PlayLayer()
-(void)afterOneShineTrun: (id) node;

@end

@implementation PlayLayer
@synthesize context = _context;
@synthesize display=_display;
@synthesize stepCount=_stepCount;

int lastHit;
int clickcount;
-(id) init{
	self = [super init];
	box = [[Box alloc] initWithSize:CGSizeMake(kBoxWidth,kBoxHeight) factor:6];
	box.holder = self;
	box.lock = YES;
    _stepCount=0;
    self.isTouchEnabled = YES;
    lastHit = 0;
    clickcount=0;
	return self;
}

-(void) onEnterTransitionDidFinish{
	[box fill];
    [box check];
    [box unlock];
    [_display startClock];
    [self schedule:@selector(renewScoreBoard) interval:0.2]; //每0.1秒更新一次计分板状态
    [self schedule:@selector(checkPosition) interval:0.5];
}

-(void) checkPosition
{
    NSMutableArray *content = [box content];
    for (int i=0; i<[content count]; i++) {
        NSMutableArray *array = [content objectAtIndex:i];
        for(int j =0;j<[array count];j++)
        {
            Germ *g= [array objectAtIndex:j];
            if(!g.moving)
            {
                [g.sprite setPosition:g.pixPosition];
            }
        }
    }
    
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
        clickcount++;
        if(clickcount==2)
        {
            clickcount=0;
            [self removeChild:selected.sprite cleanup:YES];
            [selected transform:SuperGerm];
            [self addChild:selected.sprite];
            [box check];
        }
		return;
	}
	clickcount=0;
    
	Germ *tile = [box objectAtX:x Y:y];
    
	if (selected && [selected isNeighbor:tile]) {
		[box setLock:YES];
		[self changeWithTileA: selected TileB: tile sel: @selector(check:data:)];
		selected = nil;
        firstOne = nil;
	}else {
        //如果选择到的不是neighbor 相当于重新选择
		selected = tile;
        firstOne = tile;
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
	//a.moving = YES;
    //b.moving = YES;
    [a.sprite runAction:actionA];
	[b.sprite runAction:actionB];
    
    
	[a trade:b];
    a.moving=NO;
    b.moving=NO;
}

-(void) backCheck: (id) sender data: (id) data{
	if(nil == firstOne){
		firstOne = data;
		return;
	}
	firstOne = nil;
}
// 检查转换是否有效，如果无效则换回来
-(void) check: (id) sender data: (id) data{
	if(nil == firstOne){
		firstOne = data;
		return;
	}
	BOOL result = [box check];
	if (result) {
        [self nextStep];
		//[box setLock:NO];
	}else {
		[self changeWithTileA:(Germ *)data TileB:firstOne sel:@selector(backCheck:data:)];
		[self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:kMoveTileTime + 0.03f],
						 [CCCallFunc actionWithTarget:box selector:@selector(unlock)],
						 nil]];
	}
    
	firstOne = nil;
}

-(void) nextStep{
    _stepCount++;
    [box setLock:YES];
    
    NSMutableArray *content = [box content];
    for (int i=[content count]-1; i>=0; i--) {
        NSMutableArray *array = [content objectAtIndex:i];
        for(int j =0;j<[array count];j++)
        {
            Germ *g= [array objectAtIndex:j];
            if( g.type ==PoisonousGerm )
            {
                if(i==6)
                {
                    // 游戏结束
                }else{
                    [self changeWithTileA:(Germ *)g TileB:[box objectAtX:j Y:(i+1)] sel:@selector(backCheck:data:)];
                    [box check];
                }
            }
            
        }
    }
    [box unlock];
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
