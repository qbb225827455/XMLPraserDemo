//
//  FeedParser.swift
//  XMLParserDemo
//
//  Created by 陳鈺翔 on 2022/8/17.
//

import Foundation

typealias Item = (title: String, description: String, pubDate: String)

class FeedParser: NSObject, XMLParserDelegate {
    
    var rssItems: [Item] = []
    
    enum RssTag: String {
        case item = "item"
        case title = "title"
        case description = "description"
        case pubDate = "pubDate"
    }
    
    var currentElement = ""
    var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    var currentDescription: String = "" {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    var currentPubDate: String = "" {
        didSet {
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var parserCompletionHandler:(([(title: String, description: String, pubDate: String)]) -> Void)?
    
    func parseFeed(feedUrl: String, completionHandler: (([(title: String, description: String, pubDate: String)]) -> Void)?) -> Void {
        
        self.parserCompletionHandler = completionHandler
        
        let request = URLRequest(url: URL(string: feedUrl)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        })
        
        task.resume()
    }
    
    // MARK: - XMLParserDelegate methods
    
    func parserDidStartDocument(_ parser: XMLParser) {
        rssItems = []
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        
        // 找到 item 標籤，重設暫存變數為空
        if currentElement == RssTag.item.rawValue {
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElement {
        case RssTag.title.rawValue:
            currentTitle += string
            
        case RssTag.description.rawValue:
            currentDescription += string
            
        case RssTag.pubDate.rawValue:
            currentPubDate += string
            
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == RssTag.item.rawValue {
            let rssItem = (title: currentTitle, description: currentDescription, pubDate: currentPubDate)
            rssItems.append(rssItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
