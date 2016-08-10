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
    var thumbNailURL: String
    
    var storyURL: String {
        return "https://news-at.zhihu.com/api/4/news/\(id)"
    }
    
    var thumbNailURLL: URL {
        return URL(string: thumbNailURL)!
    }
    
    private init(id: Int, title: String, thumbNailURL: String) {
        self.id = id
        self.title = title
        self.thumbNailURL = thumbNailURL
    }
    
}

// 给BannerView展示用的数据
extension Story: ModelBannerCanPresent {
    
    var bannerTitle: String {
        return title
    }
    
    var bannerImageURL: URL? {
        return URL(string: thumbNailURL.replacingOccurrences(of: "http", with: "https"))
    }
    
    var bannerImage: UIImage? {
        return nil
    }
}

// JSON转模型
extension Story: DecodeableModel {
    
    static func decode(json: AnyObject) throws -> Story {
        guard let title = json["title"] as? String,
              let id = json["id"] as? Int,
              let thumbNailURL = (json["images"] as? [String])?.first ?? json["image"] as? String else {
                throw NetworkClientError.invalidContent
        }
        
        return Story(id: id,
                     title: title,
                     thumbNailURL: thumbNailURL
        )
    }
}