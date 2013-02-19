//
//  AVViewController.m
//  AVPickerDimView
//
//  Created by Angelo Villegas on 8/1/12.
//  Copyright (c) 2012 Angelo Villegas. All rights reserved.
//

#import "AVViewController.h"
#import <AVPickerKit.h>

@interface AVViewController () <AVPickerDimViewDataSource, AVPickerDimViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (strong, nonatomic) AVPickerDimView *pickerDimView;

@property (strong, nonatomic) NSArray *pickerTitles;

- (IBAction)showButtonPressed:(id)sender;

@end

@implementation AVViewController

@synthesize showButton = _showButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	_pickerTitles = @[ @"Sample 1" , @"Sample 2" , @"Sample 3" , @"Sample 4" , @"Sample 5" ];
	
	_pickerDimView = [[AVPickerDimView alloc] initWithFrame: self.view.frame];
	_pickerDimView.dataSource = self;
	_pickerDimView.delegate = self;
	
	[self.view addSubview: _pickerDimView];
}

- (void)viewDidUnload
{
	[self setShowButton: nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )
	{
	    return ( interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown );
	}
	else
	{
	    return YES;
	}
}

#pragma mark - AVPickerDimView data source
- (NSInteger)numberOfComponentsInAVPicker
{
	return 1;
}

- (NSInteger)numberOfRowsInAVPickerComponent:(NSInteger)component
{
	return [_pickerTitles count];
}

- (NSString *)avPickerTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *string = _pickerTitles[row];
	return string;
}

#pragma mark - AVPickerDimView delegate
- (void)avPickerDidSelectWithComponentPaths:(NSArray *)indexPaths
{
	NSInteger row = [(AVIndexPath *)indexPaths[0] row];
	NSLog( @"%s [Line %d] selected object: %@" , __FUNCTION__ , __LINE__ , _pickerTitles[row] );
	NSLog( @"%s [Line %d] indexPaths: %@" , __FUNCTION__ , __LINE__ , indexPaths );
}

- (NSAttributedString *)avPickerAttributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: _pickerTitles[row]];
	
	if ( row % 2 == 0 )
	{
		[attributedString addAttribute: NSForegroundColorAttributeName value: [UIColor redColor] range: NSMakeRange( 0 , 3 )];
		[attributedString addAttribute: NSForegroundColorAttributeName value: [UIColor greenColor] range: NSMakeRange( 3 , 3 )];
		[attributedString addAttribute: NSForegroundColorAttributeName value: [UIColor blueColor] range: NSMakeRange( 6 , 2 )];
	}
	
	return attributedString;
}

#pragma mark - Custom methods
- (IBAction)showButtonPressed:(id)sender
{
	if ( [_pickerDimView isAVPickerPresent] )
	{
		[_pickerDimView hideAVPickerDimView];
	}
	else
	{
		[_pickerDimView showAVPickerDimView];
	}
}

@end
