//
//  TableViewController.m
//  iOSRecipe_17_03
//
//  Created by shimy on 1/8/14.
//  Copyright (c) 2014 shimy. All rights reserved.
//

#import "TableViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface TableViewController ()

@end

@implementation TableViewController
{
    CFArrayRef people;
}

struct Structure {
    int count;
};

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
    
    // 연락처 구하기
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFRelease(addressBook);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return CFArrayGetCount(people);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    // 이름 표시
    ABRecordRef person = CFArrayGetValueAtIndex(people, indexPath.row);
    CFStringRef name = ABRecordCopyCompositeName(person); // release되지 않는다
    cell.textLabel.text = (__bridge NSString *)name;
    
    // 수치 표시
    int mod; // 초기화되지 않는다
    BOOL flg = YES; // 참조되지 않는다
    switch (indexPath.row % 3)
    {
        case 0:
            mod = 1;
            flg = NO;
            break;
        case 1:
            mod = 2;
            struct Structure structure;
            structure.count = mod;
            [self convert: &structure ];
            break;
    }
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",mod ];

    return cell;
}

- (int)convert:(struct Structure*)structure
{
    // NULL의 경우는 고려하지 않는다
    if (structure == NULL)
    {
    }
    return structure->count;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
