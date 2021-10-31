

import 'package:eat_more_app/model/branch_response.dart';
import 'package:eat_more_app/model/service_model.dart';

import '../http_manager.dart';

class ServiceClient{
  Future<List<Services>> listService(int  vendorId) async {
    try{
      final response=await  HttpManager.get<ServiceData>('service?vendor_id=$vendorId',(json) => ServiceData.fromJson(json));
      return response.services;
    }
    catch(err){
      throw(err);
    }
  }
  Future<List<Branch>> listBranch(int vendorId,String longitude,String latitude,String type) async {
    try{
      final response=await  HttpManager.get<BranchData>('branches?vendor_id=$vendorId&type=$type&longitude=$longitude&latitude=$latitude',(json) => BranchData.fromJson(json));
      return response.branches;
    }
    catch(err){
      throw(err);
    }
  }

}