//
//  CLParallaxViewController.m
//  CLParallaxViewController
//
//  Created by lixiang on 14-4-16.
//  Copyright (c) 2014年 lixiang. All rights reserved.
//

#import "CLParallaxViewController.h"

@implementation CLParallaxViewController

- (void)dealloc {
    [_rootView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)configWithParallaxContentView:(UIView *)parallaxContentView
                             rootView:(UIScrollView *)rootView
                       parallaxHeight:(CGFloat)parallaxHeight {
    
    _parallaxContentView       = parallaxContentView;
    _rootView                  = rootView;
    _parallaxHeight            = parallaxHeight;
    
    parallaxContentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), _parallaxHeight);
    rootView.frame = self.view.bounds;
    rootView.contentInset = UIEdgeInsetsMake(_parallaxHeight, 0, 0, 0);
    rootView.backgroundColor = [UIColor clearColor];
    rootView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:parallaxContentView];
    [self.view addSubview:rootView];
    [rootView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
}

#pragma mark ========== UIScrollViewDelegate ==========
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        UIView *parallaxContentView = self.parallaxContentView;
        CGRect originParallaxFrame = parallaxContentView.frame;
        
        float y = _rootView.contentOffset.y + _parallaxHeight;
        if (y > 0) {
            CGFloat newHeight = _parallaxHeight - y;
            [parallaxContentView setHidden:(newHeight <= 0)];
            
            if (!parallaxContentView.hidden) {
                parallaxContentView.frame = CGRectMake(originParallaxFrame.origin.x,
                                                       originParallaxFrame.origin.y,
                                                       CGRectGetWidth(originParallaxFrame),
                                                       newHeight);
            }
        } else {
            CGFloat newHeight = _parallaxHeight - y;
            parallaxContentView.hidden = NO;
            parallaxContentView.frame = CGRectMake(originParallaxFrame.origin.x,
                                                   originParallaxFrame.origin.y,
                                                   CGRectGetWidth(originParallaxFrame),
                                                   newHeight);
        }
    }
}

@end
