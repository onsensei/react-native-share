//
//  LineShare.m
//  RNShare
//
//  Created by Wiwat Patanaprasitchai on 5/6/2561 BE.
//  Copyright © 2561 Facebook. All rights reserved.
//

#import "LineShare.h"

@implementation LineShare

- (void)shareSingle:(NSDictionary *)options
    failureCallback:(RCTResponseErrorBlock)failureCallback
    successCallback:(RCTResponseSenderBlock)successCallback
{
    NSLog(@"Try open view");
    if ([options objectForKey:@"message"] && [options objectForKey:@"message"] != [NSNull null])
    {
        NSLog(@"Try open view");
        NSString *message = [RCTConvert NSString:options[@"message"]];
        message = [message stringByAppendingString: [@" " stringByAppendingString: options[@"url"]] ];
        
        NSString * urlString = [NSString stringWithFormat:@"line://msg/text/?%@", message ];
        NSLog(urlString);
        NSURL * shareURL = [NSURL URLWithString:urlString];
        NSString* webStringURL = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL* url = [NSURL URLWithString:webStringURL];
        
        if ([[UIApplication sharedApplication] canOpenURL: url])
        {
            [[UIApplication sharedApplication] openURL: url];
            successCallback(@[]);
        }
        else
        {
            // Cannot open email
            NSString *errorMessage = @"Not installed";
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedString(errorMessage, nil)};
            NSError *error = [NSError errorWithDomain:@"com.rnshare" code:1 userInfo:userInfo];
            NSLog(errorMessage);
            failureCallback(error);
        }
    }
}

@end
