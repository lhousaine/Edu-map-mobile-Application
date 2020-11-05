import { Service } from "./service";
import { TEACHER_NOT_FOUND } from "../../core/exceptions/messages";
import { DocumentReference } from "@google-cloud/firestore";
import { TeacherModel } from "../../core/models/teacher_model";
import { TeacherRepository } from "../repositories/teacher_repository";
import { documentSnapshotToTeacherEntity, buildResponseTeacher } from "../utils/teacher_utils";

const teacherRepository=new TeacherRepository();

export class TechaerService extends Service<TeacherEntity,TeacherModel>{
   
   
    async getById(idTeacher: string): Promise<TeacherModel> {
        const resultTeacher = await teacherRepository.getById(idTeacher);
        if (!resultTeacher.exists) {
            throw new Error('Teacher - ' + TEACHER_NOT_FOUND)
        }
        const teacher = documentSnapshotToTeacherEntity(resultTeacher);
        return new TeacherModel(idTeacher,teacher);
    }    
    
    async getAll(): Promise<TeacherModel[]>{
        const teacherQuerySnapshot = await teacherRepository.getAll();
        const schools: any[] = [];
        teacherQuerySnapshot.forEach(
          (resultTeahcer) => {
           const teacherModel: TeacherModel = new TeacherModel(resultTeahcer.id,documentSnapshotToTeacherEntity(resultTeahcer));
            schools.push(
              buildResponseTeacher(teacherModel)
            );
          }
        );
        return schools;
    }

    async post(teacher: TeacherEntity): Promise<string> {
        const docRef:DocumentReference=await teacherRepository.post(teacher);
        return docRef.id;
    }

    async update(idTeacher: string, teacher): Promise<string> {
        return await teacherRepository.update(idTeacher,teacher);
    }

    async remove(idTeacher: string): Promise<string> {
        return await teacherRepository.remove(idTeacher);
    }

}