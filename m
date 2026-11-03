Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7909D606A33E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JPnHNVZk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3811642E4E;
	Tue,  3 Nov 2026 16:07:50 +0100 (CET)
Received: from mta1.migadu.com (out-161.mta1.migadu.com [95.215.58.161])
 by mails.dpdk.org (Postfix) with ESMTPS id 98BAE42E02
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:07:48 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=hfxhDrUtD89c1Im29lcW0FbhUJkumQ6X3Ii7FHwjjqM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718468; v=1; x=1794323268;
 b=JPnHNVZka495GR1uGISorVQgu8SbW537TQUAp/fB5ymcbMtYAoxUtp3UlB99sFuZhAXqx2jx
 yk1EjfKB/r7vIpimV4rVJUxAXMdq3fdeHmztsqtK2Ci9kX+aHpkdbPUIpJVqoaTabBn+q5s5kfk
 O05OB03pN2f3WkuQKHWyhxNo=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id e718b42dfc3a6cfe;
 Tue, 03 Nov 2026 15:07:48 +0000
X-Mizu-Trace-ID: e718b42dfc3a6cfe
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 089/227] dma/skeleton: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:47 +0800
Message-ID: <20261103145306.487255-90-chengwen.feng@linux.dev>
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
 drivers/dma/skeleton/skeleton_dmadev.c | 26 +++++++++++++-------------
 drivers/dma/skeleton/skeleton_dmadev.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/skeleton/skeleton_dmadev.c b/drivers/dma/skeleton/skeleton_dmadev.c
index e287802eb9..05f07fe80a 100644
--- a/drivers/dma/skeleton/skeleton_dmadev.c
+++ b/drivers/dma/skeleton/skeleton_dmadev.c
@@ -235,24 +235,24 @@ vchan_setup(struct skeldma_hw *hw, int16_t dev_id, uint16_t nb_desc)
 	struct rte_ring *completed;
 	uint16_t i;
 
-	desc = rte_zmalloc_socket(NULL, nb_desc * sizeof(struct skeldma_desc),
-				  RTE_CACHE_LINE_SIZE, hw->socket_id);
+	desc = rte_zmalloc_numa(NULL, nb_desc * sizeof(struct skeldma_desc),
+				  RTE_CACHE_LINE_SIZE, hw->numa_id);
 	if (desc == NULL) {
 		SKELDMA_LOG(ERR, "Malloc dma skeleton desc fail!");
 		return -ENOMEM;
 	}
 
 	snprintf(name, RTE_RING_NAMESIZE, "dma_skel_desc_empty_%d", dev_id);
-	empty = rte_ring_create(name, nb_desc, hw->socket_id,
+	empty = rte_ring_create(name, nb_desc, hw->numa_id,
 				RING_F_SP_ENQ | RING_F_SC_DEQ);
 	snprintf(name, RTE_RING_NAMESIZE, "dma_skel_desc_pend_%d", dev_id);
-	pending = rte_ring_create(name, nb_desc, hw->socket_id,
+	pending = rte_ring_create(name, nb_desc, hw->numa_id,
 				  RING_F_SP_ENQ | RING_F_SC_DEQ);
 	snprintf(name, RTE_RING_NAMESIZE, "dma_skel_desc_run_%d", dev_id);
-	running = rte_ring_create(name, nb_desc, hw->socket_id,
+	running = rte_ring_create(name, nb_desc, hw->numa_id,
 				  RING_F_SP_ENQ | RING_F_SC_DEQ);
 	snprintf(name, RTE_RING_NAMESIZE, "dma_skel_desc_comp_%d", dev_id);
-	completed = rte_ring_create(name, nb_desc, hw->socket_id,
+	completed = rte_ring_create(name, nb_desc, hw->numa_id,
 				    RING_F_SP_ENQ | RING_F_SC_DEQ);
 	if (empty == NULL || pending == NULL || running == NULL ||
 	    completed == NULL) {
@@ -380,12 +380,12 @@ skeldma_dump(const struct rte_dma_dev *dev, FILE *f)
 
 	(void)fprintf(f,
 		"    lcore_id: %d\n"
-		"    socket_id: %d\n"
+		"    numa_id: %d\n"
 		"    desc_empty_ring_count: %u\n"
 		"    desc_pending_ring_count: %u\n"
 		"    desc_running_ring_count: %u\n"
 		"    desc_completed_ring_count: %u\n",
-		hw->lcore_id, hw->socket_id,
+		hw->lcore_id, hw->numa_id,
 		GET_RING_COUNT(hw->desc_empty),
 		GET_RING_COUNT(hw->desc_pending),
 		GET_RING_COUNT(hw->desc_running),
@@ -601,11 +601,11 @@ skeldma_create(const char *name, struct rte_vdev_device *vdev, int lcore_id)
 {
 	struct rte_dma_dev *dev;
 	struct skeldma_hw *hw;
-	int socket_id;
+	int numa_id;
 
-	socket_id = (lcore_id < 0) ? rte_socket_id() :
-				     rte_lcore_to_socket_id(lcore_id);
-	dev = rte_dma_pmd_allocate(name, socket_id, sizeof(struct skeldma_hw));
+	numa_id = (lcore_id < 0) ? rte_numa_id() :
+				     rte_lcore_to_numa_id(lcore_id);
+	dev = rte_dma_pmd_allocate(name, numa_id, sizeof(struct skeldma_hw));
 	if (dev == NULL) {
 		SKELDMA_LOG(ERR, "Unable to allocate dmadev: %s", name);
 		return -EINVAL;
@@ -624,7 +624,7 @@ skeldma_create(const char *name, struct rte_vdev_device *vdev, int lcore_id)
 
 	hw = dev->data->dev_private;
 	hw->lcore_id = lcore_id;
-	hw->socket_id = socket_id;
+	hw->numa_id = numa_id;
 
 	dev->state = RTE_DMA_DEV_READY;
 
diff --git a/drivers/dma/skeleton/skeleton_dmadev.h b/drivers/dma/skeleton/skeleton_dmadev.h
index 0365f64589..2fe0547acb 100644
--- a/drivers/dma/skeleton/skeleton_dmadev.h
+++ b/drivers/dma/skeleton/skeleton_dmadev.h
@@ -45,7 +45,7 @@ struct skeldma_desc {
 
 struct skeldma_hw {
 	int lcore_id; /* cpuwork task affinity core */
-	int socket_id;
+	int numa_id;
 	rte_thread_t thread; /* cpuwork task thread */
 	volatile int exit_flag; /* cpuwork task exit flag */
 
-- 
2.55.0

