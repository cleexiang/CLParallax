//
//  CLParallaxViewController.m
//  CLParallaxViewController
//
//  Created by lixiang on 14-4-16.
//  Copyright (c) 2014年 lixiang. All rights reserved.
//

#import "CLParallaxViewController.h"

@interface CLParallaxViewController () <UITableViewDelegate, UIScrollViewDelegate>

@end

@implementation CLParallaxViewController 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)initWithParallaxController:(UIViewController *)top
                  rootController:(UITableViewController *)root
                  parallaxHeight:(CGFloat)parallaxHeight {
    self = [super init];
    if (self) {
        _parallaxContentController = top;
        _rootController = root;
        _parallaxHeight = parallaxHeight;
        
        [top willMoveToParentViewController:self];
        [root willMoveToParentViewController:self];
        
        [self addChildViewController:top];
        [self addChildViewController:root];
        
        top.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), _parallaxHeight);
        root.view.frame = self.view.bounds;
        root.tableView.contentInset = UIEdgeInsetsMake(_parallaxHeight, 0, 0, 0);
        root.tableView.showsVerticalScrollIndicator = NO;
        root.tableView.delegate = self;
        root.view.backgroundColor = [UIColor clearColor];
        [root.tableView setBackgroundColor:[UIColor clearColor]];
        [root.tableView setBackgroundView:nil];
        [self.view addSubview:top.view];
        [self.view addSubview:root.view];
        
        [top didMoveToParentViewController:self];
        [root didMoveToParentViewController:self];
    }

    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ========== UIScrollViewDelegate ==========
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UITableView *tableView = self.rootController.tableView;
    UIView *parallaxContentView = self.parallaxContentController.view;
    
    CGFloat y = abs(tableView.contentOffset.y)-_parallaxHeight;
    CGRect newFrame;
    if (y > 0) {
        newFrame = CGRectMake(CGRectGetMinX(parallaxContentView.frame),
                              CGRectGetMinY(parallaxContentView.frame),
                              CGRectGetWidth(parallaxContentView.frame),
                              _parallaxHeight+y);
    } else {
        newFrame = CGRectMake(CGRectGetMinX(parallaxContentView.frame),
                              (int)(y*0.5),
                              CGRectGetWidth(parallaxContentView.frame),
                              CGRectGetHeight(parallaxContentView.frame));
    }
    parallaxContentView.frame = newFrame;
}

@end
