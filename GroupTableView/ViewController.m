//
//  ViewController.m
//  GroupTableView
//
//  Created by Xummer on 3/18/14.
//  Copyright (c) 2014 Xummer. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

static NSString *cellID = @"CellIdentifier";

@interface ViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation ViewController

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
    self.dataArray = @[
                       @[ @{ @"name" : @"Friends",
                             @"icon" : @"sao_icon" },
                          ],
                       @[ @{ @"name" : @"Scan",
                             @"icon" : @"sao_icon" },
                          @{ @"name" : @"Shake",
                             @"icon" : @"sao_icon" },
                          ],
                       @[ @{ @"name" : @"Around",
                             @"icon" : @"sao_icon" },
                          @{ @"name" : @"MSG",
                             @"icon" : @"sao_icon" },
                          ],
                       @[ @{ @"name" : @"Game",
                             @"icon" : @"sao_icon" },
                          ],
                       
                       ];
}

- (void)setupSubviews {
    self.title = @"Home";
    
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
    NSDictionary *dict = _dataArray[ indexPath.section ][ indexPath.row ];
    cell.textLabel.text = dict[ @"name" ];
    cell.imageView.image = [UIImage imageNamed:dict[ @"icon" ]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0) {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSLog(@"%d", section);
    CGRect frame = tableView.bounds;
    frame.size.height = 60;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    
    frame.size.height = 44;
    frame.origin.y = CGRectGetHeight(view.frame) - CGRectGetHeight(frame);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = _dataArray[ section ][ 0 ][ @"name" ];
    [view addSubview:label];
    
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *dVCtrl = [[DetailViewController alloc] init];
    dVCtrl.title =
    _dataArray[ indexPath.section ][ indexPath.row ][ @"name" ];
    [self.navigationController pushViewController:dVCtrl animated:YES];
}

@end
