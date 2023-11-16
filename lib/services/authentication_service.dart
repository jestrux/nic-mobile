import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/models/recover_user_model.dart';
import 'package:nic/services/data_connection.dart';
// import 'package:imis_client_app/services/repository.dart';
import 'package:nic/models/user_model.dart';

class AuthenticationService {
  Future<UserModel?> loginUser({String? username, String? password}) async {
    UserModel? userModel;
    String login = r"""
       mutation($username: String!, $password: String!){
        tokenAuth(username: $username, password: $password){
          token
          user{
            id
            firstName
            lastName
            username
            email
            profile{
              middleName
              phone
              dp
              pic
              customerNumberType
              customCustomerNumber
              totalPolicies
              totalLifePolicies
              totalNonLifePolicies
              totalProposals
              totalClaims
              branch{
                id
                name
                code
              }
            }
          }
        }
      }
    """;

    final MutationOptions options = MutationOptions(
      document: gql(login),
      variables: <String, dynamic>{'username': username, "password": password},
    );

    GraphQLClient client = await DataConnection().connectionClient();
    final QueryResult result = await client.mutate(options);
    if (result.data != null && result.hasException == false) {
      // print(result.data);
      userModel = UserModel.fromJson(result.data);
      // var tokenBox = Hive.box("token");
      // tokenBox.put("token", userModel.token);
      // Repository().setToken(userModel);
      // var userBox = await Hive.openBox("user");
      //
      // userModel.toMap().forEach((key, value) => userBox.put(key, value));
      // var userProfileBox = await Hive.openBox("userProfile");
      // userProfileBox.put("customCustomerNumber", userModel.customCustomerNumber);
      // userProfileBox.put("customerNumberType", userModel.customerNumberType);
      // userProfileBox.put("total_proposals", userModel.totalProposals);
      // userProfileBox.put("total_non_life_policies", userModel.totalNonLifePolicies);
      // userProfileBox.put("total_policies", userModel.totalPolicies);
      // userProfileBox.put("total_life_policies", userModel.totalLifePolicies);
      // userProfileBox.put("total_claims", userModel.totalClaims);
      // if (Repository().getToken() != null) {
      //   return userModel;
      // }
    }
    return userModel;
  }

  Future<Map<String, dynamic>?> register(
    String? fullName,
    String? phoneNumber,
    String? nida,
    String? password,
    bool? salesPerson,
    int? selectedGender,
    String? dob,
    String? branch,
  ) async {
    String register = r"""
   mutation ($nida: String!, $phone: String!, $fullName: String!, $password: String!, $salesPerson: Boolean!, $selectedGender:Int!, $dob:String!, $branch:String!) {
        registerMobile(input: {nida: $nida, phone: $phone, fullName: $fullName, password: $password, salesPerson: $salesPerson, selectedGender: $selectedGender, dob:$dob, branch:$branch}) {
          success
          token
          user{
            id
            firstName
            lastName
            username
            email
            profile{
              middleName
              phone
              dp
              pic
              customerNumberType
              customCustomerNumber
              totalPolicies
              totalLifePolicies
              totalNonLifePolicies
              totalProposals
              totalClaims
              branch{
                id
                name
                code
              }
            }
          }
          errors{
            field
            messages
          }
        }
      }
    """;

    final MutationOptions options = MutationOptions(
      document: gql(register),
      variables: <String, dynamic>{
        'fullName': fullName,
        'phone': phoneNumber,
        'nida': nida,
        "password": password,
        "salesPerson": salesPerson,
        "selectedGender":selectedGender,
        "dob":dob,
        "branch":branch
      },
    );

    // print("dob----: ${dob}");
    // print("branch----: ${branch}");
    GraphQLClient client = await DataConnection().connectionClient();
    final QueryResult result = await client.mutate(options);
    if (result.data != null) {
      if (result.data!['registerMobile']['success'] == true) {
        UserModel userModel = UserModel.fromRegisterJson(
          result.data,
        );
        // Repository().setToken(userModel);
        // var tokenBox = Hive.box("token");
        // tokenBox.put("token", userModel.token);
        // Repository().setToken(userModel);
        // var userBox = await Hive.openBox("user");
        //
        // userModel.toMap().forEach((key, value) => userBox.put(key, value));
        // var userProfileBox = await Hive.openBox("userProfile");
        // userProfileBox.put("total_proposals", userModel.totalProposals);
        // userProfileBox.put(
        //     "total_non_life_policies", userModel.totalNonLifePolicies);
        // userProfileBox.put("total_policies", userModel.totalPolicies);
        // userProfileBox.put("total_life_policies", userModel.totalLifePolicies);
        // userProfileBox.put("total_claims", userModel.totalClaims);
        // if (Repository().getToken() != null) {
        //   return {
        //     "status": true,
        //     "data": userModel,
        //   };
        // }
      } else {
        return {
          "status": false,
          "errors": result.data!['registerMobile']['errors']
        };
      }
    }
    return null;
  }

  // Future<UserModel> getUser() async {
  //   // print("*******get user called*******");
  //   return Repository().getUser();
  // }
  //
  // Future<bool> createToken(String? ftoken) async {
  //   var box = Hive.box('ftoken');
  //   box.put("token", ftoken);
  //   String login = r"""
  //       mutation($ftoken: String!){
  //         androidCreateFcmToken(ftoken: $ftoken){
  //           success
  //         }
  //       }
  //   """;
  //
  //   final MutationOptions options = MutationOptions(
  //     document: gql(login),
  //     variables: <String, dynamic>{'ftoken': box.get("token")},
  //   );
  //
  //   GraphQLClient client = await DataConnection().connectionClient();
  //   final QueryResult result = await client.mutate(options);
  //   if (result.data != null) {
  //     // print(result.data);
  //   }
  //   return false;
  // }

  Future<RecoverUserModel?> recoverAccount({String? searchKey}) async {
    RecoverUserModel? userObj;
    String userQuery = r"""
          query ($searchKey: String!) {
            searchUser(searchKey: $searchKey) {
              edges {
                node{
                  phone
                  id
                  user{
                    id
                    firstName
                    lastName
                    email
                  }
                  
                }
              }
            }
          }
    """;

    final QueryOptions options = QueryOptions(
      document: gql(userQuery),
      variables: {"searchKey": searchKey},
    );

    GraphQLClient client = await DataConnection().connectionClient();
    final QueryResult result = await client.query(options);
    if (result.data != null) {
      if (result.data!['searchUser']['edges'].length > 0) {
        var user = result.data!['searchUser']['edges'][0]['node'];
        userObj = RecoverUserModel.fromJson(user);
        // userObj = RecoverUserModel(
        //     firstName: user['user']['firstName'],
        //     lastName: user['user']['lastName'],
        //     email: user['user']['email'],
        //     phone: user['phone'],
        //     id: user['user']['id']);
      }
    }
    return userObj;
  }

  Future<bool> recoverAccountAgreed({String? searchKey}) async {
    bool response = false;
    String userQuery = r"""
         query ($searchKey: String!) {
          recoverUserPassword(searchKey: $searchKey) {
            edges {
              node{
                id
              }
            }
          }
        }
  """;

    final QueryOptions options = QueryOptions(
      document: gql(userQuery),
      variables: {"searchKey": searchKey},
    );

    GraphQLClient client = await DataConnection().connectionClient();
    final QueryResult result = await client.query(options);
    if (result.data != null) {
      if (result.data!['recoverUserPassword']['edges'].length > 0) {
        var user = result.data!['recoverUserPassword']['edges'][0]['node'];
        if (user['id'] != null) {
          response = true;
        }
      }
    }
    return response;
  }

  Future<dynamic> resetPassword(String? currentPassword,
      String? newPassword, String? repeatPassword) async {
    String resetPassword = r""" 
          mutation($currentPassword: String!,$newPassword: String!, $repeatPassword: String!){
        changePassword(currentPassword:$currentPassword,newPassword:$newPassword,repeatPassword:$repeatPassword){
          success
          message
        }
      }
    """;

    final MutationOptions options = MutationOptions(
      document: gql(resetPassword),
      variables: <String, dynamic>{
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'repeatPassword': repeatPassword,
      },
    );

    GraphQLClient client = await DataConnection().connectionClient();
    final QueryResult result = await client.mutate(options);
    if (result.data != null) {
      var temp = result.data!;
      // print(result.data!);
      dynamic info = {
        "status":"${temp['changePassword']['success']}",
        "message":"${temp['changePassword']['message']}"
      };
      print(info);
      return info;

    } else {
      return {
        'status':false,
        "message":"Failed to reset password."
      };
    }
  }

  Future<dynamic> updateUserId(String? userId) async {
    String resetPassword = r""" 
          mutation($userId: String!){
        updateUserId(userId:$userId){
          success
          message
        }
      }
    """;

    final MutationOptions options = MutationOptions(
      document: gql(resetPassword),
      variables: <String, dynamic>{
        'userId': userId,
      },
    );

    GraphQLClient client = await DataConnection().connectionClient();
    final QueryResult result = await client.mutate(options);
    if (result.data != null) {
      var temp = result.data!;
      // print(result.data!);
      dynamic info = {
        "status":"${temp['updateUserId']['success']}",
        "message":"${temp['updateUserId']['message']}"
      };
      print(info);
      return info;

    } else {
      return {
        'status':false,
        "message":"Failed to update."
      };
    }
  }
}
