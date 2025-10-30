Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F2FCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 17:53:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D5FF40661;
	Thu, 30 Oct 2025 18:53:49 +0100 (CET)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id D147240150
 for <dev@dpdk.org>; Thu, 30 Oct 2025 18:53:47 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id D7B4C1D001AB;
 Thu, 30 Oct 2025 13:53:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Thu, 30 Oct 2025 13:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1761846826; x=
 1761933226; bh=GKz87PkcK7GbxN4dtK0AOuVumjoHCWxJVg4C9hlHji8=; b=p
 BkLTYrAE7BM+V6lUI6keQHXttxApUcgf0JQN7urbr+pNL/rgskt+PT/48LsNEBUm
 JhJYLNHrT2x5MXKlX6zgTFTFN67crz6JT9TW6bYxaRKFqVK+k0gDl/KeGKSn1VLW
 I9r/nBwjUIo8V+/wBeMb+lP9GAN6j1897V3RxwZ6yLHp6JuNdJqYDVBJGgAfCFjN
 KQgMD0mBRvCrtlI1u/vYXZfSjH4/8tu67yq0aSr0WqTmBZ8syIhxwZWllotVgdw0
 XOQ/5A/BYp7Lha9im7Tw+PK5zzENUpxE/36cK75vMv9DJDuyKOr3Wmk2bs0cG+dx
 IU4zMCxQnDpi/ieWFLiJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1761846826; x=1761933226; bh=G
 Kz87PkcK7GbxN4dtK0AOuVumjoHCWxJVg4C9hlHji8=; b=UCNQz3yJTLjhHMaVt
 Kb9+imgEY81wBheJSHspLiO3pKdFxztERqZl/iD0erzrxTiw3TV5Sb1SvRjwCKJn
 0KF5LHH3yP8tMI4kFdHK2iWAVGhFnZ9ncWK+QP8/0jMNPj4dIxbAfmfw1wZDNemH
 9uo2lI9ocFxj5AoJw64FYIfxcQrEyQWF4YQlgS6pz68Q7toQrt5A4A52N4MvpQ9J
 EqQdL8HJG4hDV94xYffUC8vuvvE9u29VKKFAnUTKT8blGCRDPXHteAS5+Pwk55wX
 pRtkxA08psQTRvkwBzsKZxzxAnPPRFCVFyAG8TppOYqElpYqoydpzUGV91tp9J8T
 43F8g==
X-ME-Sender: <xms:KqYDaW87ve4MmyQaVcVQebsEo7f-LcCIikLvWDL7wVV9BKRhtUlXLg>
 <xme:KqYDafphSLp1PymxNTdAsYRnegWaYgVysApZvULE2FKN9fjnCisLdTVkapJAgyFkH
 K1FjUwBb6Vj7SSCBk1VcRl9Rn4T_JvAec1u68byS_QZRkKtq2T9sKY>
X-ME-Received: <xmr:KqYDaXmbic1Oh1AWv7qVXav1uN0eShK31DzGfrhDJ5n0m2Czy2TWtMNCJsZdpaxXqE8lbrivXe5ugAkXnERvch5Jv15GcYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejvdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 ohephihiphgvnhhguddrfigrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrmh
 gvhhdrghhosghrihgvlhesihhnthgvlhdrtghomhdprhgtphhtthhopegsrhhutggvrdhr
 ihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehvlhgrughimhhirh
 drmhgvughvvggukhhinhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:KqYDaegpQ17aSHJtRJ9g3XuZouPZvBnTMcp778Gf5AaAyiH6sCvj5w>
 <xmx:KqYDaXei4pSbmBUEWHi2PPMRjAxzMXuMYEPP0xzb41be8iiLTOxWkw>
 <xmx:KqYDaWiGF96EpFfyD6ZHnQJyJgPgWMaTsgmyUYcGykHjNaN6jHnmZA>
 <xmx:KqYDaXx5GzEX4wKfCZBoau2PGXZ1mTm6AKmfnc_py0fDX7fLEBSajw>
 <xmx:KqYDaboxV-snQG1rymOkSFQB_VvRN06GIO15Y6UL4T87SBWmUqgAu3tu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 13:53:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 2/2] test/hash: reduce time of functional R/W test
Date: Thu, 30 Oct 2025 18:50:12 +0100
Message-ID: <20251030175329.4041960-3-thomas@monjalon.net>
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

When running on limited platforms like GitHub Actions,
the functional unit test "hash_readwrite_func_autotest"
will hit a timeout, especially when running with UBSan:

46/102 DPDK:fast-tests / hash_readwrite_func_autotest  TIMEOUT  30.01s
killed by signal 15 SIGTERM

Similarly to what was done in the
commit fd368e1982bc ("test/hash: test more corner cases"),
some constants are decreased.
In order to keep the performance test as it was,
a multiplier is kept for performance test case only.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 app/test/test_hash_readwrite.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/app/test/test_hash_readwrite.c b/app/test/test_hash_readwrite.c
index 22ccd6df6a..4d140439e4 100644
--- a/app/test/test_hash_readwrite.c
+++ b/app/test/test_hash_readwrite.c
@@ -18,9 +18,11 @@
 
 #define RTE_RWTEST_FAIL 0
 
-#define TOTAL_ENTRY (5*1024*1024)
-#define TOTAL_INSERT (4.5*1024*1024)
-#define TOTAL_INSERT_EXT (5*1024*1024)
+#define TOTAL_ENTRY           (5*1024) /* must be multiplied for perf test */
+#define TOTAL_INSERT_FUNC   (4.5*1024)
+#define TOTAL_INSERT_FUNC_EXT (5*1024)
+#define PERF_MULTIPLIER  1024
+#define TOTAL_INSERT (TOTAL_INSERT_FUNC * PERF_MULTIPLIER) /* only for perf */
 
 #define NUM_TEST 3
 unsigned int core_cnt[NUM_TEST] = {2, 4, 8};
@@ -136,16 +138,15 @@ test_hash_readwrite_worker(__rte_unused void *arg)
 }
 
 static int
-init_params(int use_ext, int use_htm, int rw_lf, int use_jhash)
+init_params(int use_ext, int use_htm, int rw_lf, int use_jhash, bool perf)
 {
 	unsigned int i;
-
 	uint32_t *keys = NULL;
 	uint8_t *found = NULL;
 	struct rte_hash *handle;
 
 	struct rte_hash_parameters hash_params = {
-		.entries = TOTAL_ENTRY,
+		.entries = TOTAL_ENTRY * (perf ? PERF_MULTIPLIER : 1),
 		.key_len = sizeof(uint32_t),
 		.hash_func_init_val = 0,
 		.socket_id = rte_socket_id(),
@@ -182,14 +183,13 @@ init_params(int use_ext, int use_htm, int rw_lf, int use_jhash)
 	}
 
 	tbl_rw_test_param.h = handle;
-	keys = rte_malloc(NULL, sizeof(uint32_t) * TOTAL_ENTRY, 0);
-
+	keys = rte_malloc(NULL, sizeof(uint32_t) * hash_params.entries, 0);
 	if (keys == NULL) {
 		printf("RTE_MALLOC failed\n");
 		goto err;
 	}
 
-	found = rte_zmalloc(NULL, sizeof(uint8_t) * TOTAL_ENTRY, 0);
+	found = rte_zmalloc(NULL, sizeof(uint8_t) * hash_params.entries, 0);
 	if (found == NULL) {
 		printf("RTE_ZMALLOC failed\n");
 		goto err;
@@ -198,7 +198,7 @@ init_params(int use_ext, int use_htm, int rw_lf, int use_jhash)
 	tbl_rw_test_param.keys = keys;
 	tbl_rw_test_param.found = found;
 
-	for (i = 0; i < TOTAL_ENTRY; i++)
+	for (i = 0; i < hash_params.entries; i++)
 		keys[i] = i;
 
 	return 0;
@@ -227,13 +227,13 @@ test_hash_readwrite_functional(int use_htm, int use_rw_lf, int use_ext)
 	rte_atomic_store_explicit(&gcycles, 0, rte_memory_order_relaxed);
 	rte_atomic_store_explicit(&ginsertions, 0, rte_memory_order_relaxed);
 
-	if (init_params(use_ext, use_htm, use_rw_lf, use_jhash) != 0)
+	if (init_params(use_ext, use_htm, use_rw_lf, use_jhash, false) != 0)
 		goto err;
 
 	if (use_ext)
-		tot_insert = TOTAL_INSERT_EXT;
+		tot_insert = TOTAL_INSERT_FUNC_EXT;
 	else
-		tot_insert = TOTAL_INSERT;
+		tot_insert = TOTAL_INSERT_FUNC;
 
 	tbl_rw_test_param.num_insert =
 		tot_insert / worker_cnt;
@@ -390,7 +390,7 @@ test_hash_readwrite_perf(struct perf *perf_results, int use_htm,
 	rte_atomic_store_explicit(&gread_cycles, 0, rte_memory_order_relaxed);
 	rte_atomic_store_explicit(&gwrite_cycles, 0, rte_memory_order_relaxed);
 
-	if (init_params(0, use_htm, 0, use_jhash) != 0)
+	if (init_params(0, use_htm, 0, use_jhash, true) != 0)
 		goto err;
 
 	/*
@@ -548,7 +548,7 @@ test_hash_readwrite_perf(struct perf *perf_results, int use_htm,
 		rte_eal_mp_wait_lcore();
 
 		iter = 0;
-		memset(tbl_rw_test_param.found, 0, TOTAL_ENTRY);
+		memset(tbl_rw_test_param.found, 0, TOTAL_ENTRY * PERF_MULTIPLIER);
 		while (rte_hash_iterate(tbl_rw_test_param.h,
 				&next_key, &next_data, &iter) >= 0) {
 			/* Search for the key in the list of keys added .*/
-- 
2.51.0

