//
//  Ch01_UIImageView_02_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/27.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIImageView_02_ViewController.h"

@interface Ch01_UIImageView_02_ViewController ()
{
    UIImageView *imageView;
}
@end

@implementation Ch01_UIImageView_02_ViewController

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
    // 이미지를 표시
    UIImage *image = [UIImage imageNamed:@"sample.jpg"];
    imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(20, 120, 260, 400);
    [self.view addSubview:imageView];
}
- (IBAction)scaleImageView:(id)sender {
    // 이미지의 가로폭과 세로폭을 0.5배 축소
    CGAffineTransform t2 = CGAffineTransformMakeScale(0.5,0.5);
    imageView.transform = t2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
