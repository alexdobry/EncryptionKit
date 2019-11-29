//
//  EncryptionAlgorithm.swift
//  
//
//  Created by Alexander Dobrynin on 29.11.19.
//

import CommonCrypto

enum EncryptionAlgorithm {
    case aes256, aes128
    
    var keySize: Int {
        switch self {
        case .aes256: return kCCKeySizeAES256
        case .aes128: return kCCKeySizeAES128
        }
    }
    
    var blockSize: Int {
        switch self {
        case .aes256, .aes128: return kCCBlockSizeAES128
        }
    }
    
    var algorithm: CCAlgorithm {
        switch self {
        case .aes256, .aes128: return CCAlgorithm(kCCAlgorithmAES)
        }
    }
    
    func ivSize(options: CCOptions) -> Int {
        return options & CCOptions(kCCOptionECBMode) != 0 ? 0 : kCCBlockSizeAES128
    }
}
