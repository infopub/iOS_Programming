//
//  Ch01_UITableView_04_TableViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/02/06.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UITableView_04_TableViewController.h"

@interface Ch01_UITableView_04_TableViewController ()

@end

@implementation Ch01_UITableView_04_TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // storyboard에서 정의한 Identifier를 지정한다
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    
    UILabel *uiLabel;
    UISwitch *uiSwitch;
    
    uiLabel = (UILabel *)[cell viewWithTag:1];
    uiLabel.text = [NSString stringWithFormat:@"섹션：%d　행：%d", indexPath.section, indexPath.row];
    
    uiSwitch = (UISwitch *)[cell viewWithTag:2];
    [uiSwitch setOn:true];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 섹션수를 반환
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 섹션 내의 줄 수를 반환. 이 곳에서 모든 섹션에 같은 줄 수 3을 정의한다.
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // 각 센션으로 헤더를 지정
    return [NSString stringWithFormat : @"%@%d", @"섹션", section];
}


@end
