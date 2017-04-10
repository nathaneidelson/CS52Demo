# CS52Demo

Here is the entire Photo journal demo! In class we only went through the basics of the `NEPhotoLogTableViewController`, and rushed through the `PhotoLog` model. I recommend viewing the `NEPhotoLogDetailViewController` as an example of how to make a view that can both display *and* collect data. Also, take a close look at the storyboard and how it uses constraints to properly layout the `NEPhotoLogDetailViewController`.

If you have *any* questions please do not hesitate to email me at nathan.eidelson@gmail.com

I realize that I messed up the naming of the project (using CS51 instead of CS52) but am far too lazy to fix it.

## Instructions to get set up with this project

1. Clone the entire repro (I normally use `git clone https://github.com/nathaneidelson/CS52Demo.git` from terminal) 
2. Open the workspace, and build + run the proejct.

To see the Airtable that this uses, use this link: https://airtable.com/invite/l?inviteId=invxyS0PwocucIGQw&inviteToken=16475f07c177dbfe67aca0c639a8924d

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
Make sure to actually fill in `<Target of your project>`

3. Type `pod install` to install the AFNetworking pod 
4. Close the Xcode project, and open the newly created Xcode workspace
5. Start coding!
