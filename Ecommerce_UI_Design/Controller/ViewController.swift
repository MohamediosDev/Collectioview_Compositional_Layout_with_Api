//
//  ViewController.swift
//  Ecommerce_UI_Design
//
//  Created by Soda on 6/1/21.
//

import UIKit
import Alamofire
import SideMenu


class ViewController: UIViewController {
    
    
    //MARK: -> outlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView! {
        
        didSet {
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderView")
        }
    }
    
    //MARK: -> Properties
    
    var homeModel:HomeModel?
    var menu:SideMenuNavigationController?
    var timer:Timer?
    var currentCellIndex = 0
    
    
    
    
    //MARK: -> View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createcompositionalLayout()
        setupSideMenu()
        //startTimer()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomedetail()
    }
    
    //MARK: -> Class Methods
//    func startTimer() {
//        timer = Timer(timeInterval: 1.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
//    }
//    @objc func moveToNextIndex() {
//        currentCellIndex += 1
//        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
//    }

    func createcompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { [weak self](index, enviroment) -> NSCollectionLayoutSection? in
            
            return self?.createSectionFor(index: index, enviroment: enviroment)
        }
        return layout
    }
    
    func createSectionFor(index:Int , enviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        switch index {
        case 0:
            return createFirstSection()
        case 1:
            return createSecoendSection()
        case 2 :
            return createThirdSection()
        default:
            return createFirstSection()
        }
    }
    
    func createFirstSection() -> NSCollectionLayoutSection {
        let inset: CGFloat = 2.5
        
        //Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func createSecoendSection() -> NSCollectionLayoutSection {
        let inset: CGFloat = 2.5
        
        //Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        
        //header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    func createThirdSection() -> NSCollectionLayoutSection {
        let inset: CGFloat = 2.5
        
        //Item
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
        largeItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        //Group
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))
        let verticalgroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [smallItem])
        
        let horiztanlGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.35))
        let horiztanlgroup = NSCollectionLayoutGroup.horizontal(layoutSize: horiztanlGroupSize, subitems: [largeItem,verticalgroup,verticalgroup])
        
        
        //section
        let section = NSCollectionLayoutSection(group: horiztanlgroup)
        section.orthogonalScrollingBehavior = .groupPaging
        
        
        //header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    //Network
    func getHomedetail() {
        
        let url = "https://student.valuxapps.com/api/home"
        let headers:HTTPHeaders = ["lang": "ar", "Content-Type": "application/json", "Authorization":"T4KLEXAMOsnPGoPmcUq3KauJ8uu58sULQ7JJEWbjGYfLY5v3SThsBDMshdr1CiPHz6Mlog"]
        
        ApiService.Shared.fetchData(url: url, parms: nil  , headers: headers, method:.get) { [weak self](getBook:HomeModel?, failBook:HomeModel?, error) in
            
            guard let self = self else {return}
            if let error = error {
                print(error.localizedDescription)
            }
            
            else {
                self.homeModel = getBook
                self.collectionView.reloadData()
                
            }
        }
    }
    
    func setupSideMenu() {
        menu = SideMenuNavigationController(rootViewController: SideMenuSettingTableViewController())
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        menu?.title = "Menu"
        
    }
    
    @IBAction func sideMenuButton(_ sender: Any) {
        present(menu!, animated: true)
        
        
    }
    
    
}


//MARK: -> Extension

extension ViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        else if section == 1 {
            return 3
        }
        else {
            return 19
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! cell
            let homedata = homeModel?.data?.banners?[indexPath.item].image ?? ""
            cell1.configureCell(image: homedata)
            cell1.imageViewShow.contentMode = .scaleAspectFill
            return cell1
            
        case 1:
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! cell
            let homeDataCatogery = homeModel?.data?.banners?[indexPath.item].category?.image ?? ""
            cell2.configureCell(image:homeDataCatogery)
            cell2.imageViewShow.contentMode = .scaleAspectFit
            
            return cell2
            
        case 2:
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! cell
            let homeDataProudct = homeModel?.data?.products?[indexPath.item].image ?? ""
            cell3.configureCell(image:homeDataProudct)
            cell3.imageViewShow.contentMode = .scaleAspectFit
            return cell3
            
        default:
            print("error")
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else { return UICollectionReusableView()}
        
        view.title = indexPath.section == 1 ? "Browse By Catogery" : "Recent Proudcts"
        return view
    }
}
