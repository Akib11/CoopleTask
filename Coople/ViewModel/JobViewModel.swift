//
//  JobViewModel.swift
//  Coople
//
//  Created by Akib Quraishi on 10/10/2019.
//  Copyright © 2019 AkibMakesApps. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol JobViewModelDelegate {
    func DidReceiveJobData()
    func RretrieveCachedJobData()
}

class JobViewModel {
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var delegate: JobViewModelDelegate?
    private var jobs = [JobDetails]()
    private let networkService:NetworkService?
    
    //Dependecny injection
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    
    func getJobs() {
        
        
        let urlStr = "https://www.coople.com/resources/api/work-assignments/public-jobs/list?pageNum=0&pageSize=200"
        
        networkService?.fetchRequest(urlString: urlStr, httpMethod: .get) { (_ result: Result<JobModel,Error>) in
            
            switch result {
            case .success(let JobsResult):

                if JobsResult.error == false {
                
                DispatchQueue.main.async {
                   self.clearCacheJobsData()
                   self.insertJobsToCoreData(jobList: JobsResult.data.items)
                   self.fetchCacheJobsData()
                   self.delegate?.DidReceiveJobData()
                }
                } else {
                   // Parse ERROR and show error message.
                   // Out of scope for this Coople iOS Task
                }
            case .failure(let err):
                print("Error: ", err.localizedDescription)
                DispatchQueue.main.async {
                    // Offline
                    self.fetchCacheJobsData()
                    self.delegate?.RretrieveCachedJobData()
                }
                
            }
            
        }
        
    }
    
    func getJobsCount() -> Int {
        return jobs.count
    }
    
    func getJobAtIndex(index:Int) -> JobDetails {
        return jobs[index]
    }
    
    
    private func insertJobsToCoreData(jobList:[items])  {
        
        for job in jobList {
            
            let jobDetail = JobDetails(entity: JobDetails.entity(), insertInto: self.context)
            
            jobDetail.workAssignmentName = job.workAssignmentName
            jobDetail.addressStreet = job.jobLocation.addressStreet
            jobDetail.city = job.jobLocation.city
            jobDetail.zip = job.jobLocation.zip
            
            self.appDelegate.saveContext()
        }
 
    }
    
    
    private func fetchCacheJobsData(){
        do {
            jobs = try context.fetch(JobDetails.fetchRequest())
            print("Cached Count: \(jobs.count)")
        } catch let error as NSError {
            print("Could not fetch cache event data. \(error), \(error.userInfo)")
        }
    }
    
    
    private func clearCacheJobsData() {
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "JobDetails")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("Error deleting cache job data")
        }
    }
    
}
