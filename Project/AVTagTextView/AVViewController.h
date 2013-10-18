//
//  AVViewController.h
//  AVTagTextView
//
//  Created by Arseniy Vershinin on 9/13/13.
//

#import <UIKit/UIKit.h>

@interface AVViewController : UIViewController<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end
