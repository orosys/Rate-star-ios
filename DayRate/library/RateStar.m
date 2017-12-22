//
//  RateStar.m
//  TestStar
//
//  Created by orosys on 2017. 12. 4..
//  Copyright © 2017년 oro. All rights reserved.
//

#import "RateStar.h"
@interface RateStar () {
    CALayer *_maskView;
    CGRect _imageFrame;
    UIView *_container;
    UIImageView *_bg;
}
@end

@implementation RateStar
- (id)initWithStarImage:(UIImageView *)image repeat:(int)count space:(int)space {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.rateCount = count;
    self.space = space;
    self.bgAlpha = 0.3;
    self.enableHalf = YES;
    
    _imageFrame = image.frame;
    _container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (image.frame.size.width * count) + (space * (count - 1)), image.frame.size.height)];
    for (int i = 0; i<count; i++) {
        UIImageView *iv = [[UIImageView alloc] initWithImage:image.image];
        iv.frame = CGRectMake((image.frame.size.width * i) + (space * i), 0, image.frame.size.width, image.frame.size.height);
        [_container addSubview:iv];
    }
    self.frame = _container.frame;
    
    UIImage *capture = [self captureView:_container];
    _bg = [[UIImageView alloc] initWithImage:capture];
    _bg.frame = _container.frame;
    _bg.alpha = _bgAlpha;
    [self addSubview:_bg];
    [self addSubview:_container];
    
    _maskView = [CALayer layer];
    _maskView.contents = (id)[image.image CGImage];
    _maskView.frame = _container.frame;
    _maskView.speed = 100;
    _container.layer.mask = _maskView;
    
    UIPanGestureRecognizer *panGestureRecognizer =
    [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:panGestureRecognizer];
    
    UITapGestureRecognizer *tapGestureRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tapGestureRecognizer];
    
    return self;
}

- (void)setBgAlpha:(float)bgAlpha {
    _bgAlpha = bgAlpha;
    _bg.alpha = bgAlpha;
}

- (UIImage*)captureView:(UIView *)view {
    CGRect rect = view.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)setMaskPosition:(CGPoint)point {
    if (point.x < _container.frame.origin.x) {
        point.x = _container.frame.origin.x;
    }
    _maskView.frame = CGRectMake(0, 0, point.x - _container.frame.origin.x, _container.frame.size.height);
}

- (void)setRateStar:(float)rateStar {
    float progress = rateStar / _rateCount;
    [self setMaskPosition:CGPointMake(_container.frame.size.width * progress, 0)];
    [self endMaskPosition];
}

- (float)getRateStar {
    float progress = _maskView.frame.size.width / _container.frame.size.width;
    return _rateCount * progress;
}

- (void)endMaskPosition {
    float position = 0;
    int count = self.rateCount;
    if (_enableHalf) {
        count = count * 2;
    }
    for (int i = 0; i <= count; i++) {
        int x = (_imageFrame.size.width * ((float) (_enableHalf ? i / 2.0 : i))) + (_space * (_enableHalf ? (i / 2) : i));
        int offset = 0;
        if (_enableHalf) {
            if (i % 2 == 0) {
                offset = (int) _space;
            }
        } else {
            offset = _space;
        }
        
        if (_maskView.frame.size.width > x - (_imageFrame.size.width / (_enableHalf ? 4 : 2)) - offset) {
            position = x;
        }
    }

    _maskView.frame = CGRectMake(_maskView.frame.origin.x, _maskView.frame.origin.y, position, _maskView.frame.size.height);
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer locationInView:_container];
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self endMaskPosition];
    } else {
        [self setMaskPosition:translation];
    }
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer locationInView:_container];
    [self setMaskPosition:translation];
    [self endMaskPosition];
}

@end
