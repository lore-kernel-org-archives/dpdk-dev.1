Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D977C369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 00:04:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DE4D40156;
	Wed, 23 Apr 2025 02:04:02 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id 3F6F340151
 for <dev@dpdk.org>; Wed, 23 Apr 2025 02:04:01 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 3D1D51140176;
 Tue, 22 Apr 2025 20:04:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 22 Apr 2025 20:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1745366640;
 x=1745453040; bh=WTMCq9RCZQZFcZ0xGUuA07q0h0ucJlme5KCj8YNDzTQ=; b=
 EKO/gjyIYEZkXi/ZfD86Xz0NW7jYoHDtg6NoCfWXyh0t02VsNJesiOFuBF3idTUA
 Ry35WV1chIPxo0ZsO3CsXscIsgDI2r2cKeVTIvtBjfuKrCRLrd71DWbArKPTY849
 5usIQ6FWL2LPfM5FTyJoxcudsQ+V1P4ZbY3u3xW3aqGFOPmBz8Os3PUFwQAkJYis
 dEuJJzjk/+1zLR2i82sEc6SMymX9W4+NkE9xlnBF4MHpvLYnDE3jeATWbL88FjS6
 sFVYPpFT3+uD0f57ugP75UBU1ZXPuZCeGUbeBGzSP5hnLUWTArS+gmwXiyq1zfxs
 j/3NV98uWHjgwWJsPzyxKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745366640; x=
 1745453040; bh=WTMCq9RCZQZFcZ0xGUuA07q0h0ucJlme5KCj8YNDzTQ=; b=I
 toxJH3Hmz25/swmV4OS5C2bH4PKt75hkGy2PDEXsxJc8fHZFeV0Dz/9pXxhMO00V
 rG3E2LELaJv6kM1VRMmEa62u0gn0y8UrBp8oDvLYE2J5GRqzqmpBdFKwh9OSlIAu
 ai/8dNRkooapa1dG/hbtw4uaV+XsBS44oVH5qIPsMSMm0uJ52g3CDZdfO6bmYCc9
 wHJHXE++OhtVGJlh4KcjxAW1/mtXNC5YkVRv92m6Za+OvbXAC6wCGxqlynO8VSPT
 /Z2Jc6rmWdtUIgDPXDjS0to3DRcLhahodinLjALwUwr5pRX5hqUc9m1s1k0sNuML
 Kyy5RlAEi69OIGmykYHvQ==
X-ME-Sender: <xms:bi4IaKfWloD3nXTuYYEYLEQoI6HDP-Dv6_s8hBDtYCrbINfc44px5Q>
 <xme:bi4IaEOL_UDNWUGq0ahtJB6pXgsahznEmjdoE-CvM7BXVMKmr-ZSZ2FEYRh6P9ePz
 gRqq2RpRjYtj7bfHA>
X-ME-Received: <xmr:bi4IaLjVNupht260h7zplgXtdpVBMn_aX1a-lH4fIW1MrSOBC_nHTPwZL2QQTBNVONbHa6pBwOcQcRfRdyYJ_5vCGqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeehuddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehorh
 hikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopegrmhgrnhdruggvvghprdhsihhn
 ghhhsehinhhtvghlrdgtohhmpdhrtghpthhtohepfhgvrhhruhhhrdihihhgihhtsegrmh
 gurdgtohhmpdhrtghpthhtoheprghnughrvgifrdhrhigstghhvghnkhhosehokhhtvght
 lhgrsghsrdhruhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhope
 hkihhrrghnkhhumhgrrhhksehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepughsohhs
 nhhofihskhhisehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:bi4IaH-739cytrOpPGS6AWMnDn2SQrCYNM6HNXC-DrzV-F_j_-aA9A>
 <xmx:bi4IaGuzDiTDgYEAGUTGkwJRidaMBwYqoz25pbQ8Mb9a70AKsH-GBg>
 <xmx:bi4IaOEi_0CNPlhqqXYSN2InCFJNHGloUJx98L3D5KW6nLSsutkq1g>
 <xmx:bi4IaFORAZ6n49xDIq0JT3lTfqfPXLTKddQsKTg0I5n2KLIHcKczgg>
 <xmx:cC4IaFZ5saCGOwOJ2zjR7DkyrVBbACbafbCpqJxizYyVElyBHvEO2bXD>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 20:03:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Ori Kam <orika@nvidia.com>
Cc: Aman Singh <aman.deep.singh@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org,
 Kiran Kumar K <kirankumark@marvell.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: Re: [PATCH v2] ethdev: add support for flow action pop E-tag
Date: Wed, 23 Apr 2025 02:03:52 +0200
Message-ID: <12655920.O9o76ZdvQC@thomas>
In-Reply-To: <20250422055331.1270825-1-kirankumark@marvell.com>
References: <20250421115134.841719-1-kirankumark@marvell.com>
 <20250422055331.1270825-1-kirankumark@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

22/04/2025 07:53, kirankumark@marvell.com:
> Add support for the following OpenFlow-defined action.
> 
> RTE_FLOW_ACTION_TYPE_OF_POP_ETAG: Pop E-tag from the packet.

I'm not sure about adding such action.
There is a more generic which should cover it:
	RTE_FLOW_ACTION_TYPE_MODIFY_FIELD

The idea is to deprecate a lot of actions.
See doc/guides/rel_notes/deprecation.rst


