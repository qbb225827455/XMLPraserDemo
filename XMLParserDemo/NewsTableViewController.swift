//
//  NewsTableViewController.swift
//  XMLParserDemo
//
//  Created by 陳鈺翔 on 2022/8/17.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    enum CellState {
        case expanded
        case collapsed
    }
    
    var rssItems: [Item]?
    var cellStates: [CellState]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 150.0
        tableView.rowHeight = UITableView.automaticDimension
        
        let feedURL = "https://www.nasa.gov/rss/dyn/breaking_news.rss"
        
        let feedParser = FeedParser()
        feedParser.parseFeed(feedUrl: feedURL, completionHandler: { (rssItems: [Item]) -> Void in
            
            self.rssItems = rssItems
            self.cellStates = [CellState](repeating: .collapsed, count: rssItems.count)
            OperationQueue.main.addOperation( { () -> Void in
                self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            })
        })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let rssItems = rssItems else {
            return 0
        }
        
        return rssItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        if let item = rssItems?[indexPath.row] {
            cell.titleLabel.text = item.title
            cell.descriptionLabel.text = item.description
            cell.dateLabel.text = item.pubDate
            
            if let cellStates = cellStates {
                cell.descriptionLabel.numberOfLines = cellStates[indexPath.row] == .expanded ? 0 : 4
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        let lines = cell.descriptionLabel.numberOfLines == 0 ? 4 : 0
        let state: CellState = lines == 0 ? .expanded : .collapsed
        
        tableView.beginUpdates()
        cell.descriptionLabel.numberOfLines = lines
        cellStates?[indexPath.row] = state
        tableView.endUpdates()
    }
}
