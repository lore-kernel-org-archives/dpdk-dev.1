Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75589606C85B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Au3nI5pN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50476427BA;
	Tue,  3 Nov 2026 15:59:04 +0100 (CET)
Received: from mta0.migadu.com (out-72.mta0.migadu.com [91.218.175.72])
 by mails.dpdk.org (Postfix) with ESMTPS id 4562D427B0
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:59:03 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=ZoBXbzsuRuzlKu3vsqik8QV51EqzzdVzA89frFmTKxs=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717943; v=1; x=1794322743;
 b=Au3nI5pNHjmXUHUdkJRtgBz0S+1NYfw0YddgVThE7k+3L8YIt9rsXHM0VIplrJyhnkiyEkQz
 HJx6wTwajqgG0gCOzu4SA+MXrQGuXY0r10Yl5funFJ7cH1WgSFLl3mXEX/eHFjZ/S5sHY9q1Z2N
 WnANXzsftLOX8H62+t1Oa/CI=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 5a5ad2149ed7877c;
 Tue, 03 Nov 2026 14:59:03 +0000
X-Mizu-Trace-ID: 5a5ad2149ed7877c
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 039/227] baseband/acc: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:57 +0800
Message-ID: <20261103145306.487255-40-chengwen.feng@linux.dev>
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
 drivers/baseband/acc/acc_common.h     |  4 +--
 drivers/baseband/acc/rte_acc100_pmd.c | 36 ++++++++++++-------------
 drivers/baseband/acc/rte_vrb_pmd.c    | 38 +++++++++++++--------------
 3 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/baseband/acc/acc_common.h b/drivers/baseband/acc/acc_common.h
index 3d411cd25f..100730fe5d 100644
--- a/drivers/baseband/acc/acc_common.h
+++ b/drivers/baseband/acc/acc_common.h
@@ -787,7 +787,7 @@ alloc_2x64mb_sw_rings_mem(struct rte_bbdev *dev, struct acc_device *d,
 		int socket)
 {
 	uint32_t sw_ring_size = ACC_SIZE_64MBYTE;
-	d->sw_rings_base = rte_zmalloc_socket(dev->device->driver->name,
+	d->sw_rings_base = rte_zmalloc_numa(dev->device->driver->name,
 			2 * sw_ring_size, RTE_CACHE_LINE_SIZE, socket);
 	if (d->sw_rings_base == NULL) {
 		rte_acc_log(ERR, "Failed to allocate memory for %s:%u",
@@ -830,7 +830,7 @@ alloc_sw_rings_min_mem(struct rte_bbdev *dev, struct acc_device *d,
 		 * the variable 'alignment' at the condition that the requested
 		 * size is less than the page size
 		 */
-		sw_rings_base = rte_zmalloc_socket(
+		sw_rings_base = rte_zmalloc_numa(
 				dev->device->driver->name,
 				dev_sw_ring_size, alignment, socket);
 
diff --git a/drivers/baseband/acc/rte_acc100_pmd.c b/drivers/baseband/acc/rte_acc100_pmd.c
index 67b969fc71..f63beb9d2d 100644
--- a/drivers/baseband/acc/rte_acc100_pmd.c
+++ b/drivers/baseband/acc/rte_acc100_pmd.c
@@ -410,7 +410,7 @@ allocate_info_ring(struct rte_bbdev *dev)
 	else
 		reg_addr = &vf_reg_addr;
 	/* Allocate InfoRing */
-	d->info_ring = rte_zmalloc_socket("Info Ring",
+	d->info_ring = rte_zmalloc_numa("Info Ring",
 		ACC_INFO_RING_NUM_ENTRIES *
 		sizeof(*d->info_ring), RTE_CACHE_LINE_SIZE,
 		dev->data->numa_id);
@@ -437,7 +437,7 @@ allocate_info_ring(struct rte_bbdev *dev)
 
 /* Allocate 64MB memory used for all software rings */
 static int
-acc100_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int socket_id)
+acc100_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int numa_id)
 {
 	uint32_t phys_low, phys_high, value;
 	struct acc_device *d = dev->data->dev_private;
@@ -451,13 +451,13 @@ acc100_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int socket_id)
 		return -ENODEV;
 	}
 
-	alloc_sw_rings_min_mem(dev, d, num_queues, socket_id);
+	alloc_sw_rings_min_mem(dev, d, num_queues, numa_id);
 
 	/* If minimal memory space approach failed, then allocate
 	 * the 2 * 64MB block for the sw rings
 	 */
 	if (d->sw_rings == NULL)
-		alloc_2x64mb_sw_rings_mem(dev, d, socket_id);
+		alloc_2x64mb_sw_rings_mem(dev, d, numa_id);
 
 	if (d->sw_rings == NULL) {
 		rte_bbdev_log(NOTICE,
@@ -508,10 +508,10 @@ acc100_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int socket_id)
 
 	/* Configure tail pointer for use when SDONE enabled */
 	if (d->tail_ptrs == NULL)
-		d->tail_ptrs = rte_zmalloc_socket(
+		d->tail_ptrs = rte_zmalloc_numa(
 			dev->device->driver->name,
 			ACC100_NUM_QGRPS * ACC100_NUM_AQS * sizeof(uint32_t),
-			RTE_CACHE_LINE_SIZE, socket_id);
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (d->tail_ptrs == NULL) {
 		rte_bbdev_log(ERR, "Failed to allocate tail ptr for %s:%u",
 				dev->device->driver->name,
@@ -541,7 +541,7 @@ acc100_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int socket_id)
 	}
 
 	if (d->harq_layout == NULL)
-		d->harq_layout = rte_zmalloc_socket("HARQ Layout",
+		d->harq_layout = rte_zmalloc_numa("HARQ Layout",
 			ACC_HARQ_LAYOUT * sizeof(*d->harq_layout),
 			RTE_CACHE_LINE_SIZE, dev->data->numa_id);
 	if (d->harq_layout == NULL) {
@@ -693,8 +693,8 @@ acc100_queue_setup(struct rte_bbdev *dev, uint16_t queue_id,
 		return -ENODEV;
 	}
 	/* Allocate the queue data structure. */
-	q = rte_zmalloc_socket(dev->device->driver->name, sizeof(*q),
-			RTE_CACHE_LINE_SIZE, conf->socket);
+	q = rte_zmalloc_numa(dev->device->driver->name, sizeof(*q),
+			RTE_CACHE_LINE_SIZE, conf->numa_id);
 	if (q == NULL) {
 		rte_bbdev_log(ERR, "Failed to allocate queue memory");
 		return -ENOMEM;
@@ -740,35 +740,35 @@ acc100_queue_setup(struct rte_bbdev *dev, uint16_t queue_id,
 		desc->req.fcw_ld.gain_h = 1;
 	}
 
-	q->lb_in = rte_zmalloc_socket(dev->device->driver->name,
+	q->lb_in = rte_zmalloc_numa(dev->device->driver->name,
 			RTE_CACHE_LINE_SIZE,
-			RTE_CACHE_LINE_SIZE, conf->socket);
+			RTE_CACHE_LINE_SIZE, conf->numa_id);
 	if (q->lb_in == NULL) {
 		rte_bbdev_log(ERR, "Failed to allocate lb_in memory");
 		ret = -ENOMEM;
 		goto free_q;
 	}
 	q->lb_in_addr_iova = rte_malloc_virt2iova(q->lb_in);
-	q->lb_out = rte_zmalloc_socket(dev->device->driver->name,
+	q->lb_out = rte_zmalloc_numa(dev->device->driver->name,
 			RTE_CACHE_LINE_SIZE,
-			RTE_CACHE_LINE_SIZE, conf->socket);
+			RTE_CACHE_LINE_SIZE, conf->numa_id);
 	if (q->lb_out == NULL) {
 		rte_bbdev_log(ERR, "Failed to allocate lb_out memory");
 		ret = -ENOMEM;
 		goto free_lb_in;
 	}
 	q->lb_out_addr_iova = rte_malloc_virt2iova(q->lb_out);
-	q->companion_ring_addr = rte_zmalloc_socket(dev->device->driver->name,
+	q->companion_ring_addr = rte_zmalloc_numa(dev->device->driver->name,
 			d->sw_ring_max_depth * sizeof(*q->companion_ring_addr),
-			RTE_CACHE_LINE_SIZE, conf->socket);
+			RTE_CACHE_LINE_SIZE, conf->numa_id);
 	if (q->companion_ring_addr == NULL) {
 		rte_bbdev_log(ERR, "Failed to allocate companion_ring memory");
 		ret = -ENOMEM;
 		goto free_lb_out;
 	}
-	q->derm_buffer = rte_zmalloc_socket(dev->device->driver->name,
+	q->derm_buffer = rte_zmalloc_numa(dev->device->driver->name,
 			RTE_BBDEV_TURBO_MAX_CB_SIZE * 10,
-			RTE_CACHE_LINE_SIZE, conf->socket);
+			RTE_CACHE_LINE_SIZE, conf->numa_id);
 	if (q->derm_buffer == NULL) {
 		rte_bbdev_log(ERR, "Failed to allocate derm_buffer memory");
 		ret = -ENOMEM;
@@ -4043,7 +4043,7 @@ static int acc100_pci_probe(struct rte_pci_driver *pci_drv,
 		return -ENODEV;
 
 	/* allocate device private memory */
-	bbdev->data->dev_private = rte_zmalloc_socket(dev_name,
+	bbdev->data->dev_private = rte_zmalloc_numa(dev_name,
 			sizeof(struct acc_device), RTE_CACHE_LINE_SIZE,
 			pci_dev->device.numa_node);
 
diff --git a/drivers/baseband/acc/rte_vrb_pmd.c b/drivers/baseband/acc/rte_vrb_pmd.c
index 8d86694b80..d46ec72aea 100644
--- a/drivers/baseband/acc/rte_vrb_pmd.c
+++ b/drivers/baseband/acc/rte_vrb_pmd.c
@@ -512,7 +512,7 @@ allocate_info_ring(struct rte_bbdev *dev)
 		return 0; /* Already configured. */
 
 	/* Allocate InfoRing */
-	d->info_ring = rte_zmalloc_socket("Info Ring", ACC_INFO_RING_NUM_ENTRIES *
+	d->info_ring = rte_zmalloc_numa("Info Ring", ACC_INFO_RING_NUM_ENTRIES *
 			sizeof(*d->info_ring), RTE_CACHE_LINE_SIZE, dev->data->numa_id);
 	if (d->info_ring == NULL) {
 		rte_bbdev_log(ERR,
@@ -540,7 +540,7 @@ allocate_info_ring(struct rte_bbdev *dev)
 
 /* Allocate 64MB memory used for all software rings. */
 static int
-vrb_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int socket_id)
+vrb_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int numa_id)
 {
 	uint32_t phys_low, phys_high, value;
 	struct acc_device *d = dev->data->dev_private;
@@ -567,13 +567,13 @@ vrb_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int socket_id)
 	}
 
 	if (d->device_variant == VRB1_VARIANT) {
-		alloc_sw_rings_min_mem(dev, d, num_queues, socket_id);
+		alloc_sw_rings_min_mem(dev, d, num_queues, numa_id);
 
 		/* If minimal memory space approach failed, then allocate
 		 * the 2 * 64MB block for the sw rings.
 		 */
 		if (d->sw_rings == NULL)
-			alloc_2x64mb_sw_rings_mem(dev, d, socket_id);
+			alloc_2x64mb_sw_rings_mem(dev, d, numa_id);
 
 		if (d->sw_rings == NULL) {
 			rte_bbdev_log(NOTICE, "Failure allocating sw_rings memory");
@@ -582,7 +582,7 @@ vrb_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int socket_id)
 	} else if (d->device_variant == VRB2_VARIANT) {
 		queues_per_op = RTE_MIN(VRB2_MAX_Q_PER_OP, num_queues);
 		for (i = 0; i <= RTE_BBDEV_OP_MLDTS; i++) {
-			alloc_sw_rings_min_mem(dev, d, queues_per_op, socket_id);
+			alloc_sw_rings_min_mem(dev, d, queues_per_op, numa_id);
 			if (d->sw_rings == NULL) {
 				rte_bbdev_log(NOTICE, "Failure allocating sw_rings memory %d", i);
 				return -ENOMEM;
@@ -679,9 +679,9 @@ vrb_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int socket_id)
 
 	/* Configure tail pointer for use when SDONE enabled. */
 	if (d->tail_ptrs == NULL)
-		d->tail_ptrs = rte_zmalloc_socket(dev->device->driver->name,
+		d->tail_ptrs = rte_zmalloc_numa(dev->device->driver->name,
 				max_queues * sizeof(uint32_t),
-				RTE_CACHE_LINE_SIZE, socket_id);
+				RTE_CACHE_LINE_SIZE, numa_id);
 	if (d->tail_ptrs == NULL) {
 		rte_bbdev_log(ERR, "Failed to allocate tail ptr for %s:%u",
 				dev->device->driver->name,
@@ -719,7 +719,7 @@ vrb_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int socket_id)
 	}
 
 	if (d->harq_layout == NULL)
-		d->harq_layout = rte_zmalloc_socket("HARQ Layout",
+		d->harq_layout = rte_zmalloc_numa("HARQ Layout",
 				ACC_HARQ_LAYOUT * sizeof(*d->harq_layout),
 				RTE_CACHE_LINE_SIZE, dev->data->numa_id);
 	if (d->harq_layout == NULL) {
@@ -970,8 +970,8 @@ vrb_queue_setup(struct rte_bbdev *dev, uint16_t queue_id,
 		return -ENODEV;
 	}
 	/* Allocate the queue data structure. */
-	q = rte_zmalloc_socket(dev->device->driver->name, sizeof(*q),
-			RTE_CACHE_LINE_SIZE, conf->socket);
+	q = rte_zmalloc_numa(dev->device->driver->name, sizeof(*q),
+			RTE_CACHE_LINE_SIZE, conf->numa_id);
 	if (q == NULL) {
 		rte_bbdev_log(ERR, "Failed to allocate queue memory");
 		return -ENOMEM;
@@ -1046,27 +1046,27 @@ vrb_queue_setup(struct rte_bbdev *dev, uint16_t queue_id,
 		desc->req.fcw_ld.gain_h = 1;
 	}
 
-	q->lb_in = rte_zmalloc_socket(dev->device->driver->name,
+	q->lb_in = rte_zmalloc_numa(dev->device->driver->name,
 			RTE_CACHE_LINE_SIZE,
-			RTE_CACHE_LINE_SIZE, conf->socket);
+			RTE_CACHE_LINE_SIZE, conf->numa_id);
 	if (q->lb_in == NULL) {
 		rte_bbdev_log(ERR, "Failed to allocate lb_in memory");
 		ret = -ENOMEM;
 		goto free_q;
 	}
 	q->lb_in_addr_iova = rte_malloc_virt2iova(q->lb_in);
-	q->lb_out = rte_zmalloc_socket(dev->device->driver->name,
+	q->lb_out = rte_zmalloc_numa(dev->device->driver->name,
 			RTE_CACHE_LINE_SIZE,
-			RTE_CACHE_LINE_SIZE, conf->socket);
+			RTE_CACHE_LINE_SIZE, conf->numa_id);
 	if (q->lb_out == NULL) {
 		rte_bbdev_log(ERR, "Failed to allocate lb_out memory");
 		ret = -ENOMEM;
 		goto free_lb_in;
 	}
 	q->lb_out_addr_iova = rte_malloc_virt2iova(q->lb_out);
-	q->companion_ring_addr = rte_zmalloc_socket(dev->device->driver->name,
+	q->companion_ring_addr = rte_zmalloc_numa(dev->device->driver->name,
 			d->sw_ring_max_depth * sizeof(*q->companion_ring_addr),
-			RTE_CACHE_LINE_SIZE, conf->socket);
+			RTE_CACHE_LINE_SIZE, conf->numa_id);
 	if (q->companion_ring_addr == NULL) {
 		rte_bbdev_log(ERR, "Failed to allocate companion_ring memory");
 		ret = -ENOMEM;
@@ -1095,9 +1095,9 @@ vrb_queue_setup(struct rte_bbdev *dev, uint16_t queue_id,
 		goto free_companion_ring_addr;
 	}
 
-	q->fcw_ring = rte_zmalloc_socket(dev->device->driver->name,
+	q->fcw_ring = rte_zmalloc_numa(dev->device->driver->name,
 			ACC_MAX_FCW_SIZE * d->sw_ring_max_depth,
-			RTE_CACHE_LINE_SIZE, conf->socket);
+			RTE_CACHE_LINE_SIZE, conf->numa_id);
 	if (q->fcw_ring == NULL) {
 		rte_bbdev_log(ERR, "Failed to allocate fcw_ring memory");
 		ret = -ENOMEM;
@@ -4421,7 +4421,7 @@ static int vrb_pci_probe(struct rte_pci_driver *pci_drv,
 		return -ENODEV;
 
 	/* allocate device private memory. */
-	bbdev->data->dev_private = rte_zmalloc_socket(dev_name,
+	bbdev->data->dev_private = rte_zmalloc_numa(dev_name,
 			sizeof(struct acc_device), RTE_CACHE_LINE_SIZE,
 			pci_dev->device.numa_node);
 
-- 
2.55.0

