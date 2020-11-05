import {Request,Response} from 'express';
import { MISSING_ID, MISSING_DATA } from '../../core/exceptions/messages';
import { TutorialService } from '../services/tutorial_service';
import { ExceptionError } from '../../core/exceptions/exceptions';
import { buildResponseTutorial, verifyTutorialRequestBody } from '../utils/tutorial_utils';
import { TutorialModel } from '../../core/models/tutorial_model';

const tutorialService=new TutorialService();

export class TutorialController{
   
    async getById(request: Request, response: Response){
        try {
            const idTutorial = request.params.idTutorial;
    
            if (!idTutorial) 
                throw new Error('Tutorial - ' + MISSING_ID);
    
            const tutorialModel:TutorialModel = await tutorialService.getById(idTutorial);
            response.json(buildResponseTutorial(tutorialModel));
        } catch (error) {
            new ExceptionError(500, error.message).handleError(response);
        }
    }    

    async getAll(request: Request, response: Response) {
        try {
            const tutorials:TutorialModel[]=await tutorialService.getAll();
            response.json(tutorials);
        } catch (error){
            new ExceptionError(500, error.message).handleError(response);
        }
    }

    async create(request: Request, response: Response){
        try{
            verifyTutorialRequestBody(request);
            const tutorial: TutorialEntity = request.body;
            const tutorialId:string = await tutorialService.post(tutorial);
            response.json(buildResponseTutorial(new TutorialModel(tutorialId,tutorial)));
        }catch (error){
            new ExceptionError(500, error.message).handleError(response);
        }
    }
    
    async update(request: Request, response: Response): Promise<any> {
        try {
            let idTutorial = request.params.idTutorial;
            const newTutorialData = request.body;
    
            if (!idTutorial) 
                throw new Error('Tutorial - ' + MISSING_ID);
    
            if (!newTutorialData)
                throw new Error('Tutorial - ' + MISSING_DATA);
    
            idTutorial=await tutorialService.update(idTutorial,newTutorialData);
    
            response.json(buildResponseTutorial( new TutorialModel(idTutorial,newTutorialData)));
        } catch (error) {
            new ExceptionError(500, error.message).handleError(response);
        }
    }

    async remove(request: Request, response: Response): Promise<any> {
        try {
            let idTutorial = request.params.idTutorial;
            if (!idTutorial) throw new Error('Tutorial - ' + MISSING_ID);
            idTutorial=await tutorialService.remove(idTutorial);
            response.json({
                id: idTutorial,
            })
        } catch (error) {
            new ExceptionError(500, error.message).handleError(response);
        }
    }

}