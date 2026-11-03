Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4829606B24F
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=m7jydkTJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31F2742EAB;
	Tue,  3 Nov 2026 16:14:54 +0100 (CET)
Received: from mta0.migadu.com (out-80.mta0.migadu.com [91.218.175.80])
 by mails.dpdk.org (Postfix) with ESMTPS id 31B0F42EAB
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:14:52 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=Oxw0ZC2Np1zTvpqp4QgswMKZ7O7DEUKiexTTqv/LNWQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718891; v=1; x=1794323691;
 b=m7jydkTJuFBd1na6giOjfdCASctq3I4mB9iHG2CwwEUc5Hsm1M09Ce8jgPh+IJb/OPoRueXk
 ESiupJawRMWOxJApG6/z7qWV0pmGPlxMTRZO3zyeS7Jb4Ut3K/lJDRb5m77OGiGMjVC7OAb8iQT
 IHwAwU9lJb9ZzU491c22ShM0=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id e1f3026ab52423b5;
 Tue, 03 Nov 2026 15:14:51 +0000
X-Mizu-Trace-ID: e1f3026ab52423b5
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 139/227] net/octeontx: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:37 +0800
Message-ID: <20261103145306.487255-140-chengwen.feng@linux.dev>
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
 drivers/net/octeontx/octeontx_ethdev.c | 40 +++++++++++++-------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/octeontx/octeontx_ethdev.c b/drivers/net/octeontx/octeontx_ethdev.c
index bde4c2c615..4e83b81de9 100644
--- a/drivers/net/octeontx/octeontx_ethdev.c
+++ b/drivers/net/octeontx/octeontx_ethdev.c
@@ -1223,7 +1223,7 @@ octeontx_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 
 static int
 octeontx_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qidx,
-			    uint16_t nb_desc, unsigned int socket_id,
+			    uint16_t nb_desc, unsigned int numa_id,
 			    const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct octeontx_nic *nic = octeontx_pmd_priv(dev);
@@ -1232,15 +1232,15 @@ octeontx_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qidx,
 	int res = 0;
 
 	RTE_SET_USED(nb_desc);
-	RTE_SET_USED(socket_id);
+	RTE_SET_USED(numa_id);
 
 	dq_num = (nic->pko_vfid * PKO_VF_NUM_DQ) + qidx;
 
 	/* Socket id check */
-	if (socket_id != (unsigned int)SOCKET_ID_ANY &&
-			socket_id != (unsigned int)nic->node)
-		PMD_TX_LOG(INFO, "socket_id expected %d, configured %d",
-						socket_id, nic->node);
+	if (numa_id != (unsigned int)RTE_NUMA_ID_ANY &&
+			numa_id != (unsigned int)nic->node)
+		PMD_TX_LOG(INFO, "numa_id expected %d, configured %d",
+						numa_id, nic->node);
 
 	/* Free memory prior to re-allocation if needed. */
 	if (dev->data->tx_queues[qidx] != NULL) {
@@ -1251,7 +1251,7 @@ octeontx_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qidx,
 	}
 
 	/* Allocating tx queue data structure */
-	txq = rte_zmalloc_socket("ethdev TX queue", sizeof(struct octeontx_txq),
+	txq = rte_zmalloc_numa("ethdev TX queue", sizeof(struct octeontx_txq),
 				 RTE_CACHE_LINE_SIZE, nic->node);
 	if (txq == NULL) {
 		octeontx_log_err("failed to allocate txq=%d", qidx);
@@ -1289,7 +1289,7 @@ octeontx_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qidx,
 
 static int
 octeontx_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qidx,
-				uint16_t nb_desc, unsigned int socket_id,
+				uint16_t nb_desc, unsigned int numa_id,
 				const struct rte_eth_rxconf *rx_conf,
 				struct rte_mempool *mb_pool)
 {
@@ -1340,13 +1340,13 @@ octeontx_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qidx,
 	}
 
 	/* Socket id check */
-	if (socket_id != (unsigned int)SOCKET_ID_ANY &&
-			socket_id != (unsigned int)nic->node)
-		PMD_RX_LOG(INFO, "socket_id expected %d, configured %d",
-						socket_id, nic->node);
+	if (numa_id != (unsigned int)RTE_NUMA_ID_ANY &&
+			numa_id != (unsigned int)nic->node)
+		PMD_RX_LOG(INFO, "numa_id expected %d, configured %d",
+						numa_id, nic->node);
 
 	/* Allocating rx queue data structure */
-	rxq = rte_zmalloc_socket("ethdev RX queue", sizeof(struct octeontx_rxq),
+	rxq = rte_zmalloc_numa("ethdev RX queue", sizeof(struct octeontx_rxq),
 				 RTE_CACHE_LINE_SIZE, nic->node);
 	if (rxq == NULL) {
 		octeontx_log_err("failed to allocate rxq=%d", qidx);
@@ -1531,7 +1531,7 @@ static const struct eth_dev_ops octeontx_dev_ops = {
 /* Create Ethdev interface per BGX LMAC ports */
 static int
 octeontx_create(struct rte_vdev_device *dev, int port, uint8_t evdev,
-			int socket_id)
+			int numa_id)
 {
 	int res;
 	size_t pko_vfid;
@@ -1567,7 +1567,7 @@ octeontx_create(struct rte_vdev_device *dev, int port, uint8_t evdev,
 	}
 	data = eth_dev->data;
 
-	nic = rte_zmalloc_socket(octtx_name, sizeof(*nic), 0, socket_id);
+	nic = rte_zmalloc_numa(octtx_name, sizeof(*nic), 0, numa_id);
 	if (nic == NULL) {
 		octeontx_log_err("failed to allocate nic structure");
 		res = -ENOMEM;
@@ -1624,9 +1624,9 @@ octeontx_create(struct rte_vdev_device *dev, int port, uint8_t evdev,
 		goto err;
 	}
 
-	data->mac_addrs = rte_zmalloc_socket(octtx_name, max_entries *
+	data->mac_addrs = rte_zmalloc_numa(octtx_name, max_entries *
 					     RTE_ETHER_ADDR_LEN, 0,
-							socket_id);
+							numa_id);
 	if (data->mac_addrs == NULL) {
 		octeontx_log_err("failed to allocate memory for mac_addrs");
 		res = -ENOMEM;
@@ -1733,7 +1733,7 @@ octeontx_probe(struct rte_vdev_device *dev)
 {
 	const char *dev_name;
 	static int probe_once;
-	uint8_t socket_id, qlist;
+	uint8_t numa_id, qlist;
 	int tx_vfcnt, port_id, evdev, qnum, pnum, res, i;
 	struct rte_event_dev_config dev_conf;
 	const char *eventdev_name = "event_octeontx";
@@ -1772,7 +1772,7 @@ octeontx_probe(struct rte_vdev_device *dev)
 
 	PMD_INIT_LOG(DEBUG, "initializing %s pmd", dev_name);
 
-	socket_id = rte_socket_id();
+	numa_id = rte_numa_id();
 
 	tx_vfcnt = octeontx_pko_vf_count();
 
@@ -1856,7 +1856,7 @@ octeontx_probe(struct rte_vdev_device *dev)
 
 	/* Create ethdev interface */
 	for (i = 0; i < init_params.nr_port; i++) {
-		port_id = octeontx_create(dev, i, evdev, socket_id);
+		port_id = octeontx_create(dev, i, evdev, numa_id);
 		if (port_id < 0) {
 			octeontx_log_err("failed to create device %s",
 					dev_name);
-- 
2.55.0

