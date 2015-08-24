//
//  Ch01_002_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2013/10/15.
//  Copyright (c) 2013年 shaoeisya. All rights reserved.
//

#import "Ch01_UILabel_02_ViewController.h"

@interface Ch01_UILabel_02_ViewController ()

@end

@implementation Ch01_UILabel_02_ViewController

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
    [self.label1 setText:@"열심히 IOS를 공부한다"];
    [self.label2 setText:@"열심히 IOS를 공부한다"];
    [self.label3 setText:@"열심히 IOS를 공부한다"];
    
    // 맨 앞을 ...으로 생략
    self.label1.lineBreakMode = NSLineBreakByTruncatingHead;
    // 마지막을...으로 생략
    self.label2.lineBreakMode = NSLineBreakByTruncatingTail;
    // 한 가운데를...으로 생략
    self.label3.lineBreakMode = NSLineBreakByTruncatingMiddle;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
