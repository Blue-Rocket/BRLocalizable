//
//  BaseTestingSupport.m
//  BRLocalizable
//
//  Created by Matt on 18/08/15.
//  Copyright (c) 2015 Blue Rocket. Distributable under the terms of the Apache License, Version 2.0.
//

#import "BaseTestingSupport.h"

static NSBundle *bundle;

@implementation BaseTestingSupport

- (NSBundle *)bundle {
	return bundle;
}

+ (void)setUp {
	bundle = [[NSBundle alloc] initWithURL:[NSBundle bundleForClass:[self class]].bundleURL];
}

@end
