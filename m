Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C24606A32C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xkMZ51Qp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E305427DD;
	Tue,  3 Nov 2026 16:10:01 +0100 (CET)
Received: from mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
 by mails.dpdk.org (Postfix) with ESMTPS id BC086427BC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:09:59 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=NvraiIVnXmxmVngeWvgnjXFVepmPaK89mnEh0Uwe9Tw=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718599; v=1; x=1794323399;
 b=xkMZ51QphLJTlKpzBLt0f9Ik/OyE/GIoQHisyJti8lWBFe2/bexgySQTJ80P+2MBxaBMA2cC
 G2gRfBLfqk1iVhuxUU3QfP6afxTPfevYnpp2kDbW9dt39hZRRsR1TJfe3N0/Yttkt/L+L2zNVJK
 jIO+V4VHZ3/C+cFOftE/ySBI=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id b72d7885b0893b88;
 Tue, 03 Nov 2026 15:09:59 +0000
X-Mizu-Trace-ID: b72d7885b0893b88
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 102/227] net/af_packet: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:00 +0800
Message-ID: <20261103145306.487255-103-chengwen.feng@linux.dev>
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
 drivers/net/af_packet/rte_eth_af_packet.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 44f82c0309..ad59d3dd7d 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -599,7 +599,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		return 0;
 
 	PMD_LOG(INFO, "Closing AF_PACKET ethdev on NUMA socket %u",
-		rte_socket_id());
+		rte_numa_id());
 
 	internals = dev->data->dev_private;
 	req = &internals->req;
@@ -656,7 +656,7 @@ static int
 eth_rx_queue_setup(struct rte_eth_dev *dev,
 		   uint16_t rx_queue_id,
 		   uint16_t nb_rx_desc __rte_unused,
-		   unsigned int socket_id __rte_unused,
+		   unsigned int numa_id __rte_unused,
 		   const struct rte_eth_rxconf *rx_conf __rte_unused,
 		   struct rte_mempool *mb_pool)
 {
@@ -694,7 +694,7 @@ static int
 eth_tx_queue_setup(struct rte_eth_dev *dev,
 		   uint16_t tx_queue_id,
 		   uint16_t nb_tx_desc __rte_unused,
-		   unsigned int socket_id __rte_unused,
+		   unsigned int numa_id __rte_unused,
 		   const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 
@@ -933,17 +933,17 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 		"%s: creating AF_PACKET-backed ethdev on numa socket %u",
 		name, numa_node);
 
-	*internals = rte_zmalloc_socket(name, sizeof(**internals),
+	*internals = rte_zmalloc_numa(name, sizeof(**internals),
 					0, numa_node);
 	if (*internals == NULL)
 		return -1;
 
 
-	(*internals)->rx_queue = rte_calloc_socket("af_packet_rx",
+	(*internals)->rx_queue = rte_calloc_numa("af_packet_rx",
 						nb_queues,
 						sizeof(struct pkt_rx_queue),
 						0, numa_node);
-	(*internals)->tx_queue = rte_calloc_socket("af_packet_tx",
+	(*internals)->tx_queue = rte_calloc_numa("af_packet_tx",
 						nb_queues,
 						sizeof(struct pkt_tx_queue),
 						0, numa_node);
@@ -979,7 +979,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 		PMD_LOG_ERRNO(ERR, "%s: ioctl failed (SIOCGIFINDEX)", name);
 		goto free_internals;
 	}
-	(*internals)->if_name = rte_malloc_socket(name, ifnamelen + 1, 0, numa_node);
+	(*internals)->if_name = rte_malloc_numa(name, ifnamelen + 1, 0, numa_node);
 	if ((*internals)->if_name == NULL)
 		goto free_internals;
 	strlcpy((*internals)->if_name, pair->value, ifnamelen + 1);
@@ -1098,7 +1098,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 		/* rdsize is same for both Tx and Rx */
 		rdsize = req->tp_frame_nr * sizeof(*(rx_queue->rd));
 
-		rx_queue->rd = rte_zmalloc_socket(name, rdsize, 0, numa_node);
+		rx_queue->rd = rte_zmalloc_numa(name, rdsize, 0, numa_node);
 		if (rx_queue->rd == NULL)
 			goto error;
 		for (i = 0; i < req->tp_frame_nr; ++i) {
@@ -1115,7 +1115,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 
 		tx_queue->map = rx_queue->map + req->tp_block_size * req->tp_block_nr;
 
-		tx_queue->rd = rte_zmalloc_socket(name, rdsize, 0, numa_node);
+		tx_queue->rd = rte_zmalloc_numa(name, rdsize, 0, numa_node);
 		if (tx_queue->rd == NULL)
 			goto error;
 		for (i = 0; i < req->tp_frame_nr; ++i) {
@@ -1406,8 +1406,8 @@ rte_pmd_af_packet_probe(struct rte_vdev_device *dev)
 			goto exit;
 	}
 
-	if (dev->device.numa_node == SOCKET_ID_ANY)
-		dev->device.numa_node = rte_socket_id();
+	if (dev->device.numa_node == RTE_NUMA_ID_ANY)
+		dev->device.numa_node = rte_numa_id();
 
 	ret = rte_eth_from_packet(dev, &sockfd, kvlist);
 	close(sockfd); /* no longer needed */
-- 
2.55.0

