//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Hui Shao on 2/19/17.
//  Copyright © 2017 Hui Shao. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    // the middle value of result
    private var accumulator = 0.0
    
    // the calculated result
    var result:Double {
        get {
            return accumulator
        }
        
    }
    
    // All the operations it can do
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOp(sqrt),
        "cos": Operation.UnaryOp(cos),
        "+": Operation.BinaryOp({$0 + $1}),
        "-": Operation.BinaryOp({$0 - $1}),
        "×": Operation.BinaryOp({$0 * $1}),
        "÷": Operation.BinaryOp({$0 / $1}),
        "=": Operation.Equals
        
    ]
    
    private var pendingBinary:PendingBinaryOpInfo?
    
    // Different operation types
    private enum Operation {
        case Constant(Double)
        case UnaryOp((Double) -> Double)
        case BinaryOp((Double, Double) -> Double)
        case Equals
    }
    
    // Saving info for the binary operation
    private struct PendingBinaryOpInfo {
        var binaryFunc: (Double, Double) -> Double
        var firstOperand: Double
        
    }
    
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    func performOperation(symbol:String) {
        if let constant = operations[symbol] {
            switch constant {
            case .Constant(let value):
                accumulator = value
            case .UnaryOp(let unaryFunc):
                accumulator = unaryFunc(accumulator)
            case . BinaryOp(let binaryFunc):
                // when press the binary button, execute first
                executePendingBinaryOp()
                pendingBinary = PendingBinaryOpInfo(binaryFunc: binaryFunc, firstOperand: accumulator)
            case .Equals:
                // execute pending operation
                executePendingBinaryOp()
            }
        }
        
    }
    
    private func executePendingBinaryOp() {
        if pendingBinary != nil {
            accumulator = pendingBinary!.binaryFunc(pendingBinary!.firstOperand, accumulator)
            pendingBinary = nil
        }
    }
}
