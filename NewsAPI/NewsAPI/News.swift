//
//  news.swift
//  NewsAPI
//
//  Created by Fancy Tseng on 2/24/21.
//
//
//import Foundation

import Foundation

class News {
    var author : String = ""
    var title : String = ""
    var desc : String = ""

    init(author : String, title : String, desc : String) {
        self.author = author
        self.title = title
        self.desc  = desc
    }
}
