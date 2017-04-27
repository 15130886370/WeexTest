source 'https://github.com/CocoaPods/Specs.git'
platform :ios, ‘9.0’

target 'WeexTest' do
  use_frameworks!
  pod 'SnapKit', '~> 3.0'
  pod 'Then', '~> 2.1'
  pod 'SDWebImage', '3.7.5'
  pod 'RxSwift', '~> 3.0'
  pod 'RxCocoa', '~> 3.0'
  pod 'RxDataSources', '~> 1.0'
  pod 'SocketRocket'
  pod 'WeexSDK', ‘0.11.0’
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
