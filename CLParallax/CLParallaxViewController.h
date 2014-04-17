//
//  CLParallaxViewController.h
//  CLParallaxViewController
//
//  Created by lixiang on 14-4-16.
//  Copyright (c) 2014年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLParallaxViewController : UIViewController 

@property (nonatomic, strong) UIViewController      *parallaxContentController;
@property (nonatomic, strong) UITableViewController *rootController;
@property (nonatomic, assign) CGFloat               parallaxHeight;

- (void)configWithParallaxContentController:(UIViewController *)parallaxContentController
                             rootController:(UITableViewController *)rootController
                             parallaxHeight:(CGFloat)parallaxHeight;

@end
