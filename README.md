# AudioConverter
基于 `libopencore-amr` 封装的一个把音频在 `AMR` 格式和 `WAV` 格式互转的工具.

## 安装要求:

Xcode8.0+, iOS6.0+

## 安装方法:

1. 使用 CocoaPods 安装，在你的 Podfile 中加入 `pod 'FSAudioConverter'`。
   * 需要注意的是，如果使用 CocoaPods 安装则不可使用 `use_frameworks!`，必须以静态库的方式引入，否则在使用的时候会编译不通过。
2. 或者把 `FSAudioConverter` 文件夹直接加入到你的项目中。

## 注意 ⚠️ :

`libopencore-amr` 不支持 Bitcode，因此本组件不适合用在 `Enable Bitcode = Yes` 的 TARGET 中，如果你的项目不需要开启 Bitcode，那么你可以在 `TARGETS` 中找到对应的 TARGET，然后在 `Build Settings` 中搜索 `Enable Bitcode` 并将其设置为 `No`。

## 使用示例：

```objective-c
import "AudioConverter.h"

// 把 amr 格式的音频文件转化为 wav 格式的音频文件。
[AudioConverter convertAmrToWavAtPath:<#amrFilePath#> wavSavePath:<#wavSavePath#> asynchronize:<#asynchronize#> completion:^(BOOL success, NSString * _Nullable resultPath) {
	// 转化结果回调
}];

// 把 wav 格式的音频文件转化为 amr 格式的音频文件。
[AudioConverter convertWavToAmrAtPath:<#wavFilePath#> amrSavePath:<#amrSavePath#> asynchronize:<#asynchronize#> completion:^(BOOL success, NSString * _Nullable resultPath) {
	// 转化结果回调
}];
```

## LICENSE

AudioConverter 使用 MIT 许可证开源，详情可查阅 LICENSE 文件。