//
//  APIManager.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/08.
//

import Foundation
import Alamofire


final class APIManager {
    static let shared = APIManager()
    
    private let header: HTTPHeaders = ["X-Naver-Client-Id": APIKeys.naverClientID, "X-Naver-Client-Secret": APIKeys.naverClientSecret]
    
    private init() {}
    
    func requestSearchShopping(_ searchKeyword: String, page: Int, completionHandler: @escaping (SearchShoppingModel?)-> Void){
        guard let keyword = searchKeyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        guard let url = URL(string: EndPoint.searchShopping.getURL+"?query=\(keyword)&display=30&start\(page)") else {
            print("URL error")
            return
            
        }

        AF.request(url, headers: header).validate().responseDecodable(of: SearchShoppingModel.self) { response in
            switch response.result {
            case .success(let value):
                print(value)
                completionHandler(value)
            case .failure(let error):
                print(error)
                completionHandler(nil)
            }
        }
        

    }
    
    func requestSearchShoppingURLSession(_ searchKeyword: String, page: Int, completionHandler: @escaping (SearchShoppingModel?)-> Void){
        guard let keyword = searchKeyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        
        let query: [String: String] = ["query": searchKeyword, "display": "30", "start": "\(page)"]

        let queryItems = query.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        guard var urlComponent = URLComponents(string: EndPoint.searchShopping.getURL) else {
            completionHandler(nil)
            return

        }
        urlComponent.queryItems = queryItems

        guard let url = urlComponent.url else {return}
        var request = URLRequest(url: url, timeoutInterval: 10) //10초를 기준으로 URL요청을 수행한다.
//        request.httpMethod = "GET" //GET을 수행한다.

        
        let header: [String: String] = ["X-Naver-Client-Id": APIKeys.naverClientID, "X-Naver-Client-Secret": APIKeys.naverClientSecret]
        _ = header.map({ (key, value) in
            request.addValue(key, forHTTPHeaderField: value)
        })


        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    completionHandler(nil)
                    return
                }

                guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else{
                    completionHandler(nil)
                    return
                }

                guard let data = data else {
                    completionHandler(nil)
                    return

                }

                do{
                    let result = try JSONDecoder().decode(SearchShoppingModel.self, from: data)
                    print(result)
                    completionHandler(result)
                } catch {
                    print(error)
                    completionHandler(nil)
                }
            }
        }
                
    }
}
