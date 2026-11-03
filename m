Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657736071A3E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pPnOzSj6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A62B427AC;
	Tue,  3 Nov 2026 15:59:42 +0100 (CET)
Received: from mta0.migadu.com (out-87.mta0.migadu.com [91.218.175.87])
 by mails.dpdk.org (Postfix) with ESMTPS id CE67C410FC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:59:40 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=IuRRPQqfYeRU2NRce0kZjulyTXZJ5QXzTOWSEL6VnDQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717980; v=1; x=1794322780;
 b=pPnOzSj6uiqCQ03peiwRQYDzvie4ZSqyByw8//VdX74PjAvNpgLuzQYWr4TlbAsvff9BXbcD
 giS6u5vVjYMBEQeRnrYW8YlWWVEM7JWNc1AijJ14uIrl4eUHjqDj0fWtBDVxNwaj3xuQoC3rQul
 Ed+lT++QrJqcHL67hNVdYvXc=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id d66f76fbe8efa7c5;
 Tue, 03 Nov 2026 14:59:40 +0000
X-Mizu-Trace-ID: d66f76fbe8efa7c5
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 040/227] baseband/fpga_5gnr_fec: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:58 +0800
Message-ID: <20261103145306.487255-41-chengwen.feng@linux.dev>
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
 .../fpga_5gnr_fec/rte_fpga_5gnr_fec.c         | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
index e14581cd48..cabf0a0ce9 100644
--- a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
+++ b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
@@ -377,7 +377,7 @@ fpga_5gnr_get_queue_map(struct fpga_5gnr_fec_device *d, uint32_t q_id)
 }
 
 static int
-fpga_5gnr_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int socket_id)
+fpga_5gnr_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int numa_id)
 {
 	/* Number of queues bound to a PF/VF */
 	uint32_t hw_q_num = 0;
@@ -438,9 +438,9 @@ fpga_5gnr_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int socket_id
 	RTE_BUILD_BUG_ON((RTE_CACHE_LINE_SIZE % 32) != 0);
 
 	/* Allocate memory for SW descriptor rings */
-	d->sw_rings = rte_zmalloc_socket(dev->device->driver->name,
+	d->sw_rings = rte_zmalloc_numa(dev->device->driver->name,
 			num_queues * ring_size, RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (d->sw_rings == NULL) {
 		rte_bbdev_log(ERR,
 				"Failed to allocate memory for %s:%u sw_rings",
@@ -453,8 +453,8 @@ fpga_5gnr_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int socket_id
 	d->sw_ring_max_depth = FPGA_5GNR_RING_MAX_SIZE;
 
 	/* Allocate memory for ring flush status */
-	d->flush_queue_status = rte_zmalloc_socket(NULL,
-			sizeof(uint64_t), RTE_CACHE_LINE_SIZE, socket_id);
+	d->flush_queue_status = rte_zmalloc_numa(NULL,
+			sizeof(uint64_t), RTE_CACHE_LINE_SIZE, numa_id);
 	if (d->flush_queue_status == NULL) {
 		rte_bbdev_log(ERR,
 				"Failed to allocate memory for %s:%u flush_queue_status",
@@ -678,8 +678,8 @@ fpga_5gnr_queue_setup(struct rte_bbdev *dev, uint16_t queue_id,
 		return -1;
 
 	/* Allocate the queue data structure. */
-	q = rte_zmalloc_socket(dev->device->driver->name, sizeof(*q),
-			RTE_CACHE_LINE_SIZE, conf->socket);
+	q = rte_zmalloc_numa(dev->device->driver->name, sizeof(*q),
+			RTE_CACHE_LINE_SIZE, conf->numa_id);
 	if (q == NULL) {
 		/* Mark queue as un-assigned */
 		d->q_assigned_bit_map &= (0xFFFFFFFF - (1ULL << q_idx));
@@ -699,8 +699,8 @@ fpga_5gnr_queue_setup(struct rte_bbdev *dev, uint16_t queue_id,
 	q->ring_ctrl_reg.ring_base_addr = d->sw_rings_phys + (d->sw_ring_size * queue_id);
 
 	/* Allocate memory for Completion Head variable*/
-	q->ring_head_addr = rte_zmalloc_socket(dev->device->driver->name,
-			sizeof(uint64_t), RTE_CACHE_LINE_SIZE, conf->socket);
+	q->ring_head_addr = rte_zmalloc_numa(dev->device->driver->name,
+			sizeof(uint64_t), RTE_CACHE_LINE_SIZE, conf->numa_id);
 	if (q->ring_head_addr == NULL) {
 		/* Mark queue as un-assigned */
 		d->q_assigned_bit_map &= (0xFFFFFFFF - (1ULL << q_idx));
@@ -2933,7 +2933,7 @@ fpga_5gnr_fec_probe(struct rte_pci_driver *pci_drv,
 		return -ENODEV;
 
 	/* allocate device private memory */
-	bbdev->data->dev_private = rte_zmalloc_socket(dev_name,
+	bbdev->data->dev_private = rte_zmalloc_numa(dev_name,
 			sizeof(struct fpga_5gnr_fec_device),
 			RTE_CACHE_LINE_SIZE,
 			pci_dev->device.numa_node);
-- 
2.55.0

