# CS52Demo

Set up Xcode

1. Install CocoaPods: 
    1. sudo gem install cocoapods 
2. Navigate to project directory and create a file ‘Podfile’ containing: 

```
platform :ios, '10.0’ 
inhibit_all_warnings! 
use_frameworks! 
target ‘<Target of your project>' do 
    pod 'Alamofire', '~> 4.2.0’ 
end 
```

3. Type pod install to install the AFNetworking packages 
4. Close the Xcode project, and open the newly created Xcode workspace
