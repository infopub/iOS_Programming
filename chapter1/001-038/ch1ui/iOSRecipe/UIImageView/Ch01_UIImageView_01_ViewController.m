//
//  Ch01_UIImageView_01_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/26.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIImageView_01_ViewController.h"

@interface Ch01_UIImageView_01_ViewController ()

@end

@implementation Ch01_UIImageView_01_ViewController

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
    UIImage *image = [UIImage imageNamed:@"red.png"];
    self.imageView1.image=image;
    
    // NSURL을 만든다
    NSURL *imageURL = [NSURL URLWithString:@"http://infopub.co.kr/img/main/top_logo.jpg"];
    // NSURL 객체로부터 데이타를 만든다
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    // 읽어들인 이미지 데이터에서 UIImage를 만든다
    UIImage *uiImage = [UIImage imageWithData:imageData];
    // UIImage를 UIImageView의 image 속성에 설정함
    self.imageView2.image = uiImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
