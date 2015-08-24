//
//  Ch01_UIButton_02_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/04.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIButton_02_ViewController.h"

@interface Ch01_UIButton_02_ViewController ()

@end

@implementation Ch01_UIButton_02_ViewController

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
    [self setRichButton];
    [self roundButton:self.button2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 보통상태의 버튼에 다양한 타이틀을 설정
-(void)setRichButton {
    NSString *str = @"IOS 버튼 샘플";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange range1 = [str rangeOfString:@"버튼"];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"Futura-CondensedMedium" size:25.]
                    range:range1];
    
    NSRange range2 = [str rangeOfString:@"IOS"];
    // 적색 표준 취소선
    [attrStr addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName:[UIColor redColor]} range:range2];
    
    NSRange range3 = [str rangeOfString:@"버튼"];
    // 초록색 굵은 취소선
    [attrStr addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick),NSStrikethroughColorAttributeName:[UIColor greenColor]} range:range3];
    
    NSRange range4 = [str rangeOfString:@"샘플"];
    // 파란색 이중 취소선
    [attrStr addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleDouble),NSStrikethroughColorAttributeName:[UIColor blueColor]} range:range4];
    
    [self.button1 setAttributedTitle:attrStr forState:UIControlStateNormal];
}

// 둥근사각/검은 반투명 배경 버튼에 맞춤
- (void)roundButton:(UIButton*)button{
    CALayer *buttonLayer = button.layer;
    [buttonLayer setMasksToBounds:YES];
    [buttonLayer setCornerRadius:7.5f];
    [buttonLayer setBorderWidth:1.0f];
    [buttonLayer setBorderColor:[[UIColor blackColor] CGColor]];
    [buttonLayer setBackgroundColor:[[UIColor colorWithRed:0.0/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.5f] CGColor]];
}

@end
