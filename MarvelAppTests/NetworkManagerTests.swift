//
//  NetworkManagerTests.swift
//  MarvelAppTests
//
//  Created by Ahmed Mahrous on 18/02/2024.
//

import XCTest
@testable import MarvelApp

final class NetworkManagerTests: XCTestCase {
    
    // MARK: - Mock Data
    
    // Mock data for successful response
    let successfulResponseData = """
        {
            "code": 200,
            "status": "Ok",
            "attributionText": "Data provided by Marvel. © 2024 MARVEL",
            "etag": "some-etag",
            "data": {
                "offset": 0,
                "limit": 20,
                "total": 1493,
                "count": 20,
                "results": [
                    {
                        "id": 1011334,
                        "name": "3-D Man",
                        "description": "",
                        "modified": "2023-10-08T13:28:23-0400",
                        "thumbnail": {
                            "path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                            "extension": "jpg"
                        },
                        "resourceURI": "http://gateway.marvel.com/v1/public/characters/1011334",
                        "comics": {
                            "available": 12
                        },
                        "series": {
                            "available": 3
                        },
                        "stories": {
                            "available": 21
                        },
                        "events": {
                            "available": 0
                        },
                        "urls": [
                            {
                                "type": "detail",
                                "url": "http://marvel.com/comics/characters/1011334/3-d_man?utm_campaign=apiRef&utm_source=ddc27f36b1a7d9e775d398b61b44a7f0"
                            },
                            {
                                "type": "wiki",
                                "url": "http://marvel.com/universe/3-D_Man_(Chandler)?utm_campaign=apiRef&utm_source=ddc27f36b1a7d9e775d398b61b44a7f0"
                            }
                        ]
                    }
                ]
            }
        }
        """.data(using: .utf8)!
    
    // MARK: - Test Cases
    
    // Test fetching characters
    func testFetchCharacters() {
        // Given
        let networkManager = NetworkManager.shared
        let expectation = XCTestExpectation(description: "Fetch characters")
        
        // When
        networkManager.fetchCharacters { result in
            // Then
            switch result {
            case .success(let characters):
                XCTAssertEqual(characters.code, 200)
                XCTAssertEqual(characters.data.results.count, 20)
                XCTAssertEqual(characters.data.results[0].id, 1011334)
                XCTAssertEqual(characters.data.results[0].name, "3-D Man")
                expectation.fulfill()
            case .failure:
                XCTFail("Failed to fetch characters")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    // Test fetching comics for a character
    func testFetchCharacterComics() {
        // Given
        let networkManager = NetworkManager.shared
        let characterId = 1011334
        let expectation = XCTestExpectation(description: "Fetch character comics")
        
        // When
        networkManager.fetchCharacterComics(forCharacterId: characterId) { result in
            // Then
            switch result {
            case .success(let comics):
                XCTAssertEqual(comics.code, 200)
                expectation.fulfill()
            case .failure:
                XCTFail("Failed to fetch character comics")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    // Test fetching series for a character
    func testFetchCharacterSeries() {
        // Given
        let networkManager = NetworkManager.shared
        let characterId = 1011334
        let expectation = XCTestExpectation(description: "Fetch character series")
        
        // When
        networkManager.fetchCharacterSeries(forCharacterId: characterId) { result in
            // Then
            switch result {
            case .success(let series):
                XCTAssertEqual(series.code, 200)
                expectation.fulfill()
            case .failure:
                XCTFail("Failed to fetch character series")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    // Test fetching stories for a character
    func testFetchCharacterStories() {
        // Given
        let networkManager = NetworkManager.shared
        let characterId = 1011334
        let expectation = XCTestExpectation(description: "Fetch character stories")
        
        // When
        networkManager.fetchCharacterStories(forCharacterId: characterId) { result in
            // Then
            switch result {
            case .success(let stories):
                XCTAssertEqual(stories.code, 200)
                expectation.fulfill()
            case .failure:
                XCTFail("Failed to fetch character stories")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    // Test fetching events for a character
    func testFetchCharacterEvents() {
        // Given
        let networkManager = NetworkManager.shared
        let characterId = 1011334
        let expectation = XCTestExpectation(description: "Fetch character events")
        
        // When
        networkManager.fetchCharacterEvents(forCharacterId: characterId) { result in
            // Then
            switch result {
            case .success(let events):
                XCTAssertEqual(events.code, 200)
                expectation.fulfill()
            case .failure:
                XCTFail("Failed to fetch character events")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
