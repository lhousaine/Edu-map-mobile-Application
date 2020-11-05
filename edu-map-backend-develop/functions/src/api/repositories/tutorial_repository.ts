import {TUTORIAL_API_COLLECTION_NAME} from "../../core/exceptions/messages";
import { db } from "../..";
import { DocumentSnapshot } from "firebase-functions/lib/providers/firestore";
import { DocumentReference, QuerySnapshot} from "@google-cloud/firestore";
import {Repository} from "./repository";

const tutorialsCollection = TUTORIAL_API_COLLECTION_NAME;

// @ts-ignore
export class TutorialRepository extends Repository<TutorialEntity>{
  
    async getById(idTutorial: string): Promise<DocumentSnapshot> {
        return await db.collection(tutorialsCollection).doc(idTutorial).get();
    }

    async getAll(): Promise<QuerySnapshot> {
        return await db.collection(tutorialsCollection).get();
    }

    async post(tutorial: TutorialEntity): Promise<DocumentReference> {
        return await db.collection(tutorialsCollection).add(tutorial);
    }

    async update(idTutorial: string,tutorial:any): Promise<string> {
        const docRef=db.collection(tutorialsCollection).doc(idTutorial);
        await db.collection(tutorialsCollection).doc().update(tutorial);
        return docRef.id;
    }

    async remove(idTutorial: string): Promise<string> {
        const docRef=db.collection(tutorialsCollection).doc(idTutorial);
        await db.collection(tutorialsCollection).doc(idTutorial).delete();
        return docRef.id;
    }

}