//
//  InWalletSDK.swift
//  InWalletSDK
//
//  Created by hanjinsik on 2022/11/14.
//

import Foundation
import Alamofire

public class InWalletSDK {
    
    /**
     proposal
     - Parameters:
        - MetaData: name(필수), description, url, icon, successCallback, failureCallback(옵션)
        - SendData: SendLipc, SendToken, SendNFT, ContractExecute, nil인 경우 Auth(인증)
     */
    public static func proposal(metaData: MetaData, sendData: Transaction?, complection: @escaping (String?, Int) -> Void) {
        let metaDataJson = metaData.toDictionary
        
        var params: [String : Any]
        
        if sendData == nil {
            params = ["metadata": metaDataJson!, "type": "auth"]
        }
        else {
            let type = sendData!.getType()
            let sendDataDic = sendData!.toDictionary
            params = ["metadata": metaDataJson!, "type": type, "transaction": sendDataDic!]
        }
        
        self.request(params: params) { requestId, statusCode in
            complection(requestId, statusCode)
            
            if statusCode == 200 {
                self.openUrl(requestId: requestId!)
            }
        }
    }
    
    
    /**
    Result : DApp에서 실행 결과 확인
     - Parameters:
        - requestId: 요청 식별자
     - Returns:Dictionary, statucCode(ex 200)
     */
    public static func getResult(requestId: String, complection: @escaping(Dictionary<String, Any>?, Int) -> Void) {
        
        var endPoint: String = ""
        
        if let a2aDomain = Bundle.main.object(forInfoDictionaryKey: "A2A Imn Domain") as? String {
            endPoint = a2aDomain
        } else {
            endPoint = ImnDefine.END_POINT
        }
        
        let url = endPoint + ImnDefine.A2A_RESULT + "requestId=\(requestId)"
        
        AF.request(url, method: .get).response { response in
            
            guard let statusCode = response.response?.statusCode else {
                complection(nil, 0)
                
                return
            }
            
            guard let data = response.data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                  let dic = json as? Dictionary<String, Any> else {
                    complection(nil, statusCode)
                return
            }
            
            complection(dic, statusCode)
        }
    }
    
    
    //API request
    private static func request(params: Dictionary<String, Any>, complection: @escaping (String?, Int) -> Void) {
        
        var endPoint: String = ""
        
        if let a2aDomain = Bundle.main.object(forInfoDictionaryKey: "A2A Imn Domain") as? String {
            endPoint = a2aDomain
        } else {
            endPoint = ImnDefine.END_POINT
        }
        
        let url = endPoint + ImnDefine.A2A_PROPOSAL
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).response { response in
            
            guard let statusCode = response.response?.statusCode else {
                complection(nil, 0)
                
                return
            }
            
            guard let data = response.data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                  let dic = json as? Dictionary<String, Any>,
                  let requestId = dic["requestId"] as? String else {
                      complection(nil, statusCode)
                      
                return
            }
            
            complection(requestId, statusCode)
        }
    }
    
    
    private static func openUrl(requestId: String) {
        if let schemeUrl = URL(string: "inwallet://wallet?requestId=" + requestId) {
            if UIApplication.shared.canOpenURL(schemeUrl) {
                UIApplication.shared.open(schemeUrl, options: [:]) { (bool) in }
            }
            else {
                //Todo : 앱스토어 페이지 이동
            }
        }
    }
    
}

