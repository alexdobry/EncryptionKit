//
//  AESEncryption.swift
//  
//
//  Created by Alexander Dobrynin on 29.11.19.
//

struct AESEncryption: Encryption {
    let options: EncryptionOptions
    let algorithm: EncryptionAlgorithm
    
    init(options: EncryptionOptions = .PKCS7Padding, algorithm: EncryptionAlgorithm = .aes256) {
        self.options = options
        self.algorithm = algorithm
    }
}
