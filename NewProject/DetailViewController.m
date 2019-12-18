//
//  DetailViewController.m
//  NewProject
//
//  Created by 汤鹏 on 2019/12/18.
//  Copyright © 2019 Stickers. All rights reserved.
//

#import "DetailViewController.h"

#define ScreenWidth         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight        [[UIScreen mainScreen] bounds].size.height
#define ScreenBounds        [UIScreen mainScreen].bounds
#define BarHeight           [[UIApplication sharedApplication] statusBarFrame].size.height
#define NavHeight           (44.0+BarHeight)
#define TopViewHeight       300.0

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *topView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    

    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, TopViewHeight)];
    self.topView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.topView];
    
    //悬浮的view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, TopViewHeight-NavHeight, ScreenWidth, NavHeight)];
    view.backgroundColor = [UIColor orangeColor];
    [self.topView addSubview:view];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        //拉高tableView的内边距
        _tableView.contentInset = UIEdgeInsetsMake(TopViewHeight, 0, 0, 0);
        //监听tableView的contentOffset的改变
        [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];

    return cell;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        if (-offset.y >= TopViewHeight) {
            self.topView.frame = CGRectMake(0, 0, ScreenWidth, TopViewHeight);
        }
        else if (-offset.y > NavHeight && -offset.y < TopViewHeight) {
            self.topView.frame = CGRectMake(0, -offset.y-TopViewHeight, ScreenWidth, TopViewHeight);
        }
        else if (-offset.y <= NavHeight) {
            self.topView.frame = CGRectMake(0, NavHeight-TopViewHeight, ScreenWidth, TopViewHeight);
        }
    }
}

- (void)dealloc {
    [_tableView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
