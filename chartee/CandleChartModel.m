//
//  CandleChartModel.m
//  chartee
//
//  Created by zzy on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CandleChartModel.h"


@implementation CandleChartModel
//绘制曲线
-(void)drawSerie:(Chart *)chart serie:(NSMutableDictionary *)serie
{
    // return [self drawSerie_0:chart serie:serie];
    [serie setObject:@"176,52,52" forKey:@"color"];
    [serie setObject:@"77,143,42" forKey:@"negativeColor"];
    [serie setObject:@"176,52,52" forKey:@"selectedColor"];
    [serie setObject:@"77,143,42" forKey:@"negativeSelectedColor"];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, NO);
    
    
    NSMutableArray *data          = [serie objectForKey:@"data"];
    int            yAxis          = [[serie objectForKey:@"yAxis"] intValue];
    int            section        = [[serie objectForKey:@"section"] intValue];
    NSString       *color         = [serie objectForKey:@"color"];
    
    float R   = [[[color componentsSeparatedByString:@","] objectAtIndex:0] floatValue]/255;
    float G   = [[[color componentsSeparatedByString:@","] objectAtIndex:1] floatValue]/255;
    float B   = [[[color componentsSeparatedByString:@","] objectAtIndex:2] floatValue]/255;
    
    Section *sec = [chart.sections objectAtIndex:section];
    for(int i=chart.rangeFrom;i<chart.rangeTo;i++)
    {
        if(i == data.count){
            break;
        }
        if([data objectAtIndex:i] == nil){
            continue;
        }
        
        float val  = [[[data objectAtIndex:i] objectAtIndex:0] floatValue];
        float ix  = sec.frame.origin.x+sec.paddingLeft+(i-chart.rangeFrom)*chart.plotWidth;
        float iNx = sec.frame.origin.x+sec.paddingLeft+(i+1-chart.rangeFrom)*chart.plotWidth;
        float iyo = [chart getLocalY:val withSection:section withAxis:yAxis];
        
        
        
        
        
        if(i == chart.selectedIndex && chart.selectedIndex < data.count && [data objectAtIndex:chart.selectedIndex]!=nil)
        {
            //线粗细
            CGContextSetLineWidth(context, 0.1f);
            CGContextSetStrokeColorWithColor(context, [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:1.0].CGColor);
            
            //纵向游标
            CGContextMoveToPoint(context, ix, sec.frame.origin.y+sec.paddingTop);
            CGContextAddLineToPoint(context,ix,sec.frame.size.height+sec.frame.origin.y);
            CGContextStrokePath(context);
            
            //横向游标
            ix  = sec.frame.origin.x+sec.paddingLeft+(chart.rangeFrom)*chart.plotWidth;
            iNx = sec.frame.origin.x+sec.paddingLeft+(chart.rangeTo)*chart.plotWidth;
            CGContextMoveToPoint(context, ix+chart.plotPadding, iyo);
            CGContextAddLineToPoint(context, iNx-chart.plotPadding,iyo);
            CGContextStrokePath(context);
        }
        
        ix  = sec.frame.origin.x+sec.paddingLeft+(i-chart.rangeFrom)*chart.plotWidth;
        iNx = sec.frame.origin.x+sec.paddingLeft+(i+1-chart.rangeFrom)*chart.plotWidth;
        
        if (i<data.count-1)
        {
            CGContextSetLineWidth(context, 1.0f);
            CGContextSetStrokeColorWithColor(context, [[UIColor alloc] initWithRed:R green:G blue:B alpha:1.0].CGColor);
            float valNext  = [[[data objectAtIndex:(i+1)] objectAtIndex:0] floatValue];
            float iNy = [chart getLocalY:valNext withSection:section withAxis:yAxis];
            //1.描点
            CGContextMoveToPoint(context, ix+chart.plotPadding, iyo);
            CGContextAddLineToPoint(context, ix+chart.plotPadding+1,iyo);
            CGContextStrokePath(context);
            
            //2.连线
            CGContextMoveToPoint(context, ix+chart.plotPadding, iyo);
            CGContextAddLineToPoint(context, iNx+chart.plotPadding,iNy);
            CGContextStrokePath(context);
        }else
        {
            //1.描点
            CGContextSetLineWidth(context, 1.0f);
            CGContextSetStrokeColorWithColor(context, [[UIColor alloc] initWithRed:R green:G blue:B alpha:1.0].CGColor);
            CGContextMoveToPoint(context, ix+chart.plotPadding, iyo);
            CGContextAddLineToPoint(context, ix+chart.plotPadding+1,iyo);
            CGContextStrokePath(context);
        }
        
        
    }
    
}
//绘制曲线
-(void)drawSerie_0:(Chart *)chart serie:(NSMutableDictionary *)serie
{
    
    [serie setObject:@"176,52,52" forKey:@"color"];
    [serie setObject:@"77,143,42" forKey:@"negativeColor"];
    [serie setObject:@"176,52,52" forKey:@"selectedColor"];
    [serie setObject:@"77,143,42" forKey:@"negativeSelectedColor"];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, NO);
    CGContextSetLineWidth(context, 1.0f);
    
    NSMutableArray *data          = [serie objectForKey:@"data"];
    int            yAxis          = [[serie objectForKey:@"yAxis"] intValue];
    int            section        = [[serie objectForKey:@"section"] intValue];
    NSString       *color         = [serie objectForKey:@"color"];
    NSString       *negativeColor = [serie objectForKey:@"negativeColor"];
    NSString       *selectedColor = [serie objectForKey:@"selectedColor"];
    NSString       *negativeSelectedColor = [serie objectForKey:@"negativeSelectedColor"];
    
    float R   = [[[color componentsSeparatedByString:@","] objectAtIndex:0] floatValue]/255;
    float G   = [[[color componentsSeparatedByString:@","] objectAtIndex:1] floatValue]/255;
    float B   = [[[color componentsSeparatedByString:@","] objectAtIndex:2] floatValue]/255;
    float NR  = [[[negativeColor componentsSeparatedByString:@","] objectAtIndex:0] floatValue]/255;
    float NG  = [[[negativeColor componentsSeparatedByString:@","] objectAtIndex:1] floatValue]/255;
    float NB  = [[[negativeColor componentsSeparatedByString:@","] objectAtIndex:2] floatValue]/255;
    float SR  = [[[selectedColor componentsSeparatedByString:@","] objectAtIndex:0] floatValue]/255;
    float SG  = [[[selectedColor componentsSeparatedByString:@","] objectAtIndex:1] floatValue]/255;
    float SB  = [[[selectedColor componentsSeparatedByString:@","] objectAtIndex:2] floatValue]/255;
    float NSR = [[[negativeSelectedColor componentsSeparatedByString:@","] objectAtIndex:0] floatValue]/255;
    float NSG = [[[negativeSelectedColor componentsSeparatedByString:@","] objectAtIndex:1] floatValue]/255;
    float NSB = [[[negativeSelectedColor componentsSeparatedByString:@","] objectAtIndex:2] floatValue]/255;
    
    Section *sec = [chart.sections objectAtIndex:section];
    for(int i=chart.rangeFrom;i<chart.rangeTo;i++){
        if(i == data.count){
            break;
        }
        if([data objectAtIndex:i] == nil){
            continue;
        }
        
        float high  = [[[data objectAtIndex:i] objectAtIndex:2] floatValue];
        float low   = [[[data objectAtIndex:i] objectAtIndex:3] floatValue];
        float open  = [[[data objectAtIndex:i] objectAtIndex:0] floatValue];
        float close = [[[data objectAtIndex:i] objectAtIndex:1] floatValue];
        
        float ix  = sec.frame.origin.x+sec.paddingLeft+(i-chart.rangeFrom)*chart.plotWidth;
        float iNx = sec.frame.origin.x+sec.paddingLeft+(i+1-chart.rangeFrom)*chart.plotWidth;
        float iyo = [chart getLocalY:open withSection:section withAxis:yAxis];
        float iyc = [chart getLocalY:close withSection:section withAxis:yAxis];
        float iyh = [chart getLocalY:high withSection:section withAxis:yAxis];
        float iyl = [chart getLocalY:low withSection:section withAxis:yAxis];
        
        if(i == chart.selectedIndex && chart.selectedIndex < data.count && [data objectAtIndex:chart.selectedIndex]!=nil){
            CGContextSetStrokeColorWithColor(context, [[UIColor alloc] initWithRed:0.2 green:0.2 blue:0.2 alpha:1.0].CGColor);
            CGContextMoveToPoint(context, ix+chart.plotWidth/2, sec.frame.origin.y+sec.paddingTop);
            CGContextAddLineToPoint(context,ix+chart.plotWidth/2,sec.frame.size.height+sec.frame.origin.y);
            CGContextStrokePath(context);
        }
        
        if(close == open){
            if(i == chart.selectedIndex){
                CGContextSetStrokeColorWithColor(context, [[UIColor alloc] initWithRed:SR green:SG blue:SB alpha:1.0].CGColor);
            }else{
                CGContextSetStrokeColorWithColor(context, [[UIColor alloc] initWithRed:R green:G blue:B alpha:1.0].CGColor);
            }
        }else{
            if(close < open){
                if(i == chart.selectedIndex){
                    CGContextSetStrokeColorWithColor(context, [[UIColor alloc] initWithRed:NSR green:NSG blue:NSB alpha:1.0].CGColor);
                    CGContextSetRGBFillColor(context, NSR, NSG, NSB, 1.0);
                }else{
                    CGContextSetStrokeColorWithColor(context, [[UIColor alloc] initWithRed:NR green:NG blue:NB alpha:1.0].CGColor);
                    CGContextSetRGBFillColor(context, NR, NG, NB, 1.0);
                }
            }else{
                if(i == chart.selectedIndex){
                    CGContextSetStrokeColorWithColor(context, [[UIColor alloc] initWithRed:SR green:SG blue:SB alpha:1.0].CGColor);
                    CGContextSetRGBFillColor(context, SR, SG, SB, 1.0);
                }else{
                    CGContextSetStrokeColorWithColor(context, [[UIColor alloc] initWithRed:R green:G blue:B alpha:1.0].CGColor);
                    CGContextSetRGBFillColor(context, R, G, B, 1.0);
                }
            }
        }
        
        if(close == open){
            CGContextMoveToPoint(context, ix+chart.plotPadding, iyo);
            CGContextAddLineToPoint(context, iNx-chart.plotPadding,iyo);
            CGContextStrokePath(context);
            
        }else{
            if(close < open){
                CGContextFillRect (context, CGRectMake (ix+chart.plotPadding, iyo, chart.plotWidth-2*chart.plotPadding,iyc-iyo));
            }else{
                CGContextFillRect (context, CGRectMake (ix+chart.plotPadding, iyc, chart.plotWidth-2*chart.plotPadding, iyo-iyc));
            }
        }
        
        CGContextMoveToPoint(context, ix+chart.plotWidth/2, iyh);
        CGContextAddLineToPoint(context,ix+chart.plotWidth/2,iyl);
        CGContextStrokePath(context);
    }
}

-(void)setValuesForYAxis:(Chart *)chart serie:(NSDictionary *)serie{
    if([[serie objectForKey:@"data"] count] == 0){
		return;
	}
	
	NSMutableArray *data    = [serie objectForKey:@"data"];
	NSString       *yAxis   = [serie objectForKey:@"yAxis"];
	NSString       *section = [serie objectForKey:@"section"];
	
	YAxis *yaxis = [[[chart.sections objectAtIndex:[section intValue]] yAxises] objectAtIndex:[yAxis intValue]];
	
    float high = [[[data objectAtIndex:chart.rangeFrom] objectAtIndex:2] floatValue];
    float low = [[[data objectAtIndex:chart.rangeFrom] objectAtIndex:3] floatValue];
    
    if(!yaxis.isUsed){
        [yaxis setMax:high];
        [yaxis setMin:low];
        yaxis.isUsed = YES;
    }
    
    for(int i=chart.rangeFrom;i<chart.rangeTo;i++){
        if(i == data.count){
            break;
        }
        if([data objectAtIndex:i] == nil){
            continue;
        }
        
        float high = [[[data objectAtIndex:i] objectAtIndex:2] floatValue];
        float low = [[[data objectAtIndex:i] objectAtIndex:3] floatValue];
        if(high > [yaxis max])
            [yaxis setMax:high];
        if(low < [yaxis min])
            [yaxis setMin:low];
    }
}

-(void)setLabel:(Chart *)chart label:(NSMutableArray *)label forSerie:(NSMutableDictionary *) serie{
    if([serie objectForKey:@"data"] == nil || [[serie objectForKey:@"data"] count] == 0){
	    return;
	}
	
	NSMutableArray *data          = [serie objectForKey:KEY_DATA];
	NSString       *color         = [serie objectForKey:KEY_COLOR];
	NSString       *detailInfoColor = [serie objectForKey:KEY_LABEL_DETAIL_INFO_COLOR];
    NSString       *labelColor         = [serie objectForKey:KEY_LABEL_COLOR];
    NSString       *lpStrUnit         = [serie objectForKey:KEY_UNIT];
    NSString       *lpLabelFontName  = [serie objectForKey:KEY_LABEL_FONT_NAME];
    if (nil == lpLabelFontName)
    {
        lpLabelFontName = DEFAULT_FONT_NAME;
    }
    int lnLabelFontSize = [[serie objectForKey:KEY_LABEL_DETAIL_FONT_SIZE]intValue];
    if (0 == lnLabelFontSize)
    {
        lnLabelFontSize = DEFAULT_FONT_SIZE;
    }
	
	float R   = [[[color componentsSeparatedByString:@","] objectAtIndex:0] floatValue]/255;
	float G   = [[[color componentsSeparatedByString:@","] objectAtIndex:1] floatValue]/255;
	float B   = [[[color componentsSeparatedByString:@","] objectAtIndex:2] floatValue]/255;
	
    float dR  = [[[detailInfoColor componentsSeparatedByString:@","] objectAtIndex:0] floatValue]/255;
	float dG  = [[[detailInfoColor componentsSeparatedByString:@","] objectAtIndex:1] floatValue]/255;
	float dB  = [[[detailInfoColor componentsSeparatedByString:@","] objectAtIndex:2] floatValue]/255;
    
    float ZR  = [[[labelColor componentsSeparatedByString:@","] objectAtIndex:0] floatValue]/255;
	float ZG  = [[[labelColor componentsSeparatedByString:@","] objectAtIndex:1] floatValue]/255;
	float ZB  = [[[labelColor componentsSeparatedByString:@","] objectAtIndex:2] floatValue]/255;
	
    if(chart.selectedIndex!=-1 && chart.selectedIndex < data.count && [data objectAtIndex:chart.selectedIndex]!=nil)
    {
        NSAutoreleasePool * lpPool = [[NSAutoreleasePool alloc]init];
        float lfVal = [[[data objectAtIndex:chart.selectedIndex] objectAtIndex:0]floatValue];
        NSString * lpStrInfo   = [[data objectAtIndex:chart.selectedIndex] objectAtIndex:1] ;
        NSMutableDictionary *tmp = [[[NSMutableDictionary alloc] init]autorelease];
        NSMutableString *l = [[[NSMutableString alloc] init]autorelease];
        
        //1.add val
        //val
        [l appendFormat:@"%.2f",lfVal];
        [tmp setObject:l forKey:KEY_TEXT];
        
        //font
        [tmp setObject:@"32" forKey:KEY_FONT_SIZE];
        [tmp setObject:lpLabelFontName forKey:KEY_FONT_NAME];
        
        //color
        NSMutableString *clr = [[[NSMutableString alloc] init]autorelease];
        [clr appendFormat:@"%f,",ZR];
        [clr appendFormat:@"%f,",ZG];
        [clr appendFormat:@"%f",ZB];
        [tmp setObject:clr forKey:KEY_COLOR];
        
        //position
        [tmp setObject:@"-11" forKey:KEY_PADDING_TOP];
        [label addObject:tmp];
        
        //2.add unit
        l = [[[NSMutableString alloc] init]autorelease];
        tmp = [[[NSMutableDictionary alloc] init]autorelease];
        [l appendFormat:@"%@",lpStrUnit];
        [tmp setObject:l forKey:KEY_TEXT];
        
        //font
        [tmp setObject:@"12" forKey:KEY_FONT_SIZE];
        [tmp setObject:lpLabelFontName forKey:KEY_FONT_NAME];
        
        //color
        clr = [[[NSMutableString alloc] init]autorelease];
        [clr appendFormat:@"%f,",ZR];
        [clr appendFormat:@"%f,",ZG];
        [clr appendFormat:@"%f",ZB];
        [tmp setObject:clr forKey:KEY_COLOR];
        
        //position
        [tmp setObject:@"7" forKey:KEY_PADDING_TOP];
        [label addObject:tmp];
        
        
        //3.detail info
        l = [[[NSMutableString alloc] init]autorelease];
        tmp = [[[NSMutableDictionary alloc] init]autorelease];
        [l appendFormat:@"%@",lpStrUnit];
        [tmp setObject:l forKey:KEY_TEXT];
        
        //font
        [tmp setObject:@"12" forKey:KEY_FONT_SIZE];
        [tmp setObject:lpLabelFontName forKey:KEY_FONT_NAME];
        
        //color
        clr = [[[NSMutableString alloc] init]autorelease];
        [clr appendFormat:@"%f,",ZR];
        [clr appendFormat:@"%f,",ZG];
        [clr appendFormat:@"%f",ZB];
        [tmp setObject:clr forKey:KEY_COLOR];
        
        //position
        [tmp setObject:@"7" forKey:KEY_PADDING_TOP];
        [label addObject:tmp];
        [lpPool drain];
    }
    
    //    if(chart.selectedIndex!=-1 && chart.selectedIndex < data.count && [data objectAtIndex:chart.selectedIndex]!=nil){
    //        float high  = [[[data objectAtIndex:chart.selectedIndex] objectAtIndex:2] floatValue];
    //        float low   = [[[data objectAtIndex:chart.selectedIndex] objectAtIndex:3] floatValue];
    //        float open  = [[[data objectAtIndex:chart.selectedIndex] objectAtIndex:0] floatValue];
    //        float close = [[[data objectAtIndex:chart.selectedIndex] objectAtIndex:1] floatValue];
    //        float inc   =  (close-open)*100/open;
    //
    //        NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
    //        NSMutableString *l = [[NSMutableString alloc] init];
    //        [l appendFormat:@"Open:%.2f",open];
    //        [tmp setObject:l forKey:@"text"];
    //        [l release];
    //        NSMutableString *clr = [[NSMutableString alloc] init];
    //        [clr appendFormat:@"%f,",ZR];
    //        [clr appendFormat:@"%f,",ZG];
    //        [clr appendFormat:@"%f",ZB];
    //        [tmp setObject:clr forKey:@"color"];
    //        [clr release];
    //        [label addObject:tmp];
    //        [tmp release];
    //
    //        tmp = [[NSMutableDictionary alloc] init];
    //        l = [[NSMutableString alloc] init];
    //        [l appendFormat:@"Close:%.2f",close];
    //        [tmp setObject:l forKey:@"text"];
    //        [l release];
    //        clr = [[NSMutableString alloc] init];
    //        if(close>open){
    //            [clr appendFormat:@"%f,",R];
    //            [clr appendFormat:@"%f,",G];
    //            [clr appendFormat:@"%f",B];
    //        }else if (close < open) {
    //            [clr appendFormat:@"%f,",NR];
    //            [clr appendFormat:@"%f,",NG];
    //            [clr appendFormat:@"%f",NB];
    //        }else{
    //            [clr appendFormat:@"%f,",ZR];
    //            [clr appendFormat:@"%f,",ZG];
    //            [clr appendFormat:@"%f",ZB];
    //        }
    //        [tmp setObject:clr forKey:@"color"];
    //        [clr release];
    //        [label addObject:tmp];
    //        [tmp release];
    //
    //        tmp = [[NSMutableDictionary alloc] init];
    //        l = [[NSMutableString alloc] init];
    //        [l appendFormat:@"High:%.2f",high];
    //        [tmp setObject:l forKey:@"text"];
    //        [l release];
    //        clr = [[NSMutableString alloc] init];
    //        if(high>open){
    //            [clr appendFormat:@"%f,",R];
    //            [clr appendFormat:@"%f,",G];
    //            [clr appendFormat:@"%f",B];
    //        }else{
    //            [clr appendFormat:@"%f,",ZR];
    //            [clr appendFormat:@"%f,",ZG];
    //            [clr appendFormat:@"%f",ZB];
    //        }
    //        [tmp setObject:clr forKey:@"color"];
    //        [clr release];
    //        [label addObject:tmp];
    //        [tmp release];
    //
    //        tmp = [[NSMutableDictionary alloc] init];
    //        l = [[NSMutableString alloc] init];
    //        [l appendFormat:@"Low:%.2f ",low];
    //        [tmp setObject:l forKey:@"text"];
    //        [l release];
    //        clr = [[NSMutableString alloc] init];
    //        if(low>open){
    //            [clr appendFormat:@"%f,",R];
    //            [clr appendFormat:@"%f,",G];
    //            [clr appendFormat:@"%f",B];
    //        }else if(low<open){
    //            [clr appendFormat:@"%f,",NR];
    //            [clr appendFormat:@"%f,",NG];
    //            [clr appendFormat:@"%f",NB];
    //        }else{
    //            [clr appendFormat:@"%f,",ZR];
    //            [clr appendFormat:@"%f,",ZG];
    //            [clr appendFormat:@"%f",ZB];
    //        }
    //
    //        [tmp setObject:clr forKey:@"color"];
    //        [clr release];
    //        [label addObject:tmp];
    //        [tmp release];
    //
    //
    //        tmp = [[NSMutableDictionary alloc] init];
    //        l = [[NSMutableString alloc] init];
    //        [l appendFormat:@"Change:%.2f%@  ",inc,@"%"];
    //        [tmp setObject:l forKey:@"text"];
    //        [l release];
    //        clr = [[NSMutableString alloc] init];
    //        if(inc > 0){
    //            [clr appendFormat:@"%f,",R];
    //            [clr appendFormat:@"%f,",G];
    //            [clr appendFormat:@"%f",B];
    //        }else if(inc < 0){
    //            [clr appendFormat:@"%f,",NR];
    //            [clr appendFormat:@"%f,",NG];
    //            [clr appendFormat:@"%f",NB];
    //        }else{
    //            [clr appendFormat:@"%f,",ZR];
    //            [clr appendFormat:@"%f,",ZG];
    //            [clr appendFormat:@"%f",ZB];
    //        }
    //
    //        [tmp setObject:clr forKey:@"color"];
    //        [clr release];
    //        [label addObject:tmp];
    //        [tmp release];
    //
    //    }
    
}

-(void)drawTips:(Chart *)chart serie:(NSMutableDictionary *)serie
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetShouldAntialias(context, NO);
	CGContextSetLineWidth(context, 1.0f);
	
	NSMutableArray *data          = [serie objectForKey:@"data"];
	NSString       *type          = [serie objectForKey:@"type"];
	NSString       *name          = [serie objectForKey:@"name"];
	int            section        = [[serie objectForKey:@"section"] intValue];
	NSMutableArray *category      = [serie objectForKey:@"category"];
    NSString       *fontName      = [serie objectForKey:@"font"];
    int             fontSize      = [[serie objectForKey:@"fontsize"]intValue];
    if (fontSize <=0)
    {
        fontSize = 12;
    }
	Section *sec = [chart.sections objectAtIndex:section];
	
	if([type isEqualToString:@"candle"]){
		for(int i=chart.rangeFrom;i<chart.rangeTo;i++){
			if(i == data.count){
				break;
			}
			if([data objectAtIndex:i] == nil){
			    continue;
			}
			
			float ix  = sec.frame.origin.x+sec.paddingLeft+(i-chart.rangeFrom)*chart.plotWidth;
			
			if(i == chart.selectedIndex && chart.selectedIndex < data.count && [data objectAtIndex:chart.selectedIndex]!=nil){
				
				CGContextSetShouldAntialias(context, YES);
				CGContextSetRGBFillColor(context, 0.2, 0.2, 0.2, 0.8);
				CGSize size = [[category objectAtIndex:chart.selectedIndex] sizeWithFont:[UIFont fontWithName:fontName size:fontSize]];
				
				int x = ix+chart.plotWidth/2;
				int y = sec.frame.origin.y+sec.paddingTop;
				if(x+size.width > sec.frame.size.width+sec.frame.origin.x){
					x= x-(size.width+4);
				}
				CGContextFillRect (context, CGRectMake (x, y, size.width+4,size.height+2));
				CGContextSetRGBFillColor(context, 0.8, 0.8, 0.8, 1.0);
				[[category objectAtIndex:chart.selectedIndex] drawAtPoint:CGPointMake(x+2,y+1) withFont:[UIFont fontWithName:fontName size:fontSize]];
				CGContextSetShouldAntialias(context, NO);
			}
		}
	}
	
	if([type isEqualToString:@"line"] && [name isEqualToString:@"price"]){
		for(int i=chart.rangeFrom;i<chart.rangeTo;i++){
			if(i == data.count){
				break;
			}
			if([data objectAtIndex:i] == nil){
			    continue;
			}
			
			float ix  = sec.frame.origin.x+sec.paddingLeft+(i-chart.rangeFrom)*chart.plotWidth;
			
			if(i == chart.selectedIndex && chart.selectedIndex < data.count && [data objectAtIndex:chart.selectedIndex]!=nil){
				
				CGContextSetShouldAntialias(context, YES);
				CGContextSetRGBFillColor(context, 0.2, 0.2, 0.2, 0.8);
				CGSize size = [[category objectAtIndex:chart.selectedIndex] sizeWithFont:[UIFont fontWithName:fontName size:fontSize]];
				
				int x = ix+chart.plotWidth/2;
				int y = sec.frame.origin.y+sec.paddingTop;
				if(x+size.width > sec.frame.size.width+sec.frame.origin.x){
					x = x-(size.width+4);
				}
				CGContextFillRect (context, CGRectMake (x, y, size.width+4,size.height+2));
				CGContextSetRGBFillColor(context, 0.8, 0.8, 0.8, 1.0);
				[[category objectAtIndex:chart.selectedIndex] drawAtPoint:CGPointMake(x+2,y+1) withFont:[UIFont fontWithName:fontName size:fontSize]];
				CGContextSetShouldAntialias(context, NO);
			}
		}
	}
	
}

@end
