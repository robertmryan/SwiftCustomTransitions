## Swift 3 Custom Transitions Demonstration

This is an demonstration of using custom transitions in Swift 3, including interactive transitions and presentation controllers.

See WWDC 2013 video [Custom Transitions Using View Controllers.](https://developer.apple.com/videos/wwdc/2013/?id=218), which shows an example of precisely this. For a discussion of presentation controllers, see WWDC 2014 videos [View Controller Advancements in iOS 8](https://developer.apple.com/videos/wwdc/2014/?id=214) and [A Look Inside Presentation Controllers](https://developer.apple.com/videos/wwdc/2014/?id=228). This is a Swift 3 implementation.

This branch does a swipe from right edge to animate the presentation of a view on the right edge of screen, but does not completely cover the presenting view. So, this changes the gestures accordingly and does the animation from the right to left. Also the presentation controller:

- Leaves the presenting view (so we can see it under the presented view controller); and
- Manages the chrome associated with a "dimming view" to dim the presenting view (so it makes it clear you're interacting with the new view controller on the right).

![example image](http://i.imgur.com/bpRGMZt.gif)

See http://stackoverflow.com/a/42213998/1271826.

This was developed in Swift 3 on Xcode 8.3.3 for iOS 10.3.1. But, the basic ideas are equally applicable for different versions of Swift and/or Objective-C. The use of presentation controller requires iOS 8 or later.

## License

Copyright &copy; 2017 Robert Ryan. All rights reserved.

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

--

13 February 2017
