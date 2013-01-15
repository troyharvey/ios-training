//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Troy Harvey on 12/27/12.
//  Copyright (c) 2012 Troy Harvey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)clear;
- (NSString *)description;
- (double)performOperation:(NSString *)operation;
- (void)pushOperand:(double)operand;

@property (readonly) id program;

+ (double)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;

@end
