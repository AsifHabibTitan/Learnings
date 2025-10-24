//
//  Model.swift
//  Aisle_Notes
//
//  Created by Asif Habib on 17/07/25.
//

import Foundation

// MARK: - Top Level
struct APIResponse: Codable {
    let invites: Invites
    let likes: Likes
}

// MARK: - Invites
struct Invites: Codable {
    let profiles: [Profile]
    let totalPages: Int
    let pendingInvitationsCount: Int

    enum CodingKeys: String, CodingKey {
        case profiles, totalPages
        case pendingInvitationsCount = "pending_invitations_count"
    }
}

// MARK: - Profile
struct Profile: Codable {
    let generalInformation: GeneralInformation
    let approvedTime: Double?
    let disapprovedTime: Double?
    let photos: [Photo]
    let userInterests: [String] // Adjust type if needed
    let work: Work
    let preferences: [Preference]
    let instagramImages: [String]?
    let lastSeenWindow: String?
    let isFacebookDataFetched: Bool
    let icebreakers: String?
    let story: String?
    let meetup: String?
    let verificationStatus: String
    let hasActiveSubscription: Bool
    let showConciergeBadge: Bool
    let lat: Double
    let lng: Double
    let lastSeen: String?
    let onlineCode: Int
    let profileDataList: [ProfileDataList]

    enum CodingKeys: String, CodingKey {
        case generalInformation = "general_information"
        case approvedTime = "approved_time"
        case disapprovedTime = "disapproved_time"
        case photos
        case userInterests = "user_interests"
        case work, preferences
        case instagramImages = "instagram_images"
        case lastSeenWindow = "last_seen_window"
        case isFacebookDataFetched = "is_facebook_data_fetched"
        case icebreakers, story, meetup
        case verificationStatus = "verification_status"
        case hasActiveSubscription = "has_active_subscription"
        case showConciergeBadge = "show_concierge_badge"
        case lat, lng
        case lastSeen = "last_seen"
        case onlineCode = "online_code"
        case profileDataList = "profile_data_list"
    }
}

// MARK: - GeneralInformation
struct GeneralInformation: Codable {
    let dateOfBirth: String
    let dateOfBirthV1: String
    let location: Location
    let drinkingV1: Option?
    let firstName: String
    let gender: String
    let maritalStatusV1: Option?
    let refID: String
    let smokingV1: Option?
    let sunSignV1: Option?
    let motherTongue: Option?
    let faith: Option?
    let height: Int?
    let cast, kid, diet, politics, pet, settle, mbti: String?
    let age: Int

    enum CodingKeys: String, CodingKey {
        case dateOfBirth = "date_of_birth"
        case dateOfBirthV1 = "date_of_birth_v1"
        case location
        case drinkingV1 = "drinking_v1"
        case firstName = "first_name"
        case gender
        case maritalStatusV1 = "marital_status_v1"
        case refID = "ref_id"
        case smokingV1 = "smoking_v1"
        case sunSignV1 = "sun_sign_v1"
        case motherTongue = "mother_tongue"
        case faith, height, cast, kid, diet, politics, pet, settle, mbti, age
    }
}

struct Option: Codable {
    let id: Int
    let name: String
    let nameAlias: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAlias = "name_alias"
    }
}

struct Location: Codable {
    let summary: String
    let full: String
}

// MARK: - Photo
struct Photo: Codable {
    let photo: String
    let photoID: Int
    let selected: Bool
    let status: String?

    enum CodingKeys: String, CodingKey {
        case photo
        case photoID = "photo_id"
        case selected, status
    }
}

// MARK: - Work
struct Work: Codable {
    let industryV1: Option?
    let monthlyIncomeV1: String?
    let experienceV1: Option?
    let highestQualificationV1: Option?
    let fieldOfStudyV1: Option?

    enum CodingKeys: String, CodingKey {
        case industryV1 = "industry_v1"
        case monthlyIncomeV1 = "monthly_income_v1"
        case experienceV1 = "experience_v1"
        case highestQualificationV1 = "highest_qualification_v1"
        case fieldOfStudyV1 = "field_of_study_v1"
    }
}

// MARK: - Preference
struct Preference: Codable {
    let answerID: Int
    let id: Int
    let value: Int
    let preferenceQuestion: PreferenceQuestion

    enum CodingKeys: String, CodingKey {
        case answerID = "answer_id"
        case id, value
        case preferenceQuestion = "preference_question"
    }
}

struct PreferenceQuestion: Codable {
    let firstChoice: String
    let secondChoice: String

    enum CodingKeys: String, CodingKey {
        case firstChoice = "first_choice"
        case secondChoice = "second_choice"
    }
}

// MARK: - ProfileDataList
struct ProfileDataList: Codable {
    let question: String
    let preferences: [PreferenceAnswer]
    let invitationType: String

    enum CodingKeys: String, CodingKey {
        case question, preferences
        case invitationType = "invitation_type"
    }
}

struct PreferenceAnswer: Codable {
    let answerID: Int
    let answer: String
    let firstChoice: String
    let secondChoice: String

    enum CodingKeys: String, CodingKey {
        case answerID = "answer_id"
        case answer
        case firstChoice = "first_choice"
        case secondChoice = "second_choice"
    }
}

// MARK: - Likes
struct Likes: Codable {
    let profiles: [LikeProfile]
    let canSeeProfile: Bool
    let likesReceivedCount: Int

    enum CodingKeys: String, CodingKey {
        case profiles
        case canSeeProfile = "can_see_profile"
        case likesReceivedCount = "likes_received_count"
    }
}

struct LikeProfile: Codable, Hashable {
    let firstName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case avatar
    }
}
