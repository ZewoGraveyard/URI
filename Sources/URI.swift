// URI.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Zewo
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import CURIParser
@_exported import String
@_exported import C7

public enum URIError : ErrorProtocol {
    case invalidURI
}

extension URI.UserInfo: Hashable, CustomStringConvertible {
    public var hashValue: Int {
        return description.hashValue
    }

    public var description: String {
        return "\(username):\(password)"
    }
}

extension URI {
    public init(_ string: String) throws {
        let u = parse_uri(string)

        if u.error == 1 {
            throw URIError.invalidURI
        }

        if u.field_set & 1 != 0 {
            let string = URI.getSubstring(string, start: u.scheme_start, end: u.scheme_end)
            scheme = try String(percentEncoded: string)
        } else {
            scheme = nil
        }

        if u.field_set & 2 != 0 {
            let string = URI.getSubstring(string, start: u.host_start, end: u.host_end)
            host = try String(percentEncoded: string)
        } else {
            host = nil
        }

        if u.field_set & 4 != 0 {
            port = Int(u.port)
        } else {
            port = nil
        }

        if u.field_set & 8 != 0 {
            let string = URI.getSubstring(string, start: u.path_start, end: u.path_end)
            path = try String(percentEncoded: string)
        } else {
            path = nil
        }

        if u.field_set & 16 != 0 {
            query = URI.getSubstring(string, start: u.query_start, end: u.query_end)
        } else {
            query = nil
        }

        if u.field_set & 32 != 0 {
            let string = URI.getSubstring(string, start: u.fragment_start, end: u.fragment_end)
            fragment = try String(percentEncoded: string)
        } else {
            fragment = nil
        }

        if u.field_set & 64 != 0 {
            let userInfoString = URI.getSubstring(string, start: u.user_info_start, end: u.user_info_end)
            userInfo = URI.parse(userInfoString: userInfoString)
        } else {
            userInfo = nil
        }

        if scheme == nil && host == nil && port == nil && path == nil && query == nil && fragment == nil && userInfo == nil {
            throw URIError.invalidURI
        }
    }

    @inline(__always) private static func getSubstring(_ string: String, start: UInt16, end: UInt16) -> String {
        return string[string.index(string.startIndex, offsetBy: Int(start)) ..< string.index(string.startIndex, offsetBy: Int(end))]
    }

    @inline(__always) private static func parse(userInfoString: String) -> URI.UserInfo? {
        let userInfoElements = userInfoString.split(separator: ":")
        if userInfoElements.count == 2 {
            if let
                username = try? String(percentEncoded: userInfoElements[0]),
                password = try? String(percentEncoded: userInfoElements[1]) {
                    return URI.UserInfo(
                        username: username,
                        password: password
                    )
            }
        }

        return nil
    }

    @inline(__always) private static func parse(queryString: String) -> [String: [String?]] {
        var queries: [String: [String?]] = [:]
        let queryTuples = queryString.split(separator: "&")
        for tuple in queryTuples {
            let queryElements = tuple.split(separator: "=", omittingEmptySubsequences: false)
            if queryElements.count == 1 {
                if let key = try? String(percentEncoded: queryElements[0]) {
                    let values = queries[key] ?? []
                    queries[key] = values + [nil]
                }
            } else if queryElements.count == 2 {
                if let
                    key = try? String(percentEncoded: queryElements[0]),
                    value = try? String(percentEncoded: queryElements[1]) {
                    let values = queries[key] ?? []
                    queries[key] = values + ([value] as [String?])
                }
            }
        }
        return queries
    }
}

extension URI: CustomStringConvertible {
    public var description: String {
        var string = ""

        if let scheme = scheme {
            string += "\(scheme)://"
        }

        if let userInfo = userInfo {
            string += "\(userInfo)@"
        }

        if let host = host {
            string += "\(host)"
        }

        if let port = port {
            string += ":\(port)"
        }

        if let path = path {
            string += "\(path)"
        }

        if let query = query {
            string += "\(query)"
        }

        if let fragment = fragment {
            string += "#\(fragment)"
        }

        return string
    }
}

extension URI {
    public func percentEncoded() throws -> String {
        var string = ""

        if let scheme = scheme {
            string += "\(scheme)://"
        }

        if let userInfo = userInfo {
            string += "\(userInfo)@"
        }

        if let host = host {
            string += "\(host)"
        }

        if let port = port {
            string += ":\(port)"
        }

        if let path = path {
            string += "\(path)"
        }

        if let query = try query?.percentEncoded(allowing: CharacterSet.uriQueryAllowed) {
            string += "\(query)"
        }

        if let fragment = fragment {
            string += "#\(fragment)"
        }

        return string
    }
}

extension URI: Hashable {
    public var hashValue: Int {
        return description.hashValue
    }
}

public func ==(lhs: URI, rhs: URI) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

public func ==(lhs: URI.UserInfo, rhs: URI.UserInfo) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
