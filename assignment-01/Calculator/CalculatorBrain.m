//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Troy Harvey on 12/27/12.
//  Copyright (c) 2012 Troy Harvey. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack {
    if (_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}

- (void)pushOperand:(double)operand {
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    if(operandObject) {
     [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
}
- (double)performOperation:(NSString *)operation {
    double result = 0;
    
    if([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([@"-" isEqualToString:operation]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if ([@"/" isEqualToString:operation]) {
        double divisor = [self popOperand];
        result = [self popOperand] / divisor;
    } else if ([@"sin" isEqualToString: operation]) {
        result = sin([self popOperand]);
    } else if ([@"cos" isEqualToString: operation]) {
        result = cos([self popOperand]);
    } else if ([@"√" isEqualToString: operation]) {
        result = sqrt([self popOperand]);
    }
    
    [self pushOperand:result];
    return result;
}
- (NSString *)description {
    NSString *description = [NSString stringWithFormat: @"CalculatorBrain.operandStack "];
    for (NSString *operand in self.operandStack) {
        description = [description stringByAppendingFormat: @"[%@]", operand];
    }
    return description;
}

@end
