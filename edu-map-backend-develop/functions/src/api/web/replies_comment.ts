import { Router } from "express";
import { ReplyCommentController } from "../controllers/replies_comment_controller";

const ReplyCommentRouter = Router();

const replyCommentController=new ReplyCommentController();

ReplyCommentRouter.get('/', replyCommentController.getRepliesComment);

ReplyCommentRouter.get('/:idReply', replyCommentController.getById);

ReplyCommentRouter.post('/', replyCommentController.create);

ReplyCommentRouter.patch('/:idReply', replyCommentController.update);

ReplyCommentRouter.delete('/:idReply', replyCommentController.remove);

module.exports = ReplyCommentRouter;