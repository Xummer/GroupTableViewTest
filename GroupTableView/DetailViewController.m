//
//  DetailViewController.m
//  GroupTableView
//
//  Created by Xummer on 3/18/14.
//  Copyright (c) 2014 Xummer. All rights reserved.
//

#import "DetailViewController.h"

static NSString *cellID = @"CellIdentifier";

@interface DetailViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;

@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self laodData];
    [self setupSubviews];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)laodData {
    self.selectedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:-1];
    self.dataArray = @[
                       @[ @"Xummer", @"Will" ],
                       @[ @"AcFun", @"Bilibili", @"Un", @"BlaBla", @"Some Other Web" ]
                       
                       ];
}

- (void)setupSubviews {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray[ section ] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = _dataArray[ indexPath.section ][ indexPath.row ];
    cell.accessoryType = (_selectedIndexPath.section == indexPath.section &&
                          _selectedIndexPath.row == indexPath.row) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedIndexPath != indexPath) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.accessoryType != UITableViewCellAccessoryCheckmark) {
            self.selectedIndexPath = indexPath;
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [_tableView reloadData];
        }
        
    }
    
    [self.navigationController performSelector:@selector(popViewControllerAnimated:)
                                    withObject:@(YES)
                                    afterDelay:.3f];
    
}

@end
