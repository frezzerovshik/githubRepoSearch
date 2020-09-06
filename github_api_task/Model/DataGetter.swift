//
//  DataGetter.swift
//  github_api_task
//
//  Created by Артем Шарапов on 04.09.2020.
//  Copyright © 2020 Artem Sharapov. All rights reserved.
//

import Foundation

class DataGetter {
    
    func getRepositoriesList(with request: String) -> SearchResult {
        var res = SearchResult()
        var flag = false
        let endpoint = URL(string: "https://api.github.com/search/repositories?q=\(request)&sort=stars&order=desc")
        guard let completeUrl = endpoint else {
            return res
        }
        URLSession.shared.dataTask(with: completeUrl) {(data, response, error) in
            guard let completeData = data else {
                return
            }
            if case .success(let result) = self.decodeResults(data: completeData) {
                res = result
                flag = true
                print("From method getReposList: \(result)")
            }
        }.resume()
        while flag == false {}
        return res
    }
    
    //Декодирование результатов поиска по репо
    func decodeResults(data: Data) -> Result<SearchResult, Error> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = Result {try decoder.decode(SearchResult.self, from: data)}
        result.mapError { (e) -> Error in
            print(e)
            return e
        }
        return result
    }
    
    //Запрос на получение данных о пользователе
    func getUser(with name: String) -> User {
        var res = User()
        var flag = false
        let endpoint = URL(string: "https://api.github.com/users/\(name)")
        print(endpoint!)
        guard let completeUrl = endpoint else {
            return res
        }
        URLSession.shared.dataTask(with: completeUrl){(data, response, error) in
            guard let completeData = data else {
                return
            }
            if case .success(let result) = self.decodeUser(data: completeData) {
                res = result
                print("from method: getUser: \(result)\n inserted: \(res)")
                flag = true
            }
        }.resume()
        while flag == false {}
        return res
    }
    
    //Декодирование данных о пользователе
    func decodeUser(data: Data) -> Result<User, Error> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = Result{ try decoder.decode(User.self, from: data)}
        result.mapError { (e) -> Error in
            print(e)
            return e
        }
        return result
    }
    
}
