import { Service } from "./service";
import { TutorialModel } from "../../core/models/tutorial_model";
import { TutorialRepository } from "../repositories/tutorial_repository";
import { TUTORIAL_NOT_FOUND } from "../../core/exceptions/messages";
import { documentSnapshotToTutorialEntity, buildResponseTutorial } from "../utils/tutorial_utils";
import { DocumentReference } from "@google-cloud/firestore";

const tutorial_repository=new TutorialRepository();

export class TutorialService extends Service<TutorialEntity,TutorialModel>{

    
    async getById(idTutorial: string): Promise<TutorialModel> {
        const resultTutorial = await tutorial_repository.getById(idTutorial);
        if (!resultTutorial.exists) {
            throw new Error('Tutorial - ' + TUTORIAL_NOT_FOUND)
        }
        const teacher = documentSnapshotToTutorialEntity(resultTutorial);
        return new TutorialModel(idTutorial,teacher);
    }

    async getAll(): Promise<TutorialModel[]> {
        const tutorialQuerySnapshot = await tutorial_repository.getAll();
        const tutorials: any[] = [];
        tutorialQuerySnapshot.forEach(
          (resultTutorial:any) => {
           const tutorialModel: TutorialModel = new TutorialModel(
               resultTutorial.id,documentSnapshotToTutorialEntity(resultTutorial)
               );
            tutorials.push(
              buildResponseTutorial(tutorialModel)
            );
          }
        );
        return tutorials;
    }
    
    async post(tutorial: TutorialEntity): Promise<string> {
        const docRef:DocumentReference=await tutorial_repository.post(tutorial);
        return docRef.id;
    }

    async update(idTutorial: string, tutorial:any): Promise<string> {
        return await tutorial_repository.update(idTutorial,tutorial);
    }

    async remove(idTutorial: string): Promise<string> {
        return await tutorial_repository.remove(idTutorial);
    }

}