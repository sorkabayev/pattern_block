import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_block/block/update_post_cubit.dart';
import 'package:pattern_block/block/update_post_state.dart';

import '../post_model/model_post.dart';
import '../views/view_of_update.dart';

class UpdatePage extends StatelessWidget {
  UpdatePage({Key? key, this.post}) : super(key: key);
  final Post? post;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = post!.title!;
    bodyController.text = post!.body!;

    
    return BlocProvider(create: (context) => UpdatePostCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Update Post"),
        ),
        body: BlocBuilder<UpdatePostCubit , UpdatePostState>(
          builder: (BuildContext context, UpdatePostState state ){
            if(state is UpdatePostLoading){
              String title = titleController.text.toString();
              String body = bodyController.text.toString();
              Post post = Post(id: this.post!.id!, title: title,body: body, );
              return viewOfUpdate(post,true,context,titleController,bodyController);
            }
            if(state is UpdatePostLoaded){
              _finish(context);
            }
            if(state is UpdatePostError){

            }
            return viewOfUpdate(post! , false, context,titleController,bodyController);
          },
        ),
      ),
    );
  }
}

void _finish(BuildContext context) {
  SchedulerBinding.instance?.addPostFrameCallback((_) {
    Navigator.pop(context, "result");
  });
}
