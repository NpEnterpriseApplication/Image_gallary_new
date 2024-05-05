import '../../model/image_response_model.dart';
import '../index.dart';

class Repo {
  static RepoImpl getInstance() {
    return RepoImpl(dataProvider: DataProvider());
  }
}

abstract class Repository {
//============================= Api =====================================

  Future<ImageResponseModel> getImageData();
}
