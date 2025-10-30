Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878FDCCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 17:53:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC5FC40615;
	Thu, 30 Oct 2025 18:53:44 +0100 (CET)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 817B440651;
 Thu, 30 Oct 2025 18:53:43 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D9FFC7A00AB;
 Thu, 30 Oct 2025 13:53:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 30 Oct 2025 13:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1761846822; x=
 1761933222; bh=Oo4GhbpSSGVuW7vrvyNW5rqeiIQThRKhBdmiRCoEXcU=; b=N
 MQ5qMmVH6sk5P9AbRDBh9WScF3oHXZ7Faa6j0G/e4rjMMywe+iwFCX3iHqEvjc3j
 itM2JlA3RRuw8xp0LAXNM2Z6eLhpIKQI1KcaflSI59dM+8X3/hRbJXL0tJueRgDQ
 EG4qRJuUVWGpitkWeJDSrs224UWuzmIih4cu86W6ODiUcSMxqeRukE0cbnlTciMJ
 MHs0nzuISpSORn29oLfnktwr+zlXl1T3OCzg+DDNdNRGQj6F14g7nxoEzbsdvagK
 Xh+3Zd7a4FDtxKE9RDFveS+50ywip4rtglljWBU30jUUOEylTsEtv0D20toH2aSN
 1FA9oAwRGz2Q9Zjg6xLQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1761846822; x=1761933222; bh=O
 o4GhbpSSGVuW7vrvyNW5rqeiIQThRKhBdmiRCoEXcU=; b=JgCc9jbBHXmi2+K3J
 mIkjWoisTcKIX4u/oaHk5bsIUdxQ/8VqkuKHsjQmcDle20y/5BUrL2eze6P0RYmI
 UhL9svi02I/S7HL6AhaGEHBZ9X6PuMWYPs7dTYC3GLfksJh/TqMqUu2qouK6Yxqq
 7Ar2z9f6zt3gi8lVh/iacCFGT/4rIR2jQovucz8X2FyhgIeYp1BirzOlcqUiXJl6
 rEfTWXQajcalMoGiAqEFKkton4jSxLBs/o0Gau0NM2UkWCGUQCcXTifoD3Sd2a2i
 CWKsCqe+8XG6996oDJ8cXbCMYIphL9+0HNMxR9681yRiVtO0w4TvDkw3npOCVKlu
 lymCw==
X-ME-Sender: <xms:JqYDaQN_sY4vGpIkg1nGTevTkqwFn_bBwULx4Rjj-40BrYpyhVnf6Q>
 <xme:JqYDaR7lo3kOQR7kvqGZF-FP7sEpGzJPEV9-EQzIi2CseDji6AQUbPyM6LAM7LnM4
 9OM1KdlUKq3mYzDwI8J1-yjFm0ajfY7-rk3Fx_gjORrzOiSQ886xA>
X-ME-Received: <xmr:JqYDaWT4UVRB6TVNDRL-qOfwCqkL2xA0Dy3bd9kQxBoBkYnAIjFzndt9-mIf2h0rlOu_L4E32lPDfY9cvDWZILnlnw1G99Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejvdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 ohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopeihihhpvghnghdurdifrg
 hnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrghmvghhrdhgohgsrhhivghlsehi
 nhhtvghlrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinh
 htvghlrdgtohhmpdhrtghpthhtohepvhhlrgguihhmihhrrdhmvgguvhgvughkihhnsehi
 nhhtvghlrdgtohhm
X-ME-Proxy: <xmx:JqYDaeCeDj_0GrgxOCXYSjKTy3h88EEk-QoLDtrdUAyq16O3loV8mg>
 <xmx:JqYDaWHBup0wnBLvpaliYaVjFFAy1LkFiFWgIegmH8l8dwdT8Wm1ag>
 <xmx:JqYDaYDqXORe0XxWOg7uxM1BPSUXVOeMJqT-xGkBihT6sqv3mOFtAg>
 <xmx:JqYDaeWs8yvClkmBqyEc_FqS7tofVaDxeTpTuTMfhQ251_ozf1jJOw>
 <xmx:JqYDaRuQPWCf6RkJ0ljtgYBavNjep_ZpJPbdHdUzTnv4ofoB8YUa0T5K>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 13:53:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, stable@dpdk.org,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 1/2] test/hash: check memory allocation
Date: Thu, 30 Oct 2025 18:50:11 +0100
Message-ID: <20251030175329.4041960-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030175329.4041960-1-thomas@monjalon.net>
References: <20251030175329.4041960-1-thomas@monjalon.net>
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

When reserving a specific memory amount, it was possible to pass
the first allocations and fail on a later allocation
where there was no check, resulting in a crash.
It is fixed by stopping the test if allocation failed.

Fixes: fd368e1982bc ("test/hash: test more corner cases")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 app/test/test_hash_readwrite.c         | 5 +++++
 app/test/test_hash_readwrite_lf_perf.c | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/app/test/test_hash_readwrite.c b/app/test/test_hash_readwrite.c
index 82fe03cc5a..22ccd6df6a 100644
--- a/app/test/test_hash_readwrite.c
+++ b/app/test/test_hash_readwrite.c
@@ -70,6 +70,11 @@ test_hash_readwrite_worker(__rte_unused void *arg)
 
 	ret = rte_malloc(NULL, sizeof(int) *
 				tbl_rw_test_param.num_insert, 0);
+	if (ret == NULL) {
+		printf("allocation failed\n");
+		return -1;
+	}
+
 	for (i = 0; i < rte_lcore_count(); i++) {
 		if (worker_core_ids[i] == lcore_id)
 			break;
diff --git a/app/test/test_hash_readwrite_lf_perf.c b/app/test/test_hash_readwrite_lf_perf.c
index 864c3059d9..bef987d29d 100644
--- a/app/test/test_hash_readwrite_lf_perf.c
+++ b/app/test/test_hash_readwrite_lf_perf.c
@@ -1310,6 +1310,10 @@ test_hash_rcu_qsbr_writer_perf(struct rwc_perf *rwc_perf_results, int rwc_lf,
 
 	sz = rte_rcu_qsbr_get_memsize(RTE_MAX_LCORE);
 	rv = (struct rte_rcu_qsbr *)rte_zmalloc(NULL, sz, RTE_CACHE_LINE_SIZE);
+	if (rv == NULL) {
+		printf("allocation failed\n");
+		goto err;
+	}
 	rcu_config.v = rv;
 
 	if (rte_hash_rcu_qsbr_add(tbl_rwc_test_param.h, &rcu_config) < 0) {
-- 
2.51.0

