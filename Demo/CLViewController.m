//
//  CLViewController.m
//  CLParallaxViewController
//
//  Created by lixiang on 14-4-16.
//  Copyright (c) 2014年 lixiang. All rights reserved.
//

#import "CLViewController.h"
#import "CLParallaxViewController.h"
#import "RootViewController.h"
#import "TopViewController.h"
#import "CLParallaxView.h"

@interface CLViewController () <UITableViewDataSource> {
    UIImageView *_imageView;
}

@end

@implementation CLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    UIImage *image = [UIImage imageNamed:@"car.jpg"];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFill;

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    tableView.dataSource = self;
    
//    CLParallaxView *parallaxView = [[CLParallaxView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:parallaxView];
//    [parallaxView configWithParallaxContentView:imageView rootView:tableView parallaxHeight:200];

    CLParallaxViewController *parallaxController = [[CLParallaxViewController alloc] init];
    [parallaxController willMoveToParentViewController:self];
    
    [self addChildViewController:parallaxController];
    parallaxController.view.frame = self.view.bounds;
    [self.view addSubview:parallaxController.view];
    
    [parallaxController didMoveToParentViewController:self];
    
    [parallaxController configWithParallaxContentView:imageView rootView:tableView parallaxHeight:200];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"This is Row %ld", indexPath.row];
    return cell;
}

@end
