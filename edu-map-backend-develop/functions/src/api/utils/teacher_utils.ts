import { TeacherModel } from "../../core/models/teacher_model";
import { DocumentSnapshot } from "@google-cloud/firestore";
import { verifyContactBodyRequest } from "./contact_utils";

export function buildResponseTeacher(teacherModel:TeacherModel):TeacherModel{
    return {
        idTeacher: teacherModel.idTeacher,
        first_name: teacherModel.first_name,
        last_name:teacherModel.last_name,
        contact:teacherModel.contact
    }
}

export function documentSnapshotToTeacherEntity(resultTeacher:DocumentSnapshot){
    return {
        first_name: resultTeacher.data()!.first_name,
        last_name: resultTeacher.data()!.last_name,
        contact: resultTeacher.data()!.contact,
    };
}

export function verifyTeacherRequestBody(request: any) {
        if (!request.body.first_name)
            throw new Error("firstName is required.");
        if (!request.body.last_name)
            throw new Error("lastName is required.");
        verifyContactBodyRequest(request.body.contact);
}