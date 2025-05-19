Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE098C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 18:56:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2728240668;
	Mon, 19 May 2025 20:56:27 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 19C5A40612
 for <dev@dpdk.org>; Mon, 19 May 2025 20:56:24 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JIXk76004682;
 Mon, 19 May 2025 11:56:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
 gPgzjEZUay9aJ86i/GGuDPJp4NkHKCPe0LwButBRzo=; b=P9y9LaS5ZjonUfU/S
 C5YOt/ryWN66h+Ml8CzpVPqkDivqAnqveJyT71GWr6BbpgB7L5orxGJP0MrbJXo7
 Vee14wxgkNmtCYlg4xjElmnQtWxkik8CRqe3DUFSiDibsa2XYGXpcr1QHw5XSxBm
 D0oGuqUHH0r59bibbWMnMnWYBxxdzVQWe+5DcctARBk74odVDSontkC2eBq8yiZi
 tFf1F08lMs52j7tUJeSnu1+lXRPXIl/oxGnMnvLewDmTlsP2q0wv2TczOEmAUotV
 dPqj/AR+jgQgsLHbf/umeCKkzwJJt6ECfWnPtGPPbMmkv8LxGVx4vcakU9kvxJtl
 7ThkQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46q46fb6da-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 11:56:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 19 May 2025 11:56:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 19 May 2025 11:56:21 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 35C543F7093;
 Mon, 19 May 2025 11:56:15 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Gagandeep Singh <g.singh@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
CC: <vattunuru@marvell.com>, <conor.walsh@intel.com>,
 <gmuthukrishn@marvell.com>, <vvelumuri@marvell.com>,
 <anatoly.burakov@intel.com>, <dev@dpdk.org>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>
Subject: [25.11 PATCH v2 1/5] dmadev: add enqueue dequeue operations
Date: Tue, 20 May 2025 00:26:00 +0530
Message-ID: <20250519185604.5584-2-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519185604.5584-1-pbhagavatula@marvell.com>
References: <20250416100931.6544-1-pbhagavatula@marvell.com>
 <20250519185604.5584-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=b8uy4sGx c=1 sm=1 tr=0 ts=682b7ed6 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=FitHa1sVEmefr55vNzcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 3Ot4MYAiz9F3xUm85ZT6X2wYYEsWd6vw
X-Proofpoint-ORIG-GUID: 3Ot4MYAiz9F3xUm85ZT6X2wYYEsWd6vw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE3NiBTYWx0ZWRfXw/x+SpZI9oIg
 +DKfwp7aBSPw7Mfb/NuwKdQwsJGW32o7NmbVxEVKtmfbgVFBegtFKEv3KasWxFILhjEdW7Ao3nB
 SNuacPWW3xik3N0EoP5dyiCAoP+8fz1KNk2cp0fHdZ8ZAHbDa4AHp/qHb1FeQfP+amKRRTvf0uq
 L//rk0rK2UxQNZlGuqbhQy7MaAp4k9NPvqf8QE1Q2F5sELwziuPyT0ITmgsDWlWlp+bTpbbb7El
 zn+0fVDpcjeEvLMy9a+EHgJbi00XCPOj5g5zJZX7FfDma0TDjj4TDnqZWI3prFHLJhaDDvIkZsy
 04HTSAHQrDW3Qt1KQsxv0BCKn+ZBhy61m8tEZiEE4S6GMkvcltt7JH2FRpcbOk1tFlDjwaQMXe7
 99GCgXiTmWstXqtCBfMaCPuLB9ZwN5D0/htXYMDdSEnXv4W2phGi+p1rc7VOpwmSsFecLLl6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
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
to communicate with the DMA device.

These operations need to be enabled at DMA device configuration
time by setting the flag rte_dma_conf::enable_enq_deq if the
device supports RTE_DMA_CAPA_OPS_ENQ_DEQ capability.

When the DMA device is configured with RTE_DMA_CFG_FLAG_ENQ_DEQ
flag, the enqueue/dequeue operations should be used to perform
DMA operations.
All other operations i.e., rte_dma_copy, rte_dma_copy_sg,
rte_dma_fill, rte_dma_submit, rte_dma_completed,
rte_dma_completed_status are not supported.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 app/test/test_dmadev_api.c           |   2 +-
 doc/guides/prog_guide/dmadev.rst     |  34 ++++++
 drivers/dma/dpaa/dpaa_qdma.c         |   2 +-
 drivers/dma/dpaa2/dpaa2_qdma.c       |   2 +-
 lib/dmadev/rte_dmadev.c              |  30 +++++-
 lib/dmadev/rte_dmadev.h              | 155 +++++++++++++++++++++++++--
 lib/dmadev/rte_dmadev_core.h         |  10 ++
 lib/dmadev/rte_dmadev_trace.h        |   2 +-
 lib/dmadev/rte_dmadev_trace_fp.h     |  20 ++++
 lib/dmadev/rte_dmadev_trace_points.c |   6 ++
 10 files changed, 249 insertions(+), 14 deletions(-)

diff --git a/app/test/test_dmadev_api.c b/app/test/test_dmadev_api.c
index fb49fcb56b..1ae85a9a29 100644
--- a/app/test/test_dmadev_api.c
+++ b/app/test/test_dmadev_api.c
@@ -159,7 +159,7 @@ test_dma_configure(void)
 	/* Check enable silent mode */
 	memset(&conf, 0, sizeof(conf));
 	conf.nb_vchans = info.max_vchans;
-	conf.enable_silent = true;
+	conf.flags = RTE_DMA_CFG_FLAG_SILENT;
 	ret = rte_dma_configure(test_dev_id, &conf);
 	RTE_TEST_ASSERT(ret == -EINVAL, "Expected -EINVAL, %d", ret);
 
diff --git a/doc/guides/prog_guide/dmadev.rst b/doc/guides/prog_guide/dmadev.rst
index 67a62ff420..11b20cc3d6 100644
--- a/doc/guides/prog_guide/dmadev.rst
+++ b/doc/guides/prog_guide/dmadev.rst
@@ -108,6 +108,40 @@ completed operations along with the status of each operation (filled into the
 completed operation's ``ring_idx`` which could help user track operations within
 their own application-defined rings.
 
+Alternatively, if the DMA device supports enqueue and dequeue operations, as
+indicated by ``RTE_DMA_CAPA_OPS_ENQ_DEQ`` capability in ``rte_dma_info::dev_capa``,
+the application can utilize the ``rte_dma_enqueue_ops`` and ``rte_dma_dequeue_ops``
+APIs.
+To enable this, the DMA device must be configured in operations mode by setting
+``RTE_DMA_CFG_FLAG_ENQ_DEQ`` flag in ``rte_dma_config::flags``.
+
+The following example demonstrates the usage of enqueue and dequeue operations:
+
+.. code-block:: C
+
+   struct rte_dma_op *op;
+
+   op = rte_zmalloc(sizeof(struct rte_dma_op) + (sizeof(struct rte_dma_sge) * 2), 0);
+
+   op->src_dst_seg[0].addr = src_addr;
+   op->src_dst_seg[0].length = src_len;
+   op->src_dst_seg[1].addr = dst_addr;
+   op->src_dst_seg[1].length = dst_len;
+
+
+   ret = rte_dma_enqueue_ops(dev_id, &op, 1);
+   if (ret < 0) {
+       PRINT_ERR("Failed to enqueue DMA op\n");
+       return -1;
+   }
+
+   op = NULL;
+   ret = rte_dma_dequeue_ops(dev_id, &op, 1);
+   if (ret < 0) {
+       PRINT_ERR("Failed to dequeue DMA op\n");
+       return -1;
+   }
+
 
 Querying Device Statistics
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/drivers/dma/dpaa/dpaa_qdma.c b/drivers/dma/dpaa/dpaa_qdma.c
index a541398e48..74e23d2ee5 100644
--- a/drivers/dma/dpaa/dpaa_qdma.c
+++ b/drivers/dma/dpaa/dpaa_qdma.c
@@ -954,7 +954,7 @@ dpaa_qdma_configure(struct rte_dma_dev *dmadev,
 {
 	struct fsl_qdma_engine *fsl_qdma = dmadev->data->dev_private;
 
-	fsl_qdma->is_silent = dev_conf->enable_silent;
+	fsl_qdma->is_silent = dev_conf->flags & RTE_DMA_CFG_FLAG_SILENT;
 	return 0;
 }
 
diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index 3c9a7b5485..ca18fe89c5 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -1277,7 +1277,7 @@ dpaa2_qdma_configure(struct rte_dma_dev *dev,
 	}
 
 	qdma_dev->num_vqs = dev_conf->nb_vchans;
-	qdma_dev->is_silent = dev_conf->enable_silent;
+	qdma_dev->is_silent = dev_conf->flags & RTE_DMA_CFG_FLAG_SILENT;
 
 	return 0;
 
diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index 17ee0808a9..73d24f8ff3 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -509,7 +509,7 @@ rte_dma_configure(int16_t dev_id, const struct rte_dma_conf *dev_conf)
 			"Device %d configure too many vchans", dev_id);
 		return -EINVAL;
 	}
-	if (dev_conf->enable_silent &&
+	if ((dev_conf->flags & RTE_DMA_CFG_FLAG_SILENT) &&
 	    !(dev_info.dev_capa & RTE_DMA_CAPA_SILENT)) {
 		RTE_DMA_LOG(ERR, "Device %d don't support silent", dev_id);
 		return -EINVAL;
@@ -521,6 +521,12 @@ rte_dma_configure(int16_t dev_id, const struct rte_dma_conf *dev_conf)
 		return -EINVAL;
 	}
 
+	if ((dev_conf->flags & RTE_DMA_CFG_FLAG_ENQ_DEQ) &&
+	    !(dev_info.dev_capa & RTE_DMA_CAPA_OPS_ENQ_DEQ)) {
+		RTE_DMA_LOG(ERR, "Device %d don't support enqueue/dequeue", dev_id);
+		return -EINVAL;
+	}
+
 	if (dev->dev_ops->dev_configure == NULL)
 		return -ENOTSUP;
 	ret = dev->dev_ops->dev_configure(dev, dev_conf, sizeof(struct rte_dma_conf));
@@ -863,7 +869,9 @@ rte_dma_dump(int16_t dev_id, FILE *f)
 	(void)fprintf(f, "  max_vchans_supported: %u\n", dev_info.max_vchans);
 	(void)fprintf(f, "  nb_vchans_configured: %u\n", dev_info.nb_vchans);
 	(void)fprintf(f, "  silent_mode: %s\n",
-		dev->data->dev_conf.enable_silent ? "on" : "off");
+		      dev->data->dev_conf.flags & RTE_DMA_CFG_FLAG_SILENT ? "on" : "off");
+	(void)fprintf(f, "  ops_mode: %s\n",
+		      dev->data->dev_conf.flags & RTE_DMA_CFG_FLAG_ENQ_DEQ ? "on" : "off");
 
 	if (dev->dev_ops->dev_dump != NULL)
 		ret = dev->dev_ops->dev_dump(dev, f);
@@ -937,6 +945,22 @@ dummy_burst_capacity(__rte_unused const void *dev_private,
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
@@ -948,6 +972,8 @@ dma_fp_object_dummy(struct rte_dma_fp_object *obj)
 	obj->completed        = dummy_completed;
 	obj->completed_status = dummy_completed_status;
 	obj->burst_capacity   = dummy_burst_capacity;
+	obj->enqueue          = dummy_enqueue;
+	obj->dequeue          = dummy_dequeue;
 }
 
 static int
diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
index 550dbfbf75..d88424d699 100644
--- a/lib/dmadev/rte_dmadev.h
+++ b/lib/dmadev/rte_dmadev.h
@@ -275,8 +275,22 @@ int16_t rte_dma_next_dev(int16_t start_dev_id);
 #define RTE_DMA_CAPA_OPS_COPY_SG	RTE_BIT64(33)
 /** Support fill operation. */
 #define RTE_DMA_CAPA_OPS_FILL		RTE_BIT64(34)
+/** Support enqueue and dequeue operations. */
+#define RTE_DMA_CAPA_OPS_ENQ_DEQ	RTE_BIT64(35)
 /**@}*/
 
+/** DMA device configuration flags.
+ * @see struct rte_dma_conf::flags
+ */
+/** Operate in silent mode
+ * @see RTE_DMA_CAPA_SILENT
+ */
+#define RTE_DMA_CFG_FLAG_SILENT RTE_BIT64(0)
+/** Enable enqueue and dequeue operations
+ * @see RTE_DMA_CAPA_OPS_ENQ_DEQ
+ */
+#define RTE_DMA_CFG_FLAG_ENQ_DEQ RTE_BIT64(1)
+
 /**
  * A structure used to retrieve the information of a DMA device.
  *
@@ -335,14 +349,6 @@ struct rte_dma_conf {
 	 * rte_dma_info which get from rte_dma_info_get().
 	 */
 	uint16_t nb_vchans;
-	/** Indicates whether to enable silent mode.
-	 * false-default mode, true-silent mode.
-	 * This value can be set to true only when the SILENT capability is
-	 * supported.
-	 *
-	 * @see RTE_DMA_CAPA_SILENT
-	 */
-	bool enable_silent;
 	/* The priority of the DMA device.
 	 * This value should be lower than the field 'nb_priorities' of struct
 	 * rte_dma_info which get from rte_dma_info_get(). If the DMA device
@@ -351,6 +357,8 @@ struct rte_dma_conf {
 	 * Lowest value indicates higher priority and vice-versa.
 	 */
 	uint16_t priority;
+	/** DMA device configuration flags defined as RTE_DMA_CFG_FLAG_*. */
+	uint64_t flags;
 };
 
 /**
@@ -794,6 +802,63 @@ struct rte_dma_sge {
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
@@ -1153,6 +1218,80 @@ rte_dma_burst_capacity(int16_t dev_id, uint16_t vchan)
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
diff --git a/lib/dmadev/rte_dmadev_trace.h b/lib/dmadev/rte_dmadev_trace.h
index 1de92655f2..04d9a2741b 100644
--- a/lib/dmadev/rte_dmadev_trace.h
+++ b/lib/dmadev/rte_dmadev_trace.h
@@ -41,7 +41,7 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_u16(dev_conf->nb_vchans);
 	rte_trace_point_emit_u16(dev_conf->priority);
-	rte_trace_point_emit_u8(dev_conf->enable_silent);
+	rte_trace_point_emit_u64(dev_conf->flags);
 	rte_trace_point_emit_int(ret);
 )
 
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
index 1c8998fb98..9a97a44a9c 100644
--- a/lib/dmadev/rte_dmadev_trace_points.c
+++ b/lib/dmadev/rte_dmadev_trace_points.c
@@ -64,3 +64,9 @@ RTE_TRACE_POINT_REGISTER(rte_dma_trace_completed_status,
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_burst_capacity, 24.03)
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

