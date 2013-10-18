//
//  AVCustomTagTableViewController.h
//  AVTagTextView
//
//  Created by Arseniy Vershinin on 10/15/13.
//

#import <UIKit/UIKit.h>
#import "AVTagTextView/AVHashTagsTableViewController.h"

/**
 * An examplary implementation of the custom table view
 * controller for displaying the tags. The implementation
 * has to conform to the AVTagTableViewControllerProtocol. For the
 * sake of simplicity, the controller is being inherited
 * from the simpliest implementation of the protocol -
 * AVHashTagsTableViewController
 */

@interface AVCustomTagTableViewController : AVHashTagsTableViewController

@end
