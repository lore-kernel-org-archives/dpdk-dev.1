Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7307D6082BF2
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PfcIkSsy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FC9042F23;
	Tue,  3 Nov 2026 16:18:54 +0100 (CET)
Received: from mta1.migadu.com (out-86.mta1.migadu.com [95.215.58.86])
 by mails.dpdk.org (Postfix) with ESMTPS id 64E4B427E0
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:18:52 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=UxBwVhmDdqluK2BDsAUzAzrd1crkx2TxgB+oD38qrsg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719131; v=1; x=1794323931;
 b=PfcIkSsymNxUx105Fg/ji/F4rZO9oHS+2e2HCS1UU6yC3eWGSkQhov88xtB7oOZZhoqjbrtD
 a31Z6RyLSg6IF35Sz1jK8Ft9EvQPFbTFCRCJpvus8RfIWphC+s5PZXyi+8/Y+wlv4P+pZuqX5v2
 TOBUu96iSVZ1GG5v8g40MJb4=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 8fa44affe42f45c8;
 Tue, 03 Nov 2026 15:18:51 +0000
X-Mizu-Trace-ID: 8fa44affe42f45c8
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 163/227] raw/ntb: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:01 +0800
Message-ID: <20261103145306.487255-164-chengwen.feng@linux.dev>
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
 drivers/raw/ntb/ntb.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index 9f29d409e4..6167f69402 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -187,7 +187,7 @@ ntb_rxq_setup(struct rte_rawdev *dev,
 		return -EINVAL;
 
 	/* Allocate the rx queue data structure */
-	rxq = rte_zmalloc_socket("ntb rx queue",
+	rxq = rte_zmalloc_numa("ntb rx queue",
 				 sizeof(struct ntb_rx_queue),
 				 RTE_CACHE_LINE_SIZE,
 				 dev->numa_id);
@@ -209,7 +209,7 @@ ntb_rxq_setup(struct rte_rawdev *dev,
 
 	/* Allocate the software ring. */
 	rxq->sw_ring =
-		rte_zmalloc_socket("ntb rx sw ring",
+		rte_zmalloc_numa("ntb rx sw ring",
 				   sizeof(struct ntb_rx_entry) *
 				   rxq->nb_rx_desc,
 				   RTE_CACHE_LINE_SIZE,
@@ -273,7 +273,7 @@ ntb_txq_setup(struct rte_rawdev *dev,
 		return -EINVAL;
 
 	/* Allocate the TX queue data structure. */
-	txq = rte_zmalloc_socket("ntb tx queue",
+	txq = rte_zmalloc_numa("ntb tx queue",
 				  sizeof(struct ntb_tx_queue),
 				  RTE_CACHE_LINE_SIZE,
 				  dev->numa_id);
@@ -290,7 +290,7 @@ ntb_txq_setup(struct rte_rawdev *dev,
 
 	/* Allocate software ring */
 	txq->sw_ring =
-		rte_zmalloc_socket("ntb tx sw ring",
+		rte_zmalloc_numa("ntb tx sw ring",
 				   sizeof(struct ntb_tx_entry) *
 				   txq->nb_tx_desc,
 				   RTE_CACHE_LINE_SIZE,
@@ -1319,7 +1319,7 @@ ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
 }
 
 static int
-ntb_create(struct rte_pci_device *pci_dev, int socket_id)
+ntb_create(struct rte_pci_device *pci_dev, int numa_id)
 {
 	char name[RTE_RAWDEV_NAME_MAX_LEN];
 	struct rte_rawdev *rawdev = NULL;
@@ -1335,11 +1335,11 @@ ntb_create(struct rte_pci_device *pci_dev, int socket_id)
 		 pci_dev->addr.bus, pci_dev->addr.devid,
 		 pci_dev->addr.function);
 
-	NTB_LOG(INFO, "Init %s on NUMA node %d", name, socket_id);
+	NTB_LOG(INFO, "Init %s on NUMA node %d", name, numa_id);
 
 	/* Allocate device structure. */
 	rawdev = rte_rawdev_pmd_allocate(name, sizeof(struct ntb_hw),
-					 socket_id);
+					 numa_id);
 	if (rawdev == NULL) {
 		NTB_LOG(ERR, "Unable to allocate rawdev.");
 		return -EINVAL;
@@ -1382,7 +1382,7 @@ ntb_destroy(struct rte_pci_device *pci_dev)
 		 pci_dev->addr.bus, pci_dev->addr.devid,
 		 pci_dev->addr.function);
 
-	NTB_LOG(INFO, "Closing %s on NUMA node %d", name, rte_socket_id());
+	NTB_LOG(INFO, "Closing %s on NUMA node %d", name, rte_numa_id());
 
 	rawdev = rte_rawdev_pmd_get_named_dev(name);
 	if (rawdev == NULL) {
@@ -1402,7 +1402,7 @@ static int
 ntb_probe(struct rte_pci_driver *pci_drv __rte_unused,
 	struct rte_pci_device *pci_dev)
 {
-	return ntb_create(pci_dev, rte_socket_id());
+	return ntb_create(pci_dev, rte_numa_id());
 }
 
 static int
-- 
2.55.0

