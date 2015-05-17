//
//  ViewController.m
//  fibscroller
//
//  Created by Dmitry Samuylov on 5/16/15.
//  Copyright (c) 2015 Dima Interactive. All rights reserved.
//

#import <CoreFoundation/CoreFoundation.h>
#import "ViewController.h"
#import "JKBigInteger.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _numbers = @[].mutableCopy;
    
    for(int i = 0; i < 15; i++)
    {
        [self addFibbonacciNumberFromIndex:(NSInteger)i];
    }
    
    [_table reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.numbers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // grab previously generated number for index
    JKBigInteger *number = _numbers[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NumberCell"];
    cell.textLabel.text = number.description;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // we don't have a number for this index yet, generate a batch
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self addFibbonacciNumberFromIndex:(NSInteger)_numbers.count-1];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [_table reloadData];
        });
    });
}

#pragma mark - private methods

-(void)addFibbonacciNumberFromIndex:(NSInteger)index
{
    if (index == 0)
    {
        [_numbers addObject:[[JKBigInteger new] initWithString:@"0"]];
        return;
    }
    if (index == 1 || index == 2)
    {
        [_numbers addObject:[[JKBigInteger new] initWithString:@"1"]];
        return;
    }
    
    JKBigInteger *previous = [_numbers objectAtIndex:((int)index - 2)];
    JKBigInteger *current = [_numbers objectAtIndex:(int)index - 1];
    JKBigInteger *fibbnumber = nil;
    
    fibbnumber = [previous add:current];
    previous = current;
    current = fibbnumber;
    
    [_numbers addObject:fibbnumber];
}

@end
