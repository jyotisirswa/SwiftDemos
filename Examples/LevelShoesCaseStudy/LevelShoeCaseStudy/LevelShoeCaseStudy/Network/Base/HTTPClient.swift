//
//  HTTPClient.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 16/10/2022.
//

import Foundation
import RealmSwift

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async -> Result<T, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
                    //print(decodedResponse)
                    if  let shopList = decodedResponse as? ShoppingList {
                        DispatchQueue.main.async {
                            guard let realm = RealmProvider.default.realm else {
                                return
                            }
                            let filteredProducts = (wishListArray : ListItem.wishList(), cartListArray : ListItem.cartList())
                            if filteredProducts.wishListArray.count > 0 {
                                shopList.items.forEach { $0.isWishListed =  filteredProducts.0.filter("id == '\($0.id)'").count != 0 ? true : false }
                            }
                            if filteredProducts.1.count > 0 {
                                shopList.items.forEach { $0.isCartAdded =  filteredProducts.1.filter("id == '\($0.id)'").count != 0 ? true : false }
                            }
                            try? realm.write({
                                realm.add(shopList.items, update: .modified)
                            })
                        }
                    }
                    return .success(decodedResponse)
                }
                catch {
                    //print("Decoding failed with error: \(error)")
                    return .failure(.decode(error.localizedDescription))
                }
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}


extension MutableCollection {
    mutating func mapProperty<T>(_ keyPath: WritableKeyPath<Element, T>, _ value: T) {
        indices.forEach { self[$0][keyPath: keyPath] = value }
    }
}

extension Array
{
    mutating func mapInPlace(transform: (inout Element) -> Void)
    {
        for i in 0 ..< self.count
        {
            transform(&self[i])
        }
    }
}
