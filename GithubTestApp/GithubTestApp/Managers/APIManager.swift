//
//  APIManager.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 28.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation
import Alamofire

//  api.github.com/search/repositories?page=1&per_page=5&q=tetris+language:assembly&sort=stars&order=desc

class APIManager {
    func searchRepositories(withPageNumber page: Int, resultsCount count: Int, searchQuery query: String? = "", completion: ((GitHubResponse?, Error?) -> Void)?) {
        let query = query ?? ""
        let requestString = "https://api.github.com/search/repositories?page=\(page)&per_page=\(count)&q=\(query)+language:assembly&sort=stars&order=desc"
        _ = Alamofire.request(requestString, method: .get).responseObject { (response: DataResponse<GitHubResponse>) in
            completion?(response.result.value, response.result.error)
        }
    }
    func searchRepositoriesError(withPageNumber page: Int, resultsCount count: Int, searchQuery query: String? = "", completion: ((GitHubResponse?, Error?) -> Void)?) {
        let query = query ?? ""
        let requestString = "https://api.github.com/search/repositories?page=\(page)&per_page=\(count)?q=\(query)+language:assembly&sort=stars&order=desc"
        _ = Alamofire.request(requestString, method: .get).responseObject { (response: DataResponse<GitHubResponse>) in
            completion?(response.result.value, response.result.error)
        }
    }

    
    func cancelAllTasks() {
        Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
            _ = tasks.map({ $0.cancel() })
        }
    }
}
