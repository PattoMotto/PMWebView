//Pat

import XCTest
@testable import PMWebView

final class PMWebViewInteractorTests: XCTestCase {

    var interactor: PMWebViewInteractor!
    var urlSessionMock: URLSessionMock!
    var output: PMWebViewInteractorOutputMock!
    private lazy var url = URL(string: "https://www.duckduckgo.com")!

    override func setUp() {
        super.setUp()
        output = PMWebViewInteractorOutputMock()
        urlSessionMock = URLSessionMock()
        interactor = PMWebViewInteractor()
        interactor.output = output
        interactor.urlSession = urlSessionMock
    }
    
    override func tearDown() {
        output = nil
        urlSessionMock = nil
        interactor = nil
        super.tearDown()
    }
    
    func testComplete() {
        let expectData = Data()
        let response = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        urlSessionMock.dataTaskMock.taskResponse = (expectData, response, nil)
        interactor.fetchData(url: url)
        XCTAssertEqual(output.loadSuccessCalledWithData, expectData)
    }

    func testFailure404() {
        let expectData = Data()
        let response = HTTPURLResponse(
            url: url,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )
        urlSessionMock.dataTaskMock.taskResponse = (expectData, response, nil)
        interactor.fetchData(url: url)
        XCTAssertTrue(output.loadFailureCalled)
    }

    func testFailure500() {
        let expectData = Data()
        let response = HTTPURLResponse(
            url: url,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )
        urlSessionMock.dataTaskMock.taskResponse = (expectData, response, nil)
        interactor.fetchData(url: url)
        XCTAssertTrue(output.loadFailureCalled)
    }

    func testTimeout() {
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut)
        urlSessionMock.dataTaskMock.taskResponse = (nil, nil, error)
        interactor.fetchData(url: url)
        XCTAssertTrue(output.loadFailureCalled)
    }

    class PMWebViewInteractorOutputMock: PMWebViewInteractorOutput {

        var loadSuccessCalledWithData: Data?
        func loadSuccess(data: Data) {
            loadSuccessCalledWithData = data
        }

        var loadFailureCalled = false
        func loadFailure() {
            loadFailureCalled = true
        }
    }
}

final class URLSessionMock: URLSession {
    var request: URLRequest?
    var url: URL?
    var dataTaskMock: URLSessionDataTaskMock

    init(data: Data? = nil,
         response: URLResponse? = nil,
         error: Error? = nil) {
        dataTaskMock = URLSessionDataTaskMock()
        dataTaskMock.taskResponse = (data, response, error)
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.request = request
        dataTaskMock.completion = completionHandler
        return dataTaskMock
    }

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.url = url
        dataTaskMock.completion = completionHandler
        return dataTaskMock
    }

}

final class URLSessionDataTaskMock: URLSessionDataTask {
    typealias Completion = (Data?, URLResponse?, Error?) -> Void
    var completion: Completion?
    var taskResponse: (Data?, URLResponse?, Error?)?

    override func resume() {
        completion?(taskResponse?.0, taskResponse?.1, taskResponse?.2)
    }
}
