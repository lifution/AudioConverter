//
//  ViewController.m
//  AmrToWav
//
//  Created by AllenLee on 2017/6/10.
//  Copyright © 2017年 Allen Lee. All rights reserved.
//

#import "ViewController.h"
#import "AudioConverter.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *recordFilePathLabel;
@property (weak, nonatomic) IBOutlet UILabel *amrFilePathLabel;
@property (weak, nonatomic) IBOutlet UILabel *wavFilePathLabel;

@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@property (copy, nonatomic) NSString *recordFilePath;
@property (copy, nonatomic) NSString *amrFilePath;
@property (copy, nonatomic) NSString *wavFilePath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)recordingAnimation {
    NSString *title = [_startButton titleForState:UIControlStateNormal];
    if ([title hasPrefix:@"录音中"]) {
        if ([title isEqualToString:@"录音中."]) {
            title = @"录音中..";
        } else if ([title isEqualToString:@"录音中.."]) {
            title = @"录音中...";
        } else if ([title isEqualToString:@"录音中..."]) {
            title = @"录音中.";
        }
        [_startButton setTitle:title forState:UIControlStateNormal];
        [self performSelector:@selector(recordingAnimation) withObject:nil afterDelay:1.f];
    }
}

- (IBAction)startRecording:(id)sender {
    _startButton.userInteractionEnabled = NO;
    [_startButton setTitle:@"录音中." forState:UIControlStateNormal];
    [self performSelector:@selector(recordingAnimation) withObject:nil afterDelay:1.f];
    
    // 录音
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    [audioSession setActive:YES error:nil];
    
    // 录音文件路径
    _recordFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _recordFilePath = [_recordFilePath stringByAppendingPathComponent:@"recordFile.wav"];
    _wavFilePath = [_recordFilePath copy];
    NSDictionary *recordFormat = @{AVSampleRateKey : @(8000.f),
                                   AVFormatIDKey : @(kAudioFormatLinearPCM),
                                   AVLinearPCMBitDepthKey : @(16),
                                   AVNumberOfChannelsKey : @(1),
                                   AVEncoderAudioQualityKey : @(AVAudioQualityHigh)};
    _audioRecorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:_recordFilePath] settings:recordFormat error:nil];
    _audioRecorder.meteringEnabled = YES;
    [_audioRecorder prepareToRecord];
    [_audioRecorder record];
}

- (IBAction)endRecording:(id)sender {
    _startButton.userInteractionEnabled = YES;
    [_startButton setTitle:@"开始录音" forState:UIControlStateNormal];
    
    [_audioRecorder stop];
    _recordFilePathLabel.text = _recordFilePath;
}

// amr -> wav
- (IBAction)amrTowavAction:(id)sender {
    if (![[NSFileManager defaultManager] fileExistsAtPath:_amrFilePath]) {
        _wavFilePathLabel.text = @"没有amr文件, 请先录音然后转化为amr";
        return;
    }
    
    NSString *wavSavePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    wavSavePath = [wavSavePath stringByAppendingPathComponent:@"convertToWav.wav"];
    [AudioConverter convertAmrToWavAtPath:_amrFilePath wavSavePath:wavSavePath asynchronize:YES completion:^(BOOL success, NSString * _Nullable resultPath) {
        if (success) {
            _wavFilePath = resultPath;
            _wavFilePathLabel.text = _wavFilePath;
        } else {
            _wavFilePathLabel.text = @"amr转wav失败!!";
        }
    }];
}

// 播放转化后的 wav 文件
- (IBAction)playConvertResultOfWav:(id)sender {
    if (![[NSFileManager defaultManager] fileExistsAtPath:_wavFilePath]) {
        _wavFilePathLabel.text = @"没有wav文件, 请先录音";
        return;
    }
    if (_audioPlayer) {
        [_audioPlayer stop];
        _audioPlayer = nil;
    }
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:_wavFilePath] error:nil];
    [_audioPlayer prepareToPlay];
    [_audioPlayer play];
}

// wav -> amr
- (IBAction)wavToamrAction:(id)sender {
    if (![[NSFileManager defaultManager] fileExistsAtPath:_wavFilePath]) {
        _amrFilePathLabel.text = @"没有wav文件, 请先录音";
        return;
    }
    
    NSString *amrSavePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    amrSavePath = [amrSavePath stringByAppendingPathComponent:@"convertToAmr.amr"];
    [AudioConverter convertWavToAmrAtPath:_wavFilePath amrSavePath:amrSavePath asynchronize:YES completion:^(BOOL success, NSString * _Nullable resultPath) {
        if (success) {
            _amrFilePath = resultPath;
            _amrFilePathLabel.text = _amrFilePath;
        } else {
            _amrFilePathLabel.text = @"wav转amr失败!!";
        }
    }];
}

@end
