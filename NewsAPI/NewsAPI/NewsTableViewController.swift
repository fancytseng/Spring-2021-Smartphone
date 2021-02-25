//
//  NewsTableViewController.swift
//  NewsAPI
//
//  Created by Fancy Tseng on 2/24/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class NewsTableViewController: UITableViewController {

    @IBOutlet var tblNews: UITableView!
    
    var newsArr : [News] = [News]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        getData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsArr.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        cell.lblTitle.text = newsArr[indexPath.row].title
        return cell
    }

    func getURL() -> String {
        return apiURL + apiKey
    }

    func getData() {

        let url = getURL()

        SwiftSpinner.show("Getting News Information")

        AF.request(url).responseJSON { response in

            SwiftSpinner.hide()

            if response.error == nil {
                guard let data = response.data else {return}
                guard let newsList = JSON(data)["articles"].array else {return}

                if newsList.count == 0 {
                    return
                }

                for news in newsList {
                    let author = news["author"].stringValue
                    let title = news["title"].stringValue
                    let description = news["description"].stringValue

                    self.newsArr.append(News(author: author, title: title, desc: description))

                }

                self.tblNews.reloadData()

            } // end of response.error == nil
            
        } // end of AF request
        
    } // end of get data  function
}
