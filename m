Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1F606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=eQ6MA0Sc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E0DC40A81;
	Mon,  9 Nov 2026 22:30:31 +0100 (CET)
Received: from aer-iport-6.cisco.com (aer-iport-6.cisco.com [173.38.203.68])
 by mails.dpdk.org (Postfix) with ESMTPS id D502040283
 for <dev@dpdk.org>; Mon,  9 Nov 2026 22:30:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=342; q=dns/txt;
 s=iport01; t=1794259830; x=1795469430;
 h=date:message-id:from:to:cc:subject:in-reply-to:
 references:mime-version;
 bh=lpML2VTOdFObOzU7Ffi4UZofngt21Q55jpQeSUpy1qI=;
 b=eQ6MA0SctomslmwrGG8We9rwPArOknwUuNQB896R0BN8I8IvSLGno2k+
 li7cTYve2esAB8AzgzNCC9+7GeAIr5g4D7t/+NVMOOe43NzmXOUegff7N
 b/ZbmVUva56ggYnVaOhq1kOfrXTEvA+4PRhpOhPQa04aaxS8T1uoyJBaT
 ZxDyNxiOWb3Z8UZcoHdlvx6RmxXNzCT1fVieV+bDh7WcGzf10baBqmjRh
 5Kei2QpSjDz1A1ErxCmKrGdlYQGBM+4gDdUF3rwaVRzOKtwVwbLOsvc2W
 hgv1NZ1UPCuZVvlmkRuGnmtOJKcykjwGkSkUo4M2UxADKjswHX6iwSS1y g==;
X-CSE-ConnectionGUID: 3Bd+h6mXTo2yCo1v/826NQ==
X-CSE-MsgGUID: PQVvzXfiT5arPoSXLOtRbQ==
X-IPAS-Result: =?us-ascii?q?A0B8BgBvOfJq/9NK/pBaglmCGIICEkOFII9ThlKZc4F+D?=
 =?us-ascii?q?wEBAQ9RBAEBgVEBgykKAo4dAiY1CA4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFA?=
 =?us-ascii?q?QEBAgEHBYEOE4ZckBMCAQMjVhALGgImAgJWBhuFbwO6X3qBMoEBhH/ZSoF0F?=
 =?us-ascii?q?YEKLohiAYYUhGInG4FJRIRAPogfgmoEgiKBDJdPLCZ4HANZLAEPRhMXCwcFg?=
 =?us-ascii?q?SVDA4EGI0sFLR2BIyEdFxEeWBsGBRIgKkFDW4ESgQddgSsoXQECH0YtFYF2A?=
 =?us-ascii?q?oJRgSNdAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAqBGjU8CSY/FQxkCAMaBRomA?=
 =?us-ascii?q?h8IAgsCDHQoERATHR4kLwUcJj4bCksHZj03FRkEAgE6e5R6gzR7xyCEKqFmE?=
 =?us-ascii?q?hwXg3EBEo0UhkmTEJkIo3MbhTaBagI4gVkzGggbFYMjUhkPj1gBAs8BRm8CB?=
 =?us-ascii?q?wIHDgMLk2YBAQ?=
IronPort-Data: A9a23:CwyXCq2cFrPP/tlr/fbD5YZwkn2cJEfYwER7XKvMYLTBsI5bp2cEy
 WRODWCOO/qMZDekeN93bNvn8xtTvJWBzIJhGVdv3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yEzmE4Ej9atANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXX5
 rsen+WFYAX7gmcsYzpIg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGV2s6fo1G/9ZLBjtf3
 vtBNnddNE6lvrfjqF67YrEEasULJcTxeYdasXZ6wHSAVbAtQIvIROPB4towMDUY35wSW6yDO
 4xGNXw1NU2ojx5nYj/7DLo8gOCsgnTjWzZZs1mS46Ew5gA/ySQsgeC8bYaOIbRmQ+1tp3iGt
 FLI/likCwsiM+ev7R2ZyHiV07qncSTTHdh6+KeD3vJnnnWf3mAQThoMWjOTq+OkgUP4QdNUK
 0UO9jEpq4Az8lCmSp/2WBjQnZKflhcRQZ9UVuY98gzIk/KS6AeCDW9CRTlEADA7iPILqfUR/
 gfht7vU6fZH6dV5lVr1Gm+okA6P
IronPort-HdrOrdr: A9a23:TGwQ7aop+PX7GUu8Wuz9sNoaV5oBeYIsimQD101hICG9vPb3qy
 nOpoV/6faaslwssR0b9exofZPhfZq+z+8W3WByB9qftWDd0QPCEGgh1/qA/9SKIUzDH4Bmup
 tIQuxZFMD6C0R8gILR5Qm1FMtl/fy8mZrY4ds3CxxWPGdXg2YK1XYfNjqm
X-Talos-CUID: 9a23:Ch/H02Bio6OTiGf6E3JN+A0URMUVTnqH3VzXelH/WTw3boTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AFMle0A0laRv/+bdU6eHiwQQqrTUj252QFlI9n5Q?=
 =?us-ascii?q?65sCeDStLCxO6kA69e9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,204,1787011200"; d="scan'208";a="59095433"
Received: from aer-l-core-10.cisco.com ([144.254.74.211])
 by aer-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 09 Nov 2026 21:30:28 +0000
Received: from localhost (unknown [10.189.100.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by aer-l-core-10.cisco.com (Postfix) with ESMTPS id 3E0AA180001D0;
 Mon,  9 Nov 2026 21:30:28 +0000 (GMT)
Date: Mon, 09 Nov 2026 22:30:27 +0100
Message-ID: <f4069639e22fae89492ba2e132fd553c@cisco.com>
From: Jerome Tollet <jtollet@cisco.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] net/intel/common: track all RS buckets used by a Tx packet
In-Reply-To: <20261106092514.76289-1-jtollet@cisco.com>
References: <20261106092514.76289-1-jtollet@cisco.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Outbound-Client-TLS: ANONYMOUS; unknown [10.189.100.152]; TLSv1.3;
 TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 10.189.100.152, [10.189.100.152]
X-Outbound-Node: aer-l-core-10.cisco.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bruce,

Thanks for the review. I agree with all your suggestions: please keep the original explanatory comments, add the new comment immediately before the rs_last_id loop, move rs_idx inside the if, and retain the original parentheses in the next_rs_idx expression. I'm happy for you to make these changes on apply.

Thanks,
Jerome
