import { TutorialModel } from "../../core/models/tutorial_model";
import { DocumentSnapshot } from "@google-cloud/firestore";
import { verifyTeacherRequestBody } from "./teacher_utils";

export function buildResponseTutorial(tutorialModel:TutorialModel){
    return {
        idTutorial: tutorialModel.idTutorial,
        title: tutorialModel.title,
        duration: tutorialModel.duration,
        tutorialDate: tutorialModel.tutorialDate,
        teacher: tutorialModel.teacher,
        objectives: tutorialModel.objectives,
        level: tutorialModel.level,
        speciality:tutorialModel.speciality||''
    }
}

export function documentSnapshotToTutorialEntity(resultTutorail:DocumentSnapshot){
    return {
        title: resultTutorail.data()!.title,
        duration: resultTutorail.data()!.duration,
        tutorialDate: resultTutorail.data()!.tutorialDate,
        teacher: resultTutorail.data()!.teacher,
        objectives: resultTutorail.data()!.objectives,
        level: resultTutorail.data()!.level,
        speciality:resultTutorail.data()!.speciality
    };
}

export function verifyTutorialRequestBody(request: any) {
        if (!request.body.title)
            throw new Error("title is required.");
        if (!request.body.duration)
            throw new Error("title duration is required.");
        if (!request.body.tutorialDate)
            throw new Error("tutorial date is required.");
        verifyTeacherRequestBody(request.body.teacher);
        if (!request.body.objectives)
            throw new Error("tutorial objectives should be defined");
        if (!request.body.level)
            throw new Error("tutorial concerned level is required.");
        if (!request.body.speciality)
            throw new Error("tutorial concerned speciality is required.");
}