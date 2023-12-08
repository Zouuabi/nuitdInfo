import 'package:dartz/dartz.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvema/src/data/models/article.dart';
import 'package:mouvema/src/presentation/blog/cubit/blog_state.dart';

import '../../../core/failure.dart';
import '../../../data/repository/repository_impl.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit(this.repos) : super(const FeedState(status: Status.initial)) {
    fetchArticles();
  }
  final RepositoryImpl repos;

  List<Article> articles = const [
    Article(
        title: 'The Daily Commute Dilemma: Finding Sustainable Solutions',
        imageUrl:
            'https://www.sirenergies.com/content/images/2022/10/climate-change.jpeg?fbclid=IwAR2bGO3v0xDJFQG8IBltelBxkAT5ddifiSl_zYGiruEVl_ZbjSC7dSp_RKg',
        content:
            """
The transportation sector is a major contributor to climate change, responsible for roughly 29% of global greenhouse gas emissions. Our daily commute, whether by car, bus, or bike, plays a significant role in this impact. This article explores the challenges of unsustainable transportation and delves into practical solutions for reducing our carbon footprint,including carpooling, public transportation, and embracing active mobility options like cycling and walking
""",
        likesNum: 545,
        lovesNum: 988),
    Article(
        title: 'Beyond Cars: Reimagining Mobility for a Sustainable Future',
        imageUrl:
            'https://i0.wp.com/lapresse.tn/wp-content/uploads/2022/10/changement-climatique.jpg?resize=740%2C427&ssl=1&fbclid=IwAR0lUrhfccbIs2-RZ4IDrMWGbMBFbl9XI3EdijulPwApaJZDGTJ0jw7_-l0',
        content:
            """Our dependence on personal cars has created a multitude of problems,from traffic congestion and air pollution to public health issues and social inequity. This article goes beyond the limitations of car-centric transportation, showcasing innovative and sustainable alternatives that prioritize people, not vehicles.We explore the rise of micromobility,the potential of electric vehicles, and the need for urban planning that fosters walkable and bikeable communities.
""",
        likesNum: 545,
        lovesNum: 988),
    Article(
        title: 'Reclaiming Our Streets: Building Cities for People, Not Cars',
        imageUrl:
            'https://ichef.bbci.co.uk/news/640/cpsprodpb/2B08/production/_127561011_climate_5_cc_index_and_article_image_template_976-ncclimate_change_article_image_template_976-nc.png',
        content:
            """Our cities have been designed around the automobile, prioritizing traffic flow over the needs of pedestrians, cyclists, and public transportation users.This article argues for a paradigm shift in urban planning, advocating for "15-minute cities" where all essential amenities are accessible within a 15-minute walk or bike ride.By prioritizing public spaces, green infrastructure,and safe cycling lanes, we can create cities that are not only sustainable but also vibrant and livable.
""",
        likesNum: 545,
        lovesNum: 988),
    Article(
        title: 'The Daily Commute Dilemma: Finding Sustainable Solutions',
        imageUrl:
            'https://www.sirenergies.com/content/images/2022/10/climate-change.jpeg?fbclid=IwAR2bGO3v0xDJFQG8IBltelBxkAT5ddifiSl_zYGiruEVl_ZbjSC7dSp_RKg',
        content:
            """
The transportation sector is a major contributor to climate change, responsible for roughly 29% of global greenhouse gas emissions. Our daily commute, whether by car, bus, or bike, plays a significant role in this impact. This article explores the challenges of unsustainable transportation and delves into practical solutions for reducing our carbon footprint,including carpooling, public transportation, and embracing active mobility options like cycling and walking
""",
        likesNum: 545,
        lovesNum: 988),
    Article(
        title: 'Beyond Cars: Reimagining Mobility for a Sustainable Future',
        imageUrl:
            'https://i0.wp.com/lapresse.tn/wp-content/uploads/2022/10/changement-climatique.jpg?resize=740%2C427&ssl=1&fbclid=IwAR0lUrhfccbIs2-RZ4IDrMWGbMBFbl9XI3EdijulPwApaJZDGTJ0jw7_-l0',
        content:
            """Our dependence on personal cars has created a multitude of problems,from traffic congestion and air pollution to public health issues and social inequity. This article goes beyond the limitations of car-centric transportation, showcasing innovative and sustainable alternatives that prioritize people, not vehicles.We explore the rise of micromobility,the potential of electric vehicles, and the need for urban planning that fosters walkable and bikeable communities.
""",
        likesNum: 545,
        lovesNum: 988),
    Article(
        title: 'Reclaiming Our Streets: Building Cities for People, Not Cars',
        imageUrl:
            'https://ichef.bbci.co.uk/news/640/cpsprodpb/2B08/production/_127561011_climate_5_cc_index_and_article_image_template_976-ncclimate_change_article_image_template_976-nc.png',
        content:
            """Our cities have been designed around the automobile, prioritizing traffic flow over the needs of pedestrians, cyclists, and public transportation users.This article argues for a paradigm shift in urban planning, advocating for "15-minute cities" where all essential amenities are accessible within a 15-minute walk or bike ride.By prioritizing public spaces, green infrastructure,and safe cycling lanes, we can create cities that are not only sustainable but also vibrant and livable.
""",
        likesNum: 545,
        lovesNum: 988),
    Article(
        title: 'The Daily Commute Dilemma: Finding Sustainable Solutions',
        imageUrl:
            'https://www.sirenergies.com/content/images/2022/10/climate-change.jpeg?fbclid=IwAR2bGO3v0xDJFQG8IBltelBxkAT5ddifiSl_zYGiruEVl_ZbjSC7dSp_RKg',
        content:
            """
The transportation sector is a major contributor to climate change, responsible for roughly 29% of global greenhouse gas emissions. Our daily commute, whether by car, bus, or bike, plays a significant role in this impact. This article explores the challenges of unsustainable transportation and delves into practical solutions for reducing our carbon footprint,including carpooling, public transportation, and embracing active mobility options like cycling and walking
""",
        likesNum: 545,
        lovesNum: 988),
    Article(
        title: 'Beyond Cars: Reimagining Mobility for a Sustainable Future',
        imageUrl:
            'https://i0.wp.com/lapresse.tn/wp-content/uploads/2022/10/changement-climatique.jpg?resize=740%2C427&ssl=1&fbclid=IwAR0lUrhfccbIs2-RZ4IDrMWGbMBFbl9XI3EdijulPwApaJZDGTJ0jw7_-l0',
        content:
            """Our dependence on personal cars has created a multitude of problems,from traffic congestion and air pollution to public health issues and social inequity. This article goes beyond the limitations of car-centric transportation, showcasing innovative and sustainable alternatives that prioritize people, not vehicles.We explore the rise of micromobility,the potential of electric vehicles, and the need for urban planning that fosters walkable and bikeable communities.
""",
        likesNum: 545,
        lovesNum: 988),
    Article(
        title: 'Reclaiming Our Streets: Building Cities for People, Not Cars',
        imageUrl:
            'https://ichef.bbci.co.uk/news/640/cpsprodpb/2B08/production/_127561011_climate_5_cc_index_and_article_image_template_976-ncclimate_change_article_image_template_976-nc.png',
        content:
            """Our cities have been designed around the automobile, prioritizing traffic flow over the needs of pedestrians, cyclists, and public transportation users.This article argues for a paradigm shift in urban planning, advocating for "15-minute cities" where all essential amenities are accessible within a 15-minute walk or bike ride.By prioritizing public spaces, green infrastructure,and safe cycling lanes, we can create cities that are not only sustainable but also vibrant and livable.
""",
        likesNum: 545,
        lovesNum: 988),
  ];

  void fetchArticles() async {
    if (!isClosed) {
      emit(const FeedState(status: Status.loading));

      emit(FeedState(status: Status.fetchSuccess, data: articles));
    }
  }
}
