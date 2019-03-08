//
//  RefreshView.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/8.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "RefreshView.h"

@interface RefreshView()

@property (strong,nonatomic) UIActivityIndicatorView *indicatorView;
@property (strong,nonatomic) CAShapeLayer *whiteCircleLayer;
@property (strong,nonatomic) CAShapeLayer *grayCircleLayer;

@end

@implementation RefreshView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_indicatorView stopAnimating];
        [self addSubview:_indicatorView];
        
        CGFloat radius = 9.0f;
        
        _grayCircleLayer = [[CAShapeLayer alloc] init];
        _grayCircleLayer.lineWidth = 0.5f;
        _grayCircleLayer.strokeColor = [UIColor grayColor].CGColor;
        _grayCircleLayer.fillColor = [UIColor clearColor].CGColor;
        _grayCircleLayer.opacity = 0.f;
        _grayCircleLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(frame.size.width/2-radius, frame.size.height/2-radius, 2*radius, 2*radius)].CGPath;
        [self.layer addSublayer:_grayCircleLayer];
        
        _whiteCircleLayer = [[CAShapeLayer alloc] init];
        _whiteCircleLayer.lineWidth = 1.f;
        _whiteCircleLayer.strokeColor = [UIColor whiteColor].CGColor;
        _whiteCircleLayer.fillColor = [UIColor clearColor].CGColor;
        _whiteCircleLayer.opacity = 0.f;
        _whiteCircleLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2, frame.size.height/2) radius:radius startAngle:M_PI_2 endAngle:M_PI*5/2 clockwise:YES].CGPath;
        [self.layer addSublayer:_whiteCircleLayer];
    }
    return self;
}

-(void)startAnimation{
    _grayCircleLayer.opacity = 0.0f;
    _whiteCircleLayer.opacity = 0.0f;
    _refresh = YES;
    [_indicatorView startAnimating];
}

- (void)stopAnimation {
    _refresh = NO;
    [_indicatorView stopAnimating];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(20.f, 20.f);
}

- (void)redrawFromProgress:(CGFloat)progress {
    if (_refresh) return;
    
    if (progress > 0.05) {
        _whiteCircleLayer.opacity = 1.f;
        _grayCircleLayer.opacity = 1.f;
    }else {
        _whiteCircleLayer.opacity = 0.f;
        _grayCircleLayer.opacity = 0.f;
    }
    _whiteCircleLayer.strokeEnd = progress;
    
}

@end
