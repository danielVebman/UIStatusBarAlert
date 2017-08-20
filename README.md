# UIStatusBarAlert
A simple, ready out of the box status bar alert

## Usage

Initialize a `UIStatusBarAlert`, then customize it by setting its `backgroundColor`, `tintColor`, `title`, and `font`. The `Colors` class can be used for some generic (but not harsh like the UIColor built-ins) colors. 

Once the alert is customized, it can be shown by calling its `show(for:with:)` method. The first parameter is the duration in seconds; the second parameter is the animation type, `none`, `fade`, or `slide`. 

    let alert = UIStatusBarAlert()
    alert.backgroundColor = Colors.failureRed
    alert.tintColor = UIColor.white
    alert.title = "Could not access contacts"
    alert.show(for: 3, with: .slide)
