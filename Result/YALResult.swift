//
//  YALResult.swift
//  Result
//
//  Created by Vodolazkyi Anton on 9/19/18.
//

import Foundation

public enum YALResult<T> {
    
    case success(T)
    case failure(Error)
    
    public var value: T? {
        switch self {
        case .success(let result): return result
        case .failure: return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .success: return nil
        case .failure(let error): return error
        }
    }
}

extension YALResult {
    
    @discardableResult
    public func map<U>(_ f: (T) -> U) -> YALResult<U> {
        switch self {
        case .success(let t): return .success(f(t))
        case .failure(let error): return .failure(error)
        }
    }
    
    @discardableResult
    public func map<U>(_ f: () -> U) -> YALResult<U> {
        switch self {
        case .success: return .success(f())
        case .failure(let error): return .failure(error)
        }
    }
    
    @discardableResult
    public func next<U>(_ f: (T) -> YALResult<U>) -> YALResult<U> {
        switch self {
        case .success(let t): return f(t)
        case .failure(let error): return .failure(error)
        }
    }
    
    @discardableResult
    public func next<U>(_ f: () -> YALResult<U>) -> YALResult<U> {
        switch self {
        case .success: return f()
        case .failure(let error): return .failure(error)
        }
    }
    
    @discardableResult
    public func onError(_ f: (Error) -> Error) -> YALResult<T> {
        switch self {
        case .success(let value): return .success(value)
        case .failure(let error): return .failure(f(error))
        }
    }
    
    @discardableResult
    public func require() -> T {
        switch self {
        case .success(let value): return value
        case .failure(let error): fatalError("Value is required: \(error)")
        }
    }
}
