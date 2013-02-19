//
//  AVIndexPath.m
//  AVPickerDimView
//
//  Created by Angelo Villegas on 7/22/12.
//  Copyright (c) 2012 Angelo Villegas. All rights reserved.
//

#import "AVIndexPath.h"

@interface AVIndexPath ()

@end

@implementation AVIndexPath

@synthesize row = _row;
@synthesize component = _component;

- (id)initWithRow:(NSInteger)row inComponent:(NSInteger)component
{
	self = [super init];
	
	if ( self )
	{
		_row = row;
		_component = component;
	}
	
	return self;
}

+ (AVIndexPath *)indexPathForRow:(NSInteger)row inComponent:(NSInteger)component
{
	AVIndexPath *indexPath = [[[self class] alloc] initWithRow: row inComponent: component];
	return indexPath;
}

#pragma mark - Override method
- (NSString *)description
{
	NSString *string = [NSString stringWithFormat: @"index: [%i, %i] (%@)" , _row , _component , [self class]];
	return string;
}

- (NSString *)debugDescription
{
	NSArray *keys = [NSArray arrayWithObjects: @"class" , @"row" , @"component" , nil];
	NSArray *objects = [NSArray arrayWithObjects: [self class] , [NSNumber numberWithInteger: _row] , [NSNumber numberWithInteger: _component] , nil];
	NSDictionary *objectsAndKeys = [NSDictionary dictionaryWithObjects: objects forKeys: keys];
	NSDictionary *dictionary = [NSDictionary dictionaryWithObject: objectsAndKeys forKey: @"index"];
	NSString *debugDescription = [NSString stringWithFormat: @"%@" , dictionary];
	
	return debugDescription;
}

@end
