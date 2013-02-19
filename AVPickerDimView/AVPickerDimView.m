//
//  AVPickerviewDim.m
//  AVPickerviewDim
//
//  Created by Angelo Villegas on 9/10/11.
//  Copyright (c) 2012 Angelo Villegas. All rights reserved.
//

#import "AVPickerDimView.h"
#import "AVPickerGlobal.h"
#import "AVIndexPath.h"

static CGFloat kPickerAnimationDuration = 0.5f;

@interface AVPickerDimView () <NSCoding, UIPickerViewDataSource, UIPickerViewDelegate>

// view objects
// picker view
@property (strong, nonatomic) UIPickerView *pickerView;

@property (strong, nonatomic) UISegmentedControl *selectButton;
@property (strong, nonatomic) UISegmentedControl *cancelButton;

// object properties
// view
// dim view background color
@property (strong, nonatomic) UIColor *dimColor;

- (void)selectButtonPressed;
- (void)cancelButtonPressed;

@end

@implementation AVPickerDimView

@synthesize AVPickerPresent;

// object properties
// view
@synthesize dimColor;

#pragma mark - Initialisation
- (id)init
{
	return [self initWithFrame: AVApplicationFrame()];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	return [self initWithFrame: AVApplicationFrame()];
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame: frame];
	
    if ( self )
	{
		// self.userInteractionEnabled = YES;
		self.isAccessibilityElement = YES;
		self.clipsToBounds = YES;
		self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		self.hidden = YES;
		self.backgroundColor = [UIColor colorWithWhite: 0.0 alpha: 0.8];
		
		AVPickerPresent = NO;
		
		_actionSheet = [[UIActionSheet alloc] initWithFrame: CGRectMake( 0 , self.frame.size.height , self.frame.size.width , 265 )];
		_actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
		_actionSheet.userInteractionEnabled = YES;
		_actionSheet.exclusiveTouch = YES;
		
		_pickerView = [[UIPickerView alloc] initWithFrame: CGRectMake( 0 , 50 , self.frame.size.width , 216 )];
		_pickerView.showsSelectionIndicator = YES;
		_pickerView.dataSource = self;
		_pickerView.delegate = self;
		
		_selectButton = [[UISegmentedControl alloc] initWithItems: [NSArray arrayWithObject: @"Select"]];
		_selectButton.momentary = YES;
		_selectButton.frame = CGRectMake( ( self.frame.size.width - 60 ) , 10 , 50 , 30 );
		_selectButton.segmentedControlStyle = UISegmentedControlStyleBar;
		_selectButton.tintColor = [UIColor blueColor];
		[_selectButton addTarget: self action: @selector(selectButtonPressed) forControlEvents: UIControlEventValueChanged];
		
		_cancelButton = [[UISegmentedControl alloc] initWithItems: [NSArray arrayWithObject: @"Cancel"]];
		_cancelButton.momentary = YES;
		_cancelButton.frame = CGRectMake( 10 , 10 , 50 , 30 );
		_cancelButton.segmentedControlStyle = UISegmentedControlStyleBar;
		_cancelButton.tintColor = [UIColor blackColor];
		[_cancelButton addTarget: self action: @selector(cancelButtonPressed) forControlEvents: UIControlEventValueChanged];
		
		[_actionSheet addSubview: _pickerView];
		[_actionSheet addSubview: _selectButton];
		[_actionSheet addSubview: _cancelButton];
		[self addSubview: _actionSheet];
    }
	
    return self;
}

#pragma mark - Show / Hide picker dim view
- (void)showAVPickerDimView
{
	AVPickerPresent = YES;
	
	if ( [[UIView class] respondsToSelector: @selector(animateWithDuration:animations:)] )
	{
		self.hidden = NO;
		[UIView animateWithDuration: kPickerAnimationDuration animations: ^{
			_actionSheet.frame = CGRectMake( _actionSheet.frame.origin.x , ( self.frame.size.height - _actionSheet.frame.size.height ) , _actionSheet.frame.size.width , _actionSheet.frame.size.height );
		}];
	}
	else
	{
		self.hidden = NO;
		
		[UIView beginAnimations: nil context: NULL];
		[UIView setAnimationDuration: kPickerAnimationDuration];
		[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
		
		_actionSheet.frame = CGRectMake( _actionSheet.frame.origin.x , ( self.frame.size.height - _actionSheet.frame.size.height ) , _actionSheet.frame.size.width , _actionSheet.frame.size.height );
		
		[UIView commitAnimations];
	}
}

- (void)hideAVPickerDimView
{
	AVPickerPresent = NO;
	
	if ([[UIView class] respondsToSelector: @selector(animateWithDuration:animations:)])
	{
		[UIView animateWithDuration: kPickerAnimationDuration animations: ^{
			_actionSheet.frame = CGRectMake( _actionSheet.frame.origin.x , self.frame.size.height , _actionSheet.frame.size.width , _actionSheet.frame.size.height );
		} completion: ^(BOOL finished) {
			self.hidden = YES;
		}];
	}
	else
	{
		[UIView beginAnimations: nil context: NULL];
		[UIView setAnimationDuration: kPickerAnimationDuration];
		[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
		
		_actionSheet.frame = CGRectMake( _actionSheet.frame.origin.x , self.frame.size.height , _actionSheet.frame.size.width , _actionSheet.frame.size.height );
		
		[UIView commitAnimations];
		
		self.hidden = YES;
	}
}

- (void)dismiss:(BOOL)animated
{
	[_actionSheet dismissWithClickedButtonIndex: -1 animated: YES];
}

#pragma mark - Picker View Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	if ( [_dataSource respondsToSelector: @selector(numberOfComponentsInAVPicker)] )
	{
		return [_dataSource numberOfComponentsInAVPicker];
	}
	else
	{
		return 0;
	}
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if ( [_dataSource respondsToSelector: @selector(numberOfRowsInAVPickerComponent:)] )
	{
		return [_dataSource numberOfRowsInAVPickerComponent: component];
	}
	else
	{
		return 0;
	}
}

#pragma mark - Picker View Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if ( [_delegate respondsToSelector: @selector(avPickerTitleForRow:forComponent:)] )
	{
		return [_delegate avPickerTitleForRow: row forComponent: component];
	}
	else
	{
		return nil;
	}
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if ( [_delegate respondsToSelector: @selector(avPickerAttributedTitleForRow:forComponent:)] )
	{
		return [_delegate avPickerAttributedTitleForRow: row forComponent: component];
	}
	else
	{
		return nil;
	}
}

#pragma mark - Custom Methods
- (void)reloadAllComponents
{
	[_pickerView reloadAllComponents];
}

- (void)selectButtonPressed
{
	if ( [_delegate respondsToSelector: @selector(avPickerDidSelectWithComponentPaths:)] )
	{
		int component = [[_pickerView dataSource] numberOfComponentsInPickerView: _pickerView];
		
		NSMutableArray *array = [[NSMutableArray alloc] init];
		
		for ( int x = 0 ; x < component ; x++ )
		{
			int row = [_pickerView selectedRowInComponent: x];
			
			AVIndexPath *indexPath = [AVIndexPath indexPathForRow: row inComponent: x];
			[array addObject: indexPath];
		}
		
		if ( [_delegate respondsToSelector: @selector(avPickerDidSelectWithComponentPaths:)] )
		{
			[_delegate avPickerDidSelectWithComponentPaths: array];
		}
		
		[self hideAVPickerDimView];
	}
}

- (void)cancelButtonPressed
{
	if ( [_delegate respondsToSelector: @selector(avCancelButtonPressed)] )
	{
		[_delegate avCancelButtonPressed];
	}
	
	[self hideAVPickerDimView];
}

@end
