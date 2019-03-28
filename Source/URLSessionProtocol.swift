//
//  URLSessionProtocol.swift
//  DogYears
//
//  Created by Đỗ Tấn Khoa on 3/28/19.
//  Copyright © 2019 Razeware. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession : URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let task = dataTask(with: request, completionHandler: completionHandler) as URLSessionTask
        return task as! URLSessionDataTaskProtocol
    }
}
