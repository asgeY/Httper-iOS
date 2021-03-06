//
//  ProjectsViewModel.swift
//  Httper
//
//  Created by Meng Li on 2018/9/12.
//  Copyright © 2018 MuShare Group. All rights reserved.
//

import RxSwift
import RxCocoa

class ProjectsViewModel: BaseViewModel {
    
    private let projects = BehaviorRelay<[Project]>(value: DaoManager.shared.projectDao.findAll())
    
    override init() {
        super.init()
        syncProjects()
    }
    
    func syncProjects(completion: (() -> ())? = nil) {
        // Pull remote projects from server
        SyncManager.shared.pullUpdatedProjects { [weak self] revision in
            // Pull successfully.
            if revision > 0 {
                self?.projects.accept(DaoManager.shared.projectDao.findAll())
                
                // Push local projects to server in background.
                SyncManager.shared.pushLocalProjects(nil)
            }
            completion?()
        }
    }
    
    var projectSection: Observable<SingleSection<Project>> {
        return projects.map { SingleSection.create($0) }
    }

    func pickProject(at index: Int) {
        guard index < projects.value.count else {
            return
        }
        steps.accept(ProjectStep.project(projects.value[index]))
    }
}
