//
//  AVCustomTagTableViewController.m
//  AVTagTextView
//
//  Created by Arseniy Vershinin on 10/15/13.
//

#import "AVCustomTagTableViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface AVCustomTagTableViewController ()

@end

@implementation AVCustomTagTableViewController

//Add table view header for the sake of the example:
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Tags:";
}

@end
