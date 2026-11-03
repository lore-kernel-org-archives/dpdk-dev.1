Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067A606A32F
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=A/xemJfC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56F0542E46;
	Tue,  3 Nov 2026 16:07:57 +0100 (CET)
Received: from mta1.migadu.com (out-168.mta1.migadu.com [95.215.58.168])
 by mails.dpdk.org (Postfix) with ESMTPS id EEA9B42E24
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:07:55 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=AovipvHjA3/ab9V+crxPHS180TkXj6efTJMst6OTlyQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718475; v=1; x=1794323275;
 b=A/xemJfCzLwIEpCytsWD1BSXcHp7vK9FU3THq+ixOJZBgFFmHw7enyzV41WKtTcGjBs1dNRi
 zkFgrAKEFU0PT2O7sTY7CHUa523/wixBFszx5pcr5B8iTEdTgU2O6t1Y3c2/jtlIRIYpAg3tVku
 UfIN5oW0QguDd2LYBvfICemc=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id ed688da092793d45;
 Tue, 03 Nov 2026 15:07:55 +0000
X-Mizu-Trace-ID: ed688da092793d45
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 090/227] event/cnxk: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:48 +0800
Message-ID: <20261103145306.487255-91-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/event/cnxk/cn10k_eventdev.c         | 4 ++--
 drivers/event/cnxk/cn20k_eventdev.c         | 4 ++--
 drivers/event/cnxk/cn9k_eventdev.c          | 8 ++++----
 drivers/event/cnxk/cnxk_eventdev.c          | 2 +-
 drivers/event/cnxk/cnxk_eventdev_adptr.c    | 2 +-
 drivers/event/cnxk/cnxk_eventdev_selftest.c | 2 +-
 drivers/event/cnxk/cnxk_tim_evdev.c         | 4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/event/cnxk/cn10k_eventdev.c b/drivers/event/cnxk/cn10k_eventdev.c
index 47d1ec6823..4543a76ee2 100644
--- a/drivers/event/cnxk/cn10k_eventdev.c
+++ b/drivers/event/cnxk/cn10k_eventdev.c
@@ -190,12 +190,12 @@ cn10k_sso_updt_tx_adptr_data(const struct rte_eventdev *event_dev)
 		void *ws_cookie;
 
 		ws_cookie = cnxk_sso_hws_get_cookie(ws);
-		ws_cookie = rte_realloc_socket(
+		ws_cookie = rte_realloc_numa(
 			ws_cookie,
 			sizeof(struct cnxk_sso_hws_cookie) +
 				sizeof(struct cn10k_sso_hws) +
 				dev->tx_adptr_data_sz,
-			RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 		if (ws_cookie == NULL)
 			return -ENOMEM;
 		ws = RTE_PTR_ADD(ws_cookie, sizeof(struct cnxk_sso_hws_cookie));
diff --git a/drivers/event/cnxk/cn20k_eventdev.c b/drivers/event/cnxk/cn20k_eventdev.c
index 29495eb4f9..dc368051f6 100644
--- a/drivers/event/cnxk/cn20k_eventdev.c
+++ b/drivers/event/cnxk/cn20k_eventdev.c
@@ -255,11 +255,11 @@ cn20k_sso_updt_tx_adptr_data(const struct rte_eventdev *event_dev)
 		void *ws_cookie;
 
 		ws_cookie = cnxk_sso_hws_get_cookie(ws);
-		ws_cookie = rte_realloc_socket(ws_cookie,
+		ws_cookie = rte_realloc_numa(ws_cookie,
 					       sizeof(struct cnxk_sso_hws_cookie) +
 						       sizeof(struct cn20k_sso_hws) +
 						       dev->tx_adptr_data_sz,
-					       RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+					       RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 		if (ws_cookie == NULL)
 			return -ENOMEM;
 		ws = RTE_PTR_ADD(ws_cookie, sizeof(struct cnxk_sso_hws_cookie));
diff --git a/drivers/event/cnxk/cn9k_eventdev.c b/drivers/event/cnxk/cn9k_eventdev.c
index 313dcbb384..dc509b5c95 100644
--- a/drivers/event/cnxk/cn9k_eventdev.c
+++ b/drivers/event/cnxk/cn9k_eventdev.c
@@ -269,12 +269,12 @@ cn9k_sso_updt_tx_adptr_data(const struct rte_eventdev *event_dev)
 			void *ws_cookie;
 
 			ws_cookie = cnxk_sso_hws_get_cookie(dws);
-			ws_cookie = rte_realloc_socket(
+			ws_cookie = rte_realloc_numa(
 				ws_cookie,
 				sizeof(struct cnxk_sso_hws_cookie) +
 					sizeof(struct cn9k_sso_hws_dual) +
 					dev->tx_adptr_data_sz,
-				RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+				RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 			if (ws_cookie == NULL)
 				return -ENOMEM;
 			dws = RTE_PTR_ADD(ws_cookie,
@@ -287,12 +287,12 @@ cn9k_sso_updt_tx_adptr_data(const struct rte_eventdev *event_dev)
 			void *ws_cookie;
 
 			ws_cookie = cnxk_sso_hws_get_cookie(ws);
-			ws_cookie = rte_realloc_socket(
+			ws_cookie = rte_realloc_numa(
 				ws_cookie,
 				sizeof(struct cnxk_sso_hws_cookie) +
 					sizeof(struct cn9k_sso_hws_dual) +
 					dev->tx_adptr_data_sz,
-				RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+				RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 			if (ws_cookie == NULL)
 				return -ENOMEM;
 			ws = RTE_PTR_ADD(ws_cookie,
diff --git a/drivers/event/cnxk/cnxk_eventdev.c b/drivers/event/cnxk/cnxk_eventdev.c
index e3a3134264..9d842e1788 100644
--- a/drivers/event/cnxk/cnxk_eventdev.c
+++ b/drivers/event/cnxk/cnxk_eventdev.c
@@ -639,7 +639,7 @@ cnxk_sso_init(struct rte_eventdev *event_dev)
 	int rc;
 
 	mz = rte_memzone_reserve(CNXK_SSO_MZ_NAME, sizeof(uint64_t),
-				 SOCKET_ID_ANY, 0);
+				 RTE_NUMA_ID_ANY, 0);
 	if (mz == NULL) {
 		plt_err("Failed to create eventdev memzone");
 		return -ENOMEM;
diff --git a/drivers/event/cnxk/cnxk_eventdev_adptr.c b/drivers/event/cnxk/cnxk_eventdev_adptr.c
index 5678e5d264..85b5a3fc33 100644
--- a/drivers/event/cnxk/cnxk_eventdev_adptr.c
+++ b/drivers/event/cnxk/cnxk_eventdev_adptr.c
@@ -671,7 +671,7 @@ crypto_adapter_qp_setup(struct cnxk_sso_evdev *evdev, const struct rte_cryptodev
 	cache_size = RTE_MIN(RTE_MEMPOOL_CACHE_MAX_SIZE, qp->lf.nb_desc / 1.5);
 	nb_req = qp->lf.nb_desc + (cache_size * rte_lcore_count());
 	qp->ca.req_mp = rte_mempool_create(name, nb_req, req_size, cache_size, 0, NULL, NULL, NULL,
-					   NULL, rte_socket_id(), 0);
+					   NULL, rte_numa_id(), 0);
 	if (qp->ca.req_mp == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/event/cnxk/cnxk_eventdev_selftest.c b/drivers/event/cnxk/cnxk_eventdev_selftest.c
index 8f3d0982e9..828a0f9ec1 100644
--- a/drivers/event/cnxk/cnxk_eventdev_selftest.c
+++ b/drivers/event/cnxk/cnxk_eventdev_selftest.c
@@ -145,7 +145,7 @@ _eventdev_setup(int mode)
 
 	/* Create and destroy pool for each test case to make it standalone */
 	eventdev_test_mempool = rte_pktmbuf_pool_create(
-		pool_name, MAX_EVENTS, 0, 0, 512, rte_socket_id());
+		pool_name, MAX_EVENTS, 0, 0, 512, rte_numa_id());
 	if (!eventdev_test_mempool) {
 		plt_err("ERROR creating mempool");
 		return -1;
diff --git a/drivers/event/cnxk/cnxk_tim_evdev.c b/drivers/event/cnxk/cnxk_tim_evdev.c
index 11945e0e6e..8cfb5c122f 100644
--- a/drivers/event/cnxk/cnxk_tim_evdev.c
+++ b/drivers/event/cnxk/cnxk_tim_evdev.c
@@ -37,7 +37,7 @@ cnxk_tim_chnk_pool_populate_aligned(struct rte_mempool *mp, size_t align)
 	stride = (size_t)mp->header_size + mp->elt_size + mp->trailer_size;
 	len = stride * mp->size;
 
-	mem = rte_zmalloc_socket("cnxk_tim_chunks", len, align, mp->numa_id);
+	mem = rte_zmalloc_numa("cnxk_tim_chunks", len, align, mp->numa_id);
 	if (mem == NULL)
 		return -ENOMEM;
 
@@ -83,7 +83,7 @@ cnxk_tim_chnk_pool_create(struct cnxk_tim_ring *tim_ring,
 
 	tim_ring->chunk_pool = rte_mempool_create_empty(pool_name, tim_ring->nb_chunks,
 							tim_ring->chunk_sz, cache_sz, 0,
-							rte_socket_id(), mp_flags);
+							rte_numa_id(), mp_flags);
 	if (tim_ring->chunk_pool == NULL) {
 		plt_err("Unable to create chunkpool.");
 		return -ENOMEM;
-- 
2.55.0

