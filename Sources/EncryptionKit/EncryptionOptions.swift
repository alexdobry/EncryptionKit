//
//  EncryptionOptions.swift
//  
//
//  Created by Alexander Dobrynin on 29.11.19.
//

import CommonCrypto

public enum EncryptionOptions {
    case ECBMode, PKCS7Padding, Both
    
    var options: CCOptions {
        var o = 0
        
        switch self {
        case .ECBMode:
            o |= kCCOptionECBMode
        case .PKCS7Padding:
            o |= kCCOptionPKCS7Padding
        case .Both:
            o |= kCCOptionECBMode
            o |= kCCOptionPKCS7Padding
        }
        
        return CCOptions(o)
    }
}
