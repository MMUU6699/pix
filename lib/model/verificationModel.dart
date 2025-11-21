class VerificationModel {
  String? key;
  String? userId;
  String? userName;
  String? userEmail;
  String? reason;
  String? status; // pending, approved, rejected
  String? submittedAt;
  String? reviewedAt;
  String? reviewedBy;
  String? reviewNotes;
  String? documentUrl;
  String? category; // public_figure, business, government, etc.

  VerificationModel({
    this.key,
    this.userId,
    this.userName,
    this.userEmail,
    this.reason,
    this.status = 'pending',
    this.submittedAt,
    this.reviewedAt,
    this.reviewedBy,
    this.reviewNotes,
    this.documentUrl,
    this.category,
  });

  VerificationModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    userId = json['userId'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    reason = json['reason'];
    status = json['status'] ?? 'pending';
    submittedAt = json['submittedAt'];
    reviewedAt = json['reviewedAt'];
    reviewedBy = json['reviewedBy'];
    reviewNotes = json['reviewNotes'];
    documentUrl = json['documentUrl'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['userId'] = userId;
    data['userName'] = userName;
    data['userEmail'] = userEmail;
    data['reason'] = reason;
    data['status'] = status;
    data['submittedAt'] = submittedAt;
    data['reviewedAt'] = reviewedAt;
    data['reviewedBy'] = reviewedBy;
    data['reviewNotes'] = reviewNotes;
    data['documentUrl'] = documentUrl;
    data['category'] = category;
    return data;
  }

  VerificationModel copyWith({
    String? key,
    String? userId,
    String? userName,
    String? userEmail,
    String? reason,
    String? status,
    String? submittedAt,
    String? reviewedAt,
    String? reviewedBy,
    String? reviewNotes,
    String? documentUrl,
    String? category,
  }) {
    return VerificationModel(
      key: key ?? this.key,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      submittedAt: submittedAt ?? this.submittedAt,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      reviewedBy: reviewedBy ?? this.reviewedBy,
      reviewNotes: reviewNotes ?? this.reviewNotes,
      documentUrl: documentUrl ?? this.documentUrl,
      category: category ?? this.category,
    );
  }

  bool get isPending => status == 'pending';
  bool get isApproved => status == 'approved';
  bool get isRejected => status == 'rejected';
}