//
//  Box.m
//  TheGame
//
//  Created by kcy1860 on 12/8/12.
//
//

#import "Box.h"

@interface Box()
-(int) repairSingleColumn: (int) columnIndex;
-(void) combine;
-(void) handleCombineAnimation:(Orientation) ori array:(NSMutableArray*) array;
-(void) renew;
@end

@implementation Box
@synthesize holder;
@synthesize size;
@synthesize lock;

//初始化函数
-(id) initWithSize: (CGSize) aSize factor: (int) aFacotr{
	self = [super init];
	size = aSize;
	boarderGerm = [[Germ alloc] initWithX:-1 Y:-1];
    //放置所有的游戏节点，此时只是空的，并没有真正的sprite
	content = [NSMutableArray arrayWithCapacity: size.height];
	for (int y=0; y<size.height; y++) {
		
		NSMutableArray *rowContent = [NSMutableArray arrayWithCapacity:size.width];
		for (int x=0; x < size.width; x++) {
			Germ *germ = [[Germ alloc] initWithX:x Y:y];
			[rowContent addObject:germ];
			[germ release];
		}
		[content addObject:rowContent];
		[content retain];
	}
	readyToRemove = [NSMutableSet setWithCapacity:5];
    readyToCombineHori = [[NSMutableArray alloc] init];
    readyToCombineVerti = [[NSMutableArray alloc] init];
	[readyToRemove retain];
    [readyToCombineHori retain];
    [readyToCombineVerti retain];
    return self;
}

//返回在指定坐标上的germ
-(Germ *) objectAtX: (int) x Y: (int) y{
	if (x < 0 || x >= kBoxWidth || y < 0 || y >= kBoxHeight) {
		return boarderGerm;
	}
	return [[content objectAtIndex: y] objectAtIndex: x];
}

//检查在某个方向上是否有三连
-(void) checkWith: (Orientation) orient{
	int iMax = (orient == OrientationVert) ? size.width : size.height;
	int jMax = (orient == OrientationVert) ? size.height : size.width;
	for (int i=0; i<iMax; i++) {
		int count = 0;
		int value = -1;
		first = nil;
		second = nil;
		for (int j=0; j<jMax; j++) {
			Germ *germ = [self objectAtX:((orient == OrientationVert) ?i :j)  Y:((orient == OrientationVert) ?j :i)];
			if(germ.value == value){
				count++;
				if (count > 3) {
                
                    if(count==4)
                    {
                        
                        for(int k=3;k>0;k--)
                        {
                            Germ *lastgerm = [self objectAtX:((orient == OrientationHori) ?germ.x-k:germ.x)  Y:((orient == OrientationHori) ?germ.y:germ.y-k)];
                            [readyToRemove removeObject:lastgerm];
                            if(orient == OrientationHori)
                            {
                                [readyToCombineHori addObject:lastgerm];
                            }else{
                                [readyToCombineVerti addObject:lastgerm];
                            }
                        }
                    }
                    
                    if(orient == OrientationHori)
                    {
                        [readyToCombineHori addObject:germ];
                    }else{
                        [readyToCombineVerti addObject:germ];
                    }
                    
                    
				}else
					if (count == 3) {
						[readyToRemove addObject:first];
						[readyToRemove addObject:second];
						[readyToRemove addObject:germ];
						first = nil;
						second = nil;
					}else if (count == 2) {
						second = germ;
					}
			}else {
				count = 1;
				first = germ;
				second = nil;
				value = germ.value;
			}
		}
	}
}
-(void) handleCombineAnimation:(Orientation)ori array:(NSMutableArray *)array
{
    if(array == nil || [array count] ==0 )
    {
        return;
    }
    
    Germ *center = nil;
    for(int j =0;j<[array count];j++)
    {
        if((ori==OrientationVert&&[readyToCombineHori containsObject:[array objectAtIndex:j]])||
           (ori==OrientationHori&&[readyToCombineVerti containsObject:[array objectAtIndex:j]])){
            center = [array objectAtIndex:j];
            break;
        }
    }
    if(center == nil)
    {
        center = [array objectAtIndex:[array count]/2];
    }
    CGPoint centerP = [center pixPosition];
    for(int j =0;j<[array count];j++)
    {
        Germ *g = [array objectAtIndex:j];
        g.value = 0;
        if([g sprite] /**&& g.y!=center.y*/)
        {
            CCAction *action = [CCSequence actions:[CCMoveTo actionWithDuration:kConvergeTime position: centerP],
                                [CCCallFuncN actionWithTarget: self selector:@selector(removeSprite:)],
                                nil];
            [[g sprite] runAction: action];
        }
    }
    //TODO 把center变为特殊的孢子
}


-(void)combine
{
    //合并
    int count = [readyToCombineVerti count];
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:5];
    Germ *last = nil;
    if(count>0)
    {
        last = [readyToCombineVerti objectAtIndex:0];
    }
    for (int i=0; i<count; i++) {
        if(i==0)
        {
            [tempArray addObject:last];
        }else{
            Germ *tp = [readyToCombineVerti objectAtIndex:i];
            if ([last isNeighbor:tp])
            {
                [tempArray addObject:[readyToCombineVerti objectAtIndex:i]];
            }else{ //处理combine
                [self handleCombineAnimation:OrientationVert array:tempArray];
            }
        }
        last =[readyToCombineVerti objectAtIndex:i];
    }
    [self handleCombineAnimation:OrientationVert array:tempArray];
    
    [tempArray removeAllObjects];
    count = [readyToCombineHori count];
    if(count>0)
    {
        last = [readyToCombineHori objectAtIndex:0];
    }
    for (int i=0; i<count; i++) {
        if(i==0)
        {
            [tempArray addObject:last];
        }else{
            Germ *tp = [readyToCombineHori objectAtIndex:i];
            if ([last isNeighbor:tp])
            {
                [tempArray addObject:[readyToCombineHori objectAtIndex:i]];
            }else{ //处理combine
                [self handleCombineAnimation:OrientationHori array:tempArray];
            }
        }
        last =[readyToCombineHori objectAtIndex:i];
        
    }
    [self handleCombineAnimation:OrientationHori array:tempArray];
    [tempArray removeAllObjects];
    [tempArray release];
    
    [readyToCombineVerti removeAllObjects];
    [readyToCombineHori removeAllObjects];
}

//检查并修复
-(BOOL) check{
	//从两个方向上检查
    [self checkWith:OrientationHori];
	[self checkWith:OrientationVert];
	
    //如果没有需要移除的则之间返回
	NSArray *objects = [[readyToRemove objectEnumerator] allObjects];
    if ([objects count] == 0 && [readyToCombineHori count] ==0 && [readyToCombineVerti count] ==0) {
		return NO;
	}
    
    // 消除
	int count = [objects count];
	for (int i=0; i<count; i++) {
        
		Germ *germ = [objects objectAtIndex:i];
		germ.value = 0;
		if (germ.sprite) {
            //设置被消除的孢子的消除效果 这里是缩放
			CCAction *action = [CCSequence actions:[CCFadeOut actionWithDuration:0.3f],
								[CCCallFuncN actionWithTarget: self selector:@selector(removeSprite:)],
								nil];
			[germ.sprite runAction: action];
		}
	}
	[readyToRemove removeAllObjects];
    
    [self combine];
    
    // 修复，此时被消除的孢子应该已经在屏幕上看不到了
	int maxCount = [self repair];
	
    //等修复完成以后，执行afterAllMoveDone的方法
	[holder runAction: [CCSequence actions: [CCDelayTime actionWithDuration: kMoveTileTime * maxCount + 0.03f],
                        [CCCallFunc actionWithTarget:self selector:@selector(afterAllMoveDone)],
                        nil]];
    
	return YES;
}

-(void) removeSprite: (id) sender{
	[holder removeChild: sender cleanup:YES];
}

//补全了所有的孢子
-(void) afterAllMoveDone{
    
	if([self check]){//检查补全后是否还有需要消除的
		
	}else {//如果没有
		if ([self haveMore]) {//检查是否还有解，如果存在解，那么解锁继续游戏
			[self unlock];
		}else {
            //如果已经无解，那么重新初始化游戏
            [self renew];
		}
	}
}


-(void)renew
{
    for (int y=0; y< kBoxHeight; y++) {
        for (int x=0; x< kBoxWidth; x++) {
            Germ *germ = [self objectAtX:x Y:y];
            germ.value = 0;
        }
    }
    [self check];
}

-(void) unlock{
	self.lock = NO;
}
//修复
-(int) repair{
	int maxCount = 0;
	for (int x=0; x<size.width; x++) {
		//修复单列
        int count = [self repairSingleColumn:x];
		if (count > maxCount) {
			maxCount = count;
		}
	}
	return maxCount;
}

-(int) repairSingleColumn: (int) columnIndex{
	
    int count = 0; //统计本列被消除的孢子的数目
    
	for (int y=0; y<size.height; y++) {
		Germ *germ = [self objectAtX:columnIndex Y:y];
        if(germ.value == 0){
            count++;
        }else if (count == 0) {
            
        }else{
            //如果某个孢子下面有被消除的孢子，那么它应该移动到那个孢子的位置去
            Germ *destTile = [self objectAtX:columnIndex Y:y-count];
            CCSequence *action = [CCSequence actions:
                                  [CCMoveBy actionWithDuration:kMoveTileTime*count position:ccp(0,-kTileSize*count)],
                                  nil];
            [germ.sprite runAction: action];
            destTile.value = germ.value;
            destTile.sprite = germ.sprite;
        }
	}
    
	//目前所有移动都已经完成， 那么这一列上应该有count个孢子的缺口，下面来补全
	for (int i=0; i<count; i++) {
        // 随机出一种孢子
		int value = (arc4random()%kKindCount+1);
        //从下往上来
		Germ *destGerm = [self objectAtX:columnIndex Y:kBoxHeight-count+i];
		NSString *name = [NSString stringWithFormat:@"q%d.png",value];
		CCSprite *sprite = [CCSprite spriteWithFile:name];
		sprite.position = ccp(kStartX + columnIndex * kTileSize + kTileSize/2, kStartY + (kBoxHeight + i) * kTileSize + kTileSize/2);
		
        CCSequence *action = [CCSequence actions:
							  [CCMoveBy actionWithDuration:kMoveTileTime*count position:ccp(0,-kTileSize*count)],
							  nil];
		[holder addChild: sprite];
		[sprite runAction: action];
		destGerm.value = value;
		destGerm.sprite = sprite;
	}
	return count;
}

// 当前情况下是否还有解
-(BOOL) haveMore{
	for (int y=0; y<size.height; y++) {
		for (int x=0; x<size.width; x++) {
			Germ *aGerm = [self objectAtX:x Y:y];
			
			//v 1 2
			if (aGerm.y-1 >= 0) {
				Germ *bTile = [self objectAtX:x Y:y-1];
				if (aGerm.value == bTile.value) {
					{
						Germ *cGerm = [self objectAtX:x Y:y+2];
						if (cGerm.value == aGerm.value) {
							return YES;
						}
					}
					{
                        Germ *cGerm = [self objectAtX:x-1 Y:y+1];
                        if (cGerm.value == aGerm.value) {
                            return YES;
                        }
					}
					{
                        Germ *cGerm = [self objectAtX:x+1 Y:y+1];
                        if (cGerm.value == aGerm.value) {
                            return YES;
                        }
					}
					
					{
						Germ *cGerm = [self objectAtX:x Y:y-3];
						if (cGerm.value == aGerm.value) {
							return YES;
						}
					}
					
					{
                        Germ *cGerm = [self objectAtX:x-1 Y:y-2];
                        if (cGerm.value == aGerm.value) {
                            return YES;
                        }
					}
					{
                        Germ *cGerm = [self objectAtX:x+1 Y:y-2];
                        if (cGerm.value == aGerm.value) {
                            return YES;
                        }
                    }
                }
			}
			//v 1 3
			if (aGerm.y-2 >= 0) {
				Germ *bGerm = [self objectAtX:x Y:y-2];
				if (aGerm.value == bGerm.value) {
					{
						Germ *cTile = [self objectAtX:x Y:y+1];
						if (cTile.value == aGerm.value) {
							return YES;
						}
					}
					{
						Germ *cTile = [self objectAtX:x Y:y-3];
						if (cTile.value == aGerm.value) {
							return YES;
						}
					}
					{
						Germ *cTile = [self objectAtX:x-1 Y:y-1];
						if (cTile.value == aGerm.value) {
							return YES;
						}
					}
					{
						Germ *cTile = [self objectAtX:x+1 Y:y-1];
						if (cTile.value == aGerm.value) {
							return YES;
						}
					}
				}
			}
			// h 1 2
			if (aGerm.x+1 < kBoxWidth) {
				Germ *bTile = [self objectAtX:x+1 Y:y];
				if (aGerm.value == bTile.value) {
					{
						Germ *cTile = [self objectAtX:x-2 Y:y];
						if (cTile.value == aGerm.value) {
							return YES;
						}
					}
					
					{
						Germ *cGerm = [self objectAtX:x-1 Y:y-1];
						if (cGerm.value == aGerm.value) {
							return YES;
                        }
                    }
					{
						Germ *cGerm= [self objectAtX:x-1 Y:y+1];
						if (cGerm.value == aGerm.value) {
                            return YES;
						}
					}
					
					{
						Germ *cGerm = [self objectAtX:x+3 Y:y];
						if (cGerm.value == aGerm.value) {
							return YES;
						}
					}
					
					{
						Germ *cGerm= [self objectAtX:x+2 Y:y-1];
						if (cGerm.value == aGerm.value) {
							return YES;
						}
					}
					{
						Germ *cGerm= [self objectAtX:x+2 Y:y+1];
						if (cGerm.value == aGerm.value) {
							return YES;
						}
					}
					
				}
			}
			
			//h 1 3
			if (aGerm.x+2 >= kBoxWidth) {
				Germ *bGerm = [self objectAtX:x+2 Y:y];
				if (aGerm.value == bGerm.value) {
					{
						Germ *cGerm = [self objectAtX:x+3 Y:y];
						if (cGerm.value == aGerm.value) {
							return YES;
						}
					}
					
					{
						Germ *cGerm = [self objectAtX:x-1 Y:y];
						if (cGerm.value == aGerm.value) {
							return YES;
						}
					}
					
					
					{
						Germ *cGerm = [self objectAtX:x+1 Y:y-1];
						if (cGerm.value == aGerm.value) {
							return YES;
						}
					}
					{
						Germ *cGerm = [self objectAtX:x+1 Y:y+1];
						if (cGerm.value == aGerm.value) {
							return YES;
						}
					}
				}
			}
		}
	}
	return NO;
}

-(void)fill{
    //目前所有移动都已经完成， 那么这一列上应该有count个孢子的缺口，下面来补全
	
    for (int i=0; i<[content count]; i++) {
        NSMutableArray *array = [content objectAtIndex:i];
        for(int j =0;j<[array count];j++)
        {
            // 随机出一种孢子
            int value = (arc4random()%kKindCount+1);
            //从下往上来
            Germ *destGerm = [self objectAtX:j Y:i];
            NSString *name = [NSString stringWithFormat:@"q%d.png",value];
            CCSprite *sprite = [CCSprite spriteWithFile:name];
            sprite.position = ccp(kStartX + j * kTileSize + kTileSize/2, kStartY +  i * kTileSize + kTileSize/2);
            [holder addChild: sprite];
            destGerm.value = value;
            destGerm.sprite = sprite;
        }
	}
    
}

@end
