
//  CSError.swift

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
* MODULE SUMMARY : This is independent class which we are using  *
  returing error with repective message and error code           *
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

internal enum CSError {
    enum MultipartEncodingFailureReason {
        case outputStreamWriteFailed
        case inputStreamReadFailed
        case outputStreamCreationFailed
        case outputStreamFileAlreadyExists
        case outputStreamURLInvalid
        case bodyPartInputStreamCreationFailed(url: URL)
        case bodyPartFileSizeQueryFailedWithError(url: URL)
        case bodyPartFileIsDirectory(url: URL)
        case bodyPartFileSizeNotAvailable(url: URL)
        case bodyPartFileNotReachableWithError(url: URL)
        case bodyPartFileNotReachable(url: URL)
        case bodyPartURLInvalid(url: URL)
        case bodyPartFilenameInvalid(url: URL)
    }
    case json
    case noResponse
    case noError
    case noInternet
    case invalidURL
    case invalidRequest
    case paramIncodeFaild
    case tokenExpire(Int)
    case multipartEncodingFailed(reason: MultipartEncodingFailureReason)
    
}

extension CSError {
    internal var readbleMessage: String {
        switch self {
        case .json: return "We are not getting expected json response or getting null resposne from the API"
        case .noResponse: return "No response received from API."
        case .noError: return "No error received from api."
        case .noInternet: return "No Internet connection. Please check your internet connect."
        case .invalidURL: return "Invalid URL"
        case .invalidRequest: return "Invalid Get Request."
        case .paramIncodeFaild: return "Failed to encode post parameters."
        case .multipartEncodingFailed: return "Multipart encoding Failed."
        case .tokenExpire: return ""
        }
    }
    internal func error(msg: String) ->NSError {
        return NSError.init(domain: "AppDomain", code: self.errorCode, userInfo:["message": self.readbleMessage + msg])
    }
    var errorCode: Int {
        switch self {
        case .json: return 10001
        case .noResponse: return 10002
        case .noError: return 10003
        case .noInternet: return 10004
        case .invalidURL: return 10005
        case .invalidRequest: return 10006
        case .paramIncodeFaild: return 10007
        case .multipartEncodingFailed: return 10008
        case .tokenExpire(let errorCode): return errorCode
        }
    }
}

