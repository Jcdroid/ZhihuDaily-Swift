source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target 'ZhihuDaily-Swift' do

pod 'Alamofire', '~> 4.0.1'
pod 'Kingfisher', '~> 3.1.3'
pod 'SnapKit', '~> 3.0.2'
pod 'RxSwift', '~> 3.0.0-rc.1'
pod 'IQKeyboardManagerSwift', '~> 4.0.6'

end

target 'ZhihuDaily-SwiftTests' do

#pod 'Quick', '~> 0.10.0'
#pod 'Nimble', '~> 5.0.0'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
