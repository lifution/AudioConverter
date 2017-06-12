//
//  AudioConverter.h
//  AmrToWav
//
//  Created by AllenLee on 2017/6/10.
//  Copyright © 2017年 Allen Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioConverter : NSObject

/**
 把 amr 格式的音频转化为 wav 格式的音频文件.

 @param amrFilePath    待转化的amr文件的路径
 @param resultSavePath 转化后的wav文件的保存路径
 @param asynchronize   是否异步执行转化, YES代表异步执行, NO代表在调用该方法的当前线程中执行.
 @param completion     转化结束回调 (如果 synchronize 为 YES 则会在 mainThread 中回调, 否则会在调用该方法的线程中回调)
 */
+ (void)convertAmrToWavAtPath:(NSString *)amrFilePath wavSavePath:(NSString *)resultSavePath asynchronize:(BOOL)asynchronize completion:(nullable void(^)(BOOL success, NSString * _Nullable resultPath))completion;

/**
 把 wav 格式的音频转化为 amr 格式的音频文件.
 
 @param wavFilePath    待转化的wav文件的路径
 @param resultSavePath 转化后的wav文件的保存路径
 @param asynchronize   是否异步执行转化, YES代表异步执行, NO代表在调用该方法的当前线程中执行.
 @param completion     转化结束回调 (如果 synchronize 为 YES 则会在 mainThread 中回调, 否则会在调用该方法的线程中回调)
 */
+ (void)convertWavToAmrAtPath:(NSString *)wavFilePath amrSavePath:(NSString *)resultSavePath asynchronize:(BOOL)asynchronize completion:(nullable void(^)(BOOL success, NSString * _Nullable resultPath))completion;

@end

NS_ASSUME_NONNULL_END
