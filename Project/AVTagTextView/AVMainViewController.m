//
//  AVMainViewController.m
//  AVTagTextView
//
//  Created by amb on 07/03/14.
//  Copyright (c) 2014 Arseniy Vershinin. All rights reserved.
//

#import "AVMainViewController.h"

@implementation AVMainViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSegueWithIdentifier:@"demoSegue" sender:nil];
}

@end
