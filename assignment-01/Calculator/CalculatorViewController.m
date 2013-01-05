//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Troy Harvey on 12/27/12.
//  Copyright (c) 2012 Troy Harvey. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize brainDisplay = _brainDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain {
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (void)appendToBrainDisplay:(NSString *)token {
    
    // Only show 40 characters in the display
    if (self.brainDisplay.text.length > 40) {
        self.brainDisplay.text = [self.brainDisplay.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        NSRange firstSpace = [self.brainDisplay.text rangeOfString: @" "];
        if(firstSpace.location != NSNotFound) {
            self.brainDisplay.text = [self.brainDisplay.text substringFromIndex: firstSpace.location];
        }
    }
    self.brainDisplay.text = [self.brainDisplay.text stringByAppendingFormat: @" %@", token];
}

- (IBAction)clearPressed:(id)sender {
    [self.brain clear];
    self.brainDisplay.text = @"";
    self.display.text = @"";
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = sender.currentTitle;
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)enterPressed {
    // Only add the display value once
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self.brain pushOperand:[self.display.text doubleValue]];
        NSLog(@"%@", self.brain);
        self.userIsInTheMiddleOfEnteringANumber = NO;
        [self appendToBrainDisplay: self.display.text];
    }
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    [self appendToBrainDisplay: sender.currentTitle];
}

- (IBAction)periodPressed:(UIButton *)sender {
    // Allow periods at the beginning of a new number an
    if (self.userIsInTheMiddleOfEnteringANumber == NO) {
        self.display.text = @"0.";
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
    // Only allow one
    if ([self.display.text rangeOfString: @"."].location == NSNotFound) {
        self.display.text = [self.display.text stringByAppendingString: @"."];
    }
}

- (IBAction)piPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber == NO) {
        self.display.text = @"3.1415926";
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

@end
