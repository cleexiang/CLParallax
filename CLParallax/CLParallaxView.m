//
//  CLParallaxView.m
//  CLParallaxViewController
//
//  Created by lixiang on 14-4-17.
//  Copyright (c) 2014年 lixiang. All rights reserved.
//

#import "CLParallaxView.h"

@implementation CLParallaxView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)configWithParallaxContentView:(UIView *)parallaxContentView
                             rootView:(UIScrollView *)rootView
                       parallaxHeight:(CGFloat)parallaxHeight {
    
    _parallaxContentView       = parallaxContentView;
    _rootView                  = rootView;
    _parallaxHeight            = parallaxHeight;
    
    parallaxContentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), _parallaxHeight);
    NSLog(@"f:%@", NSStringFromCGRect(parallaxContentView.frame));
    rootView.frame = self.bounds;
    rootView.contentInset = UIEdgeInsetsMake(_parallaxHeight, 0, 0, 0);
    rootView.backgroundColor = [UIColor clearColor];
    rootView.delegate = self;
    rootView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:parallaxContentView];
    [self addSubview:rootView];
}

#pragma mark ========== UIScrollViewDelegate ==========
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIView *parallaxContentView = self.parallaxContentView;
    
    CGFloat y = abs(scrollView.contentOffset.y)-_parallaxHeight;
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
