import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_block/block/list_post_state.dart';
import 'package:pattern_block/pages/update_page.dart';
import 'package:pattern_block/post_model/model_post.dart';
import 'package:pattern_block/serviece/http_service.dart';

import '../pages/create_page.dart';

class ListPostCubit extends Cubit<ListPostState> {
  ListPostCubit() : super(ListPostInit());

  // post funsiyasi
  void apiPostList() async {
    emit(ListPostLoading());
    final response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      emit(ListPostLoaded(posts: Network.parsePostList(response)));
    } else {
      emit(ListPostError(error: "Couldn't fetch posts"));
    }
  }

  // delete funksiyasi
  void apiPostDelete(Post post) async {
    emit(ListPostLoading());
    await Network.DEL(Network.API_DELETE, Network.paramsEmpty())
        .then((response) {
      if (response != null) {
        apiPostList();
      } else {
        emit(ListPostError(error: "Couldn't fetch post"));
      }
    });
  }

  // create funksiyasi
  void callCreatePage(BuildContext context) async {
    var result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CreatePage()));
    if (result != null) {
      BlocProvider.of<ListPostCubit>(context).apiPostList();
    }
  }

  void callUpdatePage(BuildContext context, Post post) async {
    var result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => UpdatePage(post: post,)));
    if(result != null){
      BlocProvider.of<ListPostCubit>(context).apiPostList();
    }
  }
}
