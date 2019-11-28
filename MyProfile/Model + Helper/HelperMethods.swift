//
//  HelperMethods.swift
//  Chandago Test
//
//  Created by Brian Corrieri on 31/10/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation
import CryptoKit

class HelperMethods {
    
    static let shared = HelperMethods()
    
    func hashString(string: String) -> String {
            let inputData = Data(string.utf8)
            let hashed = SHA256.hash(data: inputData)
            let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
            return hashString
        }
        
    func getUID() -> String {
        let defaults = UserDefaults.standard
        if let UID = defaults.string(forKey: "UID") {
            return UID
        } else {
            let UID = UUID().uuidString
            defaults.set(UID, forKey: "UID")
            return UID
        }
    }
    
    func getData(urlString: String, completion: @escaping (Data?) -> ()) {
        
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return completion(nil)
        }
        let urlRequest = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("error calling getData")
                print(error!)
                return completion(nil)
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return completion(nil)
            }
            print("got data from url")
            return completion(responseData)
        }
        task.resume()
        
    }
    
    func sendData(uploadData: Data, to url: String, completion: @escaping (Bool) -> ()) {
            
            let url = URL(string: url)!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
                if let error = error {
                    print ("error: \(error)")
                    return completion(false)
                }
                guard let response = response as? HTTPURLResponse else {
                    print ("server error")
                    return completion(false)
                }
                if !(200...299).contains(response.statusCode) {
                    print ("server error \(response.statusCode) \(response)")
                    return completion(false)
                }
                if  let data = data,
                    let dataString = String(data: data, encoding: .utf8) {
                    print ("got data: \(dataString)")
                    completion(true)
                }
            }
            task.resume()
            
        }
    
}
