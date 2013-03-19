//
//  FirstViewController.h
//  chartTest
//
//  Created by zhaodali on 13-3-15.
//  Copyright (c) 2013年 zhaodali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chart.h"
@interface FirstViewController : UIViewController
@property (strong,nonatomic) Chart * candleChart;
@property (nonatomic) int chartMode;
@end
