// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeStateDelivery()) {
    on<HomeEventGoToPickupSection>((event, emit) async {
      try{
        emit(HomeStatePickUp());
      } catch (e){
        rethrow;
      }
    });
    on<HomeEventGoToDeliverySection>((event, emit) {
      try{
        emit(HomeStateDelivery());
      } catch (e){
        rethrow;
      }
      
    });
  }
}
