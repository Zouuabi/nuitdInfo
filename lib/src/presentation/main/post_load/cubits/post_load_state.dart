import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

enum Status { initial, success, loading, failed, onPositionChanged }

class PostState extends Equatable {
  const PostState({this.message, this.data, required this.status});
  final Status status;
  final String? message;
  final List<LatLng?>? data;
  @override
  get props => [status, message, data];
}
