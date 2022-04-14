import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_block/block/create_post_cubit.dart';
import 'package:pattern_block/block/create_post_state.dart';

import '../views/view_of_create.dart';

class CreatePage extends StatelessWidget {
   CreatePage({Key? key}) : super(key: key);

   TextEditingController titleController = TextEditingController();
   TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => CreatePostCubit(),
    child: Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: BlocBuilder<CreatePostCubit , CreatePostState>(
        builder: (BuildContext context, CreatePostState state){
          if(state is CreatePostLoading){
            return viewOfCreate(true,context,titleController,bodyController);
          }
          if(state is CreatePostLoaded){
            _finish(context);
          }
          if(state is CreatePostError){

          }
          return viewOfCreate(false,context,titleController,bodyController);
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
