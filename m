Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C435C982EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:54:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A122640E25;
	Mon, 21 Sep 2026 04:54:55 +0200 (CEST)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by mails.dpdk.org (Postfix) with ESMTP id 97BDE409FA
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:54:54 +0200 (CEST)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso7094595ad.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789959294; x=1790564094;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SE2tCSC393WvPD/bVu49tvkRj8CKcdk13JdD3MpWvic=;
 b=Oiru+VBXNOYejSIV0pXYiCkVjhRjmYBYJFevnCFHCLN82CnrDGPKw7ZF5HOgbIKZUk
 pSF4h9FUCSqjk9pMtLMy2FkLXYWDS8aTmWO7FHvYU1bYyDZ93B6xt3+LO0jeW9DpH9mR
 HSmWaS3C5Hep+M8WGi9z5bysbJJOYVocFadny74GpNVx11R3eYn3MlSr5eTta1yrkxFK
 3twzVvgZsppLWJzyNud3bTxhZ0OpWfwgPz8MZw3tyrNU9hZlVKNFTO7E7Dwiwe3dRIuF
 FdpAF9tXYmMkePYyxVl8l1+pNXWcf/yuRsKb/8nd5sC4F/5JKigo3m+n9bOP1mSV0933
 zAOQ==
X-Gm-Message-State: AFuF++nIaMCx2JTdBw1KeqtmBtGVP9pRGCk91rJ5sQRcbnXL4Gc4VaPr
 5wAdeJS733gM2FIj7f4TOf+YMuOEkMfHxqBHaeE0llwZcKxZpz7xfWcLZ1BgWs4K2p8KSB1o1dz
 AuFOliOB1iNY8xrUz2uhSam3IuYE0AcA0R4qgyyPbxs54zHIHFd3Pjn+/fFcCosj03N1Frm1lec
 v3sgNmvtk1DpgbfRFjwMP4dbq1nz25KeC7qMsvmz2+YHMrcxdvumaKGiIp+WNaHONl/OukDYFef
 Ws8aDsqn6Bt
X-Gm-Gg: AYBFou1eVrYMIn3PguZHZWPR5Jy+DkMAGMFFlFUST8tC7Uky9uss8jitOdwfuQsWFzs
 j/Ahl77WWwPSiyrlHq5L8/6RtZ4JaRs87UyuDjFuljnCxfb3TcBcZbyJnADZ2RN08LwIs6Av8rc
 orybatj3oxJHOGFrobbhI4CsnxcrvfQfyvZFwsCDrN1lbXNL/URuHf5sxY+/lw3Puur9s8YzIug
 yrB08/j2Zz3NE4he0DNW6gzwYO7sfQyWgcSL2R0/Yc0p5fMS6BV+RxYzyYW/2zUSNzUTM2FbJ8C
 zaWKgb9c/H/phznQAZKfy4Zd11zvXhvpSv4ld5qygWO8ZuK72zHJepBO9JF564/lVqD8VoEUJIw
 EH80JYb8YwMeoW/60dMtD8+8OSKptpdu92E5RfmLuKN9cZJM5DoYz53HD5VrQGVYguDlqXw8now
 Mapcd79g1+4GaO3Biz8Se1nlOaB0+tu0cX9zkyXeluFmDrv5saYw==
X-Received: by 2002:a05:6300:8053:b0:3dd:a009:3187 with SMTP id
 adf61e73a8af0-3dda009322emr7754794637.47.1789959293626; 
 Sun, 20 Sep 2026 19:54:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-cc72af2814fsm3214297a12.9.2026.09.20.19.54.53
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:54:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2db3b126c9fso34208295ad.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789959292; x=1790564092; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SE2tCSC393WvPD/bVu49tvkRj8CKcdk13JdD3MpWvic=;
 b=bRkv9ful5dfkDKTUE0kKTPr1JtE0I6ecNGctB6wNoNQEK4Wuxz6119JZoqsZ6U5joi
 jmqJ4clltmJG+gii5IrRD73JAOUdHyms0Gojmy5kLwHp2mRWY0382zzqYvespGC6I0kz
 lO36n5eqYA5WUR9jvoevZF1RABR1wU+omgcYg=
X-Received: by 2002:a17:903:3def:b0:2dd:c100:424d with SMTP id
 d9443c01a7336-2ddc10044b6mr61103695ad.49.1789959291865; 
 Sun, 20 Sep 2026 19:54:51 -0700 (PDT)
X-Received: by 2002:a17:903:3def:b0:2dd:c100:424d with SMTP id
 d9443c01a7336-2ddc10044b6mr61103525ad.49.1789959291174; 
 Sun, 20 Sep 2026 19:54:51 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3311a6e5sm15464919eec.7.2026.09.20.19.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:54:50 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH] net/bnxt: enable Tx completion coalescing in hardware
Date: Sun, 20 Sep 2026 20:57:55 -0600
Message-ID: <20260921025755.1034702-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

P7 devices support Tx completion coalescing in hardware: the driver
can program the Tx coalescing parameters during Tx ring allocation
instead of always disabling it. Use the wthresh config option
provided in ethdev to select the coalescing value for the Tx rings.

A value of 0 disables the feature. A value of 254 for wthresh is the
max allowable setting; the driver converts the provided value to the
nearest power of 2 for the hardware setting (1 rounds up to 2, which
maps to the same COAL_4 setting as an exact 4; 254 rounds up to 256).

Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c          | 51 ++++++++++++++++++++++++---
 drivers/net/bnxt/bnxt_hwrm.h          |  3 +-
 drivers/net/bnxt/bnxt_mpc.c           |  2 +-
 drivers/net/bnxt/bnxt_ring.c          | 12 +++----
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c | 12 ++++++-
 drivers/net/bnxt/bnxt_rxtx_vec_neon.c | 13 +++++--
 drivers/net/bnxt/bnxt_rxtx_vec_sse.c  | 14 ++++++--
 drivers/net/bnxt/bnxt_txq.c           |  1 +
 drivers/net/bnxt/bnxt_txr.c           |  1 -
 9 files changed, 91 insertions(+), 18 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 1615b36aae..71a9730b5e 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -1113,7 +1113,7 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	int rc = 0;
 	struct hwrm_func_qcaps_input req = {.req_type = 0 };
 	struct hwrm_func_qcaps_output *resp = bp->hwrm_cmd_resp_addr;
-	uint32_t flags, flags_ext2, flags_ext3;
+	uint32_t flags, flags_ext, flags_ext2, flags_ext3;
 	uint16_t new_max_vfs;
 
 	HWRM_PREP(&req, HWRM_FUNC_QCAPS, BNXT_USE_CHIMP_MB);
@@ -1126,6 +1126,7 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 
 	bp->max_ring_grps = rte_le_to_cpu_32(resp->max_hw_ring_grps);
 	flags = rte_le_to_cpu_32(resp->flags);
+	flags_ext = rte_le_to_cpu_32(resp->flags_ext);
 	flags_ext2 = rte_le_to_cpu_32(resp->flags_ext2);
 	flags_ext3 = rte_le_to_cpu_32(resp->flags_ext3);
 
@@ -1215,6 +1216,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_VLAN_TX_INSERT;
 		PMD_DRV_LOG_LINE(DEBUG, "VLAN acceleration for TX is enabled");
 	}
+	if (flags_ext & HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT_TX_COAL_CMPL_CAP)
+		bp->fw_cap |= BNXT_FW_CAP_TX_COAL_CMPL;
 
 	bp->tunnel_disable_flag = rte_le_to_cpu_16(resp->tunnel_disable_flag);
 	if (bp->tunnel_disable_flag)
@@ -2171,11 +2174,52 @@ mpc_chnl_types[] = {HWRM_RING_ALLOC_INPUT_MPC_CHNLS_TYPE_TCE,
 		    HWRM_RING_ALLOC_INPUT_MPC_CHNLS_TYPE_RE_CFA,
 		    HWRM_RING_ALLOC_INPUT_MPC_CHNLS_TYPE_PRIMATE};
 
+static uint8_t bnxt_get_cmpl_coal(uint16_t wthresh)
+{
+	uint8_t coal;
+	uint16_t th;
+
+	th = rte_align32pow2(wthresh);
+	if (wthresh == 1)
+		th = 2;
+
+	switch (th) {
+	case 2:
+		/* FALLTHROUGH */
+	case 4:
+		coal = HWRM_RING_ALLOC_INPUT_CMPL_COAL_CNT_COAL_4;
+		break;
+	case 8:
+		coal = HWRM_RING_ALLOC_INPUT_CMPL_COAL_CNT_COAL_8;
+		break;
+	case 16:
+		coal = HWRM_RING_ALLOC_INPUT_CMPL_COAL_CNT_COAL_16;
+		break;
+	case 32:
+		coal = HWRM_RING_ALLOC_INPUT_CMPL_COAL_CNT_COAL_32;
+		break;
+	case 64:
+		coal = HWRM_RING_ALLOC_INPUT_CMPL_COAL_CNT_COAL_64;
+		break;
+	case 128:
+		coal = HWRM_RING_ALLOC_INPUT_CMPL_COAL_CNT_COAL_128;
+		break;
+	case 256:
+		coal = HWRM_RING_ALLOC_INPUT_CMPL_COAL_CNT_COAL_256;
+		break;
+	case 0:
+	default:
+		coal = HWRM_RING_ALLOC_INPUT_CMPL_COAL_CNT_COAL_OFF;
+	}
+	return coal;
+}
+
 int bnxt_hwrm_ring_alloc(struct bnxt *bp,
 			 struct bnxt_ring *ring,
 			 uint32_t ring_type, uint32_t map_index,
 			 uint32_t stats_ctx_id, uint32_t cmpl_ring_id,
-			 uint16_t tx_cosq_id, uint16_t dpi)
+			 uint16_t tx_cosq_id, uint16_t dpi,
+			 uint16_t tx_coal_thresh)
 {
 	int rc = 0;
 	uint32_t enables = 0;
@@ -2198,8 +2242,7 @@ int bnxt_hwrm_ring_alloc(struct bnxt *bp,
 		req.cmpl_ring_id = rte_cpu_to_le_16(cmpl_ring_id);
 		req.stat_ctx_id = rte_cpu_to_le_32(stats_ctx_id);
 		if (bp->fw_cap & BNXT_FW_CAP_TX_COAL_CMPL)
-			req.cmpl_coal_cnt =
-				HWRM_RING_ALLOC_INPUT_CMPL_COAL_CNT_COAL_OFF;
+			req.cmpl_coal_cnt = bnxt_get_cmpl_coal(tx_coal_thresh);
 		if (tx_cosq_id != MPC_HW_COS_ID) {
 			req.queue_id = rte_cpu_to_le_16(tx_cosq_id);
 		} else {
diff --git a/drivers/net/bnxt/bnxt_hwrm.h b/drivers/net/bnxt/bnxt_hwrm.h
index 3034803023..1dd6671046 100644
--- a/drivers/net/bnxt/bnxt_hwrm.h
+++ b/drivers/net/bnxt/bnxt_hwrm.h
@@ -221,7 +221,8 @@ int bnxt_hwrm_ring_alloc(struct bnxt *bp,
 			 struct bnxt_ring *ring,
 			 uint32_t ring_type, uint32_t map_index,
 			 uint32_t stats_ctx_id, uint32_t cmpl_ring_id,
-			 uint16_t tx_cosq_id, uint16_t dpi);
+			 uint16_t tx_cosq_id, uint16_t dpi,
+			 uint16_t tx_coal_thresh);
 int bnxt_hwrm_ring_free(struct bnxt *bp,
 			struct bnxt_ring *ring, uint32_t ring_type,
 			uint16_t cp_ring_id);
diff --git a/drivers/net/bnxt/bnxt_mpc.c b/drivers/net/bnxt/bnxt_mpc.c
index d77f9dd308..a7138f0aca 100644
--- a/drivers/net/bnxt/bnxt_mpc.c
+++ b/drivers/net/bnxt/bnxt_mpc.c
@@ -502,7 +502,7 @@ static int bnxt_mpc_ring_alloc_one(struct bnxt *bp, enum bnxt_mpc_chnl chnl_id)
 				  map_index,
 				  cpr->hw_stats_ctx_id,
 				  cp_ring->fw_ring_id,
-				  MPC_HW_COS_ID, BNXT_PRIVILEGED_DPI);
+				  MPC_HW_COS_ID, BNXT_PRIVILEGED_DPI, 0);
 	if (rc) {
 		PMD_DRV_LOG_LINE(ERR, "mpc ring %d tx ring alloc failed rc:%d!",
 			    chnl_id, rc);
diff --git a/drivers/net/bnxt/bnxt_ring.c b/drivers/net/bnxt/bnxt_ring.c
index 064520aa62..d478c60a1e 100644
--- a/drivers/net/bnxt/bnxt_ring.c
+++ b/drivers/net/bnxt/bnxt_ring.c
@@ -434,7 +434,7 @@ int bnxt_alloc_cmpl_ring(struct bnxt *bp, int queue_index,
 
 	cpr->dpi = dpi;
 	rc = bnxt_hwrm_ring_alloc(bp, cp_ring, ring_type, cp_ring_index,
-				  HWRM_NA_SIGNATURE, nq_ring_id, 0, dpi);
+				  HWRM_NA_SIGNATURE, nq_ring_id, 0, dpi, 0);
 	if (rc)
 		return rc;
 
@@ -505,7 +505,7 @@ int bnxt_alloc_rxtx_nq_ring(struct bnxt *bp)
 	nqr->dpi = dpi;
 
 	rc = bnxt_hwrm_ring_alloc(bp, ring, ring_type, ring_index,
-				  HWRM_NA_SIGNATURE, HWRM_NA_SIGNATURE, 0, dpi);
+				  HWRM_NA_SIGNATURE, HWRM_NA_SIGNATURE, 0, dpi, 0);
 	if (rc) {
 		rte_free(ring);
 		rte_free(nqr);
@@ -555,7 +555,7 @@ static int bnxt_alloc_rx_ring(struct bnxt *bp, int queue_index)
 
 	rc = bnxt_hwrm_ring_alloc(bp, ring, ring_type,
 				  queue_index, cpr->hw_stats_ctx_id,
-				  cp_ring->fw_ring_id, 0, dpi);
+				  cp_ring->fw_ring_id, 0, dpi, 0);
 	if (rc)
 		return rc;
 
@@ -595,7 +595,7 @@ static int bnxt_alloc_rx_agg_ring(struct bnxt *bp, int queue_index)
 
 	rc = bnxt_hwrm_ring_alloc(bp, ring, ring_type, map_idx,
 				  hw_stats_ctx_id, cp_ring->fw_ring_id, 0,
-				  BNXT_PRIVILEGED_DPI);
+				  BNXT_PRIVILEGED_DPI, 0);
 
 	if (rc)
 		return rc;
@@ -833,7 +833,7 @@ int bnxt_alloc_async_cp_ring(struct bnxt *bp)
 
 	rc = bnxt_hwrm_ring_alloc(bp, cp_ring, ring_type, 0,
 				  HWRM_NA_SIGNATURE, HWRM_NA_SIGNATURE, 0,
-				  BNXT_PRIVILEGED_DPI);
+				  BNXT_PRIVILEGED_DPI, 0);
 
 	if (rc)
 		return rc;
@@ -944,7 +944,7 @@ int bnxt_alloc_hwrm_tx_ring(struct bnxt *bp, int queue_index)
 				  HWRM_RING_ALLOC_INPUT_RING_TYPE_TX,
 				  queue_index, cpr->hw_stats_ctx_id,
 				  cp_ring->fw_ring_id,
-				  tx_cosq_id, txr->dpi);
+				  tx_cosq_id, txr->dpi, txq->wthresh);
 	if (rc)
 		goto err_out;
 
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
index 7f07b0a3e1..2dfb7f0ae0 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
@@ -735,7 +735,9 @@ bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq)
 	struct cmpl_base *cp_desc_ring = cpr->cp_desc_ring;
 	struct bnxt_ring *cp_ring_struct = cpr->cp_ring_struct;
 	uint32_t ring_mask = cp_ring_struct->ring_mask;
+	uint32_t tx_ring_mask;
 
+	tx_ring_mask = txq->tx_ring->tx_ring_struct->ring_mask;
 	do {
 		cons = RING_CMPL(ring_mask, raw_cons);
 		txcmp = (struct tx_cmpl *)&cp_desc_ring[cons];
@@ -749,7 +751,15 @@ bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq)
 			rte_atomic_fetch_add_explicit(&txq->tx_dma_err, 1,
 						      rte_memory_order_relaxed);
 
-		nb_tx_pkts += txcmp->opaque;
+		if (CMP_TYPE(txcmp) == CMPL_BASE_TYPE_TX_L2_COAL) {
+			struct tx_cmpl_coal *txcmp_c = (struct tx_cmpl_coal *)txcmp;
+
+			nb_tx_pkts = (rte_le_to_cpu_32(txcmp_c->sq_cons_idx) -
+				      (txq->tx_ring->tx_raw_cons & tx_ring_mask)) &
+				      tx_ring_mask;
+		} else {
+			nb_tx_pkts += txcmp->opaque;
+		}
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 	} while (nb_tx_pkts < ring_mask);
 
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_neon.c b/drivers/net/bnxt/bnxt_rxtx_vec_neon.c
index 03f39280e5..ffbcc92dc5 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_neon.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_neon.c
@@ -347,7 +347,9 @@ bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq)
 	struct cmpl_base *cp_desc_ring = cpr->cp_desc_ring;
 	struct bnxt_ring *cp_ring_struct = cpr->cp_ring_struct;
 	uint32_t ring_mask = cp_ring_struct->ring_mask;
+	uint32_t tx_ring_mask;
 
+	tx_ring_mask = txq->tx_ring->tx_ring_struct->ring_mask;
 	do {
 		cons = RING_CMPL(ring_mask, raw_cons);
 		txcmp = (struct tx_cmpl *)&cp_desc_ring[cons];
@@ -355,12 +357,19 @@ bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq)
 		if (!bnxt_cpr_cmp_valid(txcmp, raw_cons, ring_mask + 1))
 			break;
 
-		if (likely(CMP_TYPE(txcmp) == TX_CMPL_TYPE_TX_L2))
+		if (CMP_TYPE(txcmp) == CMPL_BASE_TYPE_TX_L2_COAL) {
+			struct tx_cmpl_coal *txcmp_c = (struct tx_cmpl_coal *)txcmp;
+
+			nb_tx_pkts = (rte_le_to_cpu_32(txcmp_c->sq_cons_idx) -
+				      (txq->tx_ring->tx_raw_cons & tx_ring_mask)) &
+				      tx_ring_mask;
+		} else if (likely(CMP_TYPE(txcmp) == TX_CMPL_TYPE_TX_L2)) {
 			nb_tx_pkts += txcmp->opaque;
-		else
+		} else {
 			RTE_LOG_DP_LINE(ERR, BNXT,
 				   "Unhandled CMP type %02x",
 				   CMP_TYPE(txcmp));
+		}
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 	} while (nb_tx_pkts < ring_mask);
 
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_sse.c b/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
index a97ff6f5fe..9312d41ef8 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
@@ -569,6 +569,9 @@ bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq)
 	struct cmpl_base *cp_desc_ring = cpr->cp_desc_ring;
 	struct bnxt_ring *cp_ring_struct = cpr->cp_ring_struct;
 	uint32_t ring_mask = cp_ring_struct->ring_mask;
+	uint32_t tx_ring_mask;
+
+	tx_ring_mask = txq->tx_ring->tx_ring_struct->ring_mask;
 
 	do {
 		cons = RING_CMPL(ring_mask, raw_cons);
@@ -583,12 +586,19 @@ bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq)
 			rte_atomic_fetch_add_explicit(&txq->tx_dma_err, 1,
 						      rte_memory_order_relaxed);
 
-		if (likely(CMP_TYPE(txcmp) == TX_CMPL_TYPE_TX_L2))
+		if (CMP_TYPE(txcmp) == CMPL_BASE_TYPE_TX_L2_COAL) {
+			struct tx_cmpl_coal *txcmp_c = (struct tx_cmpl_coal *)txcmp;
+
+			nb_tx_pkts = (rte_le_to_cpu_32(txcmp_c->sq_cons_idx) -
+				      (txq->tx_ring->tx_raw_cons & tx_ring_mask)) &
+				      tx_ring_mask;
+		} else if (likely(CMP_TYPE(txcmp) == TX_CMPL_TYPE_TX_L2)) {
 			nb_tx_pkts += txcmp->opaque;
-		else
+		} else {
 			RTE_LOG_DP_LINE(ERR, BNXT,
 				   "Unhandled CMP type %02x",
 				   CMP_TYPE(txcmp));
+		}
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 	} while (nb_tx_pkts < ring_mask);
 
diff --git a/drivers/net/bnxt/bnxt_txq.c b/drivers/net/bnxt/bnxt_txq.c
index 03407c556a..830298bd5e 100644
--- a/drivers/net/bnxt/bnxt_txq.c
+++ b/drivers/net/bnxt/bnxt_txq.c
@@ -175,6 +175,7 @@ int bnxt_tx_queue_setup_op(struct rte_eth_dev *eth_dev,
 	/* For PTP packets, process the completion sooner */
 	if (bp->ptp_cfg != NULL)
 		txq->tx_free_thresh = RTE_BNXT_MIN_TX_BURST;
+	txq->wthresh = tx_conf->tx_thresh.wthresh;
 	txq->offloads = eth_dev->data->dev_conf.txmode.offloads |
 			tx_conf->offloads;
 	/* mbuf fast free not supported for the following. Reset the bit */
diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index edd99dc84a..54daeef3e1 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -740,7 +740,6 @@ static void bnxt_tx_cmp(struct bnxt_tx_queue *txq, int nb_tx, bool tx_coal_cmp)
 static bool bnxt_is_tx_cmpl_type(uint16_t type)
 {
 	return (type == CMPL_BASE_TYPE_TX_L2_PKT_TS ||
-		type == CMPL_BASE_TYPE_TX_L2_COAL ||
 		type == CMPL_BASE_TYPE_TX_L2);
 }
 
-- 
2.47.3

