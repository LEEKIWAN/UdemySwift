//
//  TableViewController.swift
//  UdemySwift
//
//  Created by 이기완 on 2018. 3. 25..
//  Copyright © 2018년 이기완. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    
    var sampleData = SampleData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! MainTableViewCell
        
        tableViewCell.titleLabel.text = sampleData.data[indexPath.row].title
        tableViewCell.subTitleLabel.text = sampleData.data[indexPath.row].subTitle
        tableViewCell.mainImageView.image = UIImage.init(named: sampleData.data[indexPath.row].image)
        
        return tableViewCell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(indexPath.row == 0) {
            let storyboard = UIStoryboard(name: "PhotoLibraryViewController", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "PhotoLibrary")
            navigationController?.pushViewController(controller, animated: true)
        }
        else if(indexPath.row == 1) {
            let storyboard = UIStoryboard(name: "RealTimeViewController", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "RealTime")
            navigationController?.pushViewController(controller, animated: true)
        }
        else if(indexPath.row == 2) {
            let storyboard = UIStoryboard(name: "FacialAnalysisViewController", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "FacialAnalysis")
            navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
