Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46CB606A79C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GOAUF0ia
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72DD242EC4;
	Tue,  3 Nov 2026 16:15:53 +0100 (CET)
Received: from mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
 by mails.dpdk.org (Postfix) with ESMTPS id 459DE42D3F
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:15:52 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=XA3pXtOgeJ3eFyx7CnK7BKyEcU1u6TJkWjRi6M2PZ4E=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718951; v=1; x=1794323751;
 b=GOAUF0iaZqxr4YegVZsQpr4Vi7gJEigFG6m+h0Pg7laxtARhSGRsuEaztSZ9gmwkzHzZB/m/
 4gBojrHXffOnLe7rkDKf/f1tBSxHtRVNvpKP4BgnjbF87jVPfaz3qBkTrM0pwHucqAKvhUw6mJx
 FsErRqg7yd/C1yItyfsinMUo=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 6056537df018b22c;
 Tue, 03 Nov 2026 15:15:51 +0000
X-Mizu-Trace-ID: 6056537df018b22c
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 144/227] net/ring: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:42 +0800
Message-ID: <20261103145306.487255-145-chengwen.feng@linux.dev>
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
 drivers/net/ring/rte_eth_ring.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index d75ae2cbed..9af86f4226 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -155,7 +155,7 @@ eth_dev_set_link_up(struct rte_eth_dev *dev)
 static int
 eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 				    uint16_t nb_rx_desc __rte_unused,
-				    unsigned int socket_id __rte_unused,
+				    unsigned int numa_id __rte_unused,
 				    const struct rte_eth_rxconf *rx_conf __rte_unused,
 				    struct rte_mempool *mb_pool __rte_unused)
 {
@@ -168,7 +168,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 static int
 eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 				    uint16_t nb_tx_desc __rte_unused,
-				    unsigned int socket_id __rte_unused,
+				    unsigned int numa_id __rte_unused,
 				    const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct pmd_internals *internals = dev->data->dev_private;
@@ -374,21 +374,21 @@ do_eth_dev_ring_create(const char *name,
 	PMD_LOG(INFO, "Creating rings-backed ethdev on numa socket %u",
 			numa_node);
 
-	rx_queues_local = rte_calloc_socket(name, nb_rx_queues,
+	rx_queues_local = rte_calloc_numa(name, nb_rx_queues,
 					    sizeof(void *), 0, numa_node);
 	if (rx_queues_local == NULL) {
 		rte_errno = ENOMEM;
 		goto error;
 	}
 
-	tx_queues_local = rte_calloc_socket(name, nb_tx_queues,
+	tx_queues_local = rte_calloc_numa(name, nb_tx_queues,
 					    sizeof(void *), 0, numa_node);
 	if (tx_queues_local == NULL) {
 		rte_errno = ENOMEM;
 		goto error;
 	}
 
-	internals = rte_zmalloc_socket(name, sizeof(*internals), 0, numa_node);
+	internals = rte_zmalloc_numa(name, sizeof(*internals), 0, numa_node);
 	if (internals == NULL) {
 		rte_errno = ENOMEM;
 		goto error;
@@ -520,7 +520,7 @@ int
 rte_eth_from_ring(struct rte_ring *r)
 {
 	return rte_eth_from_rings(r->name, &r, 1, &r, 1,
-			r->memzone ? r->memzone->socket_id : SOCKET_ID_ANY);
+			r->memzone ? r->memzone->socket_id : RTE_NUMA_ID_ANY);
 }
 
 static int
@@ -693,12 +693,12 @@ rte_pmd_ring_probe(struct rte_vdev_device *dev)
 	}
 
 	if (params == NULL || params[0] == '\0') {
-		ret = eth_dev_ring_create(name, dev, rte_socket_id(), DEV_CREATE,
+		ret = eth_dev_ring_create(name, dev, rte_numa_id(), DEV_CREATE,
 				&eth_dev);
 		if (ret == -1) {
 			PMD_LOG(INFO,
 				"Attach to pmd_ring for %s", name);
-			ret = eth_dev_ring_create(name, dev, rte_socket_id(),
+			ret = eth_dev_ring_create(name, dev, rte_numa_id(),
 						  DEV_ATTACH, &eth_dev);
 		}
 	} else {
@@ -707,13 +707,13 @@ rte_pmd_ring_probe(struct rte_vdev_device *dev)
 		if (!kvlist) {
 			PMD_LOG(INFO,
 				"Ignoring unsupported parameters when creating rings-backed ethernet device");
-			ret = eth_dev_ring_create(name, dev, rte_socket_id(),
+			ret = eth_dev_ring_create(name, dev, rte_numa_id(),
 						  DEV_CREATE, &eth_dev);
 			if (ret == -1) {
 				PMD_LOG(INFO,
 					"Attach to pmd_ring for %s",
 					name);
-				ret = eth_dev_ring_create(name, dev, rte_socket_id(),
+				ret = eth_dev_ring_create(name, dev, rte_numa_id(),
 							  DEV_ATTACH, &eth_dev);
 			}
 
-- 
2.55.0

