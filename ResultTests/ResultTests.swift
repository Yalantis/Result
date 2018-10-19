//
//  ResultTests.swift
//  ResultTests
//
//  Created by Roman Kyrylenko on 10/16/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import XCTest
import Result

class ResultTests: XCTestCase {
    
    func test_result_failureResult_valueIsNil() {
        let sut = Result<Int>.failure(GenericError())
        
        XCTAssertNil(sut.value)
        XCTAssertNotNil(sut.error)
    }
    
    func test_result_successfulResult_errorIsNil() {
        let sut = Result<Int>.success(10)
        
        XCTAssertNotNil(sut.value)
        XCTAssertNil(sut.error)
    }
    
    func test_result_successfulErrorResult_errorIsNil() {
        let sut = Result<GenericError>.success(GenericError())
        
        XCTAssertNil(sut.error)
        XCTAssertNotNil(sut.value)
    }
    
    func test_require_successfulResult_returnsValue() {
        let sut = Result<Int>.success(20010)
        
        XCTAssertEqual(sut.require(), 20010)
    }
    
    func test_onError_failureResult_returnsError() {
        var sut = Result<Error>.failure(GenericError())
        let newError = AnotherError()
        
        sut = sut.onError { _ -> Error in
            return newError
        }
        
        XCTAssertNil(sut.value)
        XCTAssertEqual(newError, sut.error as! AnotherError)
    }
    
    func test_map_mutatingValue_returnsMutatedValue() {
        let sut = Result<Int>.success(100)
        
        let newSut = sut.map { value -> Float in
            return Float(value) * 0.5
        }
        
        XCTAssertEqual(newSut.require(), 50)
    }
    
    func test_voidMap_creatingValue_returnsCreatedValue() {
        let sut = Result<Int>.success(500)
        
        let newSut = sut.map { () -> Float in
            return 50
        }
        
        XCTAssertEqual(newSut.require(), 50)
    }
    
    func test_next_mutatingValue_retunsSuccessResult() {
        let sut = Result<Int>.success(100)
        
        let newSut = sut.next { value -> Result<Float> in
            return Result.success(Float(value) * 0.5)
        }
        
        XCTAssertEqual(newSut.require(), 50)
    }
    
    func test_next_mutatingValue_retunsFailureResult() {
        let sut = Result<Int>.success(100)
        
        let newSut = sut.next { value -> Result<Float> in
            return Result.failure(GenericError())
        }
        
        XCTAssertNil(newSut.value)
        XCTAssertNotNil(newSut.error)
    }
    
    func test_next_mutatingValue_returnsDifferentResult() {
        let sut = Result<Int>.success(100)
        
        let newSut = sut.next { value -> Result<Int> in
            return Result.success(2 * value)
        }
        
        XCTAssertNotEqual(newSut, sut)
    }
    
    func test_voidNext_mutatingValue_returnsSuccessResult() {
        let sut = Result<Int>.success(500)
        
        let newSut = sut.next { () -> Result<Int> in
            return Result.success(100)
        }
        
        XCTAssertEqual(newSut.require(), 100)
    }
}

class GenericError: Error {
    
    init() {}
}

class AnotherError: GenericError, Equatable {
    
    static func == (lhs: AnotherError, rhs: AnotherError) -> Bool {
        return true
    }
    
    override init() {}
}

extension Result: Equatable where T: Equatable {
    
    public static func == (lhs: Result<T>, rhs: Result<T>) -> Bool {
        switch (lhs, rhs) {
        case (.success(let lhsValue), .success(let rhsValue)): return lhsValue == rhsValue
        default: return false
        }
    }
}
