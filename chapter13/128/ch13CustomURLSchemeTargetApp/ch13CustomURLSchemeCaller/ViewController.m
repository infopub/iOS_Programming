//
//  ViewController.m
//  ch13CustomURLSchemeCaller
//
//  Created by HU QIAO on 2013/12/10.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)callTargetApp:(id)sender {

    //「jp.co.shoeisha.iphonereceipe.ch13CustomURLSchemeTargetApp://」이라는 「URLScheme」를 갖는 어플에「testinformation」이라는 문자를 송신
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"jp.co.shoeisha.iphonereceipe.ch13CustomURLSchemeTargetApp://testinformation"]];

}

@end
