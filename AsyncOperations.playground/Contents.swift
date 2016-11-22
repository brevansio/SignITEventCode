//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

// this is needed for Async in Playgrounds. We will
// call PlaygroundPage.current.finishExecution later
PlaygroundPage.current.needsIndefiniteExecution = true

//var myString = "Hello World"
//DispatchQueue.global(qos: .userInitiated).async {
//    myString = "Hello Async World"
//    
//    DispatchQueue.main.async {
//        print(myString)
//        PlaygroundPage.current.finishExecution()
//    }
//}
//print(myString)


//// Using NSOperation
//var myString = "Hello World"
//let operation = BlockOperation() {
//    myString = "Hello Async World"
//}
//operation.completionBlock = {
//    print(myString)
//    PlaygroundPage.current.finishExecution()
//}
//let queue = OperationQueue()
//print(myString)
//queue.addOperation(operation)


//// Subclassing NSOperation
//class AsyncOperation: Operation {
//    var myString = "Hello World"
//    override func main() {
//        if (self.isCancelled) {
//            return
//        }
//        
//        myString = "Hello Async World"
//    }
//}
//
//let myOperation = AsyncOperation()
//myOperation.completionBlock = {
//    print(myOperation.myString)
//    PlaygroundPage.current.finishExecution()
//}
//print(myOperation.myString)
//
//let queue = OperationQueue()
//queue.addOperation(myOperation)


// Subclass NSOperation (For Double Async)
class DoubleAsyncOperation: Operation {
    var myString = "Hello World"
    
    private var finishedState = false
    override var isFinished: Bool {
        return finishedState
    }
    private var exectutionState = false
    override var isExecuting: Bool {
        return exectutionState
    }
    
    override func start() {
        guard !self.isCancelled else {
            self.willChangeValue(forKey: "isExecuting")
            exectutionState = false
            self.didChangeValue(forKey: "isExecuting")
            return
        }
        
        self.willChangeValue(forKey: "isExecuting")
        exectutionState = true
        self.didChangeValue(forKey: "isExecuting")
        
        let url = URL(string: "https://www.google.com")!
        let sessionTask = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard !self.isCancelled else {
                return
            }
            self.myString = "Hello Async World"
            self.willChangeValue(forKey: "isFinished")
            self.willChangeValue(forKey: "isExecuting")
            self.exectutionState = false
            self.finishedState = true
            self.didChangeValue(forKey: "isExecuting")
            self.didChangeValue(forKey: "isFinished")
        }
        sessionTask.resume()
    }
}

let myOperation = DoubleAsyncOperation()
myOperation.completionBlock = {
    print(myOperation.myString)
    PlaygroundPage.current.finishExecution()
}
print(myOperation.myString)

let queue = OperationQueue()
queue.addOperation(myOperation)
