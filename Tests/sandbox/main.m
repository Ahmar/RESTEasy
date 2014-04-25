//
//  main.m
//  sandbox
//
//  Created by John Tumminaro on 4/24/14.
//
//

#import <Foundation/Foundation.h>
#import "RESTEasy.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        [[TGRESTServer sharedServer] startServerWithOptions:nil];
        TGRESTResource *resource = [TGRESTResource newResourceWithName:@"stuff" model:@{@"name": [NSNumber numberWithInteger:TGPropertyTypeString]} routes:nil actions:TGResourceRESTActionsGET | TGResourceRESTActionsPOST | TGResourceRESTActionsDELETE | TGResourceRESTActionsPUT primaryKey:nil];
        [[TGRESTServer sharedServer] addResource:resource];
        
        __block BOOL serverRunning = YES;
        
        [[NSNotificationCenter defaultCenter] addObserverForName:TGServerDidShutdownNotification
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:^(NSNotification *note) {
                                                          serverRunning = NO;
                                                      }];
        
        while (serverRunning) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        
    }
    return 0;
}
