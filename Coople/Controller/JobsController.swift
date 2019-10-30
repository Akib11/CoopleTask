//
//  ViewController.swift
//  Coople
//
//  Created by Akib Quraishi on 10/10/2019.
//  Copyright © 2019 AkibMakesApps. All rights reserved.
//

import UIKit

class JobsController: UITableViewController {

    private let cellID = "CellID"
    private let jobViewModel = JobViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        
        jobViewModel.fetchFBRestaurants()
        jobViewModel.delegate = self
    }

    private func setupViews()  {
        self.navigationItem.title = "Coople Jobs"
        tableView.register(JobCell.self, forCellReuseIdentifier: cellID)
    }

}

// MARK: - Tableview Data Source Functions
extension JobsController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobViewModel.getJobsCount()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! JobCell
        
        let jobDetails = jobViewModel.getJobAtIndex(index: indexPath.item)
        
        cell.workAssignmentLabel.text = jobDetails.workAssignmentName
        cell.addressStreetLabel.text = jobDetails.addressStreet
        cell.zipLabel.text = jobDetails.zip
        cell.cityLabel.text = jobDetails.city
        
        return cell
    }
}



 // MARK: - Tableview Delegate Funtions
extension JobsController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
   
}


// MARK: - JobViewModelDelegate Funtions
extension JobsController: JobViewModelDelegate {
    
    func DidReceiveJobData() {
        DispatchQueue.main.async { self.tableView.reloadData()}
    }
    
    func RretrieveCachedJobData() {
         DispatchQueue.main.async { self.tableView.reloadData()}
    }
    
    
}
