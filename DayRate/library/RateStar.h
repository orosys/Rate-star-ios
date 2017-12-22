//
//  RateStar.h
//  TestStar
//
//  Created by orosys 2017. 12. 4..
//  Copyright © 2017년 oro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RateStar : UIView
@property (nonatomic, assign) BOOL enableHalf;
@property (nonatomic, assign) int rateCount;
@property (nonatomic, assign) int space;
@property (nonatomic, assign) float bgAlpha;
@property (nonatomic, assign) float rateStar;

- (id)initWithStarImage:(UIImageView *)image repeat:(int)count space:(int)space;

@end
