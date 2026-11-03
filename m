Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F28606A795
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GMp86TtT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1497B42EE2;
	Tue,  3 Nov 2026 16:16:32 +0100 (CET)
Received: from mta1.migadu.com (out-224.mta1.migadu.com [95.215.58.224])
 by mails.dpdk.org (Postfix) with ESMTPS id E90F042EF1
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:16:30 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=0YCBJjnzW2tG6AhNVSZYm94wf0pdHyhjV4C9xe7q+GQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718990; v=1; x=1794323790;
 b=GMp86TtTBZKO7rshfN89RmluHgKo7UetL5wh29KwmWLz02U1jJFvARDfaSiqPE1lhsTIEBXJ
 sj3qUTbfE3GR4n8QDZTgnTmd5SoFIBEW7fihGNMJZE6g49R2YStkiPorioTQLrZlK5iIdsU299O
 1iJy2U1rzI6lN+61dUX4USZk=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id d8c69a37ebaef0b6;
 Tue, 03 Nov 2026 15:16:30 +0000
X-Mizu-Trace-ID: d8c69a37ebaef0b6
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 149/227] net/tap: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:47 +0800
Message-ID: <20261103145306.487255-150-chengwen.feng@linux.dev>
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
 drivers/net/tap/rte_eth_tap.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 1d2b71675a..c6a998cbd5 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -1155,7 +1155,7 @@ tap_dev_close(struct rte_eth_dev *dev)
 
 	internals = dev->data->dev_private;
 	TAP_LOG(DEBUG, "Closing %s Ethernet device on numa %u",
-		tuntap_types[internals->type], rte_socket_id());
+		tuntap_types[internals->type], rte_numa_id());
 
 	rte_intr_instance_free(internals->intr_handle);
 
@@ -1503,7 +1503,7 @@ tap_gso_ctx_setup(struct rte_gso_ctx *gso_ctx, struct rte_eth_dev *dev)
 		pmd->gso_ctx_mp = rte_pktmbuf_pool_create(pool_name,
 			TAP_GSO_MBUFS_NUM, TAP_GSO_MBUF_CACHE_SIZE, 0,
 			RTE_PKTMBUF_HEADROOM + TAP_GSO_MBUF_SEG_SIZE,
-			SOCKET_ID_ANY);
+			RTE_NUMA_ID_ANY);
 		if (!pmd->gso_ctx_mp) {
 			TAP_LOG(ERR,
 				"%s: failed to create mbuf pool for device %s",
@@ -1569,7 +1569,7 @@ static int
 tap_rx_queue_setup(struct rte_eth_dev *dev,
 		   uint16_t rx_queue_id,
 		   uint16_t nb_rx_desc __rte_unused,
-		   unsigned int socket_id,
+		   unsigned int numa_id,
 		   const struct rte_eth_rxconf *rx_conf __rte_unused,
 		   struct rte_mempool *mp)
 {
@@ -1619,9 +1619,9 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
 			dev->device->name, dev->data->mtu, max_rx_segs);
 	}
 
-	rxq = rte_zmalloc_socket(dev->device->name,
+	rxq = rte_zmalloc_numa(dev->device->name,
 				 sizeof(*rxq) + (max_rx_segs + 1) * sizeof(struct iovec),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (!rxq) {
 		TAP_LOG(ERR,
 			"%s: Couldn't allocate rx queue structure",
@@ -1687,7 +1687,7 @@ static int
 tap_tx_queue_setup(struct rte_eth_dev *dev,
 		   uint16_t tx_queue_id,
 		   uint16_t nb_tx_desc __rte_unused,
-		   unsigned int socket_id,
+		   unsigned int numa_id,
 		   const struct rte_eth_txconf *tx_conf)
 {
 	struct pmd_internals *internals = dev->data->dev_private;
@@ -1699,8 +1699,8 @@ tap_tx_queue_setup(struct rte_eth_dev *dev,
 	if (tx_queue_id >= dev->data->nb_tx_queues)
 		return -1;
 
-	txq = rte_zmalloc_socket(dev->device->name, sizeof(*txq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa(dev->device->name, sizeof(*txq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (!txq) {
 		TAP_LOG(ERR,
 			"%s: Couldn't allocate tx queue structure",
@@ -2150,7 +2150,7 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 		   const char *remote_iface, struct rte_ether_addr *mac_addr,
 		   enum rte_tuntap_type type, bool persist)
 {
-	int numa_node = rte_socket_id();
+	int numa_node = rte_numa_id();
 	struct rte_eth_dev *dev;
 	struct pmd_internals *pmd;
 	struct pmd_process_private *process_private;
@@ -2158,7 +2158,7 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	struct rte_eth_dev_data *data;
 	int i;
 
-	TAP_LOG(DEBUG, "%s device on numa %u", tuntap_name, rte_socket_id());
+	TAP_LOG(DEBUG, "%s device on numa %u", tuntap_name, rte_numa_id());
 
 	dev = rte_eth_vdev_allocate(vdev, sizeof(*pmd));
 	if (!dev) {
@@ -2198,7 +2198,7 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	data->numa_node = numa_node;
 
 	data->dev_link = pmd_link;
-	data->mac_addrs = rte_calloc_socket(rte_vdev_device_name(vdev),
+	data->mac_addrs = rte_calloc_numa(rte_vdev_device_name(vdev),
 					    TAP_MAX_MAC_ADDRS,
 					    sizeof(*data->mac_addrs),
 					    0, numa_node);
-- 
2.55.0

