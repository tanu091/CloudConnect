//
//  URLConvertible+URLRequestConvertible.swift

/*
******************************************************************
* COPYRIGHT (c) <<2020>> <<tanu inc  >>         *
*
 * All rights reserved                                           *
*
 * This software embodies materials and concepts which are       *
* confidential to <<Customer Name>> and is made available solely *
* pursuant to the terms of a written license agreement with      *
* <<tanu Product>>.                                            *
*
* Designed and Developed by tanu inc Industries, Inc.
.           *
*----------------------------------------------------------------*
* MODULE OR UNIT: CloudService                                *
*
* PROGRAMMER :  Tanuja Awasthi                                   *
* DATE       :  19/07/20                                         *
* VERSION    :  1.0                                              *
*
*----------------------------------------------------------------*
*
* MODULE SUMMARY : Request and url convertable method           *
*
*
*
*
*----------------------------------------------------------------*
*
* TRACEABILITY RECORDS to SW requirements and detailed design :  *
* iOS 10 and onward
*
*
*----------------------------------------------------------------*
*
* MODIFICATION RECORDS                                           *
*
******************************************************************
*/

import Foundation

/// Types adopting the `URLConvertible` protocol can be used to construct `URL`s, which can then be used to construct
/// `URLRequests`.
public protocol URLConvertible {
    /// Returns a `URL` from the conforming instance or throws.
    ///
    /// - Returns: The `URL` created from the instance.
    /// - Throws:  Any error thrown while creating the `URL`.
    func asURL() throws -> URL
}

extension String: URLConvertible {
    /// Returns a `URL` if `self` can be used to initialize a `URL` instance, otherwise throws.
    ///
    /// - Returns: The `URL` initialized with `self`.
    /// - Throws:  An `AFError.invalidURL` instance.
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw CSError.invalidURL.error(msg: "") }

        return url
    }
}

extension URL: URLConvertible {
    /// Returns `self`.
    public func asURL() throws -> URL { self }
}

extension URLComponents: URLConvertible {
    /// Returns a `URL` if the `self`'s `url` is not nil, otherwise throws.
    ///
    /// - Returns: The `URL` from the `url` property.
    /// - Throws:  An `AFError.invalidURL` instance.
    public func asURL() throws -> URL {
        guard let url = url else { throw CSError.invalidURL.error(msg: "") }

        return url
    }
}

// MARK: -

/// Types adopting the `URLRequestConvertible` protocol can be used to safely construct `URLRequest`s.
public protocol URLRequestConvertible {
    /// Returns a `URLRequest` or throws if an `Error` was encountered.
    ///
    /// - Returns: A `URLRequest`.
    /// - Throws:  Any error thrown while constructing the `URLRequest`.
    func asURLRequest() throws -> URLRequest
}

extension URLRequestConvertible {
    /// The `URLRequest` returned by discarding any `Error` encountered.
    public var urlRequest: URLRequest? { try? asURLRequest() }
}

extension URLRequest: URLRequestConvertible {
    /// Returns `self`.
    public func asURLRequest() throws -> URLRequest { self }
}

// MARK: -

extension URLRequest {
    /// Creates an instance with the specified `url`, `method`, and `headers`.
    ///
    /// - Parameters:
    ///   - url:     The `URLConvertible` value.
    ///   - method:  The `HTTPMethod`.
    ///   - headers: The `HTTPHeaders`, `nil` by default.
    /// - Throws:    Any error thrown while converting the `URLConvertible` to a `URL`.
    public init(url: URLConvertible, method: HTTPMethod, headers: HTTPHeaders? = nil) throws {
        let url = try url.asURL()

        self.init(url: url)

        httpMethod = method.rawValue
        allHTTPHeaderFields = headers?.dictionary
    }
}
