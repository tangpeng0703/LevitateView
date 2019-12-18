//
//  ViewController.m
//  NewProject
//
//  Created by 汤鹏 on 2019/12/18.
//  Copyright © 2019 Stickers. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, ([UIScreen mainScreen].bounds.size.height-50)*0.5, [UIScreen mainScreen].bounds.size.width-40, 50);
    btn.layer.cornerRadius = 25;
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [btn setTitle:@"Next" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)click {
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
