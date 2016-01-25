//
//  TTRTextField.m
//  Stations
//
//  Created by Nikolay Evstigneev on 25.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import "TTRTextField.h"

@implementation TTRTextField

@dynamic delegate;

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(0, 0, 16, 16);
    [button addTarget:self action:@selector(rightButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.rightView = button;
    self.rightViewMode = UITextFieldViewModeUnlessEditing;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect rightBounds = [super rightViewRectForBounds:bounds];
    rightBounds.origin.x -= 8;
    return rightBounds;
}

#pragma mark - Actions

- (void)rightButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(textFieldRightButtonTapped:)]) {
        [self.delegate textFieldRightButtonTapped:self];
    }
}

@end
