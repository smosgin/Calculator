//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Seth Mosgin on 5/16/17.
//  Copyright © 2017 Seth Mosgin. All rights reserved.
//

import Foundation

//Classes live in the heap and you have pointers to them (passed by reference)
//Structs do not live in the heap and are passed by value
//Going with struct here because there shouldn't be many cases of CalculatorBrain being accessed by other entities (Calculator is going to be single MVC or close to it)
//Also a good practice for writing a struct
struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        //Constant is an optional which when set contains an associated value of type Double
        case constant(Double)
        //unaryOperation represents a function that takes a Double and returns a Double
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> =
    [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "±" : Operation.unaryOperation({ -$0 }),
        //Here, Swift knows from the Operation enum that this function takes 2 Doubles and returns a Double. You can use $i for arguments in order. This syntax is called a closure
        "×" : Operation.binaryOperation({ $0 * $1 }),
        "÷" : Operation.binaryOperation({ $0 / $1 }),
        "+" : Operation.binaryOperation({ $0 + $1 }),
        "−" : Operation.binaryOperation({ $0 - $1 }),
        "=" : Operation.equals
        
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    isPendingBinaryOperation = pendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if isPendingBinaryOperation != nil && accumulator != nil {
            accumulator = isPendingBinaryOperation!.performOperation(with: accumulator!)
            isPendingBinaryOperation = nil
        }
    }
    
    private var isPendingBinaryOperation: pendingBinaryOperation?
    
    private struct pendingBinaryOperation {
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func performOperation(with secondOperand: Double) -> Double {
            return function(firstOperand,secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double){
        accumulator = operand
    }
    
    var result: Double? {
        get{
            return accumulator
        }
    }
}
