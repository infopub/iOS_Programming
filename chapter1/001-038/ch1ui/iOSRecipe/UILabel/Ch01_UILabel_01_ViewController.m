//
//  Ch01_001_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2013/10/11.
//  Copyright (c) 2013년 shaoeisya. All rights reserved.
//

#import "Ch01_UILabel_01_ViewController.h"

@interface Ch01_UILabel_01_ViewController ()

@end

@implementation Ch01_UILabel_01_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initFontLabel];
    [self initForeColorLabel];
    [self initBgColorLabel];
    [self initShadowLabel];
    [self initStrikethroughLabel];
    [self initUnderlineLabel];
    [self initLetterSpaceLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//폰트 설정
-(void)initFontLabel {
    NSString *str = @"IOS 라벨 샘플";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range1 = [str rangeOfString:@"라벨"];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"Futura-CondensedMedium" size:25.]
                    range:range1];
    [self.label1 setAttributedText:attrStr];
}

//문자색 설정
-(void)initForeColorLabel {
    NSString *str = @"IOS 라벨 샘플";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range1 = [str rangeOfString:@"라벨"];
    //赤色にセットする
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[[UIColor redColor] colorWithAlphaComponent:1.]
                    range:range1];
    [self.label2 setAttributedText:attrStr];
}

//문자 배경색 설정
-(void)initBgColorLabel{
    //▲NSMutableAttributedStringオ 오브젝트 생성
    NSString *str = @"IOS 라벨 샘플";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range1 = [str rangeOfString:@"라벨"];
    //노란색 설정
    [attrStr addAttribute:NSBackgroundColorAttributeName
                    value:[[UIColor yellowColor] colorWithAlphaComponent:1.]
                    range:range1];
    
    [self.label3 setAttributedText:attrStr];
}


//문자 그림자 설정
-(void)initShadowLabel {
    NSString *str = @"IOS 라벨 샘플";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];

    NSShadow *shadow = [[NSShadow alloc] init];
    //그림자 색
    [shadow setShadowColor:[UIColor redColor]];
    //BlurRadius
    [shadow setShadowBlurRadius:4.0];
    //그림자 크기
    [shadow setShadowOffset:CGSizeMake(2, 2)];
    [attrStr addAttribute:NSShadowAttributeName
                    value:shadow
                    range:NSMakeRange(0,[attrStr length])];
    [self.label4 setAttributedText:attrStr];
}
//삭제선 설정
-(void)initStrikethroughLabel{
    NSString *str = @"IOS 라벨 샘플";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange range1 = [str rangeOfString:@"IOS"];
    //빨간색 표준 삭제선
    [attrStr addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName:[UIColor redColor]} range:range1];
    
    NSRange range2 = [str rangeOfString:@"라벨"];
    //노란색 굵은 삭제선
    [attrStr addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick),NSStrikethroughColorAttributeName:[UIColor greenColor]} range:range2];
    
    NSRange range3 = [str rangeOfString:@"샘플"];
    //파란색 이중 삭제선
    [attrStr addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleDouble),NSStrikethroughColorAttributeName:[UIColor blueColor]} range:range3];
    
    [self.label5 setAttributedText:attrStr];
}

//아래선 설정
-(void)initUnderlineLabel {
    NSString *str = @"IOS 라벨 샘플";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange range1 = [str rangeOfString:@"IOS"];
    //빨간색 싱글 아래선
    [attrStr addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSUnderlineColorAttributeName:[UIColor redColor]} range:range1];
    
    NSRange range2 = [str rangeOfString:@"라벨"];
    //초록색 굵은 아래선
    [attrStr addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleThick),NSUnderlineColorAttributeName:[UIColor greenColor]} range:range2];

    [self.label6 setAttributedText:attrStr];
}
//문자 간격 설정
-(void)initLetterSpaceLabel{
    NSString *str = @"IOS 라벨 샘플";
    
    CGFloat customLetterSpacing = 10.0f;
    
    // NSAttributedString을 생성하여 LetterSpacing를 설정
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attrStr addAttribute:NSKernAttributeName
                           value:[NSNumber numberWithFloat:customLetterSpacing]
                           range:NSMakeRange(0, attrStr.length)];
    [self.label7 setAttributedText:attrStr];
}

@end
