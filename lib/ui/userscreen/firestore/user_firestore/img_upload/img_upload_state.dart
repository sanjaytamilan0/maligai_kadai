
import 'package:equatable/equatable.dart';

abstract class ImageUploadState extends Equatable{

}

class ImageUploadInitial extends ImageUploadState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ImageUploading extends ImageUploadState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ImageUploaded extends ImageUploadState {
  final String imageUrl;

  ImageUploaded(this.imageUrl);

  @override
  // TODO: implement props
  List<Object?> get props => [imageUrl];
}

