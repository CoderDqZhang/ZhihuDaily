//
//  Story.swift
//  Zhihu Daily
//
//  Created by kemchenj on 7/20/16.
//  Copyright © 2016 kemchenj. All rights reserved.
//

import UIKit



struct Story {
    
    var id: Int
    var title: String
    var thumbNailURLString: String
    
    var storyURL: String {
        return "https://news-at.zhihu.com/api/4/news/\(id)"
    }
    
    var thumbNailURL: URL {
        return URL(string: thumbNailURLString.replacingOccurrences(of: "http", with: "https"))!
    }
    
     init(id: Int, title: String, thumbNailURL: String) {
        self.id = id
        self.title = title
        self.thumbNailURLString = thumbNailURL
    }
    
}

// MARK: - 给BannerView展示用的数据
extension Story: ModelBannerCanPresent {
    
    var bannerTitle: String {
        return title
    }
    
    var bannerImageURL: URL? {
        return URL(string: thumbNailURLString.replacingOccurrences(of: "http", with: "https"))
    }
    
    var bannerImage: UIImage? {
        return nil
    }
}

// MARK: - JSON转模型
extension Story: JSONParsable {
    
    static func parse(json: AnyObject) throws -> Story {
        guard let title = json["title"] as? String else {
            let message = "Expected stories String"
            throw ParseError.missingAttribute(message: message)
        }
        
        guard let id = json["id"] as? Int else {
            let message = "Expected id Int"
            throw ParseError.missingAttribute(message: message)
        }
        
        guard let thumbNailURL = (json["images"] as? [String])?.first ?? json["image"] as? String else {
            let message = "Expected image urlString"
            throw ParseError.missingAttribute(message: message)
        }
        
        return Story(id: id,
                     title: title,
                     thumbNailURL: thumbNailURL
        )
    }
}
