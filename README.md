# CS52Demo

If you have *any* questions please do not hesitate to email me at nathan.eidelson@gmail.com

I realize that I messed up the naming of the project (using CS51 instead of CS52) but am far too lazy to fix it.

## Instructions to get set up with this project

1. Clone the entire repro (I normally use `git clone https://github.com/nathaneidelson/CS52Demo.git` from terminal) 
2. Open the workspace, and build + run the proejct.

## Instructions to get set up your own project

1. Install CocoaPods using: 
    1. `sudo gem install cocoapods`
    2. If you don't have ruby (and thus `gem`) installed, you'll have to do that first.
2. Create a new Xcode project
2. Navigate to project directory and create a file named `Podfile` containing: 

```
platform :ios, '10.0’ 
inhibit_all_warnings! 
use_frameworks! 
target ‘<Target of your project>' do 
    pod 'Alamofire', '~> 4.2.0’ 
end 
```
_Make sure to actually fill in <Target of your project>_
3. Type `pod install` to install the AFNetworking pod 
4. Close the Xcode project, and open the newly created Xcode workspace
5. Start coding!
