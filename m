Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54212CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:12:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A9E44065C;
	Fri, 10 Oct 2025 00:12:08 +0200 (CEST)
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com
 [209.85.166.97]) by mails.dpdk.org (Postfix) with ESMTP id 7058F40654
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:12:06 +0200 (CEST)
Received: by mail-io1-f97.google.com with SMTP id
 ca18e2360f4ac-92aee734485so59034439f.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760047926; x=1760652726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xy8fyI5PwrU/pq00OAq0TWPhL0atJCWcLPoRZgDf7Os=;
 b=DstoN/NGFqd3SKHFzIyHEB1DN88ff21Z6FPiR9k8ng4HRKdORh4aV8BDpM7+M3d20g
 L5R6mh9kqmaAFZAJm48g97bhiKihiAbb42YbS/OmPYDCrvniGHLQdJQEChLndBkoHd8c
 0AbX3UH6AZij9gIbc2u0RDzMl4DVtNMkzOPDOGK/+WJIyZbR+1+chMbgaZl3dV0W4wtr
 rfeuwGmzWtKc6AmWPWdo3dK/qXYHpV1Cq+VsJX7beRBktWUpCMTY2hw4tu0tO0VzR1tE
 lZgTSjesexEX3BzfNxeU/AEmW/kQfv7QNXsVM/oyjXphdE92w3WnN1Z1cA0TnUPqa1qB
 K0YA==
X-Gm-Message-State: AOJu0YzcXtTi3oJQNs5K2/9vX27xIVwuU0z+Oy8b0IMEu7xJ8JamGum1
 2YI+YnF6CtQcIy/tfAXaPPkWQDNPGSPyG/D2JUFg4HP+j4dQgwpxyP32+pVhAhnbnLKGc9L+i5d
 SncZEV1JGZ68yFmv1vsGdQAz0GT7UShjXSY0Uf9XHfzj1wjOKMIRco0oRizUpM6PaSvK/1w4ZjC
 ZzV6wpW6m/vRGaDmVMT4ZkDLsL37BHuWTUCGy45OM5tNbZ0u1NcaavCh2l/31i3KG3b/EJVA==
X-Gm-Gg: ASbGncu7lgnC3Sljx3SjIkqNzyq26zZYMkGxaFHRAmSleKM42gT2z8NQGJg2gFnNSD7
 43VEI6YFCjw6t5u19P+PHwvIUr1Dgub867Z9F3Dz0/p1r3GyjsPDGMiiBlebsKFYflT0Qb91tzX
 +XYF71FB5b1UxDKN/CrozfE2cHW0zCfS73e+6BOiwfqnewc3w4wool4DiFTwHM1v83GJZdIFMxh
 cnNQExOCkUrkZ/rqoseoS7DvyJAskpyOuN0+cv5EJCxdro4Jjt2PVsEZGLBs74L2TcK7ku2O7Dk
 SznjRRU18513WuVCwfxpJ+YkPaoCeje8T5GI98a445o4yMpALYt0Qe1fd3gdlsMGRVf+Buvceut
 tzbJVkLfKBJxOAyb1KRxbL0k04k6kp/JvQW/2E1apUwcXXyL2Rd5Uw/6+2Hur4VNgUFUmSrtIa5
 UovREqUDA=
X-Google-Smtp-Source: AGHT+IFNawO3fGczL1rFcbDu9pGpWOF5f8l5PXncxq6cUF8oQrcRjKNMYyf6cgMpbAWgp1s8QCS5qCIourMj
X-Received: by 2002:a05:6e02:1849:b0:429:6c5a:61f3 with SMTP id
 e9e14a558f8ab-42f87373153mr78215855ab.8.1760047925079; 
 Thu, 09 Oct 2025 15:12:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-58f71469592sm48764173.31.2025.10.09.15.12.03
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:12:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-797ab35807eso62299946d6.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760047922; x=1760652722; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xy8fyI5PwrU/pq00OAq0TWPhL0atJCWcLPoRZgDf7Os=;
 b=E9VTSv0llNQwXRT38L2nr0y2b6b6w0SURFgzwiul2innsDAimAAutzC5bkN6MxFu5B
 bjn0BTKE39t7X1grDb2Lfaoy5+Rwe0hv932oOf2kifk5JdKASWDHU7U0fKHamScofIQn
 Y2DW3Y9MjKUzE62IWmby75MPC8LTDBhAGWzK0=
X-Received: by 2002:a05:6214:b6d:b0:7f7:708e:4797 with SMTP id
 6a1803df08f44-87b2100104bmr123789196d6.12.1760047922319; 
 Thu, 09 Oct 2025 15:12:02 -0700 (PDT)
X-Received: by 2002:a05:6214:b6d:b0:7f7:708e:4797 with SMTP id
 6a1803df08f44-87b2100104bmr123788596d6.12.1760047921552; 
 Thu, 09 Oct 2025 15:12:01 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.12.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:12:01 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 Michael Baucom <michael.baucom@broadcom.com>
Subject: [PATCH v2 04/54] net/bnxt/tf_ulp: add meter stats support for Thor2
Date: Thu,  9 Oct 2025 18:10:39 -0400
Message-Id: <20251009221129.28256-5-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Jay Ding <jay.ding@broadcom.com>

A CFA stats counter is created with each meter by default but is
only activated when the meter is attached to a non-tunnel flow
because the tunnel flow may use the stats pointer for other purpose.

Only the green and red/drop packet/byte stats are supported.

Signed-off-by: Jay Ding <jay.ding@broadcom.com>
Reviewed-by: Michael Baucom <michael.baucom@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c | 45 ++++++++++++-----
 drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c     | 46 +++++++++++++++++
 drivers/net/bnxt/tf_ulp/ulp_fc_mgr.h     | 11 +++++
 drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tf.c  |  3 +-
 drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c | 63 ++++++++++++++++++++----
 drivers/net/bnxt/tf_ulp/ulp_flow_db.h    |  6 +++
 drivers/net/bnxt/tf_ulp/ulp_mapper.c     |  9 ----
 drivers/net/bnxt/tf_ulp/ulp_mapper.h     | 24 +++++++++
 drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c  |  5 +-
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c | 54 +++++++++++++++++++-
 10 files changed, 234 insertions(+), 32 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
index 591bde96e8..bc48e35c00 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
@@ -42,7 +42,6 @@
  * Meter init status
  */
 int bnxt_mtr_initialized;
-
 int32_t
 bnxt_flow_mtr_init(struct bnxt *bp __rte_unused)
 {
@@ -542,6 +541,7 @@ bnxt_flow_mtr_destroy(struct rte_eth_dev *dev,
 	uint16_t func_id;
 	int ret;
 	uint32_t tmp_mtr_id;
+	const struct ulp_mapper_core_ops *oper;
 
 	if (!bnxt_mtr_initialized)
 		return -rte_mtr_error_set(error, ENOTSUP,
@@ -750,17 +750,40 @@ bnxt_flow_mtr_stats_update(struct rte_eth_dev *dev __rte_unused,
  * Read meter statistics.
  */
 static int
-bnxt_flow_mtr_stats_read(struct rte_eth_dev *dev __rte_unused,
-			   uint32_t mtr_id __rte_unused,
-			   struct rte_mtr_stats *stats __rte_unused,
-			   uint64_t *stats_mask __rte_unused,
-			   int clear __rte_unused,
-			   struct rte_mtr_error *error)
+bnxt_flow_mtr_stats_read(struct rte_eth_dev *dev,
+			 uint32_t mtr_id,
+			 struct rte_mtr_stats *stats,
+			 uint64_t *stats_mask,
+			 int clear,
+			 struct rte_mtr_error *error)
 {
-	return -rte_mtr_error_set(error, ENOTSUP,
-				  RTE_MTR_ERROR_TYPE_UNSPECIFIED,
-				  NULL,
-				  "Meter_stats_read not supported yet");
+	int rc = 0;
+	struct bnxt_ulp_context *ulp_ctx;
+
+	ulp_ctx = bnxt_ulp_eth_dev_ptr2_cntxt_get(dev);
+	if (unlikely(!ulp_ctx)) {
+		BNXT_DRV_DBG(ERR, "ULP context is not initialized\n");
+		goto error;
+	}
+
+	memset(stats, 0, sizeof(*stats));
+	rc = ulp_mtr_query_count_get(ulp_ctx, mtr_id, clear, stats);
+	if (unlikely(rc))
+		goto error;
+
+	*stats_mask = 0;
+	*stats_mask |= RTE_MTR_STATS_N_PKTS_GREEN;
+	*stats_mask |= RTE_MTR_STATS_N_PKTS_RED;
+	*stats_mask |= RTE_MTR_STATS_N_PKTS_DROPPED;
+	*stats_mask |= RTE_MTR_STATS_N_BYTES_GREEN;
+	*stats_mask |= RTE_MTR_STATS_N_BYTES_RED;
+	*stats_mask |= RTE_MTR_STATS_N_BYTES_DROPPED;
+
+	return rc;
+error:
+	return -rte_mtr_error_set(error, EINVAL,
+				  RTE_MTR_ERROR_TYPE_STATS, NULL,
+				  "Failed to query meter.");
 }
 
 static const struct rte_mtr_ops bnxt_flow_mtr_ops = {
diff --git a/drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c
index f9d069f4e1..4be2703740 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c
@@ -627,6 +627,52 @@ int ulp_fc_mgr_query_count_get(struct bnxt_ulp_context *ctxt,
 	return rc;
 }
 
+/*
+ * Fill the rte_mtr_stats 'mtr_count' argument passed
+ * in the rte_mtr_stats_read() with the values obtained
+ * through CFA table get.
+ *
+ * ctxt [in] The ulp context for the flow counter manager
+ *
+ * mtr_id [in] The SW meter ID
+ *
+ * count [out] The rte_mtr_stats 'mtr_count' that is set
+ *
+ */
+int ulp_mtr_query_count_get(struct bnxt_ulp_context *ctxt,
+			    uint32_t mtr_id,
+			    int clear,
+			    struct rte_mtr_stats *mtr_count)
+{
+	int rc = 0;
+	struct bnxt_ulp_fc_info *ulp_fc_info;
+	const struct bnxt_ulp_fc_core_ops *fc_ops;
+	struct ulp_flow_db_res_params params;
+	uint32_t session_type = 0;
+	uint8_t dir = 0;
+	const struct ulp_mapper_core_ops *oper;
+
+	ulp_fc_info = bnxt_ulp_cntxt_ptr2_fc_info_get(ctxt);
+	if (!ulp_fc_info)
+		return -ENODEV;
+
+	oper = ulp_mapper_data_oper_get(ctxt);
+	if (!oper)
+		return -ENODEV;
+	rc = oper->ulp_mapper_mtr_stats_hndl_get(mtr_id, &params.resource_hndl);
+	if (rc)
+		return rc;
+
+	fc_ops = ulp_fc_info->fc_ops;
+	if (!fc_ops || !fc_ops->ulp_mtr_stat_get)
+		return -ENODEV;
+
+	rc = fc_ops->ulp_mtr_stat_get(ctxt, dir, session_type,
+				      params.resource_hndl, clear, mtr_count);
+
+	return rc;
+}
+
 /*
  * Set the parent flow if it is SW accumulation counter entry.
  *
diff --git a/drivers/net/bnxt/tf_ulp/ulp_fc_mgr.h b/drivers/net/bnxt/tf_ulp/ulp_fc_mgr.h
index 0b81be7af9..d80d2e4e9d 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_fc_mgr.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_fc_mgr.h
@@ -36,6 +36,13 @@ struct bnxt_ulp_fc_core_ops {
 	(*ulp_flow_stats_accum_update)(struct bnxt_ulp_context *ctxt,
 				       struct bnxt_ulp_fc_info *ulp_fc_info,
 				       struct bnxt_ulp_device_params *dparms);
+	int32_t
+	(*ulp_mtr_stat_get)(struct bnxt_ulp_context *ctxt,
+			    uint8_t direction,
+			    uint32_t session_type,
+			    uint64_t handle,
+			    int32_t clear,
+			    struct rte_mtr_stats *mtr_count);
 };
 
 struct sw_acc_counter {
@@ -186,6 +193,10 @@ bool ulp_fc_mgr_thread_isstarted(struct bnxt_ulp_context *ctxt);
 int ulp_fc_mgr_query_count_get(struct bnxt_ulp_context *ulp_ctx,
 			       uint32_t flow_id,
 			       struct rte_flow_query_count *count);
+int ulp_mtr_query_count_get(struct bnxt_ulp_context *ulp_ctx,
+			    uint32_t mtr_id,
+			    int clear,
+			    struct rte_mtr_stats *count);
 
 /*
  * Set the parent flow if in the SW accumulator table entry
diff --git a/drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tf.c b/drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tf.c
index 60a7073514..65737f0cde 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tf.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tf.c
@@ -255,5 +255,6 @@ ulp_fc_tf_flow_stat_get(struct bnxt_ulp_context *ctxt,
 
 const struct bnxt_ulp_fc_core_ops ulp_fc_tf_core_ops = {
 	.ulp_flow_stat_get = ulp_fc_tf_flow_stat_get,
-	.ulp_flow_stats_accum_update = ulp_fc_tf_update_accum_stats
+	.ulp_flow_stats_accum_update = ulp_fc_tf_update_accum_stats,
+	.ulp_mtr_stat_get = NULL,
 };
diff --git a/drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c
index 4a1d0bf3df..d1b374e603 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c
@@ -26,6 +26,8 @@
  */
 #define ULP_FC_TFC_PKT_CNT_OFFS 0
 #define ULP_FC_TFC_BYTE_CNT_OFFS 1
+#define ULP_FC_TFC_PKT_MTR_DROP_CNT_OFFS 2
+#define ULP_FC_TFC_BYTE_MTR_DROP_CNT_OFFS 3
 #define ULP_TFC_CNTR_READ_BYTES 32
 #define ULP_TFC_CNTR_ALIGN 32
 #define ULP_TFC_ACT_WORD_SZ 32
@@ -56,11 +58,12 @@ static uint8_t *data;
 static uint64_t virt2iova_data;
 
 static int32_t
-ulp_fc_tfc_flow_stat_get(struct bnxt_ulp_context *ctxt,
-			 uint8_t direction,
-			 uint32_t session_type __rte_unused,
-			 uint64_t handle,
-			 struct rte_flow_query_count *count)
+ulp_fc_tfc_stat_get(struct bnxt_ulp_context *ctxt,
+		    uint8_t direction,
+		    uint32_t session_type __rte_unused,
+		    uint64_t handle,
+		    struct rte_flow_query_count *count,
+		    struct rte_mtr_stats *mtr_drop_count)
 {
 	uint16_t data_size = ULP_TFC_CNTR_READ_BYTES;
 	struct tfc_cmm_clr cmm_clr = { 0 };
@@ -102,11 +105,15 @@ ulp_fc_tfc_flow_stat_get(struct bnxt_ulp_context *ctxt,
 	cmm_info.act_handle = handle;
 	cmm_info.dir = (enum cfa_dir)direction;
 	/* Read and Clear the hw stat if requested */
-	if (count->reset) {
+	if (count && count->reset) {
 		cmm_clr.clr = true;
 		cmm_clr.offset_in_byte = 0;
 		cmm_clr.sz_in_byte = sizeof(data64[ULP_FC_TFC_PKT_CNT_OFFS]) +
 			sizeof(data64[ULP_FC_TFC_BYTE_CNT_OFFS]);
+		if (mtr_drop_count) {
+			cmm_clr.sz_in_byte += sizeof(data64[ULP_FC_TFC_PKT_MTR_DROP_CNT_OFFS]);
+			cmm_clr.sz_in_byte += sizeof(data64[ULP_FC_TFC_BYTE_MTR_DROP_CNT_OFFS]);
+		}
 	}
 	rc = tfc_act_get(tfcp, NULL, &cmm_info, &cmm_clr, &virt2iova_data, &word_size);
 	if (rc) {
@@ -115,19 +122,57 @@ ulp_fc_tfc_flow_stat_get(struct bnxt_ulp_context *ctxt,
 			     handle);
 		return rc;
 	}
-	if (data64[ULP_FC_TFC_PKT_CNT_OFFS]) {
+	if (count && data64[ULP_FC_TFC_PKT_CNT_OFFS]) {
 		count->hits_set = 1;
 		count->hits = data64[ULP_FC_TFC_PKT_CNT_OFFS];
 	}
-	if (data64[ULP_FC_TFC_BYTE_CNT_OFFS]) {
+	if (count && data64[ULP_FC_TFC_BYTE_CNT_OFFS]) {
 		count->bytes_set = 1;
 		count->bytes = data64[ULP_FC_TFC_BYTE_CNT_OFFS];
 	}
 
+	if (mtr_drop_count) {
+		mtr_drop_count->n_pkts[RTE_COLOR_GREEN] = data64[ULP_FC_TFC_PKT_CNT_OFFS];
+		mtr_drop_count->n_bytes[RTE_COLOR_GREEN] = data64[ULP_FC_TFC_BYTE_CNT_OFFS];
+		mtr_drop_count->n_pkts_dropped = data64[ULP_FC_TFC_PKT_MTR_DROP_CNT_OFFS];
+		mtr_drop_count->n_pkts[RTE_COLOR_RED] = data64[ULP_FC_TFC_PKT_MTR_DROP_CNT_OFFS];
+		mtr_drop_count->n_bytes_dropped = data64[ULP_FC_TFC_BYTE_MTR_DROP_CNT_OFFS];
+		mtr_drop_count->n_bytes[RTE_COLOR_RED] = data64[ULP_FC_TFC_BYTE_MTR_DROP_CNT_OFFS];
+	}
+
 	return rc;
 }
 
+static int32_t
+ulp_fc_tfc_flow_stat_get(struct bnxt_ulp_context *ctxt,
+			 uint8_t direction,
+			 uint32_t session_type,
+			 uint64_t handle,
+			 struct rte_flow_query_count *count)
+{
+	return ulp_fc_tfc_stat_get(ctxt, direction, session_type, handle, count, NULL);
+}
+
+static int32_t
+ulp_fc_tfc_mtr_stat_get(struct bnxt_ulp_context *ctxt,
+			uint8_t direction,
+			uint32_t session_type,
+			uint64_t handle,
+			int32_t clear,
+			struct rte_mtr_stats *mtr_count)
+{
+	struct rte_flow_query_count count;
+
+	if (clear)
+		count.reset = 1;
+	else
+		count.reset = 0;
+
+	return ulp_fc_tfc_stat_get(ctxt, direction, session_type, handle, &count, mtr_count);
+}
+
 const struct bnxt_ulp_fc_core_ops ulp_fc_tfc_core_ops = {
 	.ulp_flow_stat_get = ulp_fc_tfc_flow_stat_get,
-	.ulp_flow_stats_accum_update = ulp_fc_tfc_update_accum_stats
+	.ulp_flow_stats_accum_update = ulp_fc_tfc_update_accum_stats,
+	.ulp_mtr_stat_get = ulp_fc_tfc_mtr_stat_get
 };
diff --git a/drivers/net/bnxt/tf_ulp/ulp_flow_db.h b/drivers/net/bnxt/tf_ulp/ulp_flow_db.h
index 4301094cfe..f0a677b64b 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_flow_db.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_flow_db.h
@@ -91,6 +91,12 @@ struct ulp_flow_db_res_params {
 	uint64_t			resource_hndl;
 };
 
+struct bnxt_mtr_stats_id_map {
+	bool valid;
+	uint32_t mtr_id;
+	uint64_t stats_hndl;
+};
+
 /*
  * Initialize the flow database. Memory is allocated in this
  * call and assigned to the flow database.
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper.c b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
index c06d849883..4829ae41d1 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
@@ -71,15 +71,6 @@ bnxt_ulp_mapper_ops_get(struct bnxt *bp)
 	return func_ops;
 }
 
-static const struct ulp_mapper_core_ops *
-ulp_mapper_data_oper_get(struct bnxt_ulp_context *ulp_ctx)
-{
-	struct bnxt_ulp_mapper_data *m_data;
-
-	m_data = (struct bnxt_ulp_mapper_data *)ulp_ctx->cfg_data->mapper_data;
-	return m_data->mapper_oper;
-}
-
 static const char *
 ulp_mapper_tmpl_name_str(enum bnxt_ulp_template_type tmpl_type)
 {
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper.h b/drivers/net/bnxt/tf_ulp/ulp_mapper.h
index d1dec6c2bd..f9a407cd84 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper.h
@@ -170,8 +170,26 @@ struct ulp_mapper_core_ops {
 	int
 	(*ulp_mapper_mpc_batch_end)(struct tfc *tfcp,
 				    struct tfc_mpc_batch_info_t *batch_info);
+
+	int32_t
+	(*ulp_mapper_mtr_stats_hndl_set)(struct bnxt_ulp_mapper_parms *parms,
+					 uint32_t mtr_id,
+					 uint64_t stats_hndl);
+	int32_t
+	(*ulp_mapper_mtr_stats_hndl_get)(uint32_t mtr_id, uint64_t *stats_hndl);
+
+	int
+	(*ulp_mapper_mtr_stats_hndl_del)(uint32_t mtr_id);
 };
 
+static inline const struct ulp_mapper_core_ops *
+ulp_mapper_data_oper_get(struct bnxt_ulp_context *ulp_ctx) {
+	struct bnxt_ulp_mapper_data *m_data;
+
+	m_data = (struct bnxt_ulp_mapper_data *)ulp_ctx->cfg_data->mapper_data;
+	return m_data->mapper_oper;
+}
+
 extern const struct ulp_mapper_core_ops ulp_mapper_tf_core_ops;
 extern const struct ulp_mapper_core_ops ulp_mapper_tfc_core_ops;
 
@@ -302,6 +320,12 @@ ulp_mapper_init(struct bnxt_ulp_context	*ulp_ctx);
 void
 ulp_mapper_deinit(struct bnxt_ulp_context *ulp_ctx);
 
+int
+ulp_mapper_get_mtr_stats_hndl(uint32_t mtr_id, uint64_t *stats_ptr);
+
+int
+ulp_mapper_del_mtr_stats_hndl(uint32_t mtr_id);
+
 #ifdef TF_FLOW_SCALE_QUERY
 int32_t
 ulp_resc_usage_sync(struct bnxt_ulp_context *ulp_ctx);
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
index 53497c164a..e755591716 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
@@ -1385,5 +1385,8 @@ const struct ulp_mapper_core_ops ulp_mapper_tf_core_ops = {
 	.ulp_mapper_core_handle_to_offset = ulp_mapper_tf_handle_to_offset,
 	.ulp_mapper_mpc_batch_started = ulp_mapper_tf_mpc_batch_started,
 	.ulp_mapper_mpc_batch_start = ulp_mapper_tf_mpc_batch_start,
-	.ulp_mapper_mpc_batch_end = ulp_mapper_tf_mpc_batch_end
+	.ulp_mapper_mpc_batch_end = ulp_mapper_tf_mpc_batch_end,
+	.ulp_mapper_mtr_stats_hndl_set = NULL,
+	.ulp_mapper_mtr_stats_hndl_get = NULL,
+	.ulp_mapper_mtr_stats_hndl_del = NULL
 };
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
index cbe9aa01c9..388ebea7ee 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
@@ -1759,6 +1759,55 @@ ulp_mapper_tfc_mpc_batch_start(struct tfc_mpc_batch_info_t *batch_info)
 	return tfc_mpc_batch_start(batch_info);
 }
 
+static int32_t
+ulp_mapper_tfc_mtr_stats_hndl_set(struct bnxt_ulp_mapper_parms *parms __rte_unused,
+				  uint32_t mtr_id, uint64_t stats_hndl)
+{
+	int32_t i, rc = -ENOMEM;
+
+	for (i = 0; i < BNXT_METER_MAX_NUM; i++)
+		if (!mtr_stats[i].valid) {
+			mtr_stats[i].mtr_id = mtr_id;
+			mtr_stats[i].stats_hndl = stats_hndl;
+			mtr_stats[i].valid = true;
+			rc = 0;
+			break;
+		}
+
+	return rc;
+}
+
+static int32_t
+ulp_mapper_tfc_mtr_stats_hndl_get(uint32_t mtr_id, uint64_t *stats_hndl)
+{
+	int32_t i, rc = -EINVAL;
+
+	for (i = 0; i < BNXT_METER_MAX_NUM; i++) {
+		if (mtr_stats[i].valid && mtr_stats[i].mtr_id == mtr_id) {
+			*stats_hndl = mtr_stats[i].stats_hndl;
+			rc = 0;
+			break;
+		}
+	}
+
+	return rc;
+}
+
+static int32_t
+ulp_mapper_tfc_mtr_stats_hndl_del(uint32_t mtr_id)
+{
+	int32_t i, rc = -EINVAL;
+
+	for (i = 0; i < BNXT_METER_MAX_NUM; i++)
+		if (mtr_stats[i].valid && mtr_stats[i].mtr_id == mtr_id) {
+			mtr_stats[i].valid = false;
+			rc = 0;
+			break;
+		}
+
+	return rc;
+}
+
 const struct ulp_mapper_core_ops ulp_mapper_tfc_core_ops = {
 	.ulp_mapper_core_tcam_tbl_process = ulp_mapper_tfc_tcam_tbl_process,
 	.ulp_mapper_core_tcam_entry_free = ulp_mapper_tfc_tcam_entry_free,
@@ -1779,5 +1828,8 @@ const struct ulp_mapper_core_ops ulp_mapper_tfc_core_ops = {
 	.ulp_mapper_core_handle_to_offset = ulp_mapper_tfc_handle_to_offset,
 	.ulp_mapper_mpc_batch_start = ulp_mapper_tfc_mpc_batch_start,
 	.ulp_mapper_mpc_batch_started = ulp_mapper_tfc_mpc_batch_started,
-	.ulp_mapper_mpc_batch_end = ulp_mapper_tfc_mpc_batch_end
+	.ulp_mapper_mpc_batch_end = ulp_mapper_tfc_mpc_batch_end,
+	.ulp_mapper_mtr_stats_hndl_set = ulp_mapper_tfc_mtr_stats_hndl_set,
+	.ulp_mapper_mtr_stats_hndl_get = ulp_mapper_tfc_mtr_stats_hndl_get,
+	.ulp_mapper_mtr_stats_hndl_del = ulp_mapper_tfc_mtr_stats_hndl_del
 };
-- 
2.39.5 (Apple Git-154)

