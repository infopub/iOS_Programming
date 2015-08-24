//
//  Ch01_UITableView_02_TableViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/02/17.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UITableView_02_TableViewController.h"

@interface Ch01_UITableView_02_TableViewController ()
{
    // 행 데이터를 저장한다
    NSMutableArray *rowDataArray;
    // 추가한 행 수
    int insertRow;
}
@end

@implementation Ch01_UITableView_02_TableViewController

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
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"줄 추가/삭제/이동 샘플";
    rowDataArray = [[NSMutableArray alloc]init];
    for(int i=1;i<4;i++) {
        [rowDataArray addObject:[NSString stringWithFormat:@"원래 행：%d",i]];
    }
    insertRow = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 샘플로 1 섹션을 설정한다.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 1개의 섹션 내의 행 수를 반환한다.
    return [rowDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // storyboard에서 지정한 Identifier를 지정한다.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    
    UILabel *uiLabel;
    
    uiLabel = (UILabel *)[cell viewWithTag:1];
    uiLabel.text = [rowDataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
    if (editing) {
        // 현재 편집 모드
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                        target:self action:@selector(insertRow:)];
        // 추가 버튼을 표시
        [self.navigationItem setLeftBarButtonItem:addButton animated:YES];
    } else {
        // 현재 일반 모드. 추가 버튼을 비표시로
        [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    }
}

// 추가 처리
- (IBAction)insertRow:(id)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowDataArray.count inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObjects:indexPath,nil];
    [rowDataArray addObject:[NSString stringWithFormat:@"추가된 줄：%d",insertRow]];
    // 다음 사용을 위해 addCount에 1을 더한다.
    insertRow++;
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
}


// 이동 처리
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
   
    if(fromIndexPath.section == toIndexPath.section) {
        // 이동 장소와 이동할 장소는 같은 섹션
        if(rowDataArray && toIndexPath.row < [rowDataArray count]) {
            // 이동 대상을 저장
            id item = [rowDataArray objectAtIndex:fromIndexPath.row ];
            // 배열에서 먼저 삭제
            [rowDataArray removeObject:item];
            // 저장해 둔 대상을 삽입
            [rowDataArray insertObject:item atIndex:toIndexPath.row];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // 모든 데이터가 이동할 수 있도록 한다
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 삭제 버튼이 눌린 행의 데이터를 배열에서 삭제
        [rowDataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // 여기는 비워둬도 문제 없음
    }
}

@end
