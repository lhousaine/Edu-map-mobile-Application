interface TutorialEntity {
    title: string,
    duration: string,
    tutorialDate: Date,
    teacher: TeacherEntity,
    objectives: Array<String>,
    level: EducationLevelEnum,
    speciality?: SpecialityEnum
}