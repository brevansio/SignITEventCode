//
//  MyClass.swift
//  TestExample
//
//  Created by Bruce Evans on 2016/11/22.
//  Copyright © 2016 Bruce Evans. All rights reserved.
//

import Foundation

func createArrayWithCount (_ count: Int) -> Array<Any> {
    var returnArray = [Any]()
    for i in 0..<count {
        returnArray.append(i)
    }
    return returnArray
}
