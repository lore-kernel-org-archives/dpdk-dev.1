Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACEE606B267
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tMXasl70
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0391427A0;
	Tue,  3 Nov 2026 16:08:56 +0100 (CET)
Received: from mta0.migadu.com (out-145.mta0.migadu.com [91.218.175.145])
 by mails.dpdk.org (Postfix) with ESMTPS id 06F2D40616
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:08:56 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=VsnVcsuZ/9pnLqR4rtye/fZ4eYnzsGyQIsCWhEzuoZU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718535; v=1; x=1794323335;
 b=tMXasl70FB2CMwUseFDC6c5VsDx0u+kXKO1nf/GyvwZY1ywiHpRiwNfffJhjDjlFpIRQYHsz
 ZDByzQ4hL5r/X/LcZDtuv3VTJ1wn0iwknQrDDn+EEPQI5NZcnJOcEKWJXCBEVZ08EvpSAd6p3gI
 u+9RWLEVsehx17LZaftG6bkc=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 9ace68ab10627369;
 Tue, 03 Nov 2026 15:08:55 +0000
X-Mizu-Trace-ID: 9ace68ab10627369
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 098/227] event/sw: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:56 +0800
Message-ID: <20261103145306.487255-99-chengwen.feng@linux.dev>
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
 drivers/event/sw/event_ring.h        |  4 ++--
 drivers/event/sw/sw_evdev.c          | 26 +++++++++++++-------------
 drivers/event/sw/sw_evdev_selftest.c |  2 +-
 drivers/event/sw/sw_evdev_xstats.c   |  2 +-
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/event/sw/event_ring.h b/drivers/event/sw/event_ring.h
index 35931888dd..bb12697720 100644
--- a/drivers/event/sw/event_ring.h
+++ b/drivers/event/sw/event_ring.h
@@ -31,14 +31,14 @@ struct rob_ring {
 };
 
 static inline struct rob_ring *
-rob_ring_create(unsigned int size, unsigned int socket_id)
+rob_ring_create(unsigned int size, unsigned int numa_id)
 {
 	struct rob_ring *retval;
 	const uint32_t ring_size = rte_align32pow2(size + 1);
 	size_t memsize = sizeof(*retval) +
 			(ring_size * sizeof(retval->ring[0]));
 
-	retval = rte_zmalloc_socket(NULL, memsize, 0, socket_id);
+	retval = rte_zmalloc_numa(NULL, memsize, 0, numa_id);
 	if (retval == NULL)
 		goto end;
 	retval->ring_size = ring_size;
diff --git a/drivers/event/sw/sw_evdev.c b/drivers/event/sw/sw_evdev.c
index d6bc23a220..b2dc61142a 100644
--- a/drivers/event/sw/sw_evdev.c
+++ b/drivers/event/sw/sw_evdev.c
@@ -237,7 +237,7 @@ qid_init(struct sw_evdev *sw, unsigned int idx, int type,
 		const struct rte_event_queue_conf *queue_conf)
 {
 	unsigned int i;
-	int socket_id = sw->data->numa_id;
+	int numa_id = sw->data->numa_id;
 	struct sw_qid *qid = &sw->qids[idx];
 
 	/* Initialize the FID structures to no pinning (-1), and zero packets */
@@ -267,9 +267,9 @@ qid_init(struct sw_evdev *sw, unsigned int idx, int type,
 			goto cleanup;
 		}
 
-		qid->reorder_buffer = rte_zmalloc_socket(NULL,
+		qid->reorder_buffer = rte_zmalloc_numa(NULL,
 				window_size * sizeof(qid->reorder_buffer[0]),
-				0, socket_id);
+				0, numa_id);
 		if (!qid->reorder_buffer) {
 			SW_LOG_DBG("reorder_buffer malloc failed");
 			goto cleanup;
@@ -280,7 +280,7 @@ qid_init(struct sw_evdev *sw, unsigned int idx, int type,
 		       window_size * sizeof(qid->reorder_buffer[0]));
 
 		qid->reorder_buffer_freelist = rob_ring_create(window_size,
-				socket_id);
+				numa_id);
 		if (!qid->reorder_buffer_freelist) {
 			SW_LOG_DBG("freelist ring create failed");
 			goto cleanup;
@@ -533,7 +533,7 @@ sw_dev_configure(const struct rte_eventdev *dev)
 	 */
 	rte_free(sw->chunks);
 
-	sw->chunks = rte_malloc_socket(NULL,
+	sw->chunks = rte_malloc_numa(NULL,
 				       sizeof(struct sw_queue_chunk) *
 				       num_chunks,
 				       0,
@@ -886,9 +886,9 @@ sw_close(struct rte_eventdev *dev)
 static int
 assign_numa_node(const char *key __rte_unused, const char *value, void *opaque)
 {
-	int *socket_id = opaque;
-	*socket_id = atoi(value);
-	if (*socket_id >= RTE_MAX_NUMA_NODES)
+	int *numa_id = opaque;
+	*numa_id = atoi(value);
+	if (*numa_id >= RTE_MAX_NUMA_NODES)
 		return -1;
 	return 0;
 }
@@ -997,7 +997,7 @@ sw_probe(struct rte_vdev_device *vdev)
 	const char *params;
 	struct rte_eventdev *dev;
 	struct sw_evdev *sw;
-	int socket_id = rte_socket_id();
+	int numa_id = rte_numa_id();
 	int sched_quanta  = SW_DEFAULT_SCHED_QUANTA;
 	int credit_quanta = SW_DEFAULT_CREDIT_QUANTA;
 	int min_burst_size = 1;
@@ -1015,7 +1015,7 @@ sw_probe(struct rte_vdev_device *vdev)
 				name);
 		} else {
 			int ret = rte_kvargs_process(kvlist, NUMA_NODE_ARG,
-					assign_numa_node, &socket_id);
+					assign_numa_node, &numa_id);
 			if (ret != 0) {
 				SW_LOG_ERR(
 					"%s: Error parsing numa node parameter",
@@ -1082,11 +1082,11 @@ sw_probe(struct rte_vdev_device *vdev)
 			"Creating eventdev sw device %s, numa_node=%d, "
 			"sched_quanta=%d, credit_quanta=%d "
 			"min_burst=%d, deq_burst=%d, refill_once=%d",
-			name, socket_id, sched_quanta, credit_quanta,
+			name, numa_id, sched_quanta, credit_quanta,
 			min_burst_size, deq_burst_size, refill_once);
 
 	dev = rte_event_pmd_vdev_init(name,
-			sizeof(struct sw_evdev), socket_id, vdev);
+			sizeof(struct sw_evdev), numa_id, vdev);
 	if (dev == NULL) {
 		SW_LOG_ERR("eventdev vdev init() failed");
 		return -EFAULT;
@@ -1116,7 +1116,7 @@ sw_probe(struct rte_vdev_device *vdev)
 	snprintf(service.name, sizeof(service.name), "%s_service", name);
 	snprintf(sw->service_name, sizeof(sw->service_name), "%s_service",
 			name);
-	service.socket_id = socket_id;
+	service.socket_id = numa_id;
 	service.callback = sw_sched_service_func;
 	service.callback_userdata = (void *)dev;
 
diff --git a/drivers/event/sw/sw_evdev_selftest.c b/drivers/event/sw/sw_evdev_selftest.c
index a2ce14051c..979ec28a72 100644
--- a/drivers/event/sw/sw_evdev_selftest.c
+++ b/drivers/event/sw/sw_evdev_selftest.c
@@ -3351,7 +3351,7 @@ test_sw_eventdev(void)
 				32 /*MBUF_CACHE_SIZE*/,
 				0,
 				512, /* use very small mbufs */
-				rte_socket_id());
+				rte_numa_id());
 		if (!eventdev_func_mempool) {
 			printf("ERROR creating mempool\n");
 			goto test_fail;
diff --git a/drivers/event/sw/sw_evdev_xstats.c b/drivers/event/sw/sw_evdev_xstats.c
index 611a7ce94a..bd558d5cdf 100644
--- a/drivers/event/sw/sw_evdev_xstats.c
+++ b/drivers/event/sw/sw_evdev_xstats.c
@@ -261,7 +261,7 @@ sw_xstats_init(struct sw_evdev *sw)
 				RTE_DIM(qid_port_stats);
 	unsigned int i, port, qid, iq, bkt, stat = 0;
 
-	sw->xstats = rte_zmalloc_socket(NULL, sizeof(sw->xstats[0]) * count, 0,
+	sw->xstats = rte_zmalloc_numa(NULL, sizeof(sw->xstats[0]) * count, 0,
 			sw->data->numa_id);
 	if (sw->xstats == NULL)
 		return -ENOMEM;
-- 
2.55.0

