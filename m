Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F73606F620
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=f8JoyN/h
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7C0142EB5;
	Tue,  3 Nov 2026 16:14:07 +0100 (CET)
Received: from mta0.migadu.com (out-47.mta0.migadu.com [91.218.175.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 6240442E8E
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:14:06 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=1Y2c2HMbcTzlri7YJhTYRHPtUk0V5n4cURJ/WhdXvig=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718846; v=1; x=1794323646;
 b=f8JoyN/hIrS8i5YQlmr+KyghLd0k6QTWJhVLtKQcu6ZP8hL3OXxtj0lkZZIvmIQAMQ0aGcGp
 E/KZL++ka/3nW1BfSZ9F7yCmySISHthkqJdJZS6CgNCRoJk1uMrmKVDL8VxD+tr4Fa94ORVgIv4
 /FwUGX48TmhrcBxOYdmBUWcc=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 0e7818ed26985ead;
 Tue, 03 Nov 2026 15:14:05 +0000
X-Mizu-Trace-ID: 0e7818ed26985ead
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 133/227] net/nfb: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:31 +0800
Message-ID: <20261103145306.487255-134-chengwen.feng@linux.dev>
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
 drivers/net/nfb/nfb_ethdev.c | 2 +-
 drivers/net/nfb/nfb_rx.c     | 8 ++++----
 drivers/net/nfb/nfb_rx.h     | 2 +-
 drivers/net/nfb/nfb_tx.c     | 8 ++++----
 drivers/net/nfb/nfb_tx.h     | 2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index ba7c849a4b..795abcd9ac 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -763,7 +763,7 @@ nfb_eth_dev_init(struct rte_eth_dev *dev, void *init_data)
 	struct rte_ether_addr eth_addr_init;
 	uint16_t max_rx_queues, max_tx_queues;
 
-	internals = rte_zmalloc_socket("nfb_internals",
+	internals = rte_zmalloc_numa("nfb_internals",
 			sizeof(struct pmd_internals), RTE_CACHE_LINE_SIZE,
 			dev->device->numa_node);
 	if (internals == NULL) {
diff --git a/drivers/net/nfb/nfb_rx.c b/drivers/net/nfb/nfb_rx.c
index 5b8579e280..0d8a515a1f 100644
--- a/drivers/net/nfb/nfb_rx.c
+++ b/drivers/net/nfb/nfb_rx.c
@@ -56,7 +56,7 @@ int
 nfb_eth_rx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t rx_queue_id,
 		uint16_t nb_rx_desc __rte_unused,
-		unsigned int socket_id,
+		unsigned int numa_id,
 		const struct rte_eth_rxconf *rx_conf __rte_unused,
 		struct rte_mempool *mb_pool)
 {
@@ -70,11 +70,11 @@ nfb_eth_rx_queue_setup(struct rte_eth_dev *dev,
 	if (rx_queue_id >= priv->max_rx_queues)
 		return -EINVAL;
 
-	rxq = rte_zmalloc_socket("ndp rx queue", sizeof(struct ndp_rx_queue),
-			RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("ndp rx queue", sizeof(struct ndp_rx_queue),
+			RTE_CACHE_LINE_SIZE, numa_id);
 
 	if (rxq == NULL) {
-		NFB_LOG(ERR, "rte_zmalloc_socket() failed for rx queue id %" PRIu16,
+		NFB_LOG(ERR, "rte_zmalloc_numa() failed for rx queue id %u",
 			rx_queue_id);
 		return -ENOMEM;
 	}
diff --git a/drivers/net/nfb/nfb_rx.h b/drivers/net/nfb/nfb_rx.h
index 831945c577..453245f6fe 100644
--- a/drivers/net/nfb/nfb_rx.h
+++ b/drivers/net/nfb/nfb_rx.h
@@ -87,7 +87,7 @@ int
 nfb_eth_rx_queue_setup(struct rte_eth_dev *dev,
 	uint16_t rx_queue_id,
 	uint16_t nb_rx_desc __rte_unused,
-	unsigned int socket_id,
+	unsigned int numa_id,
 	const struct rte_eth_rxconf *rx_conf __rte_unused,
 	struct rte_mempool *mb_pool);
 
diff --git a/drivers/net/nfb/nfb_tx.c b/drivers/net/nfb/nfb_tx.c
index 1a7dcc3d30..fb9791eab9 100644
--- a/drivers/net/nfb/nfb_tx.c
+++ b/drivers/net/nfb/nfb_tx.c
@@ -50,7 +50,7 @@ int
 nfb_eth_tx_queue_setup(struct rte_eth_dev *dev,
 	uint16_t tx_queue_id,
 	uint16_t nb_tx_desc __rte_unused,
-	unsigned int socket_id,
+	unsigned int numa_id,
 	const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct pmd_internals *internals = dev->process_private;
@@ -63,11 +63,11 @@ nfb_eth_tx_queue_setup(struct rte_eth_dev *dev,
 	if (tx_queue_id >= priv->max_tx_queues)
 		return -EINVAL;
 
-	txq = rte_zmalloc_socket("ndp tx queue", sizeof(struct ndp_tx_queue),
-		RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("ndp tx queue", sizeof(struct ndp_tx_queue),
+		RTE_CACHE_LINE_SIZE, numa_id);
 
 	if (txq == NULL) {
-		NFB_LOG(ERR, "rte_zmalloc_socket() failed for tx queue id %" PRIu16,
+		NFB_LOG(ERR, "rte_zmalloc_numa() failed for tx queue id %u",
 			tx_queue_id);
 		return -ENOMEM;
 	}
diff --git a/drivers/net/nfb/nfb_tx.h b/drivers/net/nfb/nfb_tx.h
index c253af1a86..0b6aad50e6 100644
--- a/drivers/net/nfb/nfb_tx.h
+++ b/drivers/net/nfb/nfb_tx.h
@@ -45,7 +45,7 @@ int
 nfb_eth_tx_queue_setup(struct rte_eth_dev *dev,
 	uint16_t tx_queue_id,
 	uint16_t nb_tx_desc __rte_unused,
-	unsigned int socket_id,
+	unsigned int numa_id,
 	const struct rte_eth_txconf *tx_conf __rte_unused);
 
 /**
-- 
2.55.0

