# AudioConverter
#### 基于 `libopencore-amr` 封装的一个把音频在 `AMR` 格式和 `WAV` 格式互转的工具.

#### 系统要求:

该项目最低支持 `iOS 6.0` 和 `Xcode 8.0`.

#### 使用方法:

把项目下的 `AudioConverter` 文件夹拖到你的项目中, 然后 `import "AudioConverter.h"`.

具体转化操作参照以下代码:

```objective-c
// 把 amr 格式的音频文件转化为 wav 格式的音频文件
[AudioConverter convertAmrToWavAtPath:<#amrFilePath#> wavSavePath:<#wavSavePath#> synchronize:<#synchronize#> completion:^(BOOL success, NSString * _Nullable resultPath) {
  	
}];

// 把 wav 格式的音频文件转化为 amr 格式的音频文件
[AudioConverter convertWavToAmrAtPath:<#wavFilePath#> amrSavePath:<#amrSavePath#> synchronize:<#synchronize#> completion:^(BOOL success, NSString * _Nullable resultPath) {
    
}];
```

#### LICENSE

AudioConverter使用 MIT 许可证，详情见 LICENSE 文件.