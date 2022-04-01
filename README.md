# AudioConverter
A tool based on `libopencore-amr` package to convert audio between `AMR` format and `WAV` format.

# Requirements:

iOS6.0+, Xcode8.0+

# Installation:
## CocoaPods
To integrate AudioConverter into your Xcode project using CocoaPods, specify it in your Podfile:
```Ruby
pod 'FSAudioConverter'
```
> If you use CocoaPods to install, you cannot use `use_frameworks!`, it must be imported as a static library, otherwise the compilation will fail.
## Manually
If you prefer not to use any of the aforementioned dependency managers, you can integrate FSAudioConverter into your project manually. Download the repository and add the `FSAudioConverter` folder to your project.

# Important:

The currently used `libopencore-amr` libraries does not support Bitcode, so this component is not suitable for use in TARGET with `Enable Bitcode = Yes`. Information related to Bitcode can be found [here](https://developer.apple.com/documentation/xcode/doing-basic-optimization-to-reduce-your-app-s-size).

# Usage：

```objective-c
import "AudioConverter.h"

// Convert amr to wav format.
[AudioConverter convertAmrToWavAtPath:<#amrFilePath#> wavSavePath:<#wavSavePath#> asynchronize:<#asynchronize#> completion:^(BOOL success, NSString * _Nullable resultPath) {

}];

// Convert wav to amr format.
[AudioConverter convertWavToAmrAtPath:<#wavFilePath#> amrSavePath:<#amrSavePath#> asynchronize:<#asynchronize#> completion:^(BOOL success, NSString * _Nullable resultPath) {

}];
```

# LICENSE
AudioConverter is released under the MIT license. [See LICENSE](https://github.com/lifution/AudioConverter/blob/master/LICENSE) for details.