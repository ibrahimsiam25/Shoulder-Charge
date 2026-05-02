//
//  LeagueDetailsCollectionViewController.swift
//  Shoulder-Charge
//
//  Created by siam on 01/05/2026.
//

import UIKit

private let reuseIdentifierFinished = "FinishedEventsCollectionViewCell"
private let reuseIdentifierUpComing = "UpComingEventsCollectionViewCell"
private let reuseIdentifierParticipant = "LeagueParticipantCollectionViewCell"



class LeagueDetailsCollectionViewController: UICollectionViewController ,LeagueDetailsViewProtocol{
  
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibUpComing = UINib(nibName: reuseIdentifierUpComing , bundle: nil)
           collectionView.register(nibUpComing, forCellWithReuseIdentifier: reuseIdentifierUpComing )
        let nibFinished = UINib(nibName: reuseIdentifierFinished , bundle: nil)
           collectionView.register(nibFinished, forCellWithReuseIdentifier: reuseIdentifierFinished )
        let nibParticipant = UINib(nibName: reuseIdentifierParticipant , bundle: nil)
           collectionView.register(nibParticipant, forCellWithReuseIdentifier: reuseIdentifierParticipant )
        
        
        let layout = UICollectionViewCompositionalLayout{ index , enviornement in
            switch index {
            case 0 :
                return self.setupUpComingSection()
            case 1 :
                return self.setupFinishedSection()
            case 2 :
                return self.setupParticipantSection()
            default :
                return self.setupParticipantSection()
            }
        }
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func setupSection ( )-> NSCollectionLayoutSection{
        
//        //item
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        
//        // group
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .absolute(200))
//        
//        let myGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//        myGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0)
//        
//        //create Section
//        
//       let section = NSCollectionLayoutSection(group: myGroup)
//        section.orthogonalScrollingBehavior = .none
//        section.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 100, bottom: 40, trailing: 40)
//        
//        return section
    }
    
    
   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
         case 0:
             return presenter.getUpcomingEventsCount()

         case 1:
             return presenter.getPastEventsCount()

         case 2:
             return presenter.getParticipantsCount()

         default:
             return 0
         }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {

            case 0:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: reuseIdentifierUpComing,
                    for: indexPath
                ) as! UpComingEventsCollectionViewCell

                let event = presenter.getUpcomingEvent(at: indexPath.item)
                cell.configure(with: event)

                return cell

            case 1:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: reuseIdentifierFinished,
                    for: indexPath
                ) as! FinishedEventsCollectionViewCell

                let event = presenter.getPastEvent(at: indexPath.item)
                cell.configure(with: event)

                return cell

            case 2:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: reuseIdentifierParticipant,
                    for: indexPath
                ) as! LeagueParticipantCollectionViewCell

                let participant = presenter.getParticipant(at: indexPath.item)
                cell.configure(with: participant)

                return cell

            default:
                fatalError("Invalid section")
            }
    }

  
    func reloadData() {
        <#code#>
    }
    
    func toggleLoading(_ val: Bool) {
        <#code#>
    }
    

}
