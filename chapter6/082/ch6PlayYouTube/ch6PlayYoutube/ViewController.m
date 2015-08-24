//
//  ViewController.m
//  ch6PlayYoutube
//
//  Created by shoeisha on 2013/10/30.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    IBOutlet UIWebView* webView;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.youtube.com/embed/1Ql0Z8Il73s"]];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
