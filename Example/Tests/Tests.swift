import XCTest
import InWalletSDK

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testAuth() {
        let metaData = MetaData(name: "name", description: "description")
        
        InWalletSDK.proposal(metaData: metaData, sendData: nil) { requestID, statusCode in
            if statusCode == 200 {
                print("OK")
            }
        }
    }
    
    func testSendLipc() {
        let metaData = MetaData(name: "dappName", description: "description", url: "url", icon: "iconUrl", successCallback: "", failureCallback: "")
        let sendData = SendLipc.init(from: "0x745d837b6f113D9033E6b4Fb23307fD2caEa20ec", to: "0xF90a9f2C389b440De878d1E8a161A5775cdAE8dd", value: "1")
        
        InWalletSDK.proposal(metaData: metaData, sendData: sendData) { requestID, statusCode in
            if statusCode == 200 {
                print("OK")
            }
        }
    }
    
    
    func testSendToken() {
        let metaData = MetaData(name: "dappName", description: "description", url: "url", icon: "iconUrl", successCallback: "", failureCallback: "")
        let sendData = SendToken.init(from: "0x745d837b6f113D9033E6b4Fb23307fD2caEa20ec", to: "0xF90a9f2C389b440De878d1E8a161A5775cdAE8dd", value: "100000000000000", contract: "contractAddress")
        
        InWalletSDK.proposal(metaData: metaData, sendData: sendData) { requestID, statusCode in
            if statusCode == 200 {
                print("OK")
            }
        }
    }
    
    
    func testSendNFT() {
        let metaData = MetaData(name: "dappName", description: "description", url: "url", icon: "iconUrl", successCallback: "", failureCallback: "")
        let sendData = SendNFT.init(from: "0x745d837b6f113D9033E6b4Fb23307fD2caEa20ec", to: "0xF90a9f2C389b440De878d1E8a161A5775cdAE8dd", contract: "contractAddress", tokenId: "tokenID")
        
        InWalletSDK.proposal(metaData: metaData, sendData: sendData) { requestID, statusCode in
            if statusCode == 200 {
                print("OK")
            }
        }
    }
    
    func testExecuteContract() {
        let metaData = MetaData(name: "dappName", description: "description", url: "url", icon: "iconUrl", successCallback: "", failureCallback: "")
        let sendData = ContractExecute.init(from: "0x745d837b6f113D9033E6b4Fb23307fD2caEa20ec", to: "0x29Bfe0A436D78Ff2D9D4168E0CC3247fE078A3f2", abi: "{\"constant\":false,\"inputs\":[{\"name\":\"_to\",\"type\":\"address\"},{\"name\":\"_value\",\"type\":\"uint256\"}],\"name\":\"transfer\",\"outputs\":[{\"name\":\"success\",\"type\":\"bool\"}],\"payable\":false,\"type\":\"function\"}", params: "[\"0xcad9042cf49684939a2f42c2d916d1b6526635c2\", 5000000000000000000]")
        
        InWalletSDK.proposal(metaData: metaData, sendData: sendData) { requestID, statusCode in
            if statusCode == 200 {
                print("OK")
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
