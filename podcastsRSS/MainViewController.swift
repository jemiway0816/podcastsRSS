//
//  MainViewController.swift
//  podcastsRSS
//
//  Created by Jemiway on 2022/9/27.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {

    var items = [Result]()
    var index = 0
    
    @IBOutlet var rssName: UILabel!
    @IBOutlet var rssPicture: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fatch()
    }
    
    @IBSegueAction func showRSS(_ coder: NSCoder) -> ViewController? {
        
        let controller = ViewController(coder: coder)
        controller?.item = self.items[index]
        return controller
    }
    
    @IBAction func nextRSS(_ sender: Any) {
        
        index += 1
        showItemMsg()
    }
    
    @IBAction func prevRSS(_ sender: Any) {
        
        if index > 0 {
            index -= 1
        }
        showItemMsg()
    }
    
    
    func showItemMsg() {
  
        rssName.text = items[index].name
        rssPicture.kf.setImage(with: URL(string: items[index].artworkUrl100))
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
                            
                            self.showItemMsg()
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
