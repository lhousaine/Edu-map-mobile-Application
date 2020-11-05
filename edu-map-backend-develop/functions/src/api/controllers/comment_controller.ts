import {Request,Response} from 'express';
import { CommentService } from '../services/comment_service';
import { ExceptionError } from '../../core/exceptions/exceptions';
import { buildResponseComment, verifyCommentRequestBody } from '../utils/comment_utils';
import { MISSING_ID, MISSING_DATA } from '../../core/exceptions/messages';
import { CommentModel } from '../../core/models/comment_model';

const commentService=new CommentService();
export class CommentController{

    async getById(request:Request,response:Response){
        try{
        const commentId=request.params.idComment;
        if(!commentId)
            throw new Error('Comment Id not defined');
        const comment:CommentModel=await commentService.getById(commentId);
        response.status(200).json(buildResponseComment(comment));
        }catch(error){
            new ExceptionError(500, error.message).handleError(response);
        }
    }

    async getSchoolComments(request:Request,response:Response){
        const idSchool = request.idSchool;
        if(!idSchool)
             throw new Error('Comment School\'s Id not found')
        try {
            const comments:CommentModel[]=await commentService.getSchoolComments(idSchool);
            response.json(comments);
        } catch (error){
            new ExceptionError(400, error.message).handleError(response);
        }
    }

    async create(request: Request, response: Response){
        try{
            const idSchool = request.idSchool;
            if(!idSchool)
                throw new Error('Missing school Id');
            verifyCommentRequestBody(request);
            const comment:CommentEntity = request.body;
            comment.idSchool=idSchool;
            const commentId:string = await commentService.post(comment);
            response.json(buildResponseComment(new CommentModel(commentId,comment)));
        }catch (error){
            new ExceptionError(400, error.message).handleError(response);
        }
    }
    
    async update(request: Request, response: Response): Promise<any> {
        try {
            let idComment = request.params.idComment;
            const newCommentData = request.body;
    
            if (!idComment) 
                throw new Error('Comment - ' + MISSING_ID);
    
            if (!newCommentData)
                throw new Error('Comment - ' + MISSING_DATA);
    
            idComment=await commentService.update(idComment,newCommentData);
    
            response.json(buildResponseComment(new CommentModel(idComment,newCommentData)));
        } catch (error) {
            new ExceptionError(500, error.message).handleError(response);
        }
    }

    async remove(request: Request, response: Response): Promise<any> {
        try {
            let idComment = request.params.idComment;
            if (!idComment) throw new Error('Comment - ' + MISSING_ID);
             idComment=await commentService.remove(idComment);
            response.status(200).json({
                idComment: idComment,
            })
        } catch (error) {
            new ExceptionError(500, error.message).handleError(response);
        }
    }

}