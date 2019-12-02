//
//  AESEncryption.swift
//  
//
//  Created by Alexander Dobrynin on 29.11.19.
//

public struct AESEncryption: Encryption {
    public let options: EncryptionOptions
    public let algorithm: EncryptionAlgorithm
    
    public init() {
        self.options = .PKCS7Padding
        self.algorithm = .aes256
    }
}
