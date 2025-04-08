Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D14C369A1
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 19:04:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2BCA402B9;
	Tue,  8 Apr 2025 21:04:21 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id F1AC84026B
 for <dev@dpdk.org>; Tue,  8 Apr 2025 21:04:20 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-306b6ae4fb3so3278824a91.1
 for <dev@dpdk.org>; Tue, 08 Apr 2025 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744139060;
 x=1744743860; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PUxQgVsQX4mK1ibktg+94oswByb8ud7vODqte3YPPNo=;
 b=W86td8av44l3IoHxkIawD0a/cAf1LAAyaLOPOHxiav5yyQ5uguVXaw5uQaslw9qjQ/
 caBkJHpBvhYJqZ0HNbqCZRKdf7GdEwuB66kX7i8CFvIQ0tqQzSD305FSJ2ZKCE7TkicN
 F90Zd/oEVT1LLK8Hug8GgxwPbsJC47QBEKILrkP8W6/Hs10hCFNJCWgpjU525gXgQX0s
 Qr9I6qiuM6hyUVcnBlBOnRjga54iAJKtok5VoaDBRwzq3QL8RQw90eFgUK9zXgb+7h3g
 G5pT9hSbs+2wGLk691u6jKjrwG2xgqwzorBApGMeC/srI8ygLVI3QmweI4uIaI0y11Pv
 fNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744139060; x=1744743860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PUxQgVsQX4mK1ibktg+94oswByb8ud7vODqte3YPPNo=;
 b=d4BYsXhDBtFFsZDhLdMT6ljAEYOpq6SuG/EmtLmiCNMUECC8NoJk0tVV38B0tH8bND
 Wn5bJo7LTCD2rwoejNGg+ULDiNbHJEJcDVTaq5ne0nCSMgWJLWWKc+r9PpUE35yWvYuV
 ndJBTfBmWz7GzsFdlzQaqAxWwT2dWz9xDRgbvb71Ko9usMPw/lKfLeKiNIhZ/iYQso5P
 dHR8gpphEvATVPDF+7GriDe8MMm71nR8EhKSkS+FefNefiUj9Eds//zxVtZkKIrxSUKx
 GhOtj6SCLwjFpyqwWdIofV+JyUEDkwGQysTh0CBbSTHapFr3F69ETZt2fVGo2eQ/8l3D
 wngw==
X-Gm-Message-State: AOJu0YxFY9x+HjzufdR6qVi8H93bLhgWxoa1xNwk9LV0qzQ0F0EpuktK
 Zme210K5gHfDVVTh+3w40fqRT4/y1bzc+NjZXdH6Ve9Z6XD904AR2yVwHfwkOKHEXwFt37G1ddG
 j
X-Gm-Gg: ASbGncsPmw+CAoQS34MIalQniFz8GT5m5bhSQnezD2ItZqPlW7UpzSarC4OyVEgNp4i
 4k+GySUu60s3p4XXnhQTZQG7lwii206+ueuL/swQJPbHwR8e6uWXwMLlJMXn1VSGkJ4Tnl78DNt
 3y8TalAtlt7JCNQTi4JrA8NH9pN3l8KXd3XD63PznosuZ0qWYPjQp2qdiGKWOaoy7dIm5KwdhPp
 JyjcGXrXF8kJ77z4mohEPCouKFZAVhYIh/lNWTU9JPuid8Y+zPpO3jujSn/kjdb3+ZBQr+5p9Th
 Y5eLg46YJXAhze6UkSJHabjGaM6NdomWrOlg1rpJo3xGYtJFG7jHY2kyZtsHVdiZXaJ93NGIvzU
 y24BgpN649P0A4CuOiOLj
X-Google-Smtp-Source: AGHT+IEL9sLSUDT5hIJrDlT+Pb56sLvhdoD87yYQsndvTC//7H4XOBhNLM2HjVMxXDO4m59QkhhtyQ==
X-Received: by 2002:a17:90b:5188:b0:2ee:f687:6acb with SMTP id
 98e67ed59e1d1-306dbbae2a5mr472369a91.13.1744139060076; 
 Tue, 08 Apr 2025 12:04:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-305827d71b8sm12707036a91.8.2025.04.08.12.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 12:04:19 -0700 (PDT)
Date: Tue, 8 Apr 2025 12:04:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: Re: [RFC] eal: remove support for I/O port
Message-ID: <20250408120417.3e7c5236@hermes.local>
In-Reply-To: <20250408183032.86167-1-stephen@networkplumber.org>
References: <20250408183032.86167-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

On Tue,  8 Apr 2025 11:30:32 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> In early days of virtio, the x86 I/O instructions were used
> to ring the doorbell for host access. To support these DPDK
> needed to enable IO access. This is no longer necessary and
> the vestiage can be marked deprecated.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Not yet, FreeBSD still uses it and the virtio support still needs it.
Really needs to go since many kernels fully block userspace to I/O
because it allows unrestricted access to hardware.

