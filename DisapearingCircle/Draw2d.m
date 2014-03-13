//
//  Draw2d.m
//  DisapearingCircle
//
//  Created by Jamie Lockhart on 2014-03-13.
//  Copyright (c) 2014 HotSpot Parking Inc. All rights reserved.
//

#import "Draw2d.h"

@implementation Draw2d

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *buttonl = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonl addTarget:self
                   action:@selector(left)
         forControlEvents:UIControlEventTouchDown];
        [buttonl setTitle:@"Left" forState:UIControlStateNormal];
        buttonl.frame = CGRectMake(40.0, 210.0, 160.0, 40.0);
        [self addSubview:buttonl];
        
        UIButton *buttonr = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonr addTarget:self
                   action:@selector(right)
         forControlEvents:UIControlEventTouchDown];
        [buttonr setTitle:@"Right" forState:UIControlStateNormal];
        buttonr.frame = CGRectMake(100.0, 210.0, 160.0, 40.0);
        [self addSubview:buttonr];
        
        
        
    }
    return self;
    
}

-(void)refreshUIView
{
    _degrees++;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if (_degrees == 0) {
        _degrees = 0;
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(refreshUIView) userInfo:nil repeats:YES];
        [_timer fire];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 8.0);
    CGContextSetStrokeColorWithColor(context, [UIColor  colorWithRed:46.0f/255.0f green:204.0f/255.0f blue:113.0f/255.0f alpha:1].CGColor);
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    CGFloat middlex = screenWidth*0.5;
    CGFloat middley = screenHeight*0.5;
    
    CGFloat radius = 40;
    
    CGRect rectangle = CGRectMake(middlex-radius, middley-radius,radius*2,radius*2);
    CGContextAddEllipseInRect(context, rectangle);
    CGContextStrokePath(context);
    
    float startx = middlex+radius;
    float starty = middley;
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    for (int i = 1; i < _degrees; i++) {
        CGContextMoveToPoint(context, startx, starty);

        float radians = i * M_PI / 180.0f;
        float x = (float)(radius * cos(radians)) + middlex;
        float y = (float)(radius * sin(radians)) + middley;
        
        CGContextAddLineToPoint(context, x, y);
        startx = x;
        starty = y;
        
        CGContextStrokePath(context);
    }
}

-(void)left {
    
}

-(void)right {
    
}

@end
