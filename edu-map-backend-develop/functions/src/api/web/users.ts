import { Router } from "express";
import { UserController } from "../controllers/user_controller";
import { isAuthenticated } from "../../core/auth/authenticated";
import { isUserAuthorized } from "../../core/auth/authorized";

const UserRouter = Router();
const userController=new UserController();

UserRouter.post('/login',userController.SignIn);

UserRouter.post('/subscribe',userController.create);

UserRouter.get('/:idUser',isAuthenticated,userController.getById);

UserRouter.get('/',isAuthenticated,isUserAuthorized,userController.getAll);

UserRouter.put('/:idUser',isAuthenticated, userController.update);

UserRouter.delete('/:idUser',isAuthenticated,userController.remove);

module.exports = UserRouter;