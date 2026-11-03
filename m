Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFC7606A332
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=A/O8Nfkt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24CB342EE8;
	Tue,  3 Nov 2026 16:16:53 +0100 (CET)
Received: from mta0.migadu.com (out-136.mta0.migadu.com [91.218.175.136])
 by mails.dpdk.org (Postfix) with ESMTPS id F28D842EE8
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:16:51 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=Czblt/AYnT9taGlmbxKY8nRYCTKCvo2GzOduvcY+hV8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719011; v=1; x=1794323811;
 b=A/O8NfktSfY2cCJyVfVmamh7WxtVMpcYw+DzQmAQ2r0NSchq2RVW/nEl2fYfmPgLUl5gj3xY
 Tk32lhCkIa0pUO8VAA6s8bw6ysX+p6E+2CcO3l7FfIlThvYmyaRPbg2W+HxvuyqMmY/6LHqYGEK
 1uMwE+TrBkSSOegYUnI9gkEc=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 98b8f09adb916d69;
 Tue, 03 Nov 2026 15:16:51 +0000
X-Mizu-Trace-ID: 98b8f09adb916d69
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 152/227] net/vhost: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:50 +0800
Message-ID: <20261103145306.487255-153-chengwen.feng@linux.dev>
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
 drivers/net/vhost/rte_eth_vhost.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index 41b77d8533..4f8f39f683 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -1010,11 +1010,11 @@ vhost_driver_setup(struct rte_eth_dev *eth_dev)
 	if (list)
 		return 0;
 
-	list = rte_zmalloc_socket(name, sizeof(*list), 0, numa_node);
+	list = rte_zmalloc_numa(name, sizeof(*list), 0, numa_node);
 	if (list == NULL)
 		return -1;
 
-	vring_state = rte_zmalloc_socket(name, sizeof(*vring_state),
+	vring_state = rte_zmalloc_numa(name, sizeof(*vring_state),
 					 0, numa_node);
 	if (vring_state == NULL)
 		goto free_list;
@@ -1251,14 +1251,14 @@ eth_dev_close(struct rte_eth_dev *dev)
 static int
 eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 		   uint16_t nb_rx_desc __rte_unused,
-		   unsigned int socket_id,
+		   unsigned int numa_id,
 		   const struct rte_eth_rxconf *rx_conf __rte_unused,
 		   struct rte_mempool *mb_pool)
 {
 	struct vhost_queue *vq;
 
-	vq = rte_zmalloc_socket(NULL, sizeof(struct vhost_queue),
-			RTE_CACHE_LINE_SIZE, socket_id);
+	vq = rte_zmalloc_numa(NULL, sizeof(struct vhost_queue),
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (vq == NULL) {
 		VHOST_LOG_LINE(ERR, "Failed to allocate memory for rx queue");
 		return -ENOMEM;
@@ -1276,13 +1276,13 @@ eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 static int
 eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 		   uint16_t nb_tx_desc __rte_unused,
-		   unsigned int socket_id,
+		   unsigned int numa_id,
 		   const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct vhost_queue *vq;
 
-	vq = rte_zmalloc_socket(NULL, sizeof(struct vhost_queue),
-			RTE_CACHE_LINE_SIZE, socket_id);
+	vq = rte_zmalloc_numa(NULL, sizeof(struct vhost_queue),
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (vq == NULL) {
 		VHOST_LOG_LINE(ERR, "Failed to allocate memory for tx queue");
 		return -ENOMEM;
@@ -1582,7 +1582,7 @@ eth_dev_vhost_create(struct rte_vdev_device *dev, char *iface_name,
 		goto error;
 	data = eth_dev->data;
 
-	eth_addr = rte_zmalloc_socket(name, sizeof(*eth_addr), 0, numa_node);
+	eth_addr = rte_zmalloc_numa(name, sizeof(*eth_addr), 0, numa_node);
 	if (eth_addr == NULL)
 		goto error;
 	data->mac_addrs = eth_addr;
@@ -1595,7 +1595,7 @@ eth_dev_vhost_create(struct rte_vdev_device *dev, char *iface_name,
 	 * - and point eth_dev structure to new eth_dev_data structure
 	 */
 	internal = eth_dev->data->dev_private;
-	internal->iface_name = rte_malloc_socket(name, strlen(iface_name) + 1,
+	internal->iface_name = rte_malloc_numa(name, strlen(iface_name) + 1,
 						 0, numa_node);
 	if (internal->iface_name == NULL)
 		goto error;
@@ -1689,8 +1689,8 @@ rte_pmd_vhost_probe(struct rte_vdev_device *dev)
 		eth_dev->rx_pkt_burst = eth_vhost_rx;
 		eth_dev->tx_pkt_burst = eth_vhost_tx;
 		eth_dev->dev_ops = &ops;
-		if (dev->device.numa_node == SOCKET_ID_ANY)
-			dev->device.numa_node = rte_socket_id();
+		if (dev->device.numa_node == RTE_NUMA_ID_ANY)
+			dev->device.numa_node = rte_numa_id();
 		eth_dev->device = &dev->device;
 		rte_eth_dev_probing_finish(eth_dev);
 		return 0;
@@ -1795,8 +1795,8 @@ rte_pmd_vhost_probe(struct rte_vdev_device *dev)
 	if (legacy_ol_flags == 0)
 		flags |= RTE_VHOST_USER_NET_COMPLIANT_OL_FLAGS;
 
-	if (dev->device.numa_node == SOCKET_ID_ANY)
-		dev->device.numa_node = rte_socket_id();
+	if (dev->device.numa_node == RTE_NUMA_ID_ANY)
+		dev->device.numa_node = rte_numa_id();
 
 	ret = eth_dev_vhost_create(dev, iface_name, queues,
 				   dev->device.numa_node, flags, disable_flags);
-- 
2.55.0

