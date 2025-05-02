# 使用技術
Swift, SwiftUI

## CoreData
Timetable
id UUID
name String // 時間割名
classes String // 
isOnSaturday Boolean // 土曜日に授業があるか
isOnSunday Boolean // 日曜日に授業があるか
maximumNumberOfLessons Integer16 // １日の最大授業数
Relationship
classRelationship
Destination: Class
Inverse: timetableRelationship


Class
id UUID
timetable String // 
subject String // 授業目
dayOfWeek String // 何曜日の授業か
period Integer16 // 何限の授業か
room String // 授業の場所
Relationship
timetableRelationship
Destination: Timetable
Inverse: classRelationship



