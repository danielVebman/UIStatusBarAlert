# UIStatusBarAlert
A simple, ready out of the box status bar alert

## Usage

Showing the alert could not be easier. One line shows or hides the alert with an animation: `none`, `fade`, or `slide`:

    UIStatusBarAlert.shared.setHidden(:with:)
    
Alternatively, the alert can be shown for a certain duration:

    UIStatusBarAlert.shared.show(for:with:)
    
## Customization

Customization is managed by the `Configuration` class of `UIStatusBarAlert`. The title, tint/text color, background color, and font can all be set:

    let configuration = UIStatusBarAlert.Configuration()
    configuration.backgroundColor = UIColor.red
    configuration.tintColor = UIColor.white
    configuration.title = "Could not access photos"
    configuration.font = UIFont.systemFont(ofSize: 15)
    UIStatusBarAlert.shared.setConfiguration(configuration)
