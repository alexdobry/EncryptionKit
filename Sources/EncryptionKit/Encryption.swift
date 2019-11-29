//
//  Encryption.swift
//  
//
//  Created by Alexander Dobrynin on 29.11.19.
//

import Foundation
import CommonCrypto

protocol Encryption {
    var options: EncryptionOptions { get }
    var algorithm: EncryptionAlgorithm { get }
}

extension Encryption {
    
    func encrypt(string: String, key: String) -> Result<String, Error> {
        return utf8Encoded(string)
            .flatMap { encrypt(data: $0, key: key) }
            .map { base64Encoded($0) }
    }
    
    func decrypt(string: String, key: String) -> Result<String, Error> {
        return base64Encoded(string)
            .flatMap { decrypt(data: $0, key: key) }
            .flatMap { utf8Encoded($0) }
    }
    
    func encrypt(data: Data, key: String) -> Result<Data, Error> {
        return utf8Encoded(key).flatMap { go(data, key: $0, operation: CCOperation(kCCEncrypt)) }
    }
    
    func decrypt(data: Data, key: String) -> Result<Data, Error> {
        return utf8Encoded(key).flatMap { go(data, key: $0, operation: CCOperation(kCCDecrypt)) }
    }
    
    private func utf8Encoded(_ string: String) -> Result<Data, Error> {
        return Result { string.data(using: .utf8) }
    }
    
    private func utf8Encoded(_ data: Data) -> Result<String, Error> {
        return Result { String(data: data, encoding: .utf8) }
    }
    
    private func base64Encoded(_ string: String) -> Result<Data, Error> {
        return Result { Data(base64Encoded: string) }
    }
    
    private func base64Encoded(_ data: Data) -> String {
        return data.base64EncodedString()
    }
    
    private func go(_ data: Data, key: Data, operation: CCOperation) -> Result<Data, Error> {
        let outputLength = data.count + algorithm.blockSize
        var outputBuffer = Array<UInt8>(repeating: 0, count: outputLength)
        var bytesDecrypted = 0
        
        let cryptStatus = CCCrypt(
            operation,
            algorithm.algorithm,
            options.options,
            Array(key),
            algorithm.keySize,
            nil,
            Array(data),
            data.count,
            &outputBuffer,
            outputLength,
            &bytesDecrypted
        )
        
        if cryptStatus == kCCSuccess {
            return .success(Data(outputBuffer.prefix(bytesDecrypted)))
        } else {
            return .failure("crypt operation failed. reason: \(cryptStatus)")
        }
    }
    
    func randomKey() -> String {
        let characters: [Character] = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        
        return (1...algorithm.keySize).reduce(into: "") { (key, _) in
            let c = characters[Int(arc4random_uniform(UInt32(characters.count) - 1))]
            key.append(c)
        }
    }
}
