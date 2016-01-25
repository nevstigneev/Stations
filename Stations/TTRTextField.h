//
//  TTRTextField.h
//  Stations
//
//  Created by Nikolay Evstigneev on 25.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTRTextFieldDelegate;

@interface TTRTextField : UITextField

@property (weak, nonatomic) id<UITextFieldDelegate, TTRTextFieldDelegate> delegate;

@end

@protocol TTRTextFieldDelegate <NSObject>

- (void)textFieldRightButtonTapped:(TTRTextField *)textField;

@end