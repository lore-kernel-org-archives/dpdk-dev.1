Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87068D116F1
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Nov 2025 12:43:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 607BD4013F;
	Sat, 29 Nov 2025 13:43:20 +0100 (CET)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id 96D2C400D7
 for <dev@dpdk.org>; Sat, 29 Nov 2025 13:43:18 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1828B140069B;
 Sat, 29 Nov 2025 07:43:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Sat, 29 Nov 2025 07:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm1; t=1764420198; x=1764506598; bh=fgwzq7l2puA+gWKKW4sy9
 ZACsMWuQ8FSMr+UvQ3iOUY=; b=SBUmiQj56B0RsUpRM7aJrFm4XfkerNhgJ5SaN
 stPSVsnjQoUbiqVhZJlx6khndGXYKGJD3xWNUi3y19aEPWLxLDj3j51Wsa5bOh4a
 lpYPKjM4QVHALIBisvr60wTe2KY4woJYMuA+M8llzp4lFfR3+G/7Nu/8iFa9imyO
 0HmZ/1SKK/P9TD8SDtlWv866HQQ0l3FDn016WdTJWSNd7T1Yltq6MFIlWTCzDhcR
 4KbFhge7NDagu4O6WWO5g8uSiSMMGnHNCMxWdAwYVw/cBYNFlscEXelIplBsWXq0
 hJPnR3Z0eA9aTRsXXZFBu8Aw7UP+NLWMBRf7UVkFmU3TKJBYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1764420198; x=1764506598; bh=fgwzq7l2puA+gWKKW4sy9ZACsMWuQ8FSMr+
 UvQ3iOUY=; b=hoJOp6VQVwxH5+IH1jx6J2cQmShvl23K3S1kfxuy/ocpYV+z8hN
 YYKKpDqIQNUSLARS5+RSc1EVduAHJXcPbzynf90UnNXb0yDKjmZDB/PXLv6quH8b
 2y7iV9r5R/fbKODA3j8mnx7FbrsTgBL4OK/e0c5vvlIlPa7Us7TjPzT/jHjJwqby
 KyEXgi3JfGjfiWq0G1ue9gq2t3InPWSCIHk/o4WRmJYBlggPpqyH8uzYnJVNIGE8
 qpcXndFl1X5+OBYukD7t0+CL5ROOHIkEngYjRjERE+YuTLnBI5C+W02b7oU5UlYm
 m14pwFM6/ynRiJvant+VUJ+yl1Kxcy/Lidg==
X-ME-Sender: <xms:ZeoqaYrTJokojq4MbJQBaTgjoAA3huQVzc3K7cZBV1oUQnoqj92dSg>
 <xme:ZeoqaaoLhtctuSwlRVeNtQPtfcYB-BYIowUnkMXtnRXdOoacmWkVAeOLxw2sBE-38
 Ze9mJ52vtzu-6SEhgdMIfu2rm1msCLLp7kBTxr7pzdhSchq18mFog>
X-ME-Received: <xmr:ZeoqafYDCeKcv3-3h35_zyQheetA2On9cm9LFa91RmD7wlrDIh4bXPyD93qT3B5KEy0M69hWMlfxxVl9q5CM3pS5v_TG_ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedvgeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeevveefveeiiefhtedukeegkeelieegffeukeevudetueffieduveetiedu
 keefleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtth
 hopegsihhnghiisehnvhhiughirgdrtghomhdprhgtphhtthhopehmkhgrshhhrghnihes
 nhhvihguihgrrdgtohhmpdhrtghpthhtoheprhgrshhlrghnugesnhhvihguihgrrdgtoh
 hmpdhrtghpthhtohepughsohhsnhhofihskhhisehnvhhiughirgdrtghomhdprhgtphht
 thhopehvihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopehorh
 hikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehsuhgrnhhmihhnghhmsehnvhhi
 ughirgdrtghomhdprhgtphhtthhopehmrghtrghnsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:ZeoqaQ-U4YSuvJZD5pZzNPX_RnFpAp-iVzb2MCT5-PpbkNn5dgVp9Q>
 <xmx:ZeoqaVlZA0YZ_2GQ9kreagQ4o2OQ1njOsmrOYaaH_2exZpA3iSfG8w>
 <xmx:ZeoqaVy2S2vnKW9S6dCRDSADNlIM_Zr9flAe555cRIg6CthnzKTDcQ>
 <xmx:Zeoqaf58YxsWkwsBWqoyfYUh-2f9yOGoCwCpvTd5NSeJoI6i0RKr4Q>
 <xmx:ZuoqaUBMjUxfo-xJfsbZ7eIjdh0_R6A7c9xf0ZlmiMx21BrE3_mUJinN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Nov 2025 07:43:16 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bingz@nvidia.com, mkashani@nvidia.com, rasland@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] doc: update flow engine availability in mlx5 guide
Date: Sat, 29 Nov 2025 13:42:57 +0100
Message-ID: <20251129124257.1619774-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Starting with NVIDIA ConnectX-9, the future devices will support
only hardware steering (HWS) flow engine.
The software steering options (legacy Verbs and Direct Verbs)
have lower performances, and won't be available for new devices.

Fixes: 1b55eeb7b76f ("common/mlx5: add ConnectX-9 SuperNIC")

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/nics/mlx5.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 8481cc974a..904a0ac358 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -689,9 +689,11 @@ for an additional list of options shared with other mlx5 drivers.
 - ``dv_flow_en`` parameter [int]
 
   Value 0 means legacy Verbs flow offloading.
+  It is available for devices older than ConnectX-9.
 
-  Value 1 enables the DV flow steering assuming it is supported by the
-  driver (requires rdma-core 24 or higher).
+  Value 1 enables the Direct Verbs flow steering.
+  It is available for devices older than ConnectX-9,
+  and requires rdma-core 24 or later.
 
   Value 2 enables the WQE based hardware steering.
   In this mode, only queue-based flow management is supported.
@@ -1338,7 +1340,8 @@ Hardware Steering
 ~~~~~~~~~~~~~~~~~
 
 Faster than software steering (SWS),
-hardware steering (HWS) is the only mode supporting the flow template async API.
+hardware steering (HWS) is the only mode supporting the flow template async API,
+and the only mode supported on device ConnectX-9 and later.
 
 Flow rules are managed by the hardware,
 with a WQE-based high scaling and safer flow insertion/destruction.
-- 
2.51.0

