//
//  Storage.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 04.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

struct PostModel {
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
}

struct PostSection {
    var title: String? = nil
    let posts: [PostModel]
    var footer: String? = nil
}

struct Photos {
    static let images = [
        "alexander-krivitskiy",
        "andrey-zvyagintsev",
        "artem-maltsev",
        "belen-martin",
        "carlos-lindner",
        "christopher-campbell",
        "daniel-lincoln",
        "goh-rhy-yan",
        "ilya-mondryk",
        "jonas-kakaroto",
        "jonathan-cooper",
        "logan-weaver",
        "matheus-farias",
        "max-ilienerwise",
        "metin-ozer",
        "mubariz-mehdizadeh",
        "sergio-de-paula",
        "taras-chernus",
        "vaishnav-chogale",
        "zazen-koan"
    ]
}

struct Storage {
    static let tableModel = [
        PostSection(
            posts: [
                PostModel(author: "Джеймс Мэнголд", description: "Ford против Ferrari. Биография знаменитого гонщика Кена Майлза и драма об искренней и чистой  любви к быстрой езде.", image: "FordVsFerrari", likes: 109, views: 124),
                PostModel(author: "Гари Хэлворсон", description: "Друзья. Великий комедийный сериал, с героями которого мы и правда успели подружиться", image: "Friends", likes: 291, views: 323),
                PostModel(author: "Адам МакКей", description: "Игра на понижение. Сообразительные неудачники решают заработать на финансовом кризисе. Язвительная комедия по реальным событиям.", image: "The_Big_Shot", likes: 112, views: 143),
                PostModel(author: "Марк Сендроуски", description: "Теория большого взрыва. Два блестящих физика Леонард и Шелдон - великие умы, которые понимают, как устроена вселенная. Но их гениальность ничуть не помогает им общаться с людьми, особенно с женщинами. Всё начинает меняться, когда напротив них поселяется красавица Пенни.", image: "The_Big_Bang_Theory", likes: 181, views: 215)
            ]
        )
    ]
}

