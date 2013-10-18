//
//  AVTagTextViewSpec.m
//  AVTagTextViewSpec
//
//  Created by Arseniy Vershinin on 9/13/13.
//

#import <Kiwi/Kiwi.h>

#import "UITextView+AVTagTextView.h"
#import "AVHashTagsTableViewController.h"

#import <ReactiveCocoa/NSNotificationCenter+RACSupport.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

#define DEFAULT_KEYBOARD_SIZE 216.

SPEC_BEGIN(AVTagTextViewSpec)

describe(@"AVTagTextView", ^{
    
    __block UITextView *textView = nil;
    
    beforeEach(^{
        textView = [UITextView new];
    });
    
    it(@"should contain all the hash tagged words", ^{
        textView.text = @"this# ##is#tag # a #tag string";
        
        NSArray *hashTags = @[@"is", @"tag", @"tag"];
        [[textView.hashTags should] equal:hashTags];
    });
    
    context(@"when user types in text after # symbol", ^{
        
        __block NSObject<AVTagTextViewDelegate> *hashTagsDelegate = nil;
        
        beforeEach(^{
            hashTagsDelegate = [KWMock mockForProtocol:@protocol(AVTagTextViewDelegate)];
            textView.hashTagsDelegate = hashTagsDelegate;
            textView.text = @"text";
        });
        
        it(@"should associate a hash tags deleagate with the text view", ^{
            [[(NSObject<AVTagTextViewDelegate> *)textView.hashTagsDelegate should] equal:hashTagsDelegate];
        });
        
        it(@"should request hashtags when last hashtag text changes", ^{
            textView.text = @"no tags so far #yet#ueee";
            [[hashTagsDelegate should] receive:@selector(tagsForQuery:) andReturn:nil withArguments:@"ueeett"];
            [textView simulteUserInput:@"tt"];
        });
        
        it(@"shouldn't request hashtags when entered text doesnt belong to a hashtag", ^{
            textView.text = @"some #text and #some #more";
            [[hashTagsDelegate shouldNot] receive:@selector(tagsForQuery:)];
            [textView simulteUserInput:@" tt"];
        });
        
        context(@"a table view with hashtags should be shown so that", ^{
            
            __block NSArray *foundHashTags = @[@"tag1", @"tag2", @"tag3"];
            __block UITableViewController<AVTagTableViewControllerProtocol> *tableViewController;
            
            beforeEach(^{
                [hashTagsDelegate stub:@selector(tagsForQuery:) andReturn:foundHashTags];
                tableViewController = [AVHashTagsTableViewController new];
                textView.hashTagsTableViewController = tableViewController;
            });
            
            it(@"is filled with hashtags, provided by the delegate", ^{
                [textView simulteUserInput:@" #tag"];

                [[tableViewController shouldNot] beNil];
                [[theValue([tableViewController tableView:tableViewController.tableView numberOfRowsInSection:0]) should] equal:theValue(foundHashTags.count)];
                [[theValue(tableViewController.view.hidden) should] beFalse];
            });
            
            it(@"should be hide hidden when no hashtags were provided by the delegate", ^{
                [hashTagsDelegate stub:@selector(tagsForQuery:) andReturn:nil];
                [textView simulteUserInput:@" #tag"];
                
                [[theValue(textView.hashTagsTableViewController.view.hidden) should] beTrue];
            });
            
            it(@"should be hidden when the input string doesn't end with a hashtag", ^{
                tableViewController.view.hidden = NO;
                [textView simulteUserInput:@"#tag r"];
                [[theValue(tableViewController.view.hidden) should] beTrue];
            });
            
            it(@"gets hidden when the keyboard is being hidden", ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillHideNotification object:nil];
                
                [[theValue(textView.hashTagsTableViewController.view.hidden) shouldEventually] beTrue];
            });
            
            it(@"should has a proper frame set up when the keyboard is being shown the first time", ^{
                textView.hashTagsTableViewHeight = 200.;
                
                CGRect keyboardRect = CGRectMake(0., 264., 320., 216.);
                NSValue *keyboardSizeValue = [NSValue valueWithCGRect:keyboardRect];
                [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardDidShowNotification
                                                                    object:nil
                                                                  userInfo:@{UIKeyboardFrameBeginUserInfoKey: keyboardSizeValue}];
                
                [[theValue(tableViewController.tableView.frame) should] equal:theValue(CGRectMake(0., keyboardRect.origin.y - keyboardRect.size.height - textView.hashTagsTableViewHeight, 320., textView.hashTagsTableViewHeight))];
            });
            
            it(@"should replace the last edited tag with the selected one when a cell gets tapped and hide itself", ^{
                [textView simulteUserInput:@" #tag"];
                
                NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
                [textView.hashTagsTableViewController tableView:textView.hashTagsTableViewController.tableView didSelectRowAtIndexPath:selectedIndexPath];
                
                //TODO: the trailing white space doesnt get picked up by the text property (should be "text #tag2 ")
                [[textView.text should] equal:@"text #tag2 "];
                [[[textView.hashTags lastObject] should] equal:@"tag2"];
                [[theValue(tableViewController.view.hidden) should] beTrue];
            });
            
        });
        
    });
    
});

SPEC_END