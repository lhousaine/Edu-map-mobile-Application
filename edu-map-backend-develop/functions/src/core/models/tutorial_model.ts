export class TutorialModel {
    idTutorial: string;
    title: string;
    duration: string;
    tutorialDate: Date;
    teacher: TeacherEntity;
    objectives: Array<String>;
    level: EducationLevelEnum;
    speciality?: SpecialityEnum;


    constructor(idTutorial: string, tutorial: TutorialEntity) {
        this.idTutorial = idTutorial;
        this.title = tutorial.title;
        this.duration = tutorial.duration;
        this.tutorialDate = tutorial.tutorialDate;
        this.teacher = tutorial.teacher;
        this.objectives = tutorial.objectives;
        this.level = tutorial.level;
        this.speciality = tutorial.speciality;
    }
}