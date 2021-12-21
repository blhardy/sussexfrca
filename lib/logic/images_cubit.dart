import 'package:SussexFRCA/models/image_explanation.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'images_state.dart';

class ImagesCubit extends Cubit<ImageScreenState> with HydratedMixin {
  ImagesCubit() : super(ImageScreenState(selectedImageIndex: 0));

  void selectImage(int sel) {
    emit(ImageScreenState(selectedImageIndex: sel));
  }

  @override
  ImageScreenState? fromJson(Map<String, dynamic> json) {}

  @override
  Map<String, dynamic>? toJson(ImageScreenState state) {}
}
