import { Router } from "express";
import { CommentController } from "../controllers/comment_controller";

const CommentRouter = Router();

const replyCommentRouter=require('./replies_comment');

const commentController=new CommentController();

CommentRouter.get('/', commentController.getSchoolComments);

CommentRouter.get('/:idComment', commentController.getById);

CommentRouter.post('/', commentController.create);

CommentRouter.patch('/:idComment', commentController.update);

CommentRouter.delete('/:idComment', commentController.remove);

CommentRouter.use('/:idComment/replies',function(request, response, next) {
    request.idComment = request.params.idComment;
    next()
    },replyCommentRouter);

module.exports = CommentRouter;