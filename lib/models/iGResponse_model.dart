import 'package:instagramdownloader/models/mediaItem_model.dart';
import 'package:instagramdownloader/common/appsetting.dart';

class IGResponseModel {
  List<MediaItemModel> mediaList;

  IGResponseModel(this.mediaList);

  factory IGResponseModel.fromJson(Map<String, dynamic> json) {
    List<MediaItemModel> mediaItem = List();
    var children =
        json['graphql']['shortcode_media']['edge_sidecar_to_children'];
    if (children != null) {
      for (var child in children['edges']) {
        var node = child['node'];
        String photoUrl =
            new List<dynamic>.from(node['display_resources']).last['src'];
        bool checkVideo = node['is_video'];
        String videoUrl = checkVideo ? node['video_url'] : '';
        mediaItem.add(MediaItemModel(checkVideo, photoUrl, videoUrl, downloadStart));
      }
    } else {
      String photo = new List<dynamic>.from(
              json['graphql']['shortcode_media']['display_resources'])
          .last['src'];
      bool checkVideo = json['graphql']['shortcode_media']['is_video'];
      String videoUrl =
          checkVideo ? json['graphql']['shortcode_media']['video_url'] : '';
      mediaItem.add(MediaItemModel(checkVideo, photo, videoUrl, downloadStart));
    }

    return IGResponseModel(mediaItem);
  }

  @override
  String toString() {
    return 'IGResponseModel{mediaList: $mediaList}';
  }
}
