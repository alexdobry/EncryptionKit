# EncryptionKit

EncryptionKit is a simple and type safe wrapper for Apple's `CommonCrypto` Library written in Swift. EncryptionKit supports AES128 and AES256 encryption and decryption with some additional options.

# Usage

Use `AESEncryption` for simple encryption and decryption functions. You can also conform to the `Encryption` Protocol and provide custom configurations.

```swift
let encryption = AESEncryption()
let key = encryption.randomKey()
let string = "super_secret_string"

let encrypted: Result<String, Error> = encryption.encrypt(string, key)
let decrypted: Result<String, Error> = encrypted.flatMap { encryption.decrypt($0, key) }
```
