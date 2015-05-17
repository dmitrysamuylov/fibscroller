//
//  ViewController.h
//  fibscroller
//
//  Created by Dmitry Samuylov on 5/16/15.
//  Copyright (c) 2015 Dima Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *numbers;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

