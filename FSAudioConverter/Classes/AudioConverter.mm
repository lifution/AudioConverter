//
//  AudioConverter.m
//  AmrToWav
//
//  Created by AllenLee on 2017/6/10.
//  Copyright © 2017年 Allen Lee. All rights reserved.
//

#import "AudioConverter.h"
#import "amrFileCodec.h"

@implementation AudioConverter

+ (void)convertAmrToWavAtPath:(NSString *)amrFilePath
                  wavSavePath:(NSString *)resultSavePath
                 asynchronize:(BOOL)asynchronize
                   completion:(void(^_Nullable)(BOOL success, NSString *resultPath))completion
{
    NSString *amrPath = [amrFilePath copy];
    NSString *resultPath = [resultSavePath copy];
    
    BOOL(^convert)(NSString *amrFilePath, NSString *resultSavePath) = ^BOOL(NSString *amrFilePath, NSString *resultSavePath){
        const char *amrPath = [amrFilePath cStringUsingEncoding:NSASCIIStringEncoding];
        const char *resultPath = [resultSavePath cStringUsingEncoding:NSASCIIStringEncoding];
        return DecodeAMRFileToWAVEFile(amrPath, resultPath);
    };
    
    if (asynchronize) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            BOOL result = convert(amrPath, resultPath);
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(result, resultPath);
                });
            }
        });
    }
    else {
        BOOL result = convert(amrPath, resultPath);
        if (completion) {
            completion(result, resultPath);
        }
    }
}

+ (void)convertWavToAmrAtPath:(NSString *)wavFilePath
                  amrSavePath:(NSString *)resultSavePath
                 asynchronize:(BOOL)asynchronize
                   completion:(void(^_Nullable)(BOOL success, NSString *resultPath))completion
{
    NSString *wavPath = [wavFilePath copy];
    NSString *resultPath = [resultSavePath copy];
    
    BOOL(^convert)(NSString *wavFilePath, NSString *resultSavePath) = ^BOOL(NSString *wavFilePath, NSString *resultSavePath){
        const char *wavPath = [wavFilePath cStringUsingEncoding:NSASCIIStringEncoding];
        const char *resultPath = [resultSavePath cStringUsingEncoding:NSASCIIStringEncoding];
        return EncodeWAVEFileToAMRFile(wavPath, resultPath, 1, 16);
    };
    
    if (asynchronize) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            BOOL result = convert(wavPath, resultPath);
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(result, resultPath);
                });
            }
        });
    }
    else {
        BOOL result = convert(wavPath, resultPath);
        if (completion) {
            completion(result, resultPath);
        }
    }
}

@end
