//
//  MetaData.swift
//  Pods-InWalletSDK-iOS_Example
//
//  Created by hanjinsik on 2022/11/14.
//

import Foundation

struct ImnDefine {
    static let END_POINT: String = "https://testbackend.initialmn.io"
    static let A2A_PROPOSAL: String = "/api/v1/a2a/proposal"
    static let A2A_RESULT: String = "/api/v1/a2a/result?"
}


public class MetaData: Codable {
    var name: String?                   //DAPP 이름(필수)
    var description: String?            //요청 설명(옵션)
    var url: String?                    //DAPP 대표 URL(옵션)
    var icon: String?                   //DAPP 로고 이미지 URL(옵션)
    var successCallback: String?        //DAPP 요청 성공시 처리할 callback 정보(옵션)
    var failureCallback: String?        //DAPP 요청 실패시 처리할 callback 정보(옵션)
    
    
    enum CodingKeys: CodingKey {
        case name
        case description
        case url
        case icon
        case successCallback
        case failureCallback
    }
    
    public init(name: String, description: String? = "", url: String? = "", icon: String? = "", successCallback: String? = "", failureCallback: String? = "") {
        self.name = name
        self.description = description
        self.url = url
        self.icon = icon
        self.successCallback = successCallback
        self.failureCallback = failureCallback
    }
    
    required public init(from decoder: Decoder) {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        
        guard let name = try? container!.decode(String.self, forKey: .name) else {
            return
        }
        
        guard let description = try? container!.decode(String.self, forKey: .description) else {
            return
        }
        
        guard let url = try? container!.decode(String.self, forKey: .url) else {
            return
        }
        
        guard let icon = try? container!.decode(String.self, forKey: .icon) else {
            return
        }
        
        guard let successCallback = try? container!.decode(String.self, forKey: .successCallback) else {
            return
        }
        
        guard let failureCallback = try? container!.decode(String.self, forKey: .failureCallback) else {
            return
        }
        
        self.name = name
        self.description = description
        self.url = url
        self.icon = icon
        self.successCallback = successCallback
        self.failureCallback = failureCallback
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        if let name = name {
            try container.encode(name, forKey: .name)
        }
        
        if let description = description {
            try container.encode(description, forKey: .description)
        }
        
        if let url = url {
            try container.encode(url, forKey: .url)
        }
        
        if let icon = icon {
            try container.encode(icon, forKey: .icon)
        }
        
        if let successCallback = successCallback {
            try container.encode(successCallback, forKey: .successCallback)
        }
        
        if let failureCallback = failureCallback {
            try container.encode(failureCallback, forKey: .failureCallback)
        }

    }
}


public class Transaction: Codable {
    
    func getType() -> String {
        return "auth"
    }
}


public class SendLipc : Transaction {
    var from: String! = ""           //보내는 주소
    var to: String! = ""             //받는 주소
    var value: String! = ""          //수량
    
    
    enum CodingKeys: CodingKey {
        case from
        case to
        case value
    }
    
    public init(from: String, to: String, value: String) {
        super.init()
        
        self.from = from
        self.to = to
        self.value = value
        
    }
    
    
    public required init(from decoder: Decoder) {
        
        try! super.init(from: from as! Decoder)
        
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        
        guard let from = try? container!.decode(String.self, forKey: .from) else {
            return
        }
        
        guard let to = try? container!.decode(String.self, forKey: .to) else {
            return
        }
        
        guard let value = try? container!.decode(String.self, forKey: .value) else {
            return
        }
        
        self.from = from
        self.to = to
        self.value = value
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(from, forKey: .from)
        try container.encode(to, forKey: .to)
        try container.encode(value, forKey: .value)
    }
    
    override func getType() -> String {
        return "send"
    }
}



public class SendToken: Transaction {
    var from: String! = ""
    var to: String! = ""
    var value: String! = ""
    var contract: String! = ""
    
    enum CodingKeys: CodingKey {
        case from
        case to
        case value
        case contract
    }
    
    public init(from: String, to: String, value: String, contract: String) {
        super.init()
        
        self.from = from
        self.to = to
        self.value = value
        self.contract = contract
    }
    
    
    required public init(from decoder: Decoder) {
        try! super.init(from: from as! Decoder)
        
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        
        guard let from = try? container!.decode(String.self, forKey: .from) else {
            return
        }
        
        guard let to = try? container!.decode(String.self, forKey: .to) else {
            return
        }
        
        guard let value = try? container!.decode(String.self, forKey: .value) else {
            return
        }
        
        guard let contract = try? container!.decode(String.self, forKey: .contract) else {
            return
        }
        
        self.from = from
        self.to = to
        self.value = value
        self.contract = contract
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(from, forKey: .from)
        try container.encode(to, forKey: .to)
        try container.encode(value, forKey: .value)
        try container.encode(contract, forKey: .contract)
    }
    
    override func getType() -> String {
        return "send_token"
    }
}



public class SendNFT: Transaction {
    var from: String! = ""
    var to: String! = ""
    var contract: String! = ""
    var tokenId: String! = ""
    
    enum CodingKeys: CodingKey {
        case from
        case to
        case contract
        case tokenId
    }
    
    public init(from: String, to: String, contract: String, tokenId: String) {
        super.init()
        
        self.from = from
        self.to = to
        self.contract = contract
        self.tokenId = tokenId
    }
    
    
    required public init(from decoder: Decoder) {
        try! super.init(from: from as! Decoder)
        
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        
        guard let from = try? container!.decode(String.self, forKey: .from) else {
            return
        }
        
        guard let to = try? container!.decode(String.self, forKey: .to) else {
            return
        }
        
        guard let contract = try? container!.decode(String.self, forKey: .contract) else {
            return
        }
        
        guard let tokenId = try? container!.decode(String.self, forKey: .tokenId) else {
            return
        }
        
        self.from = from
        self.to = to
        self.contract = contract
        self.tokenId = tokenId
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(from, forKey: .from)
        try container.encode(to, forKey: .to)
        try container.encode(contract, forKey: .contract)
        try container.encode(tokenId, forKey: .tokenId)
    }
    
    override func getType() -> String {
        return "send_nft"
    }
}



public class ContractExecute: Transaction {
    var from: String! = ""
    var to: String! = ""
    var abi: String! = ""
    var params: String! = ""
    
    enum CodingKeys: CodingKey {
        case from
        case to
        case abi
        case params
    }
    
    public init(from: String, to: String, abi: String, params: String) {
        super.init()
        
        self.from = from
        self.to = to
        self.abi = abi
        self.params = params
    }
    
    required public init(from decoder: Decoder) {
        try! super.init(from: from as! Decoder)
        
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        
        guard let from = try? container!.decode(String.self, forKey: .from) else {
            return
        }
        
        guard let to = try? container!.decode(String.self, forKey: .to) else {
            return
        }
        
        guard let abi = try? container!.decode(String.self, forKey: .abi) else {
            return
        }
        
        guard let params = try? container!.decode(String.self, forKey: .params) else {
            return
        }
        
        self.from = from
        self.to = to
        self.abi = abi
        self.params = params
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(from, forKey: .from)
        try container.encode(to, forKey: .to)
        try container.encode(abi, forKey: .abi)
        try container.encode(params, forKey: .params)
    }
    
    override func getType() -> String {
        return "contract_execute"
    }
}
 

extension Encodable {
    var toDictionary : [String: Any]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String:Any] else { return nil }
        return dictionary
    }
}
 
