import {Request,Response} from 'express';
import { ReplyCommentService } from "../services/replies_comment_service";
import { buildResponseReplyComment, verifyCommentReplayRequestBody } from '../utils/replies_comment_utils';
import { ExceptionError } from '../../core/exceptions/exceptions';
import { MISSING_ID, MISSING_DATA } from '../../core/exceptions/messages';
import { ReplyCommentModel } from '../../core/models/comment_model';


const replyCommentService=new ReplyCommentService();
export class ReplyCommentController{

    async getById(request:Request,response:Response){
        try{
        //const idComment = request.idComment;
        const idReply=request.params.idReply;
        if(!idReply)
            throw new Error('replyComment Id not defined');
        const replyComment:ReplyCommentModel=await replyCommentService.getById(idReply);
        response.status(200).json(buildResponseReplyComment(replyComment));
        }catch(error){
            new ExceptionError(500, error.message).handleError(response);
        }
    }

    async getRepliesComment(request:Request,response:Response){
        const idComment = request.idComment;
        try{
        if(!idComment)
             throw new Error('replies Comment Id not found');
            const repliesComment:ReplyCommentModel[]=await replyCommentService.getRepliesComment(idComment);
            response.status(200).json(repliesComment);
        } catch (error){
            new ExceptionError(400, error.message).handleError(response);
        }
    }

    async create(request: Request, response: Response){
        try{
            const idComment = request.idComment;
            if(!idComment)
                throw new Error('Missing Comment Id');
            verifyCommentReplayRequestBody(request);
            const replyComment:ReplyCommentEntity = request.body;
            replyComment.idComment=idComment;
            const replyCommentId:string = await replyCommentService.post(replyComment);
            response.json(buildResponseReplyComment(new ReplyCommentModel(replyCommentId,replyComment)));
        }catch (error){
            new ExceptionError(500, error.message).handleError(response);
        }
    }
    
    async update(request: Request, response: Response): Promise<any> {
        try {
            const idReply = request.params.idReply;
            const newreplyCommentData = request.body;
    
            if (!idReply) 
                throw new Error('replyComment - ' + MISSING_ID);
    
            if (!newreplyCommentData)
                throw new Error('replyComment - ' + MISSING_DATA);
    
            const idReplyComment:string=await replyCommentService.update(idReply,newreplyCommentData);
    
            response.json(buildResponseReplyComment(new ReplyCommentModel(idReplyComment,newreplyCommentData)));
        } catch (error) {
            new ExceptionError(500, error.message).handleError(response);
        }
    }

    async remove(request: Request, response: Response): Promise<any> {
        try {
            const idReply = request.params.idReply;
            if (!idReply) 
                throw new Error('replyComment - ' + MISSING_ID);
            const idReplyComment=await replyCommentService.remove(idReply);
            response.status(200).json({
                id: idReplyComment
            });
        } catch (error) {
            new ExceptionError(500, error.message).handleError(response);
        }
    }

}