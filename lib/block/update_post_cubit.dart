
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_block/block/update_post_state.dart';
import 'package:pattern_block/serviece/http_service.dart';

import '../post_model/model_post.dart';

class UpdatePostCubit extends Cubit<UpdatePostState>{
  UpdatePostCubit() : super(UpdatePostInit());

  void apiUpdatePost(Post post)async{
   //  post.id = 1.toString();
    emit(UpdatePostLoading());
    final response = await Network.PUT(Network.API_UPDATE + post.id.toString(), Network.paramsUpdate(post));
    if(response != null){
      emit(UpdatePostLoaded(isUpdated: true));
    }else{
      emit(UpdatePostError(error: "Couldn't update post"));
    }
  }

}