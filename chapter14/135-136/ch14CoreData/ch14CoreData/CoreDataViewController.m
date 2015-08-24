//
//  CoreDataViewController.m
//  ch14CoreData
//
//  Created by HU QIAO on 2014/01/27.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "CoreDataViewController.h"

@interface CoreDataViewController ()

@property (weak, nonatomic) IBOutlet UITextField *name;

@property (weak, nonatomic) IBOutlet UITextField *address;

@property (weak, nonatomic) IBOutlet UILabel *message;

@end

@implementation CoreDataViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 데이터를 작성
- (IBAction)Save:(id)sender {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // context는 NSManagedObjectContext의 인스턴스
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    // NSEntityDescriptionのinsertNewObjectForEntityForName:를 이용하여, NSManagedObject의 인스턴스를 구하기
    NSManagedObject *newContact;
    newContact = [NSEntityDescription insertNewObjectForEntityForName:@"Contacts"
                                               inManagedObjectContext:context];
    
    // NSManagedObject에 각 속성값을 설정
    [newContact setValue: _name.text forKey:@"name"];
    [newContact setValue: _address.text forKey:@"address"];
    NSError *error;
    
    // managedObjectContext 오브젝트의 save 메소드에서 데이터를 저장
    [context save:&error];
    
    _name.text = @"";
    _address.text = @"";
    _message.text = @"데이터를 저장했습니다.";
    
}

// 데이터 검색
- (IBAction)Search:(id)sender {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // context는 NSManagedObjectContext 클래스의 인스턴스
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    // NSFetchRequest는 검색 조건 등을 저장하는 오브젝트
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    // 검색 대상의 엔티티를 지정
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Contacts"
                                                  inManagedObjectContext:context];
    [request setEntity:entityDesc];
    
    // 검색 조건으르 지정
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name = %@)",  _name.text];
    [request setPredicate:pred];
    
    // 검색을 실행
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    // 검색 결과를 표시
    NSManagedObject *matches = nil;
    if ([objects count] == 0) {
        _message.text = @"검색 결과가 없었습니다.";
    } else {
        matches = objects[0];
        _address.text = [matches valueForKey:@"address"];
        _message.text = [NSString stringWithFormat:
                         @"%lu건의 데이터가 있었습니다.", (unsigned long)[objects count]];
    }
    
}

// 데이터 삭제
- (IBAction)delete:(id)sender {

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // context는 NSManagedObjectContext 클래스의 인스턴스
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    // NSFetchRequest는 검색 조건 등을 저장하는 오브젝트
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    // 검색 대상의 엔티티를 지정
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Contacts"
                                                  inManagedObjectContext:context];
    [request setEntity:entityDesc];
    
    // 검색 조건을 지정
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name = %@)",  _name.text];
    [request setPredicate:pred];
    
    // 검색을 실행
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    
    if ([objects count] == 0) {
        _message.text = @"검색 결과가 없었습니다.";
    } else {
        // 삭제 메소드를 호출한다
        for (NSManagedObject *object in objects) {
            [context deleteObject:object];
        }
        // save 메소드로 갱신 상태를 확정
        if (![context save:&error]) {
            _message.text = @"데이터 삭제에 실패했습니다.";
        } else {
            _message.text = [NSString stringWithFormat:
                             @"%lu건의 데이터를 삭제했습니다.", (unsigned long)[objects count]];
        }
    }
    
}


@end
