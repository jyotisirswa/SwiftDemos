//
//  ListService.swift
//  LevelShoeCaseStudy
//  Created by Jyoti on 16/10/2022.
//

import Foundation


protocol ListServiceable {
    func getItemList() async -> Result<ShoppingList, RequestError>
}

struct ListService: HTTPClient, ListServiceable {
    func getItemList() async -> Result<ShoppingList, RequestError> {
        return await sendRequest(endpoint: ListEndpoint.shoppingList, responseModel: ShoppingList.self)
    }
}
