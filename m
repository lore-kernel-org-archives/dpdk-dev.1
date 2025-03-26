Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E83C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 19:36:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79A1340653;
	Wed, 26 Mar 2025 20:36:54 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8CA26402E3
 for <dev@dpdk.org>; Wed, 26 Mar 2025 20:36:52 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QJQBjs014009;
 Wed, 26 Mar 2025 12:36:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
 FssaA+VueylxnEucnBMRkaOBI3G3XfpWDTCE6yPXFs=; b=DEMdF6noOFaE6CRZn
 6H/IXa60FYQdGWnK+FdC4FaT1XfTT4T2hASXtMNC7GHCFbm0fNCGkCBm5YZpogT/
 kY18dSHDhOwPyBrqS42cYi0ikAvv/dAXxVYZW3xJGR8N6V1Y/qbQTJWp+CMkL4KL
 SRqnxusP7TzJmnZvwxmEeHNoldh6azff7Ba3tqRlXIKw67B7avC6VoQ+RNPCjj+C
 vRWiB8MnDILekAO0wc4bIgYE8po6D8Tzz3W1voKupHIwtmzg6rv9n4LlhBUewEXm
 QuQ0UuL+HKmFHQBNnL9IFwsc2FhDY6oXZ7obl3xo9vVkFJ17ycZGS5C0Ig7OOB3v
 VBOlw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45mqr3g0m4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 12:36:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 26 Mar 2025 12:36:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Mar 2025 12:36:50 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 996C45C68F3;
 Wed, 26 Mar 2025 12:36:48 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [RFC v2 1/3] dmadev: add enqueue dequeue operations
Date: Thu, 27 Mar 2025 01:06:34 +0530
Message-ID: <20250326193637.12557-2-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326193637.12557-1-pbhagavatula@marvell.com>
References: <20250129143649.3887989-1-kshankar@marvell.com>
 <20250326193637.12557-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QmiLLGH-FkaqZ10k-FL8dn8YmhUEg6T1
X-Authority-Analysis: v=2.4 cv=Yeq95xRf c=1 sm=1 tr=0 ts=67e45753 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=KiEi8wMhqeqtjv14xTwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: QmiLLGH-FkaqZ10k-FL8dn8YmhUEg6T1
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

Add enqueue/dequeue operations that use struct rte_dma_op
to communicate with the dma device.
These operations need to be enabled at dma device configuration
time by setting the flag rte_dma_conf::enable_enq_deq if the
device supports RTE_DMA_CAPA_OPS_ENQ_DEQ capability.
The enqueue dequeue operations are not compatible with
rte_dma_copy, rte_dma_copy_sg, rte_dma_fill, rte_dma_submit,
rte_dma_completed, rte_dma_completed_status range of APIs.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 lib/dmadev/rte_dmadev.c              |  18 ++++
 lib/dmadev/rte_dmadev.h              | 145 +++++++++++++++++++++++++++
 lib/dmadev/rte_dmadev_core.h         |  10 ++
 lib/dmadev/rte_dmadev_trace_fp.h     |  20 ++++
 lib/dmadev/rte_dmadev_trace_points.c |   6 ++
 5 files changed, 199 insertions(+)

diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index 4a075ee1c6..a4dc65ac44 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -917,6 +917,22 @@ dummy_burst_capacity(__rte_unused const void *dev_private,
 	return 0;
 }
 
+static uint16_t
+dummy_enqueue(__rte_unused void *dev_private, __rte_unused uint16_t vchan,
+	      __rte_unused struct rte_dma_op **ops, __rte_unused uint16_t nb_ops)
+{
+	RTE_DMA_LOG(ERR, "Enqueue not configured or not supported.");
+	return 0;
+}
+
+static uint16_t
+dummy_dequeue(__rte_unused void *dev_private, __rte_unused uint16_t vchan,
+	      __rte_unused struct rte_dma_op **ops, __rte_unused uint16_t nb_ops)
+{
+	RTE_DMA_LOG(ERR, "Enqueue not configured or not supported.");
+	return 0;
+}
+
 static void
 dma_fp_object_dummy(struct rte_dma_fp_object *obj)
 {
@@ -928,6 +944,8 @@ dma_fp_object_dummy(struct rte_dma_fp_object *obj)
 	obj->completed        = dummy_completed;
 	obj->completed_status = dummy_completed_status;
 	obj->burst_capacity   = dummy_burst_capacity;
+	obj->enqueue          = dummy_enqueue;
+	obj->dequeue          = dummy_dequeue;
 }
 
 static int
diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
index 550dbfbf75..55ea07dccc 100644
--- a/lib/dmadev/rte_dmadev.h
+++ b/lib/dmadev/rte_dmadev.h
@@ -265,6 +265,11 @@ int16_t rte_dma_next_dev(int16_t start_dev_id);
  * known from 'nb_priorities' field in struct rte_dma_info.
  */
 #define RTE_DMA_CAPA_PRI_POLICY_SP	RTE_BIT64(8)
+/** Support enqueue and dequeue operations.
+ *
+ * @see struct rte_dma_op
+ */
+#define RTE_DMA_CAPA_OPS_ENQ_DEQ        RTE_BIT64(9)
 
 /** Support copy operation.
  * This capability start with index of 32, so that it could leave gap between
@@ -351,6 +356,15 @@ struct rte_dma_conf {
 	 * Lowest value indicates higher priority and vice-versa.
 	 */
 	uint16_t priority;
+	/** Indicates whether to use enqueue dequeue operations using rte_dma_op.
+	 * false-default mode, true-enqueue, dequeue mode.
+	 * This value can be set to true only when ENQ_DEQ_OPS capability is
+	 * supported. When enabled, only calls to `rte_dma_enqueue_ops` and
+	 * `rte_dma_dequeue_ops` are valid.
+	 *
+	 * @see RTE_DMA_CAPA_OPS_ENQ_DEQ
+	 */
+	bool enable_enq_deq;
 };
 
 /**
@@ -794,6 +808,63 @@ struct rte_dma_sge {
 	uint32_t length; /**< The DMA operation length. */
 };
 
+/**
+ * A structure used to hold event based DMA operation entry. All the information
+ * required for a DMA transfer shall be populated in "struct rte_dma_op"
+ * instance.
+ */
+struct rte_dma_op {
+	uint64_t flags;
+	/**< Flags related to the operation.
+	 * @see RTE_DMA_OP_FLAG_*
+	 */
+	struct rte_mempool *op_mp;
+	/**< Mempool from which op is allocated. */
+	enum rte_dma_status_code status;
+	/**< Status code for this operation. */
+	uint32_t rsvd;
+	/**< Reserved for future use. */
+	uint64_t impl_opaque[2];
+	/**< Implementation-specific opaque data.
+	 * An dma device implementation use this field to hold
+	 * implementation specific values to share between dequeue and enqueue
+	 * operations.
+	 * The application should not modify this field.
+	 */
+	uint64_t user_meta;
+	/**<  Memory to store user specific metadata.
+	 * The dma device implementation should not modify this area.
+	 */
+	uint64_t event_meta;
+	/**< Event metadata of DMA completion event.
+	 * Used when RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND is not
+	 * supported in OP_NEW mode.
+	 * @see rte_event_dma_adapter_mode::RTE_EVENT_DMA_ADAPTER_OP_NEW
+	 * @see RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND
+	 *
+	 * Used when RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_OP_FWD is not
+	 * supported in OP_FWD mode.
+	 * @see rte_event_dma_adapter_mode::RTE_EVENT_DMA_ADAPTER_OP_FORWARD
+	 * @see RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_OP_FWD
+	 *
+	 * @see struct rte_event::event
+	 */
+	int16_t dma_dev_id;
+	/**< DMA device ID to be used with OP_FORWARD mode.
+	 * @see rte_event_dma_adapter_mode::RTE_EVENT_DMA_ADAPTER_OP_FORWARD
+	 */
+	uint16_t vchan;
+	/**< DMA vchan ID to be used with OP_FORWARD mode
+	 * @see rte_event_dma_adapter_mode::RTE_EVENT_DMA_ADAPTER_OP_FORWARD
+	 */
+	uint16_t nb_src;
+	/**< Number of source segments. */
+	uint16_t nb_dst;
+	/**< Number of destination segments. */
+	struct rte_dma_sge src_dst_seg[0];
+	/**< Source and destination segments. */
+};
+
 #ifdef __cplusplus
 }
 #endif
@@ -1153,6 +1224,80 @@ rte_dma_burst_capacity(int16_t dev_id, uint16_t vchan)
 	return ret;
 }
 
+/**
+ * Enqueue rte_dma_ops to DMA device, can only be used underlying supports
+ * RTE_DMA_CAPA_OPS_ENQ_DEQ and rte_dma_conf::enable_enq_deq is enabled in
+ * rte_dma_configure()
+ * The ops enqueued will be immediately submitted to the DMA device.
+ * The enqueue should be coupled with dequeue to retrieve completed ops, calls
+ * to rte_dma_submit(), rte_dma_completed() and rte_dma_completed_status()
+ * are not valid.
+ *
+ * @param dev_id
+ *   The identifier of the device.
+ * @param vchan
+ *   The identifier of virtual DMA channel.
+ * @param ops
+ *   Pointer to rte_dma_op array.
+ * @param nb_ops
+ *   Number of rte_dma_op in the ops array
+ * @return uint16_t
+ *   - Number of successfully submitted ops.
+ */
+static inline uint16_t
+rte_dma_enqueue_ops(int16_t dev_id, uint16_t vchan, struct rte_dma_op **ops, uint16_t nb_ops)
+{
+	struct rte_dma_fp_object *obj = &rte_dma_fp_objs[dev_id];
+	uint16_t ret;
+
+#ifdef RTE_DMADEV_DEBUG
+	if (!rte_dma_is_valid(dev_id))
+		return 0;
+	if (*obj->enqueue == NULL)
+		return 0;
+#endif
+
+	ret = (*obj->enqueue)(obj->dev_private, vchan, ops, nb_ops);
+	rte_dma_trace_enqueue_ops(dev_id, vchan, (void **)ops, nb_ops);
+
+	return ret;
+}
+
+/**
+ * Dequeue completed rte_dma_ops submitted to the DMA device, can only be used
+ * underlying supports RTE_DMA_CAPA_OPS_ENQ_DEQ and rte_dma_conf::enable_enq_deq
+ * is enabled in rte_dma_configure()
+ *
+ * @param dev_id
+ *   The identifier of the device.
+ * @param vchan
+ *   The identifier of virtual DMA channel.
+ * @param ops
+ *   Pointer to rte_dma_op array.
+ * @param nb_ops
+ *   Size of rte_dma_op array.
+ * @return
+ *   - Number of successfully completed ops. Should be less or equal to nb_ops.
+ */
+static inline uint16_t
+rte_dma_dequeue_ops(int16_t dev_id, uint16_t vchan, struct rte_dma_op **ops, uint16_t nb_ops)
+{
+	struct rte_dma_fp_object *obj = &rte_dma_fp_objs[dev_id];
+	uint16_t ret;
+
+#ifdef RTE_DMADEV_DEBUG
+	if (!rte_dma_is_valid(dev_id))
+		return 0;
+	if (*obj->dequeue == NULL)
+		return 0;
+#endif
+
+	ret = (*obj->dequeue)(obj->dev_private, vchan, ops, nb_ops);
+	rte_dma_trace_dequeue_ops(dev_id, vchan, (void **)ops, nb_ops);
+
+	return ret;
+}
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/dmadev/rte_dmadev_core.h b/lib/dmadev/rte_dmadev_core.h
index 29f52514d7..20a467178f 100644
--- a/lib/dmadev/rte_dmadev_core.h
+++ b/lib/dmadev/rte_dmadev_core.h
@@ -50,6 +50,14 @@ typedef uint16_t (*rte_dma_completed_status_t)(void *dev_private,
 /** @internal Used to check the remaining space in descriptor ring. */
 typedef uint16_t (*rte_dma_burst_capacity_t)(const void *dev_private, uint16_t vchan);
 
+/** @internal Used to enqueue a rte_dma_op to the dma engine. */
+typedef uint16_t (*rte_dma_enqueue_ops_t)(void *dev_private, uint16_t vchan,
+					  struct rte_dma_op **ops, uint16_t nb_ops);
+
+/** @internal Used to dequeue rte_dma_op from the dma engine. */
+typedef uint16_t (*rte_dma_dequeue_ops_t)(void *dev_private, uint16_t vchan,
+					  struct rte_dma_op **ops, uint16_t nb_ops);
+
 /**
  * @internal
  * Fast-path dmadev functions and related data are hold in a flat array.
@@ -73,6 +81,8 @@ struct __rte_cache_aligned rte_dma_fp_object {
 	rte_dma_completed_t        completed;
 	rte_dma_completed_status_t completed_status;
 	rte_dma_burst_capacity_t   burst_capacity;
+	rte_dma_enqueue_ops_t      enqueue;
+	rte_dma_dequeue_ops_t      dequeue;
 };
 
 extern struct rte_dma_fp_object *rte_dma_fp_objs;
diff --git a/lib/dmadev/rte_dmadev_trace_fp.h b/lib/dmadev/rte_dmadev_trace_fp.h
index a1374e78b7..3db655fa65 100644
--- a/lib/dmadev/rte_dmadev_trace_fp.h
+++ b/lib/dmadev/rte_dmadev_trace_fp.h
@@ -125,6 +125,26 @@ RTE_TRACE_POINT_FP(
 	rte_trace_point_emit_u16(ret);
 )
 
+RTE_TRACE_POINT_FP(
+	rte_dma_trace_enqueue_ops,
+	RTE_TRACE_POINT_ARGS(int16_t dev_id, uint16_t vchan, void **ops,
+			     uint16_t nb_ops),
+	rte_trace_point_emit_i16(dev_id);
+	rte_trace_point_emit_u16(vchan);
+	rte_trace_point_emit_ptr(ops);
+	rte_trace_point_emit_u16(nb_ops);
+)
+
+RTE_TRACE_POINT_FP(
+	rte_dma_trace_dequeue_ops,
+	RTE_TRACE_POINT_ARGS(int16_t dev_id, uint16_t vchan, void **ops,
+			     uint16_t nb_ops),
+	rte_trace_point_emit_i16(dev_id);
+	rte_trace_point_emit_u16(vchan);
+	rte_trace_point_emit_ptr(ops);
+	rte_trace_point_emit_u16(nb_ops);
+)
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/dmadev/rte_dmadev_trace_points.c b/lib/dmadev/rte_dmadev_trace_points.c
index 4c74356346..60a0de95d1 100644
--- a/lib/dmadev/rte_dmadev_trace_points.c
+++ b/lib/dmadev/rte_dmadev_trace_points.c
@@ -56,3 +56,9 @@ RTE_TRACE_POINT_REGISTER(rte_dma_trace_completed_status,
 
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_burst_capacity,
 	lib.dmadev.burst_capacity)
+
+RTE_TRACE_POINT_REGISTER(rte_dma_trace_enqueue_ops,
+	lib.dmadev.enqueue_ops)
+
+RTE_TRACE_POINT_REGISTER(rte_dma_trace_dequeue_ops,
+	lib.dmadev.dequeue_ops)
-- 
2.43.0

