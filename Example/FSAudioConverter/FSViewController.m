//
//  FSViewController.m
//  FSAudioConverter
//
//  Created by Sheng on 05/13/2019.
//  Copyright (c) 2019 Sheng. All rights reserved.
//

#import "FSViewController.h"

#import <FSAudioConverter/AudioConverter.h>

@interface FSViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation FSViewController

- (IBAction)amrToWav:(id)sender
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"amr"];
    NSString *resultPath;
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.timeZone = [NSTimeZone localTimeZone];
        formatter.dateFormat = @"yyyy-MM-dd-HH:mm:ss";
        
        NSString *name = [formatter stringFromDate:[NSDate date]];
        name = [name stringByAppendingString:@".wav"];
        
        resultPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        resultPath = [resultPath stringByAppendingPathComponent:name];
    }
    
    [AudioConverter convertAmrToWavAtPath:filePath
                              wavSavePath:resultPath
                             asynchronize:YES
                               completion:^(BOOL success, NSString *resultPath) {
                                   self.textView.text = [NSString stringWithFormat:@"%@\n\n%@",
                                                         success ? @"convert success" : @"convert fail",
                                                         resultPath];
                               }];
}

- (IBAction)wavToAmr:(id)sender
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"wav"];
    NSString *resultPath;
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.timeZone = [NSTimeZone localTimeZone];
        formatter.dateFormat = @"yyyy-MM-dd-HH:mm:ss";
        
        NSString *name = [formatter stringFromDate:[NSDate date]];
        name = [name stringByAppendingString:@".amr"];
        
        resultPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        resultPath = [resultPath stringByAppendingPathComponent:name];
    }
    
    [AudioConverter convertWavToAmrAtPath:filePath
                              amrSavePath:resultPath
                             asynchronize:YES
                               completion:^(BOOL success, NSString *resultPath) {
                                   self.textView.text = [NSString stringWithFormat:@"%@\n\n%@",
                                                         success ? @"convert success" : @"convert fail",
                                                         resultPath];
                               }];
}


@end
