Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AD7C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 19:37:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A115740661;
	Wed, 26 Mar 2025 20:36:59 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C3E7A40652
 for <dev@dpdk.org>; Wed, 26 Mar 2025 20:36:57 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QI7nGm007583
 for <dev@dpdk.org>; Wed, 26 Mar 2025 12:36:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=n
 VNs0k8Y5NZ9pkJb70ZABhxky5P39qmOBfL+Peb6wuo=; b=Qq3bZPlVM05Dpcnmj
 kmdNaJtLSFSGM5f/alsCWUKbajv+wv03fzgqgRpaP08Zfp7dEg2SK+azFsrh9Mha
 3+Xfln0JYzoJPSO5Q862Ipr9YNMonf2fRWWpwjXAohT90z3yK+HmgFOUQbRLvoRX
 7f79ENcgaf8O0L2LuNCJ8lL42087zj/rFmnMcdoVLQgCTIDq2HexDKb/myOu9zkX
 BafqN4ZI++69tCXVUmkDhSJBcIcOHcM9oE3DWwDBYIQpNG4IAleX4sqmBBSMDL0+
 fG96Zd7GQMymkZcfsvV5XT9DalMmri+4HCNagCtVagY7K8W8o5u6gR0k8ik6Gx16
 0YkBQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45meyk1d88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 26 Mar 2025 12:36:56 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 26 Mar 2025 12:36:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Mar 2025 12:36:55 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 332605C68F3;
 Wed, 26 Mar 2025 12:36:52 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Amit Prakash Shukla <amitprakashs@marvell.com>,
 Vamsi Attunuru <vattunuru@marvell.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [RFC v2 3/3] eventdev: refactor DMA adapter ops
Date: Thu, 27 Mar 2025 01:06:36 +0530
Message-ID: <20250326193637.12557-4-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326193637.12557-1-pbhagavatula@marvell.com>
References: <20250129143649.3887989-1-kshankar@marvell.com>
 <20250326193637.12557-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=G+wcE8k5 c=1 sm=1 tr=0 ts=67e45758 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=HSV2A0hCgou1vQeWYFIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: lrJIyTEVzhFOm0FyiJKulqWfcYC4fYwY
X-Proofpoint-GUID: lrJIyTEVzhFOm0FyiJKulqWfcYC4fYwY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Migrate all invocations of rte_event_dma_adapter_op
API to rte_dma_op.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
Acked-by: Amit Prakash Shukla <amitprakashs@marvell.com>
---
 app/test-eventdev/test_perf_common.c          |  6 +-
 app/test-eventdev/test_perf_common.h          |  4 +-
 app/test/test_event_dma_adapter.c             |  6 +-
 .../prog_guide/eventdev/event_dma_adapter.rst |  6 +-
 drivers/dma/cnxk/cnxk_dmadev.c                |  2 +-
 drivers/dma/cnxk/cnxk_dmadev_fp.c             | 12 ++--
 lib/eventdev/rte_event_dma_adapter.c          | 18 +++---
 lib/eventdev/rte_event_dma_adapter.h          | 57 -------------------
 8 files changed, 27 insertions(+), 84 deletions(-)

diff --git a/app/test-eventdev/test_perf_common.c b/app/test-eventdev/test_perf_common.c
index 627f07caa1..4e0109db52 100644
--- a/app/test-eventdev/test_perf_common.c
+++ b/app/test-eventdev/test_perf_common.c
@@ -562,11 +562,11 @@ crypto_adapter_enq_op_fwd(struct prod_data *p)
 static inline void
 dma_adapter_enq_op_fwd(struct prod_data *p)
 {
-	struct rte_event_dma_adapter_op *ops[BURST_SIZE] = {NULL};
+	struct rte_dma_op *ops[BURST_SIZE] = {NULL};
 	struct test_perf *t = p->t;
 	const uint32_t nb_flows = t->nb_flows;
 	const uint64_t nb_pkts = t->nb_pkts;
-	struct rte_event_dma_adapter_op op;
+	struct rte_dma_op op;
 	struct rte_event evts[BURST_SIZE];
 	const uint8_t dev_id = p->dev_id;
 	struct evt_options *opt = t->opt;
@@ -2114,7 +2114,7 @@ perf_mempool_setup(struct evt_test *test, struct evt_options *opt)
 	} else if (opt->prod_type == EVT_PROD_TYPE_EVENT_DMA_ADPTR) {
 		t->pool = rte_mempool_create(test->name,   /* mempool name */
 					     opt->pool_sz, /* number of elements*/
-					     sizeof(struct rte_event_dma_adapter_op) +
+					     sizeof(struct rte_dma_op) +
 						     (sizeof(struct rte_dma_sge) * 2),
 					     cache_sz,		       /* cache size*/
 					     0, NULL, NULL, NULL,      /* obj constructor */
diff --git a/app/test-eventdev/test_perf_common.h b/app/test-eventdev/test_perf_common.h
index d7333ad390..63078b0ee2 100644
--- a/app/test-eventdev/test_perf_common.h
+++ b/app/test-eventdev/test_perf_common.h
@@ -139,7 +139,7 @@ perf_mark_fwd_latency(enum evt_prod_type prod_type, struct rte_event *const ev)
 		}
 		pe->timestamp = rte_get_timer_cycles();
 	} else if (prod_type == EVT_PROD_TYPE_EVENT_DMA_ADPTR) {
-		struct rte_event_dma_adapter_op *op = ev->event_ptr;
+		struct rte_dma_op *op = ev->event_ptr;
 
 		op->user_meta = rte_get_timer_cycles();
 	} else {
@@ -297,7 +297,7 @@ perf_process_last_stage_latency(struct rte_mempool *const pool, enum evt_prod_ty
 		tstamp = pe->timestamp;
 		rte_crypto_op_free(op);
 	} else if (prod_type == EVT_PROD_TYPE_EVENT_DMA_ADPTR) {
-		struct rte_event_dma_adapter_op *op = ev->event_ptr;
+		struct rte_dma_op *op = ev->event_ptr;
 
 		to_free_in_bulk = op;
 		tstamp = op->user_meta;
diff --git a/app/test/test_event_dma_adapter.c b/app/test/test_event_dma_adapter.c
index 9988d4fc7b..7f72a4e81d 100644
--- a/app/test/test_event_dma_adapter.c
+++ b/app/test/test_event_dma_adapter.c
@@ -234,7 +234,7 @@ test_op_forward_mode(void)
 {
 	struct rte_mbuf *src_mbuf[TEST_MAX_OP];
 	struct rte_mbuf *dst_mbuf[TEST_MAX_OP];
-	struct rte_event_dma_adapter_op *op;
+	struct rte_dma_op *op;
 	struct rte_event ev[TEST_MAX_OP];
 	int ret, i;
 
@@ -266,7 +266,7 @@ test_op_forward_mode(void)
 		op->vchan = TEST_DMA_VCHAN_ID;
 		op->event_meta = dma_response_info.event;
 
-		/* Fill in event info and update event_ptr with rte_event_dma_adapter_op */
+		/* Fill in event info and update event_ptr with rte_dma_op */
 		memset(&ev[i], 0, sizeof(struct rte_event));
 		ev[i].event = 0;
 		ev[i].op = RTE_EVENT_OP_NEW;
@@ -396,7 +396,7 @@ configure_dmadev(void)
 						       rte_socket_id());
 	RTE_TEST_ASSERT_NOT_NULL(params.dst_mbuf_pool, "Can't create DMA_DST_MBUFPOOL\n");
 
-	elt_size = sizeof(struct rte_event_dma_adapter_op) + (sizeof(struct rte_dma_sge) * 2);
+	elt_size = sizeof(struct rte_dma_op) + (sizeof(struct rte_dma_sge) * 2);
 	params.op_mpool = rte_mempool_create("EVENT_DMA_OP_POOL", DMA_OP_POOL_SIZE, elt_size, 0,
 					     0, NULL, NULL, NULL, NULL, rte_socket_id(), 0);
 	RTE_TEST_ASSERT_NOT_NULL(params.op_mpool, "Can't create DMA_OP_POOL\n");
diff --git a/doc/guides/prog_guide/eventdev/event_dma_adapter.rst b/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
index e040d89e8b..e8437a3297 100644
--- a/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
@@ -144,7 +144,7 @@ on which it enqueues events towards the DMA adapter using ``rte_event_enqueue_bu
    uint32_t cap;
    int ret;
 
-   /* Fill in event info and update event_ptr with rte_event_dma_adapter_op */
+   /* Fill in event info and update event_ptr with rte_dma_op */
    memset(&ev, 0, sizeof(ev));
    .
    .
@@ -244,11 +244,11 @@ Set event response information
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 In the ``RTE_EVENT_DMA_ADAPTER_OP_FORWARD`` / ``RTE_EVENT_DMA_ADAPTER_OP_NEW`` mode,
-the application specifies the dmadev ID and vchan ID in ``struct rte_event_dma_adapter_op``
+the application specifies the dmadev ID and vchan ID in ``struct rte_dma_op``
 and the event information (response information)
 needed to enqueue an event after the DMA operation has completed.
 The response information is specified in ``struct rte_event``
-and appended to the ``struct rte_event_dma_adapter_op``.
+and appended to the ``struct rte_dma_op``.
 
 
 Start the adapter instance
diff --git a/drivers/dma/cnxk/cnxk_dmadev.c b/drivers/dma/cnxk/cnxk_dmadev.c
index 1ce3563250..e4e8042497 100644
--- a/drivers/dma/cnxk/cnxk_dmadev.c
+++ b/drivers/dma/cnxk/cnxk_dmadev.c
@@ -611,7 +611,7 @@ cnxk_dmadev_probe(struct rte_pci_driver *pci_drv __rte_unused, struct rte_pci_de
 	rdpi = &dpivf->rdpi;
 
 	rdpi->pci_dev = pci_dev;
-	rc = roc_dpi_dev_init(rdpi, offsetof(struct rte_event_dma_adapter_op, impl_opaque));
+	rc = roc_dpi_dev_init(rdpi, offsetof(struct rte_dma_op, impl_opaque));
 	if (rc < 0)
 		goto err_out_free;
 
diff --git a/drivers/dma/cnxk/cnxk_dmadev_fp.c b/drivers/dma/cnxk/cnxk_dmadev_fp.c
index 419425c386..89dbb7324c 100644
--- a/drivers/dma/cnxk/cnxk_dmadev_fp.c
+++ b/drivers/dma/cnxk/cnxk_dmadev_fp.c
@@ -449,7 +449,7 @@ uint16_t
 cn10k_dma_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 {
 	const struct rte_dma_sge *src, *dst;
-	struct rte_event_dma_adapter_op *op;
+	struct rte_dma_op *op;
 	struct cnxk_dpi_conf *dpi_conf;
 	struct cnxk_dpi_vf_s *dpivf;
 	struct cn10k_sso_hws *work;
@@ -508,7 +508,7 @@ uint16_t
 cn9k_dma_adapter_dual_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 {
 	const struct rte_dma_sge *fptr, *lptr;
-	struct rte_event_dma_adapter_op *op;
+	struct rte_dma_op *op;
 	struct cn9k_sso_hws_dual *work;
 	struct cnxk_dpi_conf *dpi_conf;
 	struct cnxk_dpi_vf_s *dpivf;
@@ -524,7 +524,7 @@ cn9k_dma_adapter_dual_enqueue(void *ws, struct rte_event ev[], uint16_t nb_event
 	for (count = 0; count < nb_events; count++) {
 		op = ev[count].event_ptr;
 		rsp_info = (struct rte_event *)((uint8_t *)op +
-						sizeof(struct rte_event_dma_adapter_op));
+						sizeof(struct rte_dma_op));
 		dpivf = rte_dma_fp_objs[op->dma_dev_id].dev_private;
 		dpi_conf = &dpivf->conf[op->vchan];
 
@@ -578,7 +578,7 @@ uint16_t
 cn9k_dma_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 {
 	const struct rte_dma_sge *fptr, *lptr;
-	struct rte_event_dma_adapter_op *op;
+	struct rte_dma_op *op;
 	struct cnxk_dpi_conf *dpi_conf;
 	struct cnxk_dpi_vf_s *dpivf;
 	struct cn9k_sso_hws *work;
@@ -644,11 +644,11 @@ cn9k_dma_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 uintptr_t
 cnxk_dma_adapter_dequeue(uintptr_t get_work1)
 {
-	struct rte_event_dma_adapter_op *op;
+	struct rte_dma_op *op;
 	struct cnxk_dpi_conf *dpi_conf;
 	struct cnxk_dpi_vf_s *dpivf;
 
-	op = (struct rte_event_dma_adapter_op *)get_work1;
+	op = (struct rte_dma_op *)get_work1;
 	dpivf = rte_dma_fp_objs[op->dma_dev_id].dev_private;
 	dpi_conf = &dpivf->conf[op->vchan];
 
diff --git a/lib/eventdev/rte_event_dma_adapter.c b/lib/eventdev/rte_event_dma_adapter.c
index d9a02a30f2..76c65ab788 100644
--- a/lib/eventdev/rte_event_dma_adapter.c
+++ b/lib/eventdev/rte_event_dma_adapter.c
@@ -39,8 +39,8 @@ struct __rte_cache_aligned dma_ops_circular_buffer {
 	/* Size of circular buffer */
 	uint16_t size;
 
-	/* Pointer to hold rte_event_dma_adapter_op for processing */
-	struct rte_event_dma_adapter_op **op_buffer;
+	/* Pointer to hold rte_dma_op for processing */
+	struct rte_dma_op **op_buffer;
 };
 
 /* Vchan information */
@@ -201,7 +201,7 @@ edma_circular_buffer_space_for_batch(struct dma_ops_circular_buffer *bufp)
 static inline int
 edma_circular_buffer_init(const char *name, struct dma_ops_circular_buffer *buf, uint16_t sz)
 {
-	buf->op_buffer = rte_zmalloc(name, sizeof(struct rte_event_dma_adapter_op *) * sz, 0);
+	buf->op_buffer = rte_zmalloc(name, sizeof(struct rte_dma_op *) * sz, 0);
 	if (buf->op_buffer == NULL)
 		return -ENOMEM;
 
@@ -217,7 +217,7 @@ edma_circular_buffer_free(struct dma_ops_circular_buffer *buf)
 }
 
 static inline int
-edma_circular_buffer_add(struct dma_ops_circular_buffer *bufp, struct rte_event_dma_adapter_op *op)
+edma_circular_buffer_add(struct dma_ops_circular_buffer *bufp, struct rte_dma_op *op)
 {
 	uint16_t *tail = &bufp->tail;
 
@@ -235,7 +235,7 @@ edma_circular_buffer_flush_to_dma_dev(struct event_dma_adapter *adapter,
 				      struct dma_ops_circular_buffer *bufp, uint8_t dma_dev_id,
 				      uint16_t vchan, uint16_t *nb_ops_flushed)
 {
-	struct rte_event_dma_adapter_op *op;
+	struct rte_dma_op *op;
 	uint16_t *head = &bufp->head;
 	uint16_t *tail = &bufp->tail;
 	struct dma_vchan_info *tq;
@@ -498,7 +498,7 @@ edma_enq_to_dma_dev(struct event_dma_adapter *adapter, struct rte_event *ev, uns
 {
 	struct rte_event_dma_adapter_stats *stats = &adapter->dma_stats;
 	struct dma_vchan_info *vchan_qinfo = NULL;
-	struct rte_event_dma_adapter_op *dma_op;
+	struct rte_dma_op *dma_op;
 	uint16_t vchan, nb_enqueued = 0;
 	int16_t dma_dev_id;
 	unsigned int i, n;
@@ -641,7 +641,7 @@ edma_adapter_enq_run(struct event_dma_adapter *adapter, unsigned int max_enq)
 #define DMA_ADAPTER_MAX_EV_ENQ_RETRIES 100
 
 static inline uint16_t
-edma_ops_enqueue_burst(struct event_dma_adapter *adapter, struct rte_event_dma_adapter_op **ops,
+edma_ops_enqueue_burst(struct event_dma_adapter *adapter, struct rte_dma_op **ops,
 		       uint16_t num)
 {
 	struct rte_event_dma_adapter_stats *stats = &adapter->dma_stats;
@@ -687,7 +687,7 @@ edma_circular_buffer_flush_to_evdev(struct event_dma_adapter *adapter,
 				    struct dma_ops_circular_buffer *bufp,
 				    uint16_t *enqueue_count)
 {
-	struct rte_event_dma_adapter_op **ops = bufp->op_buffer;
+	struct rte_dma_op **ops = bufp->op_buffer;
 	uint16_t n = 0, nb_ops_flushed;
 	uint16_t *head = &bufp->head;
 	uint16_t *tail = &bufp->tail;
@@ -736,7 +736,7 @@ edma_adapter_deq_run(struct event_dma_adapter *adapter, unsigned int max_deq)
 	struct rte_event_dma_adapter_stats *stats = &adapter->dma_stats;
 	struct dma_vchan_info *vchan_info;
 	struct dma_ops_circular_buffer *tq_buf;
-	struct rte_event_dma_adapter_op *ops;
+	struct rte_dma_op *ops;
 	uint16_t n, nb_deq, nb_enqueued, i;
 	struct dma_device_info *dev_info;
 	uint16_t vchan, num_vchan;
diff --git a/lib/eventdev/rte_event_dma_adapter.h b/lib/eventdev/rte_event_dma_adapter.h
index 5c480b82ff..453754d13b 100644
--- a/lib/eventdev/rte_event_dma_adapter.h
+++ b/lib/eventdev/rte_event_dma_adapter.h
@@ -151,63 +151,6 @@
 extern "C" {
 #endif
 
-/**
- * A structure used to hold event based DMA operation entry. All the information
- * required for a DMA transfer shall be populated in "struct rte_event_dma_adapter_op"
- * instance.
- */
-struct rte_event_dma_adapter_op {
-	uint64_t flags;
-	/**< Flags related to the operation.
-	 * @see RTE_DMA_OP_FLAG_*
-	 */
-	struct rte_mempool *op_mp;
-	/**< Mempool from which op is allocated. */
-	enum rte_dma_status_code status;
-	/**< Status code for this operation. */
-	uint32_t rsvd;
-	/**< Reserved for future use. */
-	uint64_t impl_opaque[2];
-	/**< Implementation-specific opaque data.
-	 * An dma device implementation use this field to hold
-	 * implementation specific values to share between dequeue and enqueue
-	 * operations.
-	 * The application should not modify this field.
-	 */
-	uint64_t user_meta;
-	/**<  Memory to store user specific metadata.
-	 * The dma device implementation should not modify this area.
-	 */
-	uint64_t event_meta;
-	/**< Event metadata of DMA completion event.
-	 * Used when RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND is not
-	 * supported in OP_NEW mode.
-	 * @see rte_event_dma_adapter_mode::RTE_EVENT_DMA_ADAPTER_OP_NEW
-	 * @see RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND
-	 *
-	 * Used when RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_OP_FWD is not
-	 * supported in OP_FWD mode.
-	 * @see rte_event_dma_adapter_mode::RTE_EVENT_DMA_ADAPTER_OP_FORWARD
-	 * @see RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_OP_FWD
-	 *
-	 * @see struct rte_event::event
-	 */
-	int16_t dma_dev_id;
-	/**< DMA device ID to be used with OP_FORWARD mode.
-	 * @see rte_event_dma_adapter_mode::RTE_EVENT_DMA_ADAPTER_OP_FORWARD
-	 */
-	uint16_t vchan;
-	/**< DMA vchan ID to be used with OP_FORWARD mode
-	 * @see rte_event_dma_adapter_mode::RTE_EVENT_DMA_ADAPTER_OP_FORWARD
-	 */
-	uint16_t nb_src;
-	/**< Number of source segments. */
-	uint16_t nb_dst;
-	/**< Number of destination segments. */
-	struct rte_dma_sge src_dst_seg[];
-	/**< Source and destination segments. */
-};
-
 /**
  *  DMA event adapter mode
  */
-- 
2.43.0

