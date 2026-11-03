Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EED606C84E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=En+97ir9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58687427B2;
	Tue,  3 Nov 2026 15:59:55 +0100 (CET)
Received: from mta0.migadu.com (out-96.mta0.migadu.com [91.218.175.96])
 by mails.dpdk.org (Postfix) with ESMTPS id 8D775410FC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:59:54 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=qZJJgk2Z1o4mpQQaKYcMAqTRr/dgsA0dJMopMGOMbKg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717994; v=1; x=1794322794;
 b=En+97ir9IQDFUis9eKMQfB7DMhc/ELYTAFOU3gGJkkqBJ92ErncO/qnnaq5469hYtimvM6VE
 vmo8iDOQ0/tCqyXML8GaSFeTEsXb3r6FdfJdjOO4vONuW4tV12Gi/v1Lxo26WB42TRy2eui8eiv
 Nq15MKaS20C70qVe2O3XhxQg=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 34cae37ae93d7c82;
 Tue, 03 Nov 2026 14:59:54 +0000
X-Mizu-Trace-ID: 34cae37ae93d7c82
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 041/227] baseband/fpga_lte_fec: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:59 +0800
Message-ID: <20261103145306.487255-42-chengwen.feng@linux.dev>
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
 drivers/baseband/fpga_lte_fec/fpga_lte_fec.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
index dc1394930f..27697c9b59 100644
--- a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
+++ b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
@@ -475,7 +475,7 @@ print_dma_dec_desc_debug_info(union fpga_dma_desc *desc)
 #endif
 
 static int
-fpga_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int socket_id)
+fpga_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int numa_id)
 {
 	/* Number of queues bound to a PF/VF */
 	uint32_t hw_q_num = 0;
@@ -536,9 +536,9 @@ fpga_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int socket_id)
 	RTE_BUILD_BUG_ON((RTE_CACHE_LINE_SIZE % 32) != 0);
 
 	/* Allocate memory for SW descriptor rings */
-	fpga_dev->sw_rings = rte_zmalloc_socket(dev->device->driver->name,
+	fpga_dev->sw_rings = rte_zmalloc_numa(dev->device->driver->name,
 			num_queues * ring_size, RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (fpga_dev->sw_rings == NULL) {
 		rte_bbdev_log(ERR,
 				"Failed to allocate memory for %s:%u sw_rings",
@@ -551,8 +551,8 @@ fpga_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int socket_id)
 	fpga_dev->sw_ring_max_depth = FPGA_RING_MAX_SIZE;
 
 	/* Allocate memory for ring flush status */
-	fpga_dev->flush_queue_status = rte_zmalloc_socket(NULL,
-			sizeof(uint64_t), RTE_CACHE_LINE_SIZE, socket_id);
+	fpga_dev->flush_queue_status = rte_zmalloc_numa(NULL,
+			sizeof(uint64_t), RTE_CACHE_LINE_SIZE, numa_id);
 	if (fpga_dev->flush_queue_status == NULL) {
 		rte_bbdev_log(ERR,
 				"Failed to allocate memory for %s:%u flush_queue_status",
@@ -714,8 +714,8 @@ fpga_queue_setup(struct rte_bbdev *dev, uint16_t queue_id,
 		return -1;
 
 	/* Allocate the queue data structure. */
-	q = rte_zmalloc_socket(dev->device->driver->name, sizeof(*q),
-			RTE_CACHE_LINE_SIZE, conf->socket);
+	q = rte_zmalloc_numa(dev->device->driver->name, sizeof(*q),
+			RTE_CACHE_LINE_SIZE, conf->numa_id);
 	if (q == NULL) {
 		/* Mark queue as un-assigned */
 		d->q_assigned_bit_map &= (0xFFFFFFFF - (1ULL << q_idx));
@@ -732,8 +732,8 @@ fpga_queue_setup(struct rte_bbdev *dev, uint16_t queue_id,
 			(d->sw_ring_size * queue_id);
 
 	/* Allocate memory for Completion Head variable*/
-	q->ring_head_addr = rte_zmalloc_socket(dev->device->driver->name,
-			sizeof(uint64_t), RTE_CACHE_LINE_SIZE, conf->socket);
+	q->ring_head_addr = rte_zmalloc_numa(dev->device->driver->name,
+			sizeof(uint64_t), RTE_CACHE_LINE_SIZE, conf->numa_id);
 	if (q->ring_head_addr == NULL) {
 		/* Mark queue as un-assigned */
 		d->q_assigned_bit_map &= (0xFFFFFFFF - (1ULL << q_idx));
@@ -2357,7 +2357,7 @@ fpga_lte_fec_probe(struct rte_pci_driver *pci_drv,
 		return -ENODEV;
 
 	/* allocate device private memory */
-	bbdev->data->dev_private = rte_zmalloc_socket(dev_name,
+	bbdev->data->dev_private = rte_zmalloc_numa(dev_name,
 			sizeof(struct fpga_lte_fec_device), RTE_CACHE_LINE_SIZE,
 			pci_dev->device.numa_node);
 
-- 
2.55.0

