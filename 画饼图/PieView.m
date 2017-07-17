//
//  PieView.m
//  画饼图
//
//  Created by MAC on 2017/6/28.
//  Copyright © 2017年 GuoDongge. All rights reserved.
//

#import "PieView.h"

@implementation PieView


//做一个随机数组
-(NSArray*)arrRandom
{
    //数组中所有数的总和为100
    int totoal = 100;
    
    NSMutableArray * arrM = [NSMutableArray array];
    
    int temp = 0;
    //设置循环的随机次数不超过10， +1是因为随机数可能为0，如果是0没有意义
    for (int i =0; i < arc4random_uniform(10) + 1; i++) {
        
        //随机分配的数
        temp = arc4random_uniform(totoal) + 1;
        
        //将随机数加到数组里
        [arrM addObject:@(temp)];
     
         // 解决方式：当随机出来的数等于总数直接退出循环。
        if (temp == totoal) {
            
            break;
        }
        
        //每循环一次，就减掉一个随机数
        totoal -= temp;
    }
    
    //退出循环之后，如果总数中还有剩余值就加上最后的值
    if (totoal) {
        [arrM addObject:@(totoal)];
    }
    
    return arrM;
    
}


- (void)drawRect:(CGRect)rect {
 
    
//    NSArray * arr = @[@25,@25,@50];
    
    NSArray * arr = [self arrRandom];
    
    //半径的长度  rect:控件本身的bounds
    CGFloat radius = rect.size.width * 0.5;
    //中心点
    CGPoint center =  CGPointMake(radius, radius);
    
    CGFloat startA = 0;
    CGFloat endA = 0;
    CGFloat angle = 0;
    
    for (int i = 0; i < arr.count; i++) {
        
        startA = endA;
        //所画出来的扇形的角度  M_PI * 2  : 360˚
        
        angle = [arr[i] integerValue] / 100.0 * M_PI * 2;
        endA = startA + angle;
        
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        
        [path addLineToPoint:center];
        
        //设置随机颜色
        [[self colorRandom] set];
        
        [path fill];
        
    }
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
    
}

//做一个随机颜色
-(UIColor*)colorRandom
{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
    
    
    
}











@end
