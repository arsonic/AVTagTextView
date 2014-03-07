//
//  AVViewController.m
//  AVTagTextView
//
//  Created by Arseniy Vershinin on 9/13/13.
//

#import "AVViewController.h"

#import <AVTagTextView/UITextView+AVTagTextView.h>
#import "AVCustomTagTableViewController.h"

@interface AVViewController ()<AVTagTextViewDelegate>
@property (nonatomic, strong) NSArray *tagsArray;

@end

@implementation AVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Set up the tags array
    self.tagsArray = @[@"tag1", @"instagram", @"anothertag", @"hmm", @"tag3", @"tag4", @"tag5", @"tag6", @"tag7"];
    
    //Set up the first text view with the default table view
    self.textView.delegate = self;
    self.textView.hashTagsDelegate = self;
    self.textView.hashTagsTableViewHeight = 120.;
    self.textView.keyboardType = UIKeyboardTypeTwitter;
    //Provide a custom implementation of the hash tags table view (optional)
    //self.textView.hashTagsTableViewController = [AVCustomTagTableViewController new];
}

/**
 * As soon as the user enters some symbols after the last '#' sign, this method gets called.
 * Entered symbols are contained in the query string. It is your responsibility to provide 
 * the text view with the list of the corresponding hashtags
 */
- (NSArray *)tagsForQuery:(NSString *)query{
    //Provide the list of tags, you wish to display to the user:
    
    //For example, return the tags, which start with the query string from the predefined array:
    NSPredicate *bPredicate =
    [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", query];
    NSArray *array = [self.tagsArray filteredArrayUsingPredicate:bPredicate];
    
    return array;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        
        //list all the contained tags:
        NSLog(@"Entered tags: %@", [self.textView.hashTags componentsJoinedByString:@" "]);
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
