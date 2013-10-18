# AVTagTextView

[![Version](http://cocoapod-badges.herokuapp.com/v/AVTagTextView/badge.png)](http://cocoadocs.org/docsets/AVTagTextView)
[![Platform](http://cocoapod-badges.herokuapp.com/p/AVTagTextView/badge.png)](http://cocoadocs.org/docsets/AVTagTextView)

A category that adds an instragram-like hashtag choosing/listing capability to the UITextView.

![Screencapture GIF](https://dl.dropboxusercontent.com/u/31058381/OpenSource/AVTagTextView/out.gif)

## Installation

AVTagTextView is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "AVTagTextView"

Alternatively you can drop the "Classes" folder into your project that should have the [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) library installed

Import the category int the wished file:

```objc
#import <AVTagTextView/UITextView+AVTagTextView.h>
```

## Usage

Assign the hashTagsDelegate property to the desired delegate and implement the tagsForQuery method:

```objc
self.textView.hashTagsDelegate = self;
//...

/**
 * As soon as the user enters some symbols after the last '#' sign, this method gets called.
 * Entered symbols are contained in the query string. It is your responsibility to provide 
 * the text view with the list of the corresponding hashtags as an array of strings:
 */
- (NSArray *)tagsForQuery:(NSString *)query{
    //Provide the list of the tag, you wish to display to the user:
    
    //For example, return the tags, which start with the query string, from the predefined array:
    NSPredicate *bPredicate =
    [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", query];
    NSArray *array = [self.tagsArray filteredArrayUsingPredicate:bPredicate];
    
    return array;
}
```

Hashtags, contained in the UITextView, can be accessed through its hashTags property:

```objc
self.textView.hashTags //returns an array of strings, corresponding to the hash tags, found in the UITextView's text
```

The default UITableViewController that displays the tags can be replaced with your custom UITableViewController implementation that has to conform to the [AVTagTableViewProtocol](https://github.com/arsonic/AVTagTextView/blob/master/Classes/AVTagTableViewProtocol.h). See the exemplary [AVCustomTagTableViewController](https://github.com/arsonic/AVTagTextView/blob/master/Project/AVCustomTagTableViewController.h) class.

## Example

To run the example project; clone the repo, and run `pod install` from the Project directory first.

## Requirements

+ [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa). The category strongly relies on the capabilities of ReactiveCocoa library to react on the user's input and to properly handle the keyboard's hiding/showing notifications.
+ iOS 6.1 or greater

## Tests

The project includes a [Kiwi](https://github.com/allending/Kiwi) spec that can be found in the Tests folder

## TODO

1. Remove ReactiveCocoa as a dependency.

## Author

Arseniy Vershinin

## License

AVTagTextView is available under the MIT license. See the LICENSE file for more info.


