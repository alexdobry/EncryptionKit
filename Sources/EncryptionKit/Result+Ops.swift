//
//  File.swift
//  
//
//  Created by Alexander Dobrynin on 29.11.19.
//

import Foundation

extension String: Error {
    
}

extension Result where Failure == Error {
        
    init(_ f: () -> Success?) {
        if let t = f() {
            self = .success(t)
         } else {
            self = .failure("predicate does not satisfy")
         }
    }
}
