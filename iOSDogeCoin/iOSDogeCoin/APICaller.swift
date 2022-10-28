//
//  APICaller.swift
//  iOSDogeCoin
//
//  Created by Furkan Ademoğlu on 28.10.2022.
//

import Foundation

final class APICaller{
    static let shared = APICaller()
    
    private init(){}
    
    struct Constants{
        static let apikey = "cf928265-d9b9-4abd-afb9-4d80207aaaf7"
        static let apikeyHeader = "X-CMC_PRO_API_KEY"
        static let baseUrl = "https://pro-api.coinmarketcap.com/v1/"
        static let doge = "dogecoin"
        static let endpoint = "cryptocurrency/quotes/latest"
    }
    
    enum APIError: Error{
        case invalidUrl
    }
    
    public func getDogeCoindata(completion: @escaping(Result<DogeCoinData,Error>) -> Void){
        
        guard let url = URL(string: Constants.baseUrl + Constants.endpoint + "?slug=" + Constants.doge) else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.apikey, forHTTPHeaderField: Constants.apikeyHeader)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request){data , _,error in
            if let error = error{
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do{
                let response = try JSONDecoder().decode(APIResponse.self, from: data)
                guard let dogeCoinData = response.data.values.first else {
                    return
                }
                completion(.success(dogeCoinData))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
}
