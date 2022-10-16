//
//  MainViewController.swift
//  podcastsRSS
//
//  Created by Jemiway on 2022/9/27.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: myTableView!
    var items = [Result]()
    var index = 0
    var colorValue = 0.0
    var colorDirect = true
    
    @IBOutlet var rssName: UILabel!
    @IBOutlet var rssPicture: UIImageView!
    
    @IBOutlet weak var rssIconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.dataSource = self
        rssIconImageView.layer.cornerRadius = 10
        fatch()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "\(mainTableViewCell.self)", for: indexPath) as! mainTableViewCell
        
        let item = items[indexPath.row]

        cell.cellImageView.kf.setImage(with: URL(string: item.artworkUrl100))
        cell.cellLabel.text = item.name
        cell.cellNameLabel.text = item.artistName
        
        if colorValue > 0.9 {
            colorDirect = false
        }
        if colorValue < 0.1 {
            colorDirect = true
        }

        if colorDirect == true {
            colorValue += 0.1
        } else {
            colorValue -= 0.1
        }
        cell.backgroundColor = UIColor(red: 0, green: colorValue, blue: 1-colorValue, alpha: 0.3)
        
        return cell
    }
    
    @IBSegueAction func showDetail(_ coder: NSCoder) -> ViewController? {
        
        let controller = ViewController(coder: coder)
        
        if let row = myTableView.indexPathForSelectedRow?.row  {
            
            controller?.item = self.items[row]
        }
            
        return controller
    }
    
    func fatch() {
        
        if let url = URL(string: "https://rss.applemarketingtools.com/api/v2/tw/podcasts/top/25/podcasts.json") {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let data {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        
                        let welcome = try decoder.decode(Welcome.self, from: data)
                        
                        self.items = welcome.feed.results
                       
                        let item = self.items[self.index]
                        
                        DispatchQueue.main.async {
                            
                            self.myTableView.reloadData()
//                            self.showItemMsg()
                        }
                        
                        print(item.artistName)
                        print(item.kind)
                        print(item.artworkUrl100)
                        print(item.name)
                        
                    } catch  {
                        
                        print(error)
                    }
                }
                
            }.resume()
        }
    }
}



