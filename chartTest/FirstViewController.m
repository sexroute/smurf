//
//  FirstViewController.m
//  chartTest
//
//  Created by zhaodali on 13-3-15.
//  Copyright (c) 2013年 zhaodali. All rights reserved.
//

#import "FirstViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize candleChart;
- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   self.candleChart = [[Chart alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-40)];
    
    [self.view addSubview:self.candleChart];
    [self initChart];
    [self InitData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setData:(NSDictionary *)dic
{
	[self.candleChart appendToData:[dic objectForKey:@"price"] forName:@"price"];
//	[self.candleChart appendToData:[dic objectForKey:@"vol"] forName:@"vol"];
//	
//	[self.candleChart appendToData:[dic objectForKey:@"ma10"] forName:@"ma10"];
//	[self.candleChart appendToData:[dic objectForKey:@"ma30"] forName:@"ma30"];
//	[self.candleChart appendToData:[dic objectForKey:@"ma60"] forName:@"ma60"];
//	
//	[self.candleChart appendToData:[dic objectForKey:@"rsi6"] forName:@"rsi6"];
//	[self.candleChart appendToData:[dic objectForKey:@"rsi12"] forName:@"rsi12"];
//	
//	[self.candleChart appendToData:[dic objectForKey:@"wr"] forName:@"wr"];
//	[self.candleChart appendToData:[dic objectForKey:@"vr"] forName:@"vr"];
//	
//	[self.candleChart appendToData:[dic objectForKey:@"kdj_k"] forName:@"kdj_k"];
//	[self.candleChart appendToData:[dic objectForKey:@"kdj_d"] forName:@"kdj_d"];
//	[self.candleChart appendToData:[dic objectForKey:@"kdj_j"] forName:@"kdj_j"];
	
	NSMutableDictionary *serie = [self.candleChart getSerie:@"price"];
	if(serie == nil)
	{
     return;   
    }
	if(self.chartMode == 1)
    {
		[serie setObject:@"candle" forKey:@"type"];
	}else{
		[serie setObject:@"line" forKey:@"type"];
	}
}

-(void)setCategory:(NSArray *)category
{
	[self.candleChart appendToCategory:category forName:@"price"];
	[self.candleChart appendToCategory:category forName:@"line"];
}

-(void)InitData
{
    int lnDataSize = 10;
    NSMutableArray *   lpArray= [NSMutableArray arrayWithCapacity:lnDataSize];
    for (int i=0; i<lnDataSize; i++)
    {
        NSMutableArray * lpDataArray = [NSMutableArray arrayWithCapacity:6];
        [lpDataArray addObject:[NSString  stringWithFormat:@"%f",i*1.0]];
        [lpDataArray addObject:[NSString  stringWithFormat:@"%f",i*1.0]];;
        [lpDataArray addObject:[NSString  stringWithFormat:@"%f",i*1.0]];
        [lpDataArray addObject:[NSString  stringWithFormat:@"%f",i*1.0]];
        [lpDataArray addObject:[NSString  stringWithFormat:@"%f",i*1.0]];
        [lpArray addObject:lpDataArray];
    }
   
    [self.candleChart appendToData:lpArray forName:@"price"];
    [self.candleChart setRange:lnDataSize];
}

-(void)initChart
{
	NSMutableArray *padding = [NSMutableArray arrayWithObjects:@"20",@"20",@"20",@"20",nil];
	[self.candleChart setPadding:padding];
	NSMutableArray *secs = [[NSMutableArray alloc] init];
    //分区，数值大小代表分区的高低
	[secs addObject:@"4"]; //占位4/7
	[secs addObject:@"2"]; //占位2/7
	[secs addObject:@"1"]; //占位1/7
	[self.candleChart addSections:3 withRatios:secs]; //初始化分区，按照给定的比例关系
	[self.candleChart getSection:2].hidden = YES; //隐藏第3个分区
	[[[self.candleChart sections] objectAtIndex:0] addYAxis:0]; //从分区的Y方向0点开始绘制Y轴
	[[[self.candleChart sections] objectAtIndex:1] addYAxis:0];
	[[[self.candleChart sections] objectAtIndex:2] addYAxis:0];
	
	[self.candleChart getYAxis:2 withIndex:0].baseValueSticky = NO; //第3个分区的属性设置，每个分区可以有多个Y轴
	[self.candleChart getYAxis:2 withIndex:0].symmetrical = NO;
	[self.candleChart getYAxis:0 withIndex:0].ext = 0.05; 
	
    NSMutableArray *series = [[NSMutableArray alloc] init];
	NSMutableArray *secOne = [[NSMutableArray alloc] init];
	NSMutableArray *secTwo = [[NSMutableArray alloc] init];
	NSMutableArray *secThree = [[NSMutableArray alloc] init];
	
	//向1分区中增加序列属性，序列数据根据[self.candleChart appendToData:lpArray forName:@"price"]可以随时修改
	NSMutableDictionary *serie = [[NSMutableDictionary alloc] init];
	NSMutableArray *data = [[NSMutableArray alloc] init];
	[serie setObject:@"price" forKey:@"name"];
	[serie setObject:@"Price" forKey:@"label"];
	[serie setObject:data forKey:@"data"];
	[serie setObject:@"candle" forKey:@"type"];
	[serie setObject:@"0" forKey:@"yAxis"];
	[serie setObject:@"0" forKey:@"section"];
	[serie setObject:@"0,0,255" forKey:@"color"];
	[serie setObject:@"255,0,0" forKey:@"negativeColor"];
	[serie setObject:@"255,0,0" forKey:@"selectedColor"];
	[serie setObject:@"255,0,0" forKey:@"negativeSelectedColor"];
	[serie setObject:@"255,255,0" forKey:KEY_LABEL_COLOR];
	[serie setObject:@"255,0,0" forKey:@"labelNegativeColor"];
    [serie setObject:@"um" forKey:KEY_UNIT];
	[series addObject:serie];
	[secOne addObject:serie];
	[data release];
	[serie release];
	
//	//MA10
//	serie = [[NSMutableDictionary alloc] init];
//	data = [[NSMutableArray alloc] init];
//	[serie setObject:@"ma10" forKey:@"name"];
//	[serie setObject:@"MA10" forKey:@"label"];
//	[serie setObject:data forKey:@"data"];
//	[serie setObject:@"line" forKey:@"type"];
//	[serie setObject:@"0" forKey:@"yAxis"];
//	[serie setObject:@"0" forKey:@"section"];
//	[serie setObject:@"255,255,255" forKey:@"color"];
//	[serie setObject:@"255,255,255" forKey:@"negativeColor"];
//	[serie setObject:@"255,255,255" forKey:@"selectedColor"];
//	[serie setObject:@"255,255,255" forKey:@"negativeSelectedColor"];
//	[series addObject:serie];
//	[secOne addObject:serie];
//	[data release];
//	[serie release];
//    
//	//MA30
//	serie = [[NSMutableDictionary alloc] init];
//	data = [[NSMutableArray alloc] init];
//	[serie setObject:@"ma30" forKey:@"name"];
//	[serie setObject:@"MA30" forKey:@"label"];
//	[serie setObject:data forKey:@"data"];
//	[serie setObject:@"line" forKey:@"type"];
//	[serie setObject:@"0" forKey:@"yAxis"];
//	[serie setObject:@"0" forKey:@"section"];
//	[serie setObject:@"250,232,115" forKey:@"color"];
//	[serie setObject:@"250,232,115" forKey:@"negativeColor"];
//	[serie setObject:@"250,232,115" forKey:@"selectedColor"];
//	[serie setObject:@"250,232,115" forKey:@"negativeSelectedColor"];
//	[series addObject:serie];
//	[secOne addObject:serie];
//	[data release];
//	[serie release];
//	
//	//MA60
//	serie = [[NSMutableDictionary alloc] init];
//	data = [[NSMutableArray alloc] init];
//	[serie setObject:@"ma60" forKey:@"name"];
//	[serie setObject:@"MA60" forKey:@"label"];
//	[serie setObject:data forKey:@"data"];
//	[serie setObject:@"line" forKey:@"type"];
//	[serie setObject:@"0" forKey:@"yAxis"];
//	[serie setObject:@"0" forKey:@"section"];
//	[serie setObject:@"232,115,250" forKey:@"color"];
//	[serie setObject:@"232,115,250" forKey:@"negativeColor"];
//	[serie setObject:@"232,115,250" forKey:@"selectedColor"];
//	[serie setObject:@"232,115,250" forKey:@"negativeSelectedColor"];
//	[series addObject:serie];
//	[secOne addObject:serie];
//	[data release];
//	[serie release];
//	
//	
//	//VOL
//	serie = [[NSMutableDictionary alloc] init];
//	data = [[NSMutableArray alloc] init];
//	[serie setObject:@"vol" forKey:@"name"];
//	[serie setObject:@"VOL" forKey:@"label"];
//	[serie setObject:data forKey:@"data"];
//	[serie setObject:@"column" forKey:@"type"];
//	[serie setObject:@"0" forKey:@"yAxis"];
//	[serie setObject:@"1" forKey:@"section"];
//	[serie setObject:@"0" forKey:@"decimal"];
//	[serie setObject:@"176,52,52" forKey:@"color"];
//	[serie setObject:@"77,143,42" forKey:@"negativeColor"];
//	[serie setObject:@"176,52,52" forKey:@"selectedColor"];
//	[serie setObject:@"77,143,42" forKey:@"negativeSelectedColor"];
//	[series addObject:serie];
//	[secTwo addObject:serie];
//	[data release];
//	[serie release];
	
	//candleChart init
    [self.candleChart setSeries:series];
	[series release];
	
	[[[self.candleChart sections] objectAtIndex:0] setSeries:secOne];
	[secOne release];
	[[[self.candleChart sections] objectAtIndex:1] setSeries:secTwo];
	[secTwo release];
	[[[self.candleChart sections] objectAtIndex:2] setSeries:secThree];
	[[[self.candleChart sections] objectAtIndex:2] setPaging:YES];
	[secThree release];
	
	
	NSString *indicatorsString =[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"indicators" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
	if(indicatorsString != nil){
		NSArray *indicators = [indicatorsString JSONValue];
		for(NSObject *indicator in indicators){
			if([indicator isKindOfClass:[NSArray class]]){
				NSMutableArray *arr = [[NSMutableArray alloc] init];
				for(NSDictionary *indic in indicator){
					NSMutableDictionary *serie = [[NSMutableDictionary alloc] init];
					[self setOptions:indic ForSerie:serie];
					[arr addObject:serie];
					[serie release];
				}
			    [self.candleChart addSerie:arr];
				[arr release];
			}else{
				NSDictionary *indic = (NSDictionary *)indicator;
				NSMutableDictionary *serie = [[NSMutableDictionary alloc] init];
				[self setOptions:indic ForSerie:serie];
				[self.candleChart addSerie:serie];
				[serie release];
			}
		}
	}
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 10.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [self.candleChart addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
}


-(void)viewDidUnload
{
    self.candleChart = nil;
    [super viewDidUnload];
}

-(void)dealloc
{
    
    [super dealloc];
}

@end
