//
//  ViewController.m
//  DayRate
//
//  Created by orosys on 2017. 12. 5..
//  Copyright © 2017년 oro. All rights reserved.
//

#import "ViewController.h"
#import "RateStar.h"

@interface ViewController ()<UIGestureRecognizerDelegate> {
    RateStar *rateStar;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *image=[UIImage imageNamed:@"mask6.png"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, 60, 60);
    
    rateStar = [[RateStar alloc] initWithStarImage:imageView repeat:5 space:10];
    rateStar.frame = CGRectMake(40, 200, rateStar.frame.size.width, rateStar.frame.size.height);
    [rateStar setEnableHalf:YES];
    [rateStar setRateStar:5];
    [self.view addSubview:rateStar];
}

@end
