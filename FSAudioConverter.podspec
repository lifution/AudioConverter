#
# Be sure to run `pod lib lint FSAudioConverter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name      = 'FSAudioConverter'
  s.version   = '1.0.0'
  s.summary   = '基于 libopencore-amr 封装的一个 AMR 和 WAV 格式互转的工具.'
  s.homepage  = 'https://github.com/lifution/AudioConverter'
  s.author    = 'lifution'
  s.license   = { 
    :type => 'MIT', 
    :file => 'LICENSE'
  }
  s.source    = { 
    :git => 'git@github.com:lifution/AudioConverter.git', 
    :tag => s.version.to_s
  }
  
  s.requires_arc = true
  s.ios.deployment_target = '6.0'
  
  s.libraries = 'c++'
  s.source_files = 'FSAudioConverter/Classes/**/*'
  s.ios.frameworks = 'UIKit', 'Foundation'
  s.vendored_libraries = 'FSAudioConverter/Libraries/**/*'
end
