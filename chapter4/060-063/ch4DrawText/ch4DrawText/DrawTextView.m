//
//  DrawTextView.m
//  ch4DrawText
//
//  Created by shoeisha on 2013/11/07.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "DrawTextView.h"

typedef enum {
    DRAW_TEXT_NOTHING,
    DRAW_TEXT_TEXT,
    DRAW_TEXT_COLOR,
    DRAW_TEXT_FONT,
    DRAW_TEXT_RECT,
} DrawTextKind;

@implementation DrawTextView {
    DrawTextKind drawTextKind;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        drawTextKind = DRAW_TEXT_NOTHING;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    switch(drawTextKind) {
        case DRAW_TEXT_TEXT:
            [self drawTextText];
            break;
        case DRAW_TEXT_COLOR:
            [self drawTextColor];
            break;
        case DRAW_TEXT_FONT:
            [self drawTextFont];
            break;
        case DRAW_TEXT_RECT:
            [self drawTextRect:rect];
            break;
        default:;
    }
}

- (IBAction)drawText:(id)sender {
    [self drawSelect:DRAW_TEXT_TEXT];
}

- (IBAction)drawTextWithColor:(id)sender {
    [self drawSelect:DRAW_TEXT_COLOR];
}

- (IBAction)drawTextWithFont:(id)sender {
    [self drawSelect:DRAW_TEXT_FONT];
}

- (IBAction)drawTextWithRect:(id)sender {
    [self drawSelect:DRAW_TEXT_RECT];
}

-(void)drawSelect:(DrawTextKind) kind {
    drawTextKind = kind;
    [self setNeedsDisplay];
}

// 텍스트 출력
- (void)drawTextText {
    // 문자열 생성
    NSString *string = @"가나다라마바사";
    
    // 표시좌표
    float x = 10;
    float y = 200;

    // 문자열을 출력
    [string drawAtPoint:CGPointMake(x, y) withAttributes:nil];
}

// 색을 지정하여 문자열을 출력
- (void)drawTextColor {
    // 문자열을 생성
    NSString *string = @"가나다라마바사";
    
    // 표시좌표
    float x = 10;
    float y = 200;
    
    // 색 데이터를 생성
    UIColor *color = [UIColor colorWithRed:1.0f green:0.0f blue: 0.0f alpha:1.0f];

    // 문자열의 속성을 생성
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                            color, NSForegroundColorAttributeName, nil];
    
    // 문자열 출력
    [string drawAtPoint:CGPointMake(x, y)
         withAttributes:attrs];
}

// 폰트를 지정하여 문자열을 출력
- (void)drawTextFont {
    // 문자열을 생성
    NSString *string = @"가나다라마바사";
    
    // 표시좌표
    float x = 10;
    float y = 200;
    
    // 폰트 매개변수를 생성
    UIFont *font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:20];
    
    // 속성을 생성
    NSDictionary* attrs=[NSDictionary dictionaryWithObjectsAndKeys:
                         font,NSFontAttributeName, nil];
    
    // 문자열 출력
    [string drawAtPoint:CGPointMake(x, y)
         withAttributes:attrs];
    
}

// 직사각형에 문자열을 출력
- (void)drawTextRect:(CGRect)rect {
    // 문자열을 생성
    NSString *string = @"동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리 나라 만세 무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세";
    
    // 그릴 범위의 직사각형을 설정
    float x = 100;
    float y = 200;
    float width = 100;
    float height = 100;
    
    // 출력 범위의 직사각형을 생성
    CGRect textrect = CGRectMake(x, y, width, height);
    
    // 직사각형 내의 문자열을 생성
    [string drawInRect:textrect
        withAttributes:nil];
    

    // 출력 범위를 표시하기 위해 출력 범위의 직사각형을 표시
    // 문자열을 감싸는 직사각형의 패스를 설정
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:textrect];
    
    // 직사각형을 그리기
    [path stroke];
}

@end

