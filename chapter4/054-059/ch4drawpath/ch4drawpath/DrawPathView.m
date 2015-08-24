//
//  DrawPathView.m
//  ch4DrawPath
//
//  Created by shoeisha on 2013/11/04.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "DrawPathView.h"

typedef enum {
    DRAW_PATH_NOTHING,
    DRAW_PATH_LINE,
    DRAW_PATH_FAT_LINE,
    DRAW_PATH_LINE_CAP,
    DRAW_PATH_LINE_JOIN_BEVEL,
    DRAW_PATH_LINE_JOIN_MITER,
    DRAW_PATH_DASH_LINE,
    DRAW_PATH_CURVE_LINE,
    DRAW_PATH_ARC,
    DRAW_PATH_RECT,
    DRAW_PATH_ECLIPSE,
    DRAW_PATH_GRAPH,
} DrawPathKind;

@implementation DrawPathView
{
    DrawPathKind drawPathKind;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        drawPathKind = DRAW_PATH_NOTHING;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    switch(drawPathKind) {
        case DRAW_PATH_LINE:
            [self drawPathLine];
            break;
        case DRAW_PATH_FAT_LINE:
            [self drawPathFatLine];
            break;
        case DRAW_PATH_LINE_CAP:
            [self drawPathLineCap];
            break;
        case DRAW_PATH_LINE_JOIN_BEVEL:
            [self drawPathLineJoinBevel];
            break;
        case DRAW_PATH_LINE_JOIN_MITER:
            [self drawPathLineJoinMiter];
            break;
        case DRAW_PATH_DASH_LINE:
            [self drawPathDashlLine];
            break;
        case DRAW_PATH_CURVE_LINE:
            [self drawPathCurveLine];
            break;
        case DRAW_PATH_ARC:
            [self drawPathArc];
            break;
        case DRAW_PATH_RECT:
            [self drawPathRectangle];
            break;
        case DRAW_PATH_ECLIPSE:
            [self drawPathEclipse];
            break;
        case DRAW_PATH_GRAPH:
            [self drawPathGraph];
            break;
        default:;
    }
    drawPathKind = DRAW_PATH_NOTHING;
}

- (IBAction)drawLine:(id)sender {
    [self drawSelect:DRAW_PATH_LINE];
}

- (IBAction)drawFatLine:(id)sender {
    [self drawSelect:DRAW_PATH_FAT_LINE];
}

- (IBAction)drawLineCap:(id)sender {
    [self drawSelect:DRAW_PATH_LINE_CAP];
}

- (IBAction)drawLineJoinBevel:(id)sender {
    [self drawSelect:DRAW_PATH_LINE_JOIN_BEVEL];
}

- (IBAction)drawLineJoinMiter:(id)sender {
    [self drawSelect:DRAW_PATH_LINE_JOIN_MITER];
}

- (IBAction)drawDashLine:(id)sender {
    [self drawSelect:DRAW_PATH_DASH_LINE];
}

- (IBAction)drawCurveLine:(id)sender {
    [self drawSelect:DRAW_PATH_CURVE_LINE];
}

- (IBAction)drawArc:(id)sender {
    [self drawSelect:DRAW_PATH_ARC];
}

- (IBAction)drawGraph:(id)sender {
    [self drawSelect:DRAW_PATH_GRAPH];
}

- (IBAction)drawEclipse:(id)sender {
    [self drawSelect:DRAW_PATH_ECLIPSE];
}

- (IBAction)drawRectangle:(id)sender {
    [self drawSelect:DRAW_PATH_RECT];
}

-(void)drawSelect:(DrawPathKind) kind {
    drawPathKind = kind;
    [self setNeedsDisplay];
}

// 직선 긋기
-(void) drawPathLine {
    // UIBezierPath의 인스턴스를 생성
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float startX = 100;
    float startY = 200;
    float pointX1 = 200;
    float pointY1 = 300;
    float pointX2 = 100;
    float pointY2 = 400;
    
    // 패스에 시작점을 설정
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // 패스에 적선을 추가
    [path addLineToPoint:CGPointMake(pointX1, pointY1)];
    
    // 패스에 직선을 추가
    [path addLineToPoint:CGPointMake(pointX2, pointY2)];
    
    // 그리기 실행
    [path stroke];
}

// 굵은선을 그리기
-(void) drawPathFatLine {
    // UIBezierPath의 인스턴스를 생성
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 선의 굵기를 설정
    path.lineWidth = 8.0;
    
    float startX = 100;
    float startY = 200;
    float pointX1 = 200;
    float pointY1 = 300;
    float pointX2 = 100;
    float pointY2 = 400;
    
    // 패스에 시작점을 설정
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // 패스에 직선을 추가
    [path addLineToPoint:CGPointMake(pointX1, pointY1)];
    
    // 패스에 직선을 추가
    [path addLineToPoint:CGPointMake(pointX2, pointY2)];
    
    // 그리기 실행
    [path stroke];
}


// 선 끝을 둥글게 그리기
-(void) drawPathLineCap {
    // UIBezierPath의 인스턴스를 생성
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 선의 굵기를 설정
    [path setLineWidth:8.0];
    
    // 선 끝의 형태를 설정
    [path setLineCapStyle:kCGLineCapRound];
    
    float startX = 100;
    float startY = 200;
    float pointX1 = 200;
    float pointY1 = 300;
    float pointX2 = 100;
    float pointY2 = 400;
    
    // 패스에 시작점을 설정
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // 패스에 직선을 추가
    [path addLineToPoint:CGPointMake(pointX1, pointY1)];
    
    // 패스에 직선을 추가
    [path addLineToPoint:CGPointMake(pointX2, pointY2)];
    
    // 그리기 실행
    [path stroke];
}

// 굵은 선의 끝을 다듬어서 그리기
-(void) drawPathLineJoinBevel {
    // UIBezierPath의 인스턴스를 생성
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 선의 굵기를 설정
    [path setLineWidth:8.0];
    
    // 선 끝의 형태를 설정
    [path setLineJoinStyle:kCGLineJoinBevel];
    
    float startX = 100;
    float startY = 200;
    float pointX1 = 200;
    float pointY1 = 300;
    float pointX2 = 100;
    float pointY2 = 400;
    
    // 패스에 시작점을 설정
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // 패스에 직선을 추가
    [path addLineToPoint:CGPointMake(pointX1, pointY1)];
    
    // 패스에 직선을 추가
    [path addLineToPoint:CGPointMake(pointX2, pointY2)];
    
    // 그리기 실행
    [path stroke];
}

// 굵은 선으로 그리기
-(void) drawPathLineJoinMiter {
    // UIBezierPath의 인스턴스를 생성
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 선의 굵기를 설정
    [path setLineWidth:8.0];
    
    // 선 끝의 형태를 설정
    [path setLineJoinStyle:kCGLineJoinMiter];
    
    float startX = 100;
    float startY = 200;
    float pointX1 = 200;
    float pointY1 = 300;
    float pointX2 = 100;
    float pointY2 = 400;
    
    // 패스에 시작점을 설정
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // 패스에 직선을 추가
    [path addLineToPoint:CGPointMake(pointX1, pointY1)];
    
    // 패스에 직선을 추가
    [path addLineToPoint:CGPointMake(pointX2, pointY2)];
    
    // 그리기 실행
    [path stroke];
}

// 파선 그리기
-(void) drawPathDashlLine {
    // UIBezierPath의 인스턴스를 생성
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float startX = 100;
    float startY = 200;
    float pointX = 200;
    float pointY = 300;
    float endX = 100;
    float endY = 400;
    
    // 시작점을 설정
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // 중심점을 설정
    [path addLineToPoint:CGPointMake(pointX, pointY)];
    
    // 종료점을 설정
    [path addLineToPoint:CGPointMake(endX, endY)];
    
    // 파선 패턴을 설정
    const CGFloat lengths[] = {5,5,5,5,10,5};
    [path setLineDash:lengths count:5 phase:6];
    
    // 그리기 실행
    [path stroke];
}

// 곡선 그리기
-(void) drawPathCurveLine {
    // UIBezierPath의 인스턴스를 생성
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float startX = 200;
    float startY = 200;
    float controlPointX = 180;
    float controlPointY = 300;
    float endX = 50;
    float endY = 300;
    
    // 시작점을 설정
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // 종료점과 컨트롤 포인트를 설정
    [path addQuadCurveToPoint:CGPointMake(endX, endY)
                 controlPoint:CGPointMake(controlPointX, controlPointY)];
    
    // 그리기 실행
    [path stroke];
}

// 곡선그리기(보조선 있음)
-(void) drawPathCurveLineWithAsistLine {
    // UIBezierPath의 인스턴스를 생성
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float startX = 200;
    float startY = 200;
    float controlPointX = 180;
    float controlPointY = 300;
    float endX = 50;
    float endY = 300;
    
    // 시작점을 설정
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // 종료점과 컨트롤 포인트를 설정
    [path addQuadCurveToPoint:CGPointMake(endX, endY)
                 controlPoint:CGPointMake(controlPointX, controlPointY)];
    
    // 그리기 실행
    [path stroke];
    
    // 보조선 그리기
    [path removeAllPoints];
    
    // 시작점을 설정
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // 컨트롤 포인트를 설정
    [path addLineToPoint:CGPointMake(controlPointX, controlPointY)];
    
    // 중료점을 설정
    [path addLineToPoint:CGPointMake(endX, endY)];
    
    // 파선 패턴을 설정
    const CGFloat lengths[] = {5,5,5,5,10,5};
    [path setLineDash:lengths count:5 phase:6];
    
    // 보조선으로 빨강색을 지정
    [[UIColor redColor] setStroke];
    
    // 그리기 실행
    [path stroke];
    
}

// 원호그리기(중심점, 반지름, 시작각, 종료각, 회전방향을 지정)
-(void) drawPathArc {
    // UIBezierPath의 인스턴스를 생성
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 원호의 매개변수를 작성
    float centerX = 160;        // 중심점
    float centerY = 300;
    CGPoint center = CGPointMake(centerX, centerY);
    float radius = 100;         // 반지를
    float startAngle = 0;       // 시작각 단위는 라디안
    float endAngle = M_PI*1.5;  // 종료각 단위는 라디안
    BOOL clockwise = YES;       // 시계방향
    
    // 원호의 패스를 추가
    [path addArcWithCenter:center
                    radius:radius
                startAngle:startAngle
                  endAngle:endAngle
                 clockwise:clockwise];
    
    // 그리기 실행
    [path stroke];
}

// 직사각형 그리기
-(void) drawPathRectangle {
    // 직사각형의 매개변수를 생성
    int x = 100;        // 직사각형의 x좌표
    int y = 150;        // 직사각형의 y좌표
    int width = 100;    // 직사각형의 높이
    int height = 200;   // 직사각형의 폭
    CGRect rect = CGRectMake(x, y, width, height);
    
    // 직사각형의 패스를 설정
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    
    // 선의 색상을 설정
    [[UIColor redColor] setStroke];
    
    // 그리기 실행
    [path stroke];
}

// 타원 그리기
-(void) drawPathEclipse {
    // 직사각형의 매개변수를 생성
    int x = 100;        // 직사각형의 x좌표
    int y = 150;        // 직사각형의 y좌표
    int width = 100;    // 직사각형의 높이
    int height = 200;   // 직사각형의 폭
    CGRect rect = CGRectMake(x, y, width, height);
    
    // 타원의 패스를 설정
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    // 선의 색상을 설정
    [[UIColor greenColor] setStroke];
    
    // 그리기 실행
    [path stroke];
}


// 원 그래프 그리기
-(void) drawPathGraph {
    
    // 원 그래프의 중심점
    float centerX = 160;
    float centerY = 300;
    CGPoint center = CGPointMake(centerX, centerY);
    
    // 원 그래프의 반지름
    float radius = 100;
    
    // 그래프의 내용을 비율 테이블(％）
    int parcentTable[] = {15,26,40,19};
    
    // 시작각, 0은 3시방향
    float startAngle = 0;
    
    // 테이블의 내용에 따라 부채꼴을 그리기
    for (int i=0; i<4; i++) {
        // 그리프 비율
        int percent = parcentTable[i];
        
        // 비율에서 각도를 산출
        float angle = M_PI*2 * percent / 100.0;

        // 채우는 색을 설정
        UIColor *color;
        switch (i) {
            case 0:
                color = [UIColor blueColor];
                break;
            case 1:
                color = [UIColor yellowColor];
                break;
            case 2:
                color = [UIColor greenColor];
                break;
            case 3:
                color = [UIColor redColor];
                break;
        }
        
        // 부채꼴을 그리기
        [self drawFunShapeWithCenter:center radius:radius startAngle:startAngle angle:angle color:color];
        
        // 다음 시작각을 계산
        startAngle += angle;
    }
}

// 부채꼴을 그리기
-(void) drawFunShapeWithCenter:(CGPoint)center      // 중심점
                        radius:(float)radius        // 반지름
                    startAngle:(float)startAngle    // 시작각
                         angle:(float)angle         // 각도
                         color:(UIColor *)color     // 색
{
    
    // UIBezierPath의 인스턴스를 생성
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 종료각을 산출
    float endAngle = startAngle + angle;
    
    // PATH에 원 그래프의 부채꼴을 설정
    [path addArcWithCenter:center       // 중심점
                    radius:radius       // 반지름
                startAngle:startAngle   // 시작각
                  endAngle:endAngle     // 종료각
                 clockwise:YES];        // 시계방향을 지정
    
    // 원호부터 중심점으로의 직선을 추가
    [path addLineToPoint:center];
    
    // 패스를 닫고 부채꼴을 작성
    [path closePath];
    
    // 채우는 색을 설정
    if (color) {
        [color setFill];
    }

    // 그리기 실행
    // 색을 채움
    [path fill];
    
    // 선 그리기
    [path stroke];
}


@end
