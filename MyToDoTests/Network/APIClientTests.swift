//
//  APIClientTests.swift
//  MyToDoTests
//
//  Created by Nitin Kalokhe on 24/06/23.
//

import XCTest
@testable import MyToDo

final class APIClientTests: XCTestCase {
    
    var apiClient : APIClient!
    var urlSession : MockURLSession!
    
    override func setUp() {
        apiClient = APIClient()
        urlSession = MockURLSession()
        apiClient.session = urlSession
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_login_usesExpectedHost() {
        let completion = {(token: Token?, error:Error?) in}
        apiClient.loginUser(with: Constants.userName, password: Constants.password, completion: completion)
        
        guard let _ = urlSession.url else {
            XCTFail("Url not found")
            return
        }
        
        XCTAssertEqual(urlSession.urlComponent?.host, "awesometodos.com")
    }
    
    func test_login_usesExpectedPath() {
        
        let completion = {(toke: Token?, error: Error?) in}
        apiClient.loginUser(with: Constants.userName, password: Constants.password, completion: completion)
        
        guard let _ = urlSession.url else {
            XCTFail("Url not found")
            return
        }
        
        XCTAssertEqual(urlSession.urlComponent?.path, "/login")
    }
    
    func test_login_usesExpectedQuery() {
        let completion = { (token: Token?, error: Error?) in }
        apiClient.loginUser(with: Constants.userName, password: Constants.password, completion: completion)
        
        guard let _ = urlSession.url else {
          XCTFail();
          return
        }
        
        XCTAssertEqual(urlSession.urlComponent?.query, "username=\(Constants.userName)&password=\(Constants.password)")
    }

    func test_login_givenSuccessResponse_createToke(){
        
        let jsonData = "{\"token\":\"1234567890\"}".data(using: .utf8)
        let mockUrlSession = MockURLSession(data: jsonData)
        apiClient.session = mockUrlSession
        
        let tokenExpectation = expectation(description: "Token")
        
        var coughtToken : Token?
        
        apiClient.loginUser(with: Constants.userName, password: Constants.password){(token, error) in
            coughtToken = token
            tokenExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5){ _ in
            XCTAssertEqual(coughtToken?.id, "1234567890")
        }
    }

    func test_login_givenJSONInInvalid_returnsError(){
        
        let mockUrlSession = MockURLSession(data: Data())
        apiClient.session = mockUrlSession
        
        let errorExpectation = expectation(description: "Error")
        var catchedError : Error?
        
        apiClient.loginUser(with: Constants.userName, password: Constants.password){ (_, error) in
            catchedError = error
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1){ _ in
            XCTAssertNotNil(catchedError)
        }
    }
    
    func test_login_givenFailResponse_returnsError(){
        let jsonData = "{\"token\":\"1234567890\"}".data(using: .utf8)
        let error = NSError(domain: "SomeError", code: 1234, userInfo: nil)
        
        let mockUrlSession = MockURLSession(data: jsonData, error: error)
        apiClient.session = mockUrlSession
        
        let errorExpectation = expectation(description: "Error")
        
        var catchedError : Error?
        apiClient.loginUser(with: Constants.userName, password: Constants.password){(_, error) in
            catchedError = error
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1){ _ in
            XCTAssertNotNil(catchedError)
        }
    }
}

extension APIClientTests {
    
    class MockURLSession : Sessionable {
        
        var url : URL!
        private let mockTask : MockTask
        var urlComponent : URLComponents? {
            guard let url = url else { return nil }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        init(data: Data! = nil, urlResponse: URLResponse! = nil, error:Error!=nil) {
            self.mockTask =   MockTask(data: data, response: urlResponse, error: error)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            return mockTask
        }
    }
    
    class MockTask: URLSessionDataTask {
        
        private let data:Data?
        private let urlResponse:URLResponse?
        private let responseError:Error?
        
        var completionHandler = {(data:Data?, urlResponse:URLResponse?, error:Error!) in}
        
        init(data: Data?, response:URLResponse?, error:Error?){
            self.data = data
            self.urlResponse = response
            self.responseError = error
        }
            
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler(self.data, self.urlResponse, self.responseError)
            }
        }
    }
}
