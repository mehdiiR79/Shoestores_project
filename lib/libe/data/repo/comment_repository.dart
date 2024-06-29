
import 'package:shoestores/libe/common/http_client.dart';
import 'package:shoestores/libe/data/comment.dart';
import 'package:shoestores/libe/data/source/comment_data_source.dart';

final commentRepository =
    CommentRepository(CommentRemoteDataSource(httpClient));

abstract class ICommentRepository {
  Future<List<CommentEntity>> getAll({required int productId});
  Future<CommentEntity> insert(String title, String content, int product);

}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource dataSource;

  CommentRepository(this.dataSource);
  @override
  Future<List<CommentEntity>> getAll({required int productId}) =>
      dataSource.getAll(productId: productId);

  @override
  Future<CommentEntity> insert(String title, String content, int productId) {
    return dataSource.insert(title, content, productId);
  }
}
