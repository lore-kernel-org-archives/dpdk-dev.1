Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C963CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:08:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E6A440659;
	Wed, 29 Oct 2025 17:08:17 +0100 (CET)
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com
 [74.125.224.97]) by mails.dpdk.org (Postfix) with ESMTP id AE59E4028F
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:08:15 +0100 (CET)
Received: by mail-yx1-f97.google.com with SMTP id
 956f58d0204a3-63d97bcb898so205003d50.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754095; x=1762358895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xy8fyI5PwrU/pq00OAq0TWPhL0atJCWcLPoRZgDf7Os=;
 b=rhFpFlOZ5UMMW5YOKwUCZHTeEe2dX0TuMVc5kvdiu/a3OAmxAKyZGZD8jsObjTg6ZZ
 UJcCZ+SyqVH5sYDKPWPw05NPuQgEoUqjPzl8b3Sra85v13NdDWHl8YRdvo4ohMRaNjmG
 yRmOiGMZYstuQWshy+eC8LDB9tjX9t4S7zXcw503WbPFSwBajQ/l2CuyJ+D7pl3hg9me
 pb5cIhNdwqzE5uDfJo7gnXeL6tfrxRT729XVPBFDUhcfE+mUt1UyG53Wm43hG+b2qqu+
 BDj/Uq+dMq5GC0SqkagZaqa2RXffigVZytwqTQxsOttWbWGOwXAOfCuOkj1PIpqNWz8V
 W38Q==
X-Gm-Message-State: AOJu0YweyUe1FMJKTGaEIISDhXd1Sy4opM/6ATmC2DDZyzNGAO8DFJWX
 8Nw5LUJbzZk6gaqiUw41TnK1psbqVgfWtUt4cEXToVds1OUzQETJY+B8GLXiH95xh1EZZtqwYId
 ayxNltHbYvM15OAlZYPTFNcP/tyx/Jp6hPc5ppRcQceJP4c1GkpYbhjlYl1ty5GHdQ+M0KPfpMf
 dq/iXHfRwqzthCoVyjCiM+qbRSgaeoSX7wgUD0PEpfr3U3dnEAYq7ebsBGs1AHsg9yJPY9pw==
X-Gm-Gg: ASbGncvBYEOfExUX8MW2IP3APKSLbgEboR0kETm4PVTc6yhTbB3YswYEvaDEEbToyT3
 +S5ucbqFC0U/iBN86fT2JxLVlcRMZce1VsjQllvskzud5tye4dbKjUCQV9SAtt9a/jkAEclhXve
 xlKsTlYDK93Dly3YeB0tM12h9QYWGyN4BivF6diyhNp5myyNBbyfLqSRY0lXwf7ZTjCfDQu9moo
 LePn0AZ+X2Iw8fP3UQ/Fm5KbIGW6XWi45sAVYq/h6iNXoBQPUsQY4I+ZXarQBvkIkmDZEncsbLK
 LScIGC3K/CmHX/8zvlJn2sTwbA5MvD6ebNnPAuD9RCWO/qYVeNYa3rwGItE+ER/sKbO7LOHE81k
 hJlCEvBfqN3v2g+BvdFmEIWOpjG3veOpR/vzCH4EKFLBSSjAX9CW9iTErB+ei4UmPdowAjLm2jj
 QHW9r0oV1Jlcb6I1lVnJFlnZpl7nhjw/jX/Q==
X-Google-Smtp-Source: AGHT+IFgZSp+x4PC2q0fnxQBz04x/3v1qq62zZpI2y8/9QVCEZhZWpmHexgFd1RP8HjjbjRJJA77/Yq8obi6
X-Received: by 2002:a05:690e:4311:b0:63f:471b:c949 with SMTP id
 956f58d0204a3-63f828dc3f4mr94652d50.8.1761754094772; 
 Wed, 29 Oct 2025 09:08:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-785ed1d05e9sm9721237b3.25.2025.10.29.09.08.14
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:08:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8a5b03118f4so290171785a.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754094; x=1762358894; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xy8fyI5PwrU/pq00OAq0TWPhL0atJCWcLPoRZgDf7Os=;
 b=JrhIunjpRQL0/Tmk9XhI7wYjznYUuzqVOtLRGd4ApFGjpealrifcQVMv60I8WG1jVQ
 B7BOsogwxHHEoMMMk18kz3V4mRVQnr4WM+Wbn2KnIxErKRLh9mOfexSkH6O28A2zTXNv
 pBzWFHzPliZncLY3cLdpecfFqQ1d/y6nvDOyM=
X-Received: by 2002:a05:620a:46a2:b0:883:b39f:418e with SMTP id
 af79cd13be357-8aa2bcb1393mr19248985a.33.1761754093515; 
 Wed, 29 Oct 2025 09:08:13 -0700 (PDT)
X-Received: by 2002:a05:620a:46a2:b0:883:b39f:418e with SMTP id
 af79cd13be357-8aa2bcb1393mr19238185a.33.1761754092689; 
 Wed, 29 Oct 2025 09:08:12 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.08.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:08:12 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 Michael Baucom <michael.baucom@broadcom.com>
Subject: [PATCH v5 07/57] net/bnxt/tf_ulp: add meter stats support for Thor2
Date: Wed, 29 Oct 2025 12:06:22 -0400
Message-Id: <20251029160712.58519-8-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

