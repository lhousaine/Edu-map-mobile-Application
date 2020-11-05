import { SCHOOL_API_COLLECTION_NAME } from "../../core/exceptions/messages";
import { db } from "../..";
import { DocumentSnapshot } from "firebase-functions/lib/providers/firestore";
import { DocumentReference, QuerySnapshot} from "@google-cloud/firestore";
import {Repository} from "./repository";

const schoolsCollection = SCHOOL_API_COLLECTION_NAME;

export class SchoolRepository extends Repository<SchoolEntity>{

    async getById(idSchool: string): Promise<DocumentSnapshot> {
        return await db.collection(schoolsCollection).doc(idSchool).get();
    } 


    async getByTrendingSchool():Promise<QuerySnapshot>{
        return await db.collection(schoolsCollection)
        .orderBy('rating','desc')
        .limit(5)
        .get();
    }

    async getAll(): Promise<QuerySnapshot> {
       return await db.collection(schoolsCollection).get();
    }

    async post(school: SchoolEntity): Promise<DocumentReference> {
        return await db.collection(schoolsCollection).add(school);
    }

    async update(idSchool: string,entity): Promise<string> {
        const docRef=db.collection(schoolsCollection).doc(idSchool);
        await docRef.update(entity);
        return docRef.id;
    }

    async remove(idSchool: string): Promise<string> {
        const docRef=db.collection(schoolsCollection).doc(idSchool);
        if(!docRef)
            throw new Error('Not exist school ID');
        await db.collection(schoolsCollection).doc(idSchool).delete();
        return docRef.id;
    }

}