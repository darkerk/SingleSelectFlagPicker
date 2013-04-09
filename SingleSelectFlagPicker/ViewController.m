//
//  ViewController.m
//  SingleSelectFlagPicker
//
//  Created by wangguohui on 13-4-9.
//  Copyright (c) 2013年 TuShengNetWork. All rights reserved.
//

#import "ViewController.h"
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *_pickerView;
    NSArray *_provinces;
    NSMutableArray *_rowArr;
}
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
	// Do any additional setup after loading the view.
    
    _provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvincesCities.plist" ofType:nil]];
    _rowArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    _pickerView = [[UIPickerView alloc] init];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    
    _pickerView.center = self.view.center;
    [self.view addSubview:_pickerView];
    
    [self showImageViewForRow:0 show:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_provinces release],_provinces=nil;
    [_rowArr release],_rowArr=nil;
    _pickerView.delegate = nil;
    _pickerView.dataSource = nil;
    [_pickerView release],_pickerView = nil;
    [super dealloc];
}


- (void)showImageViewForRow:(NSInteger)row show:(BOOL)show{
    UIView *bgView = [_pickerView viewForRow:row forComponent:0];
    UIImageView *imgView = (UIImageView *)[bgView viewWithTag:102];
    imgView.hidden = !show;
    
    UILabel *label = (UILabel *)[bgView viewWithTag:101];
    label.textColor = show? RGBCOLOR(55, 77, 133):[UIColor blackColor];
}

#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_provinces count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)theView
{
    UIView *bgView = theView;
    if (!bgView) {
        bgView=[[[UIView alloc] initWithFrame:CGRectZero] autorelease];
        bgView.tag = row;
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(40, 10, 240, 30)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:[UIFont boldSystemFontOfSize:20]];
        label.tag = 101;
        [bgView addSubview:label];
        [label release];
        
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 15, 15)];
        [imgView setImage:[UIImage imageNamed:@"UIPickerChecked.png"]];
        imgView.tag = 102;
        [bgView addSubview:imgView];
        [imgView release];
        
        [_rowArr addObject:bgView];
    }
    UILabel *lbl = (UILabel *)[bgView viewWithTag:101];
    lbl.textColor = [UIColor blackColor];
    lbl.text = [[_provinces objectAtIndex:row] objectForKey:@"State"];
    
    UIImageView *imgView = (UIImageView *)[bgView viewWithTag:102];
    imgView.hidden = YES;
    
    return bgView;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    for (UIView *view in _rowArr) {
        UILabel *label = (UILabel *)[view viewWithTag:101];
        UIImageView *imgView = (UIImageView *)[view viewWithTag:102];
        label.textColor = view.tag==row ? RGBCOLOR(55, 77, 133):[UIColor blackColor];
        imgView.hidden = view.tag==row?NO:YES;
    }
    [self showImageViewForRow:row show:YES];
}


@end
