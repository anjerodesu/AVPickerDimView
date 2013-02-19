AVPickerDimView *alpha*
===============
`AVPickerDimView` is a simple class combination of `UIView`, `UIActionSheet`, and `UIPickerView`.

![AVPickerDimView](http://www.studiovillegas.com/img/avpickerdimview-screen.png "AVPickerDimView demo screenshot")

Installation
-------------------------------
There are 3 ways to download and import the files to your project:

### Download: ###

1. Using git **subtree** (recommended)
    - `git subtree add --prefix=AVPickerDimView --squash git@github.com:anjerodesu/AVPickerDimView.git master`
2. Using git **submodule**
    - `git submodule add git@github.com:anjerodesu/AVPickerDimView.git AVPickerDimView`
3. Download as **zip**
    - Download the file: [AVPickerDimView Project Page on GitHub](https://github.com/anjerodesu/AVPickerDimView "AVPickerDimView")
    - Unzip the folder and put it inside your project with the **.xcodeproj** file

After downloading and importing the files to your project folder, your next step is setting it up:

### Xcode: ###

- Drag and drop **AVPickerDimView-Demo.xcodeproj** to your project (either root or under the Frameworks group)
- Project configuration:
    - **Build Phases:**
        - Add **AVPickerDimView** as a Target Dependency
        - Add **libAVPickerDimView.a** in the Link Binaries With Library
    - **Build Settings:**
        - Locate **User Header Search Paths** and add **${PROJECT_DIR}/AVPickerDimView** and choose **recursive**.
        - Locate **Always Search User Paths** and set it to **YES**.
        - Locate **Other Linker Flags** and add the value `-ObjC`.
- Import the library to your project using `#import <AVPickerDimView/AVPickerKit.h>`


Usage
-------------------------------
#### Object initialisation: ####

    AVPickerDimView *pickerDimView = [[AVPickerDimView alloc] initWithFrame: self.view.bounds];
    pickerDimView.dataSource = self;
    pickerDimView.delegate = self;

    [self.view addSubview: pickerDimView];

#### Checking if AVPickerDimView is present: ####

    [pickerDimView isAVPickerPresent]

#### Showing and Hiding AVPickerDimView ####

    if ( [pickerDimView isAVPickerPresent] )
    {
    	[pickerDimView hideAVPickerDimView];
    }
    else
    {
    	[pickerDimView showAVPickerDimView];
    }

License
-
AVPickerDimView is available under the [MIT license](https://github.com/anjerodesu/AVPickerDimView/blob/master/LICENSE "LICENSE").
