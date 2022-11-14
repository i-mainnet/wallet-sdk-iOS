
# INWalletSDK for iOS(Swift)
  SDK for iOS that connect In Wallet App to dApp.

## Requirements

- iOS 12.0 or above
- Swift 4 or above

## Settings

### Adding dependency with CocoaPod

Add the following to your podfile

```swift
target 'project' do
    pod 'InWalletSDK-iOS'
end
```

### Setup Info.plist

To run the In Wallet app via the iOS SDK, the user needs to add the custom scheme information to the Info.plist file as follows: Custom schemes to add are inwallet, itms-apps.

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>inwallet<string>      <!-- In Wallet scheme -->
    <string>itms-apps<string>     <!-- AppStore scheme -->
</array>
```

### Setup Network

Can change the network if necessary. The default network is Mainnet, but it is not currently available.

Be sure to set it as Testnet.

Add the following line to your info.plist

```xml
<key>A2A Imn Domain</key>
<string>http://testbackend.initialmn.io</string>
```

## API

In the iOS SDK, App-to-App requests are progressed in two main steps : `Proposal`, `Result`

- `Proposal`: A stage that requests a task to be performed by a dApp. There are 5 different types of requests.
- `Result`: A stage to confirm the results of the called functions.

### MetaData

This page describes the required information about the dAp to request a Proposal.

| Property    | Type   | Value                       | Required |
| ----------- | ------ | --------------------------- | -------- |
| name        | string | Name of dApp                | true     |
| description | string | About the request. Reserved | true     |
| url         | string | Main URL of dApp. Reserved  | false    |
| icon        | string | URL of dApp logo. Reserved  | false    |

**Example**

```swift
metaData = MetaData(name: "dappName", description: "description", url: "url", icon: "iconUrl")
```

### Proposal

This function uses InWalletSDK.proposal(MetaData, SendData) and provides 5 different request types.

- null : request wallet address
- SendLipc : request LIPC transfer
- SendToken : request Token transfer
- SendNFT : request NFT transfer
- ExecuteContract : request execute contract

### Auth

This function requests an authentication of the user’s wallet, and the address of the user wallet can be confirmed when the authentication is completed.

**Example**

```swift
InWalletSDK.proposal(metaData: metaData, sendData: nil) { requestID, statusCode in
    // If successful, internal logic calls the wallet by passing the requestId to the scheme.
    guard let requestId = requestID, !requestId.isEmpty else {
        return
    }
}
```

### SendLipc

This is a request to send the user’s LIPC to a specific address. After the approval of the request, the user can check the transactionHash of the request.

**SendLipc(from, to, value)**

| Parameter | Type   | Value                                                    |
| --------- | ------ | -------------------------------------------------------- |
| from      | string | Address of the sender (Wallet User Verification Purpose) |
| to        | string | Address of the recipient                                 |
| value     | string | Amount of LIPC to send **(unit : wei)**                 |

**Example**

```swift
let sendLipc = SendLipc.init(
    from: "0x7A8519fE4A25521e4f7692489149BEe8864c6935",
    to: "0x23a80bdE8dCDDEf6829beD0d5d966BDBf6cB44C3",
    value: "1000000000000000000" // 1 LIPC
)

InWalletSDK.proposal(metaData: metaData, sendData: sendLipc) { requestID, statusCode in
    // If successful, internal logic calls the wallet by passing the requestId to the scheme..
    guard let requestId = requestID, !requestId.isEmpty else {
        return
    }
}
```

### SendToken

This is a request to send the user’s Token to a specific address. After the approval of the request, the user can check the transactionHash of the request.

**SendToken(from, to , value, contract)**

| Parameter | Type   | Value                                                    |
| --------- | ------ | -------------------------------------------------------- |
| from      | string | Address of the sender (Wallet User Verification Purpose) |
| to        | string | Address of the recipient                                 |
| value     | string | Amount of Token to send **(including decimals)**         |
| contract  | string | Address of the token contract                            |

**Example**

```swift
let sendToken = SendToken.init(
    from: "0x7A8519fE4A25521e4f7692489149BEe8864c6935",
    to: "0x23a80bdE8dCDDEf6829beD0d5d966BDBf6cB44C3",
    value: "10000000000",    // In case decimal 10, 1 TOKEN
    contract: "0xF6fF95D53E08c9660dC7820fD5A775484f77183A"
);

InWalletSDK.proposal(metaData: metaData, sendData: sendToken) { requestID, statusCode in
    guard let requestId = requestID, !requestId.isEmpty else {
        return
    }
}
```

### SendNFT

This is a request to send the user’s NFT to a specific address. After the approval of the request, the user can check the transactionHash of the request.

| Parameter | Type   | Value                                                    |
| --------- | ------ | -------------------------------------------------------- |
| from      | string | Address of the sender (Wallet User Verification Purpose) |
| to        | string | Address of the recipient                                 |
| contract  | string | Address of the NFT contract                              |
| tokenId   | string | Token ID of the NFT                                      |

**Example**

```swift
let sendNFT = SendNFT.init(
    from: "0x7A8519fE4A25521e4f7692489149BEe8864c6935",
    to: "0x23a80bdE8dCDDEf6829beD0d5d966BDBf6cB44C3",
    contract: "0x1dfe2bd526ac5be67e8b968957107e3f5593086a",
    tokenId: "13" // token id
);

InWalletSDK.proposal(metaData: metaData, sendData: sendNFT) { requestID, statusCode in
    guard let requestId = requestID, !requestId.isEmpty else {
        return
    }
}
```

## ExecuteContract

This is a request to execute a specific contract. After the approval of the request, the user can check the transactionHash of the request.

**ContractExecute(from, to, abi, params)**

| Parameter | Type   | Value                                                    |
| --------- | ------ | -------------------------------------------------------- |
| from      | string | Address of the sender (Wallet User Verification Purpose) |
| contract  | string | Address of contract                                      |
| abi       | string | abi of the function (json object)                        |
| params    | string | Parameters of the function (json array)                  |

**Example**

```swift
let abi = "{\"constant\":false,\"inputs\":[{\"name\":\"_to\",\"type\":\"address\" ..."
let params = "[\"0xcad9042cf49684939a2f42c2d916d1b6526635c2\", \"500000000000\"]"

let contractExecute = ContractExecute.init(
    from: "0x7A8519fE4A25521e4f7692489149BEe8864c6935",
    to: "0xF6fF95D53E08c9660dC7820fD5A775484f77183A",
    abi: abi,
    params: params
);

InWalletSDK.proposal(metaData: metaData, sendData: contractExecute) { requestID, statusCode in
    guard let requestId = requestID, !requestId.isEmpty else {
        return
    }
}
```

### Result

When the dApp goes into the foreground state after the request is approved, use InWalletSDK.getResult () to see the result of the request.

```swift
InWalletSDK.getResult(requestId: requestId) { response, statusCode in
    if statusCode == 200 {
        //when requesting an address
        guard let result = response!["result"] as? Dictionary<String, Any>,
              let address = result["address"] as? String else {
            return
        }

        //All except address requests are txId.
        guard let result = response!["result"] as? Dictionary<String, Any>,
              let txId = result["transactionHash"] as? String else {
            return
        }
    }
}
```

## License

InWalletSDK-iOS is available under the MIT license. See the LICENSE file for more info.
