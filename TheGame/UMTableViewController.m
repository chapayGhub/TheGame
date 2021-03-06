//
//  UMTableViewDemo.m
//  UMAppNetwork
//
//  Created by liu yu on 12/17/11.
//  Copyright (c) 2011 Realcent. All rights reserved.
//

#import "UMTableViewController.h"
#import "UMTableViewCell.h"
#import "SceneManager.h"
@implementation UMTableViewController


-(id) init{
    self = [super init];
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    _mTableView.dataLoadDelegate = nil;
    [_mTableView removeFromSuperview];
    _mTableView = nil;
    [_mLoadingStatusLabel release];
    _mLoadingStatusLabel = nil;
    [_mLoadingActivityIndicator release];
    _mLoadingActivityIndicator = nil;
    [_mNoNetworkImageView release];
    _mNoNetworkImageView = nil;
    [_mLoadingWaitView removeFromSuperview];
    [_mLoadingWaitView release];
    _mLoadingWaitView = nil;
    
    [super dealloc];
}

#pragma mark - View lifecycle
-(void) backToPrevious{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animDone:finished:context:)];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:[[CCDirector sharedDirector] view] cache:YES];
    
    [self.view removeFromSuperview];
    [MusicHandler resumeBackgound];
    [UIView commitAnimations];
}

-(void)animDone:(NSString*) animationID finished:(BOOL) finished context:(void*) context
{
    [[CCDirector sharedDirector] resume];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //创建一个导航栏
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(backToPrevious)];
    
    //设置导航栏内容
    [navigationItem setTitle:@"推荐应用"];
    
    
    //把导航栏集合添加入导航栏中，设置动画关闭
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    //把左右两个按钮添加入导航栏集合中
    [navigationItem setLeftBarButtonItem:leftButton];
    //把导航栏添加到视图中
    [self.view addSubview:navigationBar];

    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.view.backgroundColor = [UIColor whiteColor];
//    
    CGFloat navigationBarHeight = self.navigationController.navigationBar.bounds.size.height+50;

    _mTableView = [[UMUFPTableView alloc] initWithFrame:CGRectMake(0, navigationBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarHeight) style:UITableViewStylePlain appkey:@"50ee3d23527015717600000f" slotId:nil currentViewController:self];
    _mTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _mTableView.rowHeight = 70.0f;
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.backgroundColor = [UIColor clearColor];
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _mTableView.dataLoadDelegate = (id<UMUFPTableViewDataLoadDelegate>)self;
    [self.view addSubview:_mTableView];
    [_mTableView release];
    
    //如果设置了tableview的dataLoadDelegate，请在viewController销毁时将tableview的dataLoadDelegate置空，这样可以避免一些可能的delegate问题，虽然我有在tableview的dealloc方法中将其置空
    
    _mLoadingWaitView = [[UIView alloc] initWithFrame:self.view.bounds];
    _mLoadingWaitView.backgroundColor = [UIColor lightGrayColor];
    _mLoadingWaitView.autoresizesSubviews = YES;
    _mLoadingWaitView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    _mLoadingStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-300)/2, 210, 300, 21)];
    _mLoadingStatusLabel.backgroundColor = [UIColor clearColor];
    _mLoadingStatusLabel.textColor = [UIColor whiteColor];
    _mLoadingStatusLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
    _mLoadingStatusLabel.text = @"正在加载数据，请稍等...";
    _mLoadingStatusLabel.textAlignment = UITextAlignmentCenter;
    _mLoadingStatusLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [_mLoadingWaitView addSubview:_mLoadingStatusLabel];
    
    _mLoadingActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _mLoadingActivityIndicator.backgroundColor = [UIColor clearColor];
    _mLoadingActivityIndicator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _mLoadingActivityIndicator.frame = CGRectMake((self.view.bounds.size.width-30)/2, 170, 30, 30);
    [_mLoadingWaitView addSubview:_mLoadingActivityIndicator];
    
    [_mLoadingActivityIndicator startAnimating];
    
    [self.view insertSubview:_mLoadingWaitView aboveSubview:_mTableView];
    
    [_mTableView requestPromoterDataInBackground];
    [navigationBar release];
    [navigationItem release];
    [leftButton release];
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIApplication *application = [UIApplication sharedApplication];
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
        size = CGSizeMake(size.height, size.width);
    }
    
    if (application.statusBarHidden == NO)
    {
        size.height -= MIN(application.statusBarFrame.size.width, application.statusBarFrame.size.height);
    }
    
    CGRect frame = self.navigationController.navigationBar.frame;
    _mTableView.frame = CGRectMake(0, frame.size.height, size.width, size.height - frame.size.height);
    
    if ([_mLoadingWaitView superview])
    {
        _mLoadingWaitView.frame = CGRectMake(0, 0, size.width, size.height);
    }
}

#pragma mark - UITableViewDataSource Delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!_mTableView.mIsAllLoaded && [_mTableView.mPromoterDatas count] > 0)
    {
        return [_mTableView.mPromoterDatas count] + 1;
    }
    else if (_mTableView.mIsAllLoaded && [_mTableView.mPromoterDatas count] > 0)
    {
        return [_mTableView.mPromoterDatas count];
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UMUFPTableViewCell";
    
    if (indexPath.row < [_mTableView.mPromoterDatas count])
    {
        UMTableViewCell *cell = (UMTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UMTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        }
        
        NSDictionary *promoter = [_mTableView.mPromoterDatas objectAtIndex:indexPath.row];
        cell.textLabel.text = [promoter valueForKey:@"title"];
        cell.detailTextLabel.text = [promoter valueForKey:@"ad_words"];
        [cell setImageURL:[promoter valueForKey:@"icon"]];
        
        return cell;
    }
    else
    {
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"UMUFPTableViewCell2"];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UMUFPTableViewCell2"] autorelease];
            UIView *bgimageSel = [[UIView alloc] initWithFrame:cell.bounds];
            bgimageSel.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.4];
            cell.selectedBackgroundView = bgimageSel;
            [bgimageSel release];
        }
        
        for (UIView *view in cell.subviews)
        {
            [view removeFromSuperview];
        }
        
        UILabel *addMoreLabel = [[[UILabel alloc] initWithFrame:CGRectMake(120, 20, 120, 30)] autorelease];
        addMoreLabel.backgroundColor = [UIColor clearColor];
        addMoreLabel.textAlignment = UITextAlignmentCenter;
        addMoreLabel.font = [UIFont systemFontOfSize:14];
        addMoreLabel.text = @"加载中...";
        [cell addSubview:addMoreLabel];
        
        UIActivityIndicatorView *loadingIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        loadingIndicator.backgroundColor = [UIColor clearColor];
        loadingIndicator.frame = CGRectMake(115, 20, 30, 30);
        [loadingIndicator startAnimating];
        [cell addSubview:loadingIndicator];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < [_mTableView.mPromoterDatas count])
    {
        NSDictionary *promoter = [_mTableView.mPromoterDatas objectAtIndex:indexPath.row];
        [_mTableView didClickPromoterAtIndex:promoter index:indexPath.row];
    }
}

#pragma mark - UMTableViewDataLoadDelegate methods

- (void)removeLoadingMaskView {
    
    if ([_mLoadingWaitView superview])
    {
        [_mLoadingWaitView removeFromSuperview];
    }
}

- (void)loadDataFailed {
    
    _mLoadingActivityIndicator.hidden = YES;
    
    if (!_mNoNetworkImageView)
    {
        UIImage *image = [UIImage imageNamed:@"UMUFP.bundle/um_no_network.png"];
        CGSize imageSize = image.size;
        _mNoNetworkImageView = [[UIImageView alloc] initWithFrame:CGRectMake((_mLoadingWaitView.bounds.size.width - imageSize.width) / 2, 80, imageSize.width, imageSize.height)];
        _mNoNetworkImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _mNoNetworkImageView.image = image;
    }
    
    if (![_mNoNetworkImageView superview])
    {
        [_mLoadingWaitView addSubview:_mNoNetworkImageView];
    }
    
    _mLoadingStatusLabel.text = @"抱歉，网络连接不畅，请稍后再试！";
}

//该方法在成功获取广告数据后被调用
- (void)UMUFPTableViewDidLoadDataFinish:(UMUFPTableView *)tableview promoters:(NSArray *)promoters {
    
    if ([promoters count] > 0)
    {
        [self removeLoadingMaskView];
        
        [_mTableView reloadData];
    }
    else if ([_mTableView.mPromoterDatas count])
    {
        [_mTableView reloadData];
    }
    else
    {
        [self loadDataFailed];
    }
}

//该方法在获取广告数据失败后被调用
- (void)UMUFPTableView:(UMUFPTableView *)tableview didLoadDataFailWithError:(NSError *)error {
    
    if ([_mTableView.mPromoterDatas count])
    {
        [_mTableView reloadData];
    }
    else
    {
        [self loadDataFailed];
    }
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint contentOffset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize contentSize = scrollView.contentSize;
    UIEdgeInsets contentInset = scrollView.contentInset;
    
    float y = contentOffset.y + bounds.size.height - contentInset.bottom;
    if (y > contentSize.height-30)
    {
        if (!_mTableView.mIsAllLoaded && !_mTableView.mIsLoadingMore)
        {
            [_mTableView requestMorePromoterInBackground];
        }
    }
}

@end