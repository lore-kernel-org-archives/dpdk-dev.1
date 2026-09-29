Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3769CA5FAB
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:20:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09AB940E39;
	Tue, 29 Sep 2026 02:20:42 +0200 (CEST)
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com
 [209.85.210.98]) by mails.dpdk.org (Postfix) with ESMTP id 08C8940DDA
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:20:40 +0200 (CEST)
Received: by mail-ot1-f98.google.com with SMTP id
 46e09a7af769-81e15b81a52so96387a34.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641239; x=1791246039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/ejhTlbuj+oURcYHczD4YcmqkinsoIIc5Q5qmdoVKLM=;
 b=Dd1NvxMuZ++8UIr0Sb5sgMuQPlekFFCl7xLKHre9Fhiqvo/wAe06GuaFkV8+IO//JP
 7je1cuvjC8+uuLG6Hw/tKpUGXIzu73E0q5D4aouzBMpYPggEA0G23L/UriP82xG/MV7J
 ti1Ij182KoYr95e8AYUnfK5y6uN1ZlnCfmI+s3F37BlweV1zawnNLsgBpMbCf1t9XwvR
 +/qY9uv2lcepyX9AeK9TV16BJVINwSn7obNrddJFprGr7oiIb57HClfDatmmARroiXO2
 +IUhi3Z3nlqHas5p2FWp0UxYB8H4SP34xbkBEFrgjuRCT9/69GnEkiim0edmsd3DVhS9
 HYCQ==
X-Gm-Message-State: AFuF++n4LUwUkLltRyys8KRlk5AQP5cFA8EYs9yxQupY3nXBWHNOnt5d
 SEbF+1KgGeT1VqEn+2SON3vaSXbWpcpe4kZyFaSOzvJtLz9nii216ocbj2GN8oSDUkHdr3IQT83
 Hsx+lxHwoJuanGvpEtU9tcbnaZx2FcaYC7fj4NjmZnX8El1BMrQZTO4J0uaLc7tEFYajL4c44wY
 QaFSaoRKkBN5EmT4kv4jhhkcP6jCDsUxhxBJXE1yrmi+z99in65Hi0H60iMx/mtOL3uI6AdTzey
 lJdqCrEe4n6
X-Gm-Gg: AYBFou08pkPPi/D8FBtnDeDE1LNq5CsXBUTUKxmhNaGdQ+gxpTIPqlx+YXXy3Fxpx5C
 MxI2TqQ9CTnG40io+PNmw8f4yVes46lkLHX0d9Ts/p8smXgUuCp7oHR8m5iYKU2rPUGRjT2dxNS
 L14KfVKtUEhxNRD9aLHwT7X2KO/X1/crWiYL8FcOqQsSJcB9qZZbr8HighWLTOOmIiOsZPbkorj
 VFMJRZikFcJSuFq+dNQUlcGpnI7XGFn0LxK530YWA4H0fAxxV2CAxUt3bFP1rJJe4RxZgW15IFv
 OkEUZ4lMJt8MNwgu7xar3yYXdHoWB8m2Hgcp3DtU1CCsh+ZMrcgJuBKZOpc0JD5A+G5Trf5M63l
 vhmxoTiU8gBIu8AvraCyPml0MkWEca9D2xxEwd2zKrTNmP3F7DS+IqSo8oDEPsbYPZXhNHv707P
 ZL1ul4/SLJwp5e8lxX1M8SwLvGJLSu6Q1x0Z8odx39ANMFrSm3ryAb
X-Received: by 2002:a05:6830:2b25:b0:81e:b1d2:95f with SMTP id
 46e09a7af769-81eb1d218ffmr357968a34.28.1790641239205; 
 Mon, 28 Sep 2026 17:20:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-81d580e8808sm908115a34.4.2026.09.28.17.20.38
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:20:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c820cf67dso289806985a.0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641238; x=1791246038; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/ejhTlbuj+oURcYHczD4YcmqkinsoIIc5Q5qmdoVKLM=;
 b=Zr1QwPYLyRGQ9xzl4qgL3Wztm/ymkw+vYszaxF5BgcV6VOI8DcGruvCnKYrzmLBnMm
 jWCvqzELcOXZcwlksUQEIIMOdziTJsL8lY8V2GYgJUwWB8/AMo9G1sqt0F6LTtNQYkM5
 +aYkD/6DSYxuOQu9XuZTRggL58BSeCDyW+0ZE=
X-Received: by 2002:a05:620a:439e:b0:93c:6092:ac66 with SMTP id
 af79cd13be357-93c6092af0dmr1461167285a.24.1790641237814; 
 Mon, 28 Sep 2026 17:20:37 -0700 (PDT)
X-Received: by 2002:a05:620a:439e:b0:93c:6092:ac66 with SMTP id
 af79cd13be357-93c6092af0dmr1461164585a.24.1790641237208; 
 Mon, 28 Sep 2026 17:20:37 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c8141617bsm273141285a.25.2026.09.28.17.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:20:35 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH v2] net/bnxt: enable Tx completion coalescing in hardware
Date: Mon, 28 Sep 2026 18:23:35 -0600
Message-ID: <20260929002335.1208402-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921025755.1034702-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260921025755.1034702-1-Mohammad-Shuab.Siddique@broadcom.com>
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

bnxt_hwrm_ring_alloc() previously programmed cmpl_coal_cnt as
COAL_OFF unconditionally. Add a bnxt_get_cmpl_coal() helper and
thread a new tx_coal_thresh parameter through bnxt_hwrm_ring_alloc()
and its callers, wiring txq->wthresh (assigned from
tx_conf->tx_thresh.wthresh) through to the Tx ring's alloc call.

Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v2:
* Rebased onto current main -- Stephen Hemminger noted v1 did not
  apply cleanly.
* Added a "Tx Completion Coalescing" section to
  doc/guides/nics/bnxt.rst and a release notes entry, both requested
  by Stephen Hemminger.

 doc/guides/nics/bnxt.rst               | 10 +++++
 doc/guides/rel_notes/release_26_11.rst |  2 +
 drivers/net/bnxt/bnxt_hwrm.c           | 51 ++++++++++++++++++++++++--
 drivers/net/bnxt/bnxt_hwrm.h           |  3 +-
 drivers/net/bnxt/bnxt_mpc.c            |  2 +-
 drivers/net/bnxt/bnxt_ring.c           | 12 +++---
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c  | 12 +++++-
 drivers/net/bnxt/bnxt_rxtx_vec_neon.c  | 13 ++++++-
 drivers/net/bnxt/bnxt_rxtx_vec_sse.c   | 14 ++++++-
 drivers/net/bnxt/bnxt_txq.c            |  1 +
 drivers/net/bnxt/bnxt_txr.c            |  1 -
 11 files changed, 103 insertions(+), 18 deletions(-)

diff --git a/doc/guides/nics/bnxt.rst b/doc/guides/nics/bnxt.rst
index 48b950876c..8c36cec102 100644
--- a/doc/guides/nics/bnxt.rst
+++ b/doc/guides/nics/bnxt.rst
@@ -342,6 +342,16 @@ The BNXT PMD supports hardware-based CRC offload:
 
 Note that the CRC offload is always turned on.
 
+Tx Completion Coalescing
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+On P7 devices, the BNXT PMD programs the hardware to coalesce Tx completions
+instead of generating one completion per descriptor. The coalescing count is
+derived from the ``wthresh`` field of ``struct rte_eth_txconf.tx_thresh``
+passed to ``rte_eth_tx_queue_setup()``, rounded up to the nearest power of
+two supported by the hardware (up to 256). A ``wthresh`` of 0 disables Tx
+completion coalescing.
+
 Checksum Offload
 ^^^^^^^^^^^^^^^^
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87941f57dd..ab1192960c 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -81,6 +81,8 @@ New Features
     is also folded into the standard ``oerrors`` counter.
   * Raised the maximum Tx and Rx ring descriptor counts from 4096/8192 to
     16384 each.
+  * Enabled hardware Tx completion coalescing on P7 devices, controlled
+    by the existing ``wthresh`` Tx queue configuration field.
 
 * **Updated Intel iavf driver.**
 
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
index 1398321ca7..5560d3da00 100644
--- a/drivers/net/bnxt/bnxt_mpc.c
+++ b/drivers/net/bnxt/bnxt_mpc.c
@@ -504,7 +504,7 @@ static int bnxt_mpc_ring_alloc_one(struct bnxt *bp, enum bnxt_mpc_chnl chnl_id)
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
index 80074a56c4..1236d3c2fe 100644
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
@@ -751,7 +753,15 @@ bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq)
 							 rte_memory_order_relaxed) + 1,
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
index aa2c5e26e6..7aa153bc4e 100644
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
@@ -363,12 +365,19 @@ bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq)
 							 rte_memory_order_relaxed) + 1,
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
 
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_sse.c b/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
index 5ac1809ad7..8dfb16a26d 100644
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
@@ -585,12 +588,19 @@ bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq)
 							 rte_memory_order_relaxed) + 1,
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
index 64ff42b38e..fd0ac8fd19 100644
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

