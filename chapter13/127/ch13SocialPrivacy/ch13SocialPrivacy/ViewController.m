//
//  ViewController.m
//  ch13SocialPrivacy
//
//  Created by HU QIAO on 2014/01/16.
//  Copyright (c) 2014年 shoeisya. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface ViewController ()

@property (strong, nonatomic) NSArray *dataSource;

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

//Twitter
- (IBAction)TwitterAccess:(id)sender {
    
    
    //ACAccountStore 오브젝트를 생성
    ACAccountStore *account = [[ACAccountStore alloc] init];
    
    //ACAccountType 얻기
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    // 단말의 Twitter 계정의 접근권을 요구한다
    [account requestAccessToAccountsWithType:accountType
                                     options:nil
                                  completion:^(BOOL granted, NSError *error)
     {
         
         if (granted) {
             // 사용자가 접근을 허가한 경우
             // 단말에 등록된 Twtitter 계정（ACAccount）배열을 구함
             NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
             if ([arrayOfAccounts count] > 0)
             {
                 ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                 
                 //Twitter API를 이용하여 Twitter로 접근을 한다
                 NSDictionary *message = [NSDictionary dictionaryWithObjectsAndKeys:@"My First Twitter post from iOS", @"status",nil];
                 
                 NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/update.json"];
                 
                 //SLRequest을 사용
                 SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                             requestMethod:SLRequestMethodPOST
                                                                       URL:requestURL
                                                                parameters:message];
                 // 계정을 지정
                 postRequest.account = twitterAccount;
                 
                 // 리퀘스트를 발행
                 [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
                  {
                      NSLog(@"Response, %@",[urlResponse description]);
                      
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [[[UIAlertView alloc] initWithTitle:@"확인"
                                                      message:[NSString stringWithFormat:@"Twitter HTTP response: %ld",(long)[urlResponse statusCode]]
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil]
                           show];
                          
                          
                      });
                      
                  }];
             }
         } else {
             // 사용자가 접근을 거부한 경우
             dispatch_async(dispatch_get_main_queue(), ^{
                 [[[UIAlertView alloc] initWithTitle:@"확인"
                                             message:@"이 앱의 Twitter 계정으로 접근을 허가하려면 개인정보보호에서 설정해야 한다."
                                            delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil]
                  show];
             });
         }
         
     }];
}

//Facebook
- (IBAction)FacebookAccess:(id)sender {
    
    //ACAccountStore 오브젝트를 생성
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    
    //ACAccountType 구함
    ACAccountType *accountTypeFacebook =   [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    NSDictionary *options = @{ACFacebookAppIdKey: @"gsio@nate.com",
                                  ACFacebookPermissionsKey: @[@"publish_stream",@"publish_actions"],
                                  ACFacebookAudienceKey: ACFacebookAudienceFriends
                                  };
    
    // 단말의 Facebook 계정의 접근권을 요구한다
    [accountStore requestAccessToAccountsWithType:accountTypeFacebook
                                          options:options
                                       completion:^(BOOL granted, NSError *error)
     {
         if(granted) {
             // 사용자가 접근을 허가한 경우
             
             // 단말에 등록된 Facebook 계정（ACAccount）배열을 취득
             NSArray *accounts = [accountStore accountsWithAccountType:accountTypeFacebook];
             
             // 계정을 지정
             ACAccount *facebookAccount = [accounts lastObject];
             
             NSDictionary *parameters = @{@"access_token":facebookAccount.credential.oauthToken,
                                          @"message": @"My first iOS Facebook posting"};
             
             //Facebook API를 이용하여,Facebook으로 접근을 한다
             NSURL *requestURL = [NSURL URLWithString:@"https://graph.facebook.com/me/feed"];
             
             //SLRequest을 사용
             SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                                         requestMethod:SLRequestMethodPOST
                                                                   URL:requestURL
                                                            parameters:parameters];
                          

             // 리퀘스트를 발행
             [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
              {
                  NSLog(@"Response, %@",[urlResponse description]);
                  
                  dispatch_async(dispatch_get_main_queue(), ^{
                      [[[UIAlertView alloc] initWithTitle:@"확인"
                                                  message:[NSString stringWithFormat:@"Facebook HTTP response: %ld",(long)[urlResponse statusCode]]
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil]
                       show];
                  });
              }];
         } else {
             // 사용자가 접근을 거부한 경우
             dispatch_async(dispatch_get_main_queue(), ^{
                 [[[UIAlertView alloc] initWithTitle:@"확인"
                                             message:@"이 앱의 Facebook 계정으로 접근을 허가하려면 개인정보보호에서 설정을 해야합니다."
                                            delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil]
                  show];
             });
         }
     }];
}


@end
