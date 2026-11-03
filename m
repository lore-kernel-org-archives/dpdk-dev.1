Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64429606A78B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sqSWbJKF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9B8342E6E;
	Tue,  3 Nov 2026 16:11:32 +0100 (CET)
Received: from mta0.migadu.com (out-222.mta0.migadu.com [91.218.175.222])
 by mails.dpdk.org (Postfix) with ESMTPS id 88C7A427D7
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:11:30 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=IUykrRu8lQzIPV6OrUoVegFPAtcNtNud1YbCf/e7HGA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718690; v=1; x=1794323490;
 b=sqSWbJKFMXfYMeQfWV/zjZ2YJ9MuUVGWL/cZmoAZtZwf2ygHYqVOh8026X0WLix2vFh0/Es8
 oeDtm3Yu9qNWAeKS3Lp9Ce2mERS+iHXzcmwQ3z8UZgdFdA/pQkhY2mdNin6pFvbwY2e4B8XkFs5
 AIDAXYPoT9v8ufg0Op/0yblA=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 11e1a0ee702b975f;
 Tue, 03 Nov 2026 15:11:30 +0000
X-Mizu-Trace-ID: 11e1a0ee702b975f
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 114/227] net/dpaa2: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:12 +0800
Message-ID: <20261103145306.487255-115-chengwen.feng@linux.dev>
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
 drivers/net/dpaa2/dpaa2_ethdev.c | 6 +++---
 drivers/net/dpaa2/dpaa2_tm.c     | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index b3a725c0ea..12ddfe90b1 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -933,7 +933,7 @@ static int
 dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	uint16_t rx_queue_id,
 	uint16_t nb_rx_desc,
-	unsigned int socket_id __rte_unused,
+	unsigned int numa_id __rte_unused,
 	const struct rte_eth_rxconf *rx_conf,
 	struct rte_mempool *mb_pool)
 {
@@ -1142,7 +1142,7 @@ static int
 dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	uint16_t tx_queue_id,
 	uint16_t nb_tx_desc,
-	unsigned int socket_id __rte_unused,
+	unsigned int numa_id __rte_unused,
 	const struct rte_eth_txconf *tx_conf)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
@@ -3874,7 +3874,7 @@ static int dpaa2_tx_sg_pool_init(void)
 			DPAA2_POOL_SIZE,
 			DPAA2_POOL_CACHE_SIZE, 0,
 			DPAA2_MAX_SGS * sizeof(struct qbman_sge),
-			rte_socket_id());
+			rte_numa_id());
 		if (!dpaa2_tx_sg_pool) {
 			DPAA2_PMD_ERR("SG pool creation failed");
 			return -ENOMEM;
diff --git a/drivers/net/dpaa2/dpaa2_tm.c b/drivers/net/dpaa2/dpaa2_tm.c
index 3057f4d031..d26b27f915 100644
--- a/drivers/net/dpaa2/dpaa2_tm.c
+++ b/drivers/net/dpaa2/dpaa2_tm.c
@@ -322,8 +322,8 @@ dpaa2_shaper_profile_add(struct rte_eth_dev *dev, uint32_t shaper_profile_id,
 					 RTE_TM_ERROR_TYPE_SHAPER_PROFILE_ID,
 					 NULL, "Profile id already exists\n");
 
-	profile = rte_zmalloc_socket(NULL, sizeof(*profile), 0,
-				     rte_socket_id());
+	profile = rte_zmalloc_numa(NULL, sizeof(*profile), 0,
+				     rte_numa_id());
 	if (!profile)
 		return -rte_tm_error_set(error, ENOMEM,
 					 RTE_TM_ERROR_TYPE_UNSPECIFIED,
@@ -486,7 +486,7 @@ dpaa2_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 					 RTE_TM_ERROR_TYPE_NODE_ID,
 					 NULL, "Node id already exists\n");
 
-	node = rte_zmalloc_socket(NULL, sizeof(*node), 0, rte_socket_id());
+	node = rte_zmalloc_numa(NULL, sizeof(*node), 0, rte_numa_id());
 	if (!node)
 		return -rte_tm_error_set(error, ENOMEM,
 					 RTE_TM_ERROR_TYPE_UNSPECIFIED,
-- 
2.55.0

