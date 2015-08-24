//
//  MyPaymentTransactionObserver.m
//  Chapter03
//
//
//

#import "MyPaymentTransactionObserver.h"

@implementation MyPaymentTransactionObserver

static MyPaymentTransactionObserver* _sharedObserver = nil;

// 여러 개의 클래스에서 같은 인스턴스를 다룰 수 있도록 하기 위하여 싱글턴으로 한다
+ (id)sharedObserver {
	@synchronized(self) {
		if (_sharedObserver == nil) {
			_sharedObserver = [[self alloc] init];
		}
	}
	return _sharedObserver;
}


#pragma mark - SKPaymentTransactionObserver Required Methods
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
  NSLog(@"%s", __PRETTY_FUNCTION__);

  for (SKPaymentTransaction *transaction in transactions) {
    switch (transaction.transactionState) {
      case SKPaymentTransactionStatePurchasing:
        NSLog(@"SKPaymentTransactionStatePurchasing");
        break;

      case SKPaymentTransactionStatePurchased:
        // 구입 완료 시의 처리를 한다
        [self completeTransaction:transaction];
        NSLog(@"SKPaymentTransactionStatePurchased");
        break;

      case SKPaymentTransactionStateFailed:
        // 구입 실패 시의 처리를 한다
        [self failedTransaction:transaction];
        NSLog(@"SKPaymentTransactionStateFailed");
        break;

      case SKPaymentTransactionStateRestored:
        // 리스토어 시의 처리를 한다
        NSLog(@"SKPaymentTransactionStateRestored");
        break;

      default:
        break;
    }
  }
}

#pragma mark - SKPaymentTransactionObserver Optional Methods

// 트랜잭션이 finishTransaction 경유로 큐에서 삭제되었을 때에 송신된다
- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions {
  NSLog(@"%s", __PRETTY_FUNCTION__);
}

// 사용자의 구입 이력에서 큐로 되돌아간 트랜잭션을 추가 중에 에러가 발생했을 때에 송신된다
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error {
  NSLog(@"%s", __PRETTY_FUNCTION__);
}

// 사용자의 구입 이력에서 모든 트랜잭션을 정상적으로 돌려놓고 큐에 추가되었을 때에 송신된다
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
  NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark - Transaction Methods
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
  NSLog(@"%s", __PRETTY_FUNCTION__);
  
  // 구입이 완료한 것을 통지한다
  [[NSNotificationCenter defaultCenter] postNotificationName:kPaymentCompletedNotification
                                                      object:transaction];
  
  // 페이 도큐먼트에 종료를 전달하여 트랜잭션을 삭제한다
  [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
  NSLog(@"%s", __PRETTY_FUNCTION__);
  
  switch (transaction.error.code) {
    case SKErrorPaymentCancelled:
      NSLog(@"SKErrorPaymentCancelled");
      break;
      
    case SKErrorUnknown:
      NSLog(@"SKErrorUnknown");
      break;
      
    case SKErrorClientInvalid:
      NSLog(@"SKErrorClientInvalid");
      break;
      
    case SKErrorPaymentInvalid:
      NSLog(@"SKErrorPaymentInvalid");
      break;
      
    case SKErrorPaymentNotAllowed:
      NSLog(@"SKErrorPaymentNotAllowed");
      break;
      
    default:
      break;
  }
  
  // 에러를 통지한다
  [[NSNotificationCenter defaultCenter] postNotificationName:kPaymentErrorNotification
                                                      object:transaction];


  // 페이 도큐먼트에 종료를 전달하여 트랜잭션을 삭제한다
  [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

@end
