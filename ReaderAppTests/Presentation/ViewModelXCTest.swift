//
//  ViewModelXCTest.swift
//  ReaderAppTests
//
//  Created by Prashanth on 19/10/25.
//

import XCTest
@testable import ReaderApp

final class ViewModelXCTest: XCTestCase {
    
    var mockService: MockNetworkService?
    var repository: Repository?
    var usecase: FetchArticlesUseCase?
    var ViewModel: ArticlesViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockService = MockNetworkService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockService = nil
        repository = nil
        usecase = nil
        ViewModel = nil
    }
    
    func testFetchData_Success() async throws {
        let mockJSON = """
                {
                    "status": "ok",
                    "totalResults": 1,
                    "articles": [
                        {
                            "author": "John",
                            "title": "Mock Title"
                        }
                    ]
                }
                """.data(using: .utf8)!
        mockService?.result = .success(mockJSON)
        repository = Repository(networkService: mockService!)
        usecase = FetchArticlesUseCase(repository: repository!)
        ViewModel = ArticlesViewModel(fetchArticleUseCase: usecase!)
        
        ViewModel!.onFetchUpdated = { news in
            XCTAssertEqual(news.articles.count, 1)
            XCTAssertEqual(news.articles.first?.author, "John")
        }
        
        ViewModel!.fetchArticles()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
