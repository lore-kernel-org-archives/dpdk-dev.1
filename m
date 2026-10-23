Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86802606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=dtSyOGao
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60C52402C9;
	Fri, 23 Oct 2026 18:51:31 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id 32C3240265
 for <dev@dpdk.org>; Fri, 23 Oct 2026 18:51:28 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-3adac5c10e3so637902a91.0
 for <dev@dpdk.org>; Fri, 23 Oct 2026 09:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792774287; x=1793379087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0eg3DpOwLcf3eU082NHFiYTjACMtdGL0yAQRDnksIfk=;
 b=kh4Gy9gPDTp+4hefntIvSvgf6+x+z/6NrB5eQ62mHDF6961cmlmjBod5pFqqkt4Ucd
 L4yxqpKJ8NwCAppXbnXtcQg+/IPrlmcJ/7rMk4/k23UQnZUTKG+wdpqQZbfw/3f2lXUF
 c4EevOhQXqSv1GbB251uF/5lZRuSuSX0sXCZB7zia+EMK71sG1YQNVXSo9TTSmZBx9Sf
 +Q9I/L2KY5gol91IIWxamsUlHgpNHXL+COGJhZ5kFdcF6r0iOWHnf7vePs97qdEYitR0
 mXdCrGdw4EhhpP3fvuSl+goTiaU+XqLDCRttrkTQmZd3/w4rOKHi5C2xr0iWqNDs8gM1
 XOEQ==
X-Gm-Message-State: AFq9FYLO1iyJI93uLFjrh6MTKcjCj0Mu6JHKNSjJ4PXdtIO41/YgWr44
 s4KzUXmMmNd3XYQ6ItayUMk2StiGEflbJBRSdgv36Qc5Xim5QBa1YV7QoOhUQFcMfx4oPkXxiV2
 gIpJB1CEYX13EVx5Noge7S5uR+BCB6MdZZK1b5aixytNK0ynCGvVtEsqp8EnmHiySZhhnm/Q0dp
 X9EI1nIgT8XgFrLrtOcA/tAlCAC5MRWruXeno/Dw3zzBgE9aRGnFHGm2uSy8u1hwoZzj2Qi/hw1
 cgvKUkQU28M
X-Gm-Gg: AYBFou0Iu0nhHmlFSx+SJ37fKhjeIIMQblKXd2fnyx2Cb+mpcZ9u9KnXgf2RIFMli/J
 72BM2CtJ+Yfr6SFKfS/1Kbv1gCvpeOy2z/v+PmcV87Y24ISnJcD11+6J9pYB+J/iQfPl16q757u
 xjwTOzgiFTQOOciIYZreo7emtwZaQBfgaRKwmLC+wlGm0dICzp93zGtzoaY8WbdP1VHIPIimtUD
 Y6LwhaDF4GGz6s4W8H0eUD9H+Yq7LsgHt0Q22zb3bc+9C13uVMPR3V+n3Zv7QyWQWoRBIS6Bs7d
 3fPzTS2LvvR/ptbjhJhVIj4uh8LKQ/kLaflAiIkpucNE7+B+OGo3TWtTYimSPy0NaduAtxqDsHi
 LFMkbZwIlOzS5D7cCU3yGpLvRtn/9XMgxQBf0y5LE4NvcTE07YYmfdi5wqhuX5tAheOYqecWfQ+
 htYFAK0RdjpHdhYh+CMIYg1C0lx7ii5tuP1oo1abM1vliwcDhBUg==
X-Received: by 2002:a17:90b:2645:b0:396:41d1:cbc7 with SMTP id
 98e67ed59e1d1-3adcdc94d2fmr2582451a91.3.1792774287216; 
 Fri, 23 Oct 2026 09:51:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ade29747a7sm112963a91.1.2026.10.23.09.51.26
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Oct 2026 09:51:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f1e62510cso270141185a.1
 for <dev@dpdk.org>; Fri, 23 Oct 2026 09:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792774286; x=1793379086; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0eg3DpOwLcf3eU082NHFiYTjACMtdGL0yAQRDnksIfk=;
 b=dtSyOGaokQCb1Og2+nhaXquHVP/feQtwAczuwTe89b144juhvOGS37aewL9omvA8p4
 XYQ7HD0r3pcVuoDKt7llI0FIpiOvs5P4HMSx4vKeO3phnGh2OHaBr1M76tL8+Yc9/gsI
 tEYlDV4S81O6OKV+4SByeRzyroBC3KzBthW4E=
X-Received: by 2002:a05:620a:2b92:b0:93c:c2c2:40eb with SMTP id
 af79cd13be357-93f6f84ff78mr507766585a.66.1792774285995; 
 Fri, 23 Oct 2026 09:51:25 -0700 (PDT)
X-Received: by 2002:a05:620a:2b92:b0:93c:c2c2:40eb with SMTP id
 af79cd13be357-93f6f84ff78mr507762685a.66.1792774285358; 
 Fri, 23 Oct 2026 09:51:25 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c45228d8bsm5928056d6.21.2026.10.23.09.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:51:24 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH 1/7] net/bnxt: enable Tx completion coalescing in hardware
Date: Fri, 23 Oct 2026 10:54:50 -0600
Message-ID: <20261023165457.1225312-2-mohammad-shuab.siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023165457.1225312-1-mohammad-shuab.siddique@broadcom.com>
References: <20261023165457.1225312-1-mohammad-shuab.siddique@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 doc/guides/nics/bnxt.rst               | 10 ++++++
 doc/guides/rel_notes/release_26_11.rst |  2 ++
 drivers/net/bnxt/bnxt_hwrm.c           | 50 +++++++++++++++++++++++---
 drivers/net/bnxt/bnxt_hwrm.h           |  3 +-
 drivers/net/bnxt/bnxt_mpc.c            |  2 +-
 drivers/net/bnxt/bnxt_ring.c           | 12 +++----
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c  | 12 ++++++-
 drivers/net/bnxt/bnxt_rxtx_vec_neon.c  | 13 +++++--
 drivers/net/bnxt/bnxt_rxtx_vec_sse.c   | 14 ++++++--
 drivers/net/bnxt/bnxt_txq.c            |  1 +
 drivers/net/bnxt/bnxt_txr.c            |  1 -
 11 files changed, 102 insertions(+), 18 deletions(-)

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
index 33d6e548bf..df476005da 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -141,6 +141,8 @@ New Features
     and is also folded into the standard ``oerrors`` counter.
   * Raised the maximum Tx and Rx ring descriptor counts
     from 4096/8192 to 16384 each.
+  * Enabled hardware Tx completion coalescing on P7 devices,
+    controlled by the existing ``wthresh`` Tx queue configuration field.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 573a33b2de..870411ace9 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -1098,7 +1098,7 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	int rc = 0;
 	struct hwrm_func_qcaps_input req = {.req_type = 0 };
 	struct hwrm_func_qcaps_output *resp = bp->hwrm_cmd_resp_addr;
-	uint32_t flags, flags_ext2, flags_ext3;
+	uint32_t flags, flags_ext, flags_ext2, flags_ext3;
 	uint16_t new_max_vfs;
 
 	HWRM_PREP(&req, HWRM_FUNC_QCAPS, BNXT_USE_CHIMP_MB);
@@ -1113,6 +1113,7 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	if (bp->max_ring_grps > BNXT_MAX_RING_GRPS)
 		bp->max_ring_grps = BNXT_MAX_RING_GRPS;
 	flags = rte_le_to_cpu_32(resp->flags);
+	flags_ext = rte_le_to_cpu_32(resp->flags_ext);
 	flags_ext2 = rte_le_to_cpu_32(resp->flags_ext2);
 	flags_ext3 = rte_le_to_cpu_32(resp->flags_ext3);
 
@@ -1204,6 +1205,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_VLAN_TX_INSERT;
 		PMD_DRV_LOG_LINE(DEBUG, "VLAN acceleration for TX is enabled");
 	}
+	if (flags_ext & HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT_TX_COAL_CMPL_CAP)
+		bp->fw_cap |= BNXT_FW_CAP_TX_COAL_CMPL;
 
 	bp->tunnel_disable_flag = rte_le_to_cpu_16(resp->tunnel_disable_flag);
 	if (bp->tunnel_disable_flag)
@@ -2161,11 +2164,51 @@ mpc_chnl_types[] = {HWRM_RING_ALLOC_INPUT_MPC_CHNLS_TYPE_TCE,
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
@@ -2188,8 +2231,7 @@ int bnxt_hwrm_ring_alloc(struct bnxt *bp,
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
index f6b858c15b..983be5130b 100644
--- a/drivers/net/bnxt/bnxt_txq.c
+++ b/drivers/net/bnxt/bnxt_txq.c
@@ -175,6 +175,7 @@ int bnxt_tx_queue_setup_op(struct rte_eth_dev *eth_dev,
 	/* For PTP packets, process the completion sooner */
 	if (bp->ptp_cfg != NULL)
 		txq->tx_free_thresh = RTE_BNXT_MIN_TX_BURST;
+	txq->wthresh = tx_conf->tx_thresh.wthresh;
 	txq->offloads = eth_dev->data->dev_conf.txmode.offloads |
 			tx_conf->offloads;
 	txq->fast_free_requested =
diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index 70ddda2bc3..4c01e8a275 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -716,7 +716,6 @@ static void bnxt_tx_cmp(struct bnxt_tx_queue *txq, int nb_tx, bool tx_coal_cmp)
 static bool bnxt_is_tx_cmpl_type(uint16_t type)
 {
 	return (type == CMPL_BASE_TYPE_TX_L2_PKT_TS ||
-		type == CMPL_BASE_TYPE_TX_L2_COAL ||
 		type == CMPL_BASE_TYPE_TX_L2);
 }
 
-- 
2.47.3

