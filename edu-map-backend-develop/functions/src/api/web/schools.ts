import { Router } from "express";
import { SchoolController } from "../controllers/school_controller";

const commentRouter=require('./comments');

const SchoolRouter = Router();

const schoolController=new SchoolController();

SchoolRouter.get('/', schoolController.getAll);

SchoolRouter.get('/:idSchool',schoolController.getById);

SchoolRouter.get('/trending/today', schoolController.getTrendingSchools);

SchoolRouter.post('/filtrateschools',schoolController.getAllfiltrateSchools);

SchoolRouter.post('/subscribe',schoolController.create);

SchoolRouter.post('/coordinates/nearest/',schoolController.getNearestSchoolsToCoodinate);

SchoolRouter.patch('/:idSchool', schoolController.update);

SchoolRouter.delete('/:idSchool', schoolController.remove);

SchoolRouter.use('/:idSchool/comments',function(request, response, next) {
                    request.idSchool = request.params.idSchool;
                    next()
                    },commentRouter);

module.exports = SchoolRouter;