import {TEACHER_API_COLLECTION_NAME} from "../../core/exceptions/messages";
import { db } from "../..";
import { DocumentSnapshot } from "firebase-functions/lib/providers/firestore";
import { DocumentReference, QuerySnapshot} from "@google-cloud/firestore";
import {Repository} from "./repository";

const teachersCollection = TEACHER_API_COLLECTION_NAME;

export class TeacherRepository extends Repository<TeacherEntity>{
    
    async getById(idTeacher: string): Promise<DocumentSnapshot> {
        return await db.collection(teachersCollection).doc(idTeacher).get();
    }

    async getAll(): Promise<QuerySnapshot> {
        return await db.collection(teachersCollection).get();
    }

    async post(teacher: TeacherEntity): Promise<DocumentReference> {
        return await db.collection(teachersCollection).add(teacher);
    }

    async update(idTeacher: string,teacher:any): Promise<string> {
        const docRef=db.collection(teachersCollection).doc(idTeacher);
        await db.collection(teachersCollection).doc().update(teacher);
        return docRef.id;
    }

    async remove(idTeacher: string): Promise<string>{
        const docRef=db.collection(teachersCollection).doc(idTeacher);
        await db.collection(teachersCollection).doc(idTeacher).delete();
        return docRef.id;
    }

}