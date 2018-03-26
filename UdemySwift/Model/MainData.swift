//
//  MainData.swift
//  UdemySwift
//
//  Created by 이기완 on 2018. 3. 25..
//  Copyright © 2018년 이기완. All rights reserved.
//

import UIKit

class MainData {
    let title: String
    let subTitle: String
    let image: String
    
    init(title: String, subTitle: String, image: String) {
        self.title = title
        self.subTitle = subTitle
        self.image = image
    }
}

class SampleData{
    let data: [MainData]
    
    init() {
        let data1 = MainData(title: "Photo Object Detection", subTitle: "불러온 이미지에 사물 인식", image: "ic_photo")
        let data2 = MainData(title: "Real Time Object Detection", subTitle: "실시간으로 카메라에 보이는 사물 인식", image: "ic_camera")
        let data3 = MainData(title: "Facial Analysis", subTitle: "사람 얼굴로부터 나이, 성별, 감정 추측", image: "ic_emotion")
        
        data = [data1,data2,data3]
    }
}
