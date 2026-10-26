Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC51606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RYx42WCr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38C6940613;
	Mon, 26 Oct 2026 20:09:25 +0100 (CET)
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com
 [209.85.215.225])
 by mails.dpdk.org (Postfix) with ESMTPS id C62E540041
 for <dev@dpdk.org>; Mon, 26 Oct 2026 20:09:21 +0100 (CET)
Received: by mail-pg1-f225.google.com with SMTP id
 41be03b00d2f7-cc7e79c1eaaso1191681a12.2
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793041760; x=1793646560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5QrKvtG860OIMwZJQItH84zfcSjciPQkBWcTMXAarZ8=;
 b=FmrcA+70volByznZh56M+JkvkEYaj3SpI0cLQ+6/ZewvjI4jffpRamejnmO0WbSaDZ
 pxxOLbg6KctzORWz6CqcNm3Vvpq3BRVgITfVa5vWSXVLkb46YxEMmEat7nxG0guY28KE
 +ynn492+WwE6fz5dSMkfGZD7qU9ruS6FJan/eKeGLOKUPKcve07VedEzo95sKG+5AqVi
 5owh/SQvwCsoMrAdJs9ObeltYYP6BAPET7AnhmFaIW70yw4BV2iuMvt66XAk+dik586i
 7kbVCInwv4obQG+Ut6L7mSXX5EE7q8rCg527Nti+Bk9t2ZcNyELBbsHlBzPicCCh+Bfb
 BGHA==
X-Gm-Message-State: AFq9FYJOHk3v1LEwhiQ19QEgiXwNg/zeXpHB9iTv3RH4g/RzKITHA7SE
 +0bJhaI+lUkj5rqDpRAKp0zzCF8QB1VpI/b5wYQBVfodqnMWlCJB0r0PzSh+jWoKhQrPzFGAkKi
 OB9RJlW5nixCV2/kDN+CpZ5ynrzdKcgg0Il79tw0BnWaooUDMagEwXMxNyTHLoIdWYQU0YEmYts
 1X4tjZfnCT99xmYjFWhsL4aykUA5P14GcVpaFdL+tkCd4xOAc3IcbTk3LkmY52p7hBC6S4kTvf2
 3SZ9Ffoquyb
X-Gm-Gg: AYBFou3ywju66yISxJIR/mPoKzNA9OU/FU/tOmS385/9w+CB5KYCTBZTS+uMn0wX4Ud
 SAlZNBj8POnQ2qVM0bSwDUZfdlSCMVAqto2yzmqNZRy8f8qQIDwJ/V28y/jovqHU8/OzdOO/kXc
 Hb5NEIIm51jNrQqPWO/fvTKUjtmHZD8/QRdzKnwP8eHYGo1EldRXDMXycjdITAe7Sj+25OvP965
 ui14oMHzbbM82vGvw6KK8dk3Vpp/9R1TtW+scFn//iRc3mmXxX7KQ+pjnDnW2KnZAsqHAKf3q5G
 KsmM8jhNwYccm/L00uG+q0Tryz52wh2CKKLtBsU0wODIC2+BR495/cJfMlknaPkfHUDafuxl5aP
 AJaGg3O19gp7HaHICgk8vGcRdoLMYovHraHaXI9c41K12gfFzG1QVZtbPkMkvhdP8qLKL23SeNM
 dPbZr1ThB33EuouDxiEo4B8zloRfhW50aap0Dou31DlPHq7EGilA==
X-Received: by 2002:a17:90b:2552:b0:3ab:884b:659e with SMTP id
 98e67ed59e1d1-3adea8984bamr6016006a91.9.1793041759985; 
 Mon, 26 Oct 2026 12:09:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae40405cfbsm354332a91.0.2026.10.26.12.09.19
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Oct 2026 12:09:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-351788121cfso2785709eec.0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793041758; x=1793646558; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5QrKvtG860OIMwZJQItH84zfcSjciPQkBWcTMXAarZ8=;
 b=RYx42WCrMwRrT/YUYDCrTsDyP6JyiTUBdPxmftBAlx7T3EpHRwyhEyv4S2jGRP/RH9
 aSwn9O96zf4h+etAmTiBFnM+C1GApmewYA9U/Vj++Dw/5B+FOoBPsKJqI8pjw9LtQnYd
 PFSUe2JcbSRXoBIgKB9iVIyCsUolcrxQzipbo=
X-Received: by 2002:a05:7301:fd02:b0:342:645a:5cf with SMTP id
 5a478bee46e88-369e830ed89mr11458562eec.1.1793041757879; 
 Mon, 26 Oct 2026 12:09:17 -0700 (PDT)
X-Received: by 2002:a05:7301:fd02:b0:342:645a:5cf with SMTP id
 5a478bee46e88-369e830ed89mr11458525eec.1.1793041757021; 
 Mon, 26 Oct 2026 12:09:17 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db7b23sm37103906eec.19.2026.10.26.12.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:09:16 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 1/7] net/bnxt: enable Tx completion coalescing in hardware
Date: Mon, 26 Oct 2026 13:12:45 -0600
Message-ID: <20261026191251.1274062-2-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026191251.1274062-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20261023165457.1225312-1-mohammad-shuab.siddique@broadcom.com>
 <20261026191251.1274062-1-Mohammad-Shuab.Siddique@broadcom.com>
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
index 48b950876cf..8c36cec1027 100644
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
index 33d6e548bfa..df476005da0 100644
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
index 573a33b2def..870411ace90 100644
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
index 30348030239..1dd66710462 100644
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
index 1398321ca7f..5560d3da001 100644
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
index 064520aa622..d478c60a1e5 100644
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
index 80074a56c4a..1236d3c2fed 100644
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
index aa2c5e26e61..7aa153bc4e1 100644
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
index 5ac1809ad7f..8dfb16a26d6 100644
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
index f6b858c15be..983be5130be 100644
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
index 70ddda2bc36..4c01e8a275a 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -716,7 +716,6 @@ static void bnxt_tx_cmp(struct bnxt_tx_queue *txq, int nb_tx, bool tx_coal_cmp)
 static bool bnxt_is_tx_cmpl_type(uint16_t type)
 {
 	return (type == CMPL_BASE_TYPE_TX_L2_PKT_TS ||
-		type == CMPL_BASE_TYPE_TX_L2_COAL ||
 		type == CMPL_BASE_TYPE_TX_L2);
 }
 
