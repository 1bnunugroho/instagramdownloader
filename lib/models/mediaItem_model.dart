class MediaItemModel {
  String _id;
  bool _isVideo;
  String _photoUrl;
  String _videoUrl;
  String _downloadStatus;

  MediaItemModel(this._isVideo, this._photoUrl, this._videoUrl, this._downloadStatus);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["downloadIsVideo"] = _isVideo;
    map["downloadPhotoUrl"] = _photoUrl;
    map["downloadVideoUrl"] = _videoUrl;
    map["downloadStatus"] = _downloadStatus;
    if (_id != null) {
      map["downloadId"] = _id;
    }
    return map;
  }

  MediaItemModel.fromObject(dynamic o) {
    this._id = o["downloadId"].toString();
    var checkVideo = o["downloadIsVideo"];
    if (checkVideo == "1") {
      this._isVideo = true;
    } else {
      this._isVideo = false;
    }
    this._photoUrl = o["downloadPhotoUrl"];
    this._videoUrl = o["downloadVideoUrl"];
    this._downloadStatus = o["downloadStatus"];
  }

  String get videoUrl => _videoUrl;

  set videoUrl(String value) {
    _videoUrl = value;
  }

  String get photoUrl => _photoUrl;

  set photoUrl(String value) {
    _photoUrl = value;
  }

  bool get isVideo => _isVideo;

  set isVideo(bool value) {
    _isVideo = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get downloadStatus => _downloadStatus;

  set downloadStatus(String value) {
    _downloadStatus = value;
  }

  @override
  String toString() {
    return 'MediaItemModel{_id: $_id, _isVideo: $_isVideo, _photoUrl: $_photoUrl,'
        ' _videoUrl: $_videoUrl, _downloadStatus: $_downloadStatus}';
  }

}
