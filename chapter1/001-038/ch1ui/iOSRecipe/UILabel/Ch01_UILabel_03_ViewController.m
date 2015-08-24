//
//  Ch01_003_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2013/10/23.
//  Copyright (c) 2013年 shaoeisya. All rights reserved.
//

#import "Ch01_UILabel_03_ViewController.h"
//QuartzCore 프레임워크를 프로젝트에 추가한 후,
//UILabel을 이용할 클래스 파일에 import문에서 QuartzCore 헤더 파일을 읽어들임
#import <QuartzCore/QuartzCore.h>

@interface Ch01_UILabel_03_ViewController ()

@end

@implementation Ch01_UILabel_03_ViewController

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
    
    // 테두리 선을 지정
    self.label1.layer.borderColor =[[UIColor blueColor] CGColor];
    // 테두리 폭을 지정
    self.label1.layer.borderWidth=1.0f;
    // 둥근 사각형 반경을 지정
    self.label1.layer.cornerRadius=10.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
