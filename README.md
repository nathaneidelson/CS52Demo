# CS52Demo

Thanks for listening! If you have *any* questions please do not hesitate to email me at nathan.eidelson@gmail.com

## Instructions to get set up with this project

1. Clone the entire repro (I normally would use `git clone https://github.com/nathaneidelson/CS52Demo.git` from terminal) 
2. Open the worksapce, and build + run the proejct.

## Instructions to get set up your own project

Set up Xcode

1. Install CocoaPods using: 
    1. `sudo gem install cocoapods`
2. Navigate to project directory and create a file ‘Podfile’ containing: 

```
platform :ios, '10.0’ 
inhibit_all_warnings! 
use_frameworks! 
target ‘<Target of your project>' do 
    pod 'Alamofire', '~> 4.2.0’ 
end 
```

3. Type `pod install` to install the AFNetworking pod 
4. Close the Xcode project, and open the newly created Xcode workspace
5. Start coding!
