import 'package:llr/features/auth/data/delete_account_rx/rx.dart';
import 'package:llr/features/auth/data/logut_rx/rx.dart';
import 'package:llr/features/auth/data/rx.dart';
import 'package:llr/features/auth/model/login_response_model.dart';
import 'package:llr/features/auth/presentation/signup/data/rx.dart';
import 'package:llr/features/auth/presentation/update_profile_rx/rx.dart';
import 'package:llr/features/auth/presentation/verify_otp/model/otp_verify_model.dart';
import 'package:llr/features/auth/presentation/verify_otp/otp_verify_rx/rx.dart';
import 'package:llr/features/block/data/rx_block_list/rx.dart';
import 'package:llr/features/block/data/rx_unblock_user/rx.dart';
import 'package:llr/features/block/model/block_user_response.dart';
import 'package:llr/features/chat/data/get_chat_inbox_rx/rx.dart';
import 'package:llr/features/chat/data/rx_chat_send/rx.dart';
import 'package:llr/features/chat/data/rx_report_user/rx.dart';
import 'package:llr/features/chat/data/user_chatList_rx/rx.dart';
import 'package:llr/features/chat/model/chat_inbox_model.dart';
import 'package:llr/features/chat/model/send_model.dart';
import 'package:llr/features/chat/model/user_list_model.dart';
import 'package:llr/features/create_alumubs/data/rx.dart';
import 'package:llr/features/create_alumubs/model/create_model.dart';
import 'package:llr/features/festival_details/data/all_festival_rx/rx.dart';
import 'package:llr/features/festival_details/data/drop_down_festive_rx/rx.dart';
import 'package:llr/features/festival_details/data/festival_details_rx/data/rx.dart';
import 'package:llr/features/festival_details/data/festival_details_rx/model/alumbs_details_model.dart';
import 'package:llr/features/festival_details/data/review_comment_rx/rx.dart';
import 'package:llr/features/festival_details/data/review_like_rx/rx.dart';
import 'package:llr/features/festival_details/data/review_rx/rx.dart';
import 'package:llr/features/festival_details/data/rx_report_content/rx.dart';
import 'package:llr/features/festival_details/model/allalums_model.dart';
import 'package:llr/features/festival_details/model/fseive_all_model.dart';
import 'package:llr/features/festival_details/model/review_comment_model.dart';
import 'package:llr/features/festival_details/model/review_like_model.dart';
import 'package:llr/features/festival_details/model/review_model.dart';
import 'package:llr/features/friend/data/add_friend_list_rx/rx.dart';
import 'package:llr/features/friend/data/friend_request_accept_rx/rx.dart';
import 'package:llr/features/friend/data/friend_request_list_rx/rx.dart';
import 'package:llr/features/friend/data/my_all_friend_list_rx/rx.dart';
import 'package:llr/features/friend/data/rx_block/rx.dart';
import 'package:llr/features/friend/data/rx_unfriend/rx.dart';
import 'package:llr/features/friend/data/send_friendrequest_rx/rx.dart';
import 'package:llr/features/friend/model/add_friend_list_model.dart';
import 'package:llr/features/friend/model/friend_request_model.dart';
import 'package:llr/features/friend/model/my_all_friend_model.dart';
import 'package:llr/features/friend/model/request_accept.dart';
import 'package:llr/features/help_and_support/data/rx_contact_message/rx.dart';
import 'package:llr/features/help_and_support/data/rx_get_help/rx.dart';
import 'package:llr/features/help_and_support/model/faq_response.dart';
import 'package:llr/features/privacy_policy/data/rx_privacy_policy/rx.dart';
import 'package:llr/features/privacy_policy/model/privacy_policy_response.dart';
import 'package:llr/features/profile/data/get_private/rx.dart';
import 'package:llr/features/profile/data/get_public/rx.dart';
import 'package:llr/features/profile/data/get_wish_get/rx.dart';
import 'package:llr/features/profile/data/my_alumbs/rx.dart';
import 'package:llr/features/profile/data/rx_post_wish/rx.dart';
import 'package:llr/features/profile/data/user_details_rx/rx.dart';
import 'package:llr/features/profile/model/my_alumbs_model.dart';
import 'package:llr/features/profile/model/private_albums_response.dart';
import 'package:llr/features/profile/model/public_albums_response.dart';
import 'package:llr/features/profile/model/user_details_model.dart';
import 'package:llr/features/profile/model/wish_list_response.dart';
import 'package:llr/features/search/data/rx.dart';
import 'package:llr/features/search/model/search_festival_response.dart';
import 'package:llr/features/terms_and_condition/data/rx_terms_and_condition/rx.dart';
import 'package:llr/features/terms_and_condition/model/term_and_conditon_response.dart';
import 'package:rxdart/rxdart.dart';

SignupRX signupRXObj = SignupRX(empty: {}, dataFetcher: BehaviorSubject<Map>());
VerifyOtpRx verifyOtpRxObj = VerifyOtpRx(
  empty: VerfiyOtpModel(),
  dataFetcher: BehaviorSubject<VerfiyOtpModel>(),
);
LoginRX loginRXObj = LoginRX(
  empty: LoginResponseModel(),
  dataFetcher: BehaviorSubject<LoginResponseModel>(),
);
EditProfileRx profileUpdateRxObj = EditProfileRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
AllAlumsRx allAlumsRxObj = AllAlumsRx(
  empty: AllAlumsModel(),
  dataFetcher: BehaviorSubject<AllAlumsModel>(),
);
AllAlumsDetailsRx allAlumsDetailsRxObj = AllAlumsDetailsRx(
  empty: AllAlumbsDetailsModel(),
  dataFetcher: BehaviorSubject<AllAlumbsDetailsModel>(),
);
ReviewRx reviewRxObj = ReviewRx(
  empty: ReviewModel(),
  dataFetcher: BehaviorSubject<ReviewModel>(),
);
ReviewLikeRx reviewLikeRxObj = ReviewLikeRx(
  empty: ReviewModelLike(),
  dataFetcher: BehaviorSubject<ReviewModelLike>(),
);
ReviewCommentRx reviewCommentRxOj = ReviewCommentRx(
  empty: ReviewCommentModel(),
  dataFetcher: BehaviorSubject<ReviewCommentModel>(),
);
AddFriendRx addFriendRxObj = AddFriendRx(
  empty: AddFriendListModel(),
  dataFetcher: BehaviorSubject<AddFriendListModel>(),
);
FriendRequestRx friendRequestRxObj = FriendRequestRx(
  empty: FriendRequestModel(),
  dataFetcher: BehaviorSubject<FriendRequestModel>(),
);
MyAllFriendRx myAllFriendRxObj = MyAllFriendRx(
  empty: MyAllFriendModel(),
  dataFetcher: BehaviorSubject<MyAllFriendModel>(),
);
RequestAcceptRx requestAcceptRxObj = RequestAcceptRx(
  empty: AcceptModel(),
  dataFetcher: BehaviorSubject<AcceptModel>(),
);
RequestSenerRx requestSenerRxObj = RequestSenerRx(
  empty: AcceptModel(),
  dataFetcher: BehaviorSubject<AcceptModel>(),
);
UserChatListRx userChatListRxObj = UserChatListRx(
  empty: UserListModel(),
  dataFetcher: BehaviorSubject<UserListModel>(),
);
SendMessageRx sendMessageRxObj = SendMessageRx(
  empty: SendChatModel(),
  dataFetcher: BehaviorSubject<SendChatModel>(),
);

GetChatDataRx getChatDataRxObj = GetChatDataRx(
  empty: ChatInboxModel(),
  dataFetcher: BehaviorSubject<ChatInboxModel>(),
);
UserDetailsRx userDetailsRxObj = UserDetailsRx(
  empty: UserDetailsModel(),
  dataFetcher: BehaviorSubject<UserDetailsModel>(),
);
MyAlumbsRx alumbsRxObj = MyAlumbsRx(
  empty: MyAlumbsModel(),
  dataFetcher: BehaviorSubject<MyAlumbsModel>(),
);
CreateAlumbsRx createAlumbsRxObj = CreateAlumbsRx(
  empty: CreateAlumbsModel(),
  dataFetcher: BehaviorSubject<CreateAlumbsModel>(),
);
LogoutRx logoutRxObj = LogoutRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
DeleteAccountRx deleteAccountRxObj = DeleteAccountRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
AllFestiveRx allFestiveRxObj = AllFestiveRx(
  empty: AllFestiveModel(),
  dataFetcher: BehaviorSubject<AllFestiveModel>(),
);
GetWishListRx getWishListRx = GetWishListRx(
  empty: WishResponse(),
  dataFetcher: BehaviorSubject<WishResponse>(),
);
FestivalSearchRx festivalSearchRx = FestivalSearchRx(
  empty: SearchFestivalResponse(),
  dataFetcher: BehaviorSubject<SearchFestivalResponse>(),
);
UnFriendRx unFriendRxObj = UnFriendRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
BlockUserRx blockUserRxObj = BlockUserRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
BlockUserListRx blockUserListRxObj = BlockUserListRx(
  empty: BlockUserModelResponse(),
  dataFetcher: BehaviorSubject<BlockUserModelResponse>(),
);
UnBlockUserRx unBlockUserRxObj = UnBlockUserRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
FaqRx faqRxObj = FaqRx(
  empty: FaqResponse(),
  dataFetcher: BehaviorSubject<FaqResponse>(),
);
ContactMessageRx contactMessageRxObj = ContactMessageRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
PostWishRx postWishRxObj = PostWishRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
TermsAndConditionRx termsAndConditionRxObj = TermsAndConditionRx(
  empty: TermsAndCodnition(),
  dataFetcher: BehaviorSubject<TermsAndCodnition>(),
);
PrivacyPolicyRx privacyPolicyRxObj = PrivacyPolicyRx(
  empty: PrivacyPolicyResponse(),
  dataFetcher: BehaviorSubject<PrivacyPolicyResponse>(),
);
GetPrivateAlbumsRx getPrivateAlbumsRxObj = GetPrivateAlbumsRx(
  empty: PrivetAlbumsResponse(),
  dataFetcher: BehaviorSubject<PrivetAlbumsResponse>(),
);
GetPublicAlbumsRx getPublicAlbumsRxObj = GetPublicAlbumsRx(
  empty: PublicAlbumsResponse(),
  dataFetcher: BehaviorSubject<PublicAlbumsResponse>(),
);
ReportUserRx reportUserRxObj = ReportUserRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
ReportContentRx reportContentRxObj = ReportContentRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
