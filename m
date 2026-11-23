Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F73606A31E
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=BiaYrnPz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DA2A4065A;
	Mon, 23 Nov 2026 22:15:28 +0100 (CET)
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com
 [209.85.161.97])
 by mails.dpdk.org (Postfix) with ESMTPS id 522FA40395
 for <dev@dpdk.org>; Mon, 23 Nov 2026 22:15:25 +0100 (CET)
Received: by mail-oo1-f97.google.com with SMTP id
 006d021491bc7-6d290b10a35so1555091eaf.2
 for <dev@dpdk.org>; Mon, 23 Nov 2026 13:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795468524; x=1796073324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BC9t6pmbdrqsCd0fC3IVdCd8DO/rOgLqU7BtQvE3c9s=;
 b=fLiA0i0I8QnK6WAFCmNtEooG4wnogkFdz3ZqXfNBTW4jiKsDAla7zkJuOVl1kxoQhh
 TBbTIQXefGqwaj6xD1DkIliZiRTovbV2i7i0i5zeRfI7P/ZDA47zB4pj84sWBM/ntNKU
 Y8lzQ96Bcct8zPkYIsOKr1wsVDnxusc894Dq0tIMEsB1rT0L1nxsVtpZwI6ug6lbTZLs
 XD5zJC0XmP5QC4lqTXKI/1LI0RfS0iV2aiEL55l5nXFzFsqcbyoQ+R+JuRnnR2/vnjQ3
 etcavgJ1W896cnq3eX6OBctNeu3dSrJ5E39+J81qWfNUaTLRloM9O71YaNtk53/YN8ie
 YKjQ==
X-Gm-Message-State: APuU4Z9oqN4iBVDOlEWuPKKYzZtbyCbDkSzJ7Lw118rWS3Bcjs51NbXS
 3TsRuOD9mPxAnCdLqs27O9MRmGjiMvsCDsjHz9v6HsViEk/NwEoZriCp0qlduyBlKLS+frs34o+
 NZ1dX5AaQ++5ADOGSMomueD36U8Yo/b6C3NR6bhfcBE5EwPGLbP+OIQE74zk+jAfAUXNyNeWFj2
 y/upiikBJGA5V2W0slcjwhEgK7dzQPoqOsnwYapZbsnkNJd93G5MqIsQgKBsd7qYukh930HOPUP
 p+UVeboe+w0
X-Gm-Gg: AZFdTZegGb35KOX4tuIiyHHnnBDmwxvkmv4b92axlmRZ3A0DrsYLZdXMSYeWo+DBVO3
 PCV7FMxnyxrsyusPKmUXS84Z6fA7RJpgzvvILSLdS/t5A8cW03yxVYBvktKsS9OJ96sxZBH4JLR
 l0JvVvggP81NruzXGGV71vN+AiwhaSin71c7dPhnX7/LPD0Mgmmj8Fw/4ovXRlDg5s0x09UjeV9
 qJLgylixawdYSB2gU2hMeAjxOIGbOJi9044a+5ULv/362pUojGWHkwvOWv0TkyiG7keloklZSnK
 qT9cmUe77C1WNnaBbiRk8KjR0V54OTgcxUzur7JMrVWZ91hmdjD/NYGiI/0t7ACLY0JTYnDrVOL
 BFFsLid2IDo6NdTXawRw/C6fRdQejLMDprqq6pe1qIn5dZzH4DyLLAUGjTRE4sLH7CagE09qpHa
 sauRcRyRDu59TpuUzIfL8wg1zZoq51fLZdJB9Ej86PEQjUHXEpHg==
X-Received: by 2002:a05:6820:16a0:b0:71a:f754:a236 with SMTP id
 006d021491bc7-71b395ac355mr9654627eaf.83.1795468523700; 
 Mon, 23 Nov 2026 13:15:23 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-71b380a36d8sm97325eaf.24.2026.11.23.13.15.22
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Nov 2026 13:15:23 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b25d977b91so3964817c88.1
 for <dev@dpdk.org>; Mon, 23 Nov 2026 13:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1795468522; x=1796073322; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BC9t6pmbdrqsCd0fC3IVdCd8DO/rOgLqU7BtQvE3c9s=;
 b=BiaYrnPzVIaitQOesswCfoh3a0px2/KTxr1KoJsPZhZ/1KjJ4rJ9OEts+/CxsnP8A+
 ufOSx9g23eLLy/SrPsWzn0dhFq4p4L/tmo+ryMB1163Ur+8iw84FqkQANZfHRIDv7D5I
 V5KQXUPh4+dBJibQ+KrzhE7tHz4+aWgPwZrCM=
X-Received: by 2002:a05:701b:4648:b0:1b5:43af:1bde with SMTP id
 a92af1059eb24-1b5568bebeemr11707636c88.25.1795468521670; 
 Mon, 23 Nov 2026 13:15:21 -0800 (PST)
X-Received: by 2002:a05:701b:4648:b0:1b5:43af:1bde with SMTP id
 a92af1059eb24-1b5568bebeemr11707588c88.25.1795468520592; 
 Mon, 23 Nov 2026 13:15:20 -0800 (PST)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5566c1142sm29495218c88.2.2026.11.23.13.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 13:15:20 -0800 (PST)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Keegan Freyhof <keegan.freyhof@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 2/2] net/bnxt: use extended ring stats on P5
Date: Mon, 23 Nov 2026 14:19:27 -0700
Message-ID: <20261123211927.261389-3-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123211927.261389-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20261123211927.261389-1-Mohammad-Shuab.Siddique@broadcom.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

P5 devices with TPA v2 support the same extended stat context as P7,
minus the Rx TPA events counter, which P5 firmware does not report.
Use the extended ring stats path for them as well, so the flipped
bit handling added for ring stats also covers the TPA counters on
these devices and the TPA xstats are reported.

Size the DMA stat context one counter smaller on P5 to match what
the firmware writes, and skip the missing Rx TPA events counter when
filtering the samples.

Fixes: 27c32143d508 ("net/bnxt: query extended stats from firmware")
Cc: stable@dpdk.org

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 doc/guides/rel_notes/release_26_11.rst |  2 ++
 drivers/net/bnxt/bnxt_ethdev.c         |  4 ++--
 drivers/net/bnxt/bnxt_hwrm.h           | 11 ++++++-----
 drivers/net/bnxt/bnxt_rxq.c            |  2 +-
 drivers/net/bnxt/bnxt_stats.c          | 27 +++++++++++++++-----------
 drivers/net/bnxt/bnxt_txr.c            |  2 +-
 6 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 79994bb93a..1b88051da0 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -162,6 +162,8 @@ New Features
     (a failed PCIe DMA transaction) without a full adapter reset,
     gated behind the new ``func-error-support`` devarg (default off).
     Added a ``func_error_recovery`` xstat to report the recovery count.
+  * Enabled the extended ring statistics, including the TPA counters,
+    on P5 devices that support TPA v2.
 
 * **Updated Intel i40e driver.**
 
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index a456131c5c..30ac4da16d 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -791,7 +791,7 @@ static int bnxt_update_phy_setting(struct bnxt *bp)
 static void bnxt_free_prev_ring_stats_ext(struct bnxt *bp)
 {
 	/* tpa v2 devices use ext variant local struct */
-	if (BNXT_TPA_V2_P7(bp)) {
+	if (BNXT_TPA_V2_P7(bp) || BNXT_TPA_V2_P5(bp)) {
 		rte_free(bp->prev_rx_ring_stats_ext);
 		rte_free(bp->prev_tx_ring_stats_ext);
 		bp->prev_rx_ring_stats_ext = NULL;
@@ -846,7 +846,7 @@ static int bnxt_alloc_prev_ring_ext_stats(struct bnxt *bp)
 
 static int bnxt_alloc_prev_ring_stats(struct bnxt *bp)
 {
-	if (BNXT_TPA_V2_P7(bp))
+	if (BNXT_TPA_V2_P7(bp) || BNXT_TPA_V2_P5(bp))
 		return bnxt_alloc_prev_ring_ext_stats(bp);
 
 	if (bp->prev_rx_ring_stats == NULL)
diff --git a/drivers/net/bnxt/bnxt_hwrm.h b/drivers/net/bnxt/bnxt_hwrm.h
index 546107b08d..6ddb9acf97 100644
--- a/drivers/net/bnxt/bnxt_hwrm.h
+++ b/drivers/net/bnxt/bnxt_hwrm.h
@@ -169,13 +169,14 @@ struct bnxt_pf_resource_info {
 	 BNXT_TUNNELED_OFFLOADS_CAP_GRE_EN(bp)   &&		\
 	 BNXT_TUNNELED_OFFLOADS_CAP_IPINIP_EN(bp))
 
-/* Is this tpa_v2 and P7
- * Just add P5 to this once we validate on Thor FW
- */
+/* Is this tpa_v2 and P7 */
 #define BNXT_TPA_V2_P7(bp) ((bp)->max_tpa_v2 && BNXT_CHIP_P7(bp))
+/* Is this tpa_v2 and P5 */
+#define BNXT_TPA_V2_P5(bp) ((bp)->max_tpa_v2 && BNXT_CHIP_P5(bp))
 /* Get the size of the stat context size for DMA from HW */
-#define BNXT_HWRM_CTX_GET_SIZE(bp)  (BNXT_TPA_V2_P7(bp) ?	\
-	sizeof(struct ctx_hw_stats_ext) :			\
+#define BNXT_HWRM_CTX_GET_SIZE(bp)					\
+	(BNXT_TPA_V2_P7(bp) ? sizeof(struct ctx_hw_stats_ext) :         \
+	BNXT_TPA_V2_P5(bp) ? (sizeof(struct ctx_hw_stats_ext) - sizeof(uint64_t)) :	\
 	sizeof(struct ctx_hw_stats))
 
 int bnxt_hwrm_cfa_l2_clear_rx_mask(struct bnxt *bp,
diff --git a/drivers/net/bnxt/bnxt_rxq.c b/drivers/net/bnxt/bnxt_rxq.c
index 62530d261d..faa9aaf343 100644
--- a/drivers/net/bnxt/bnxt_rxq.c
+++ b/drivers/net/bnxt/bnxt_rxq.c
@@ -512,7 +512,7 @@ int bnxt_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	/* reset the previous stats for the rx_queue since the counters
 	 * will be cleared when the queue is started.
 	 */
-	if (BNXT_TPA_V2_P7(bp))
+	if (BNXT_TPA_V2_P7(bp) || BNXT_TPA_V2_P5(bp))
 		memset(&bp->prev_rx_ring_stats_ext[rx_queue_id], 0,
 		       sizeof(struct bnxt_ring_stats_ext));
 	else
diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index 7c7c7c04cf..d3391b8e6d 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -617,7 +617,7 @@ int bnxt_get_ring_stats_masks(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
 	if (cpr->hw_stats_ctx_id == HWRM_NA_SIGNATURE)
 		return 0;
 
-	if (BNXT_TPA_V2_P7(bp))
+	if (BNXT_TPA_V2_P7(bp) || BNXT_TPA_V2_P5(bp))
 		bnxt_hwrm_ring_stats_ext_masks(bp, cpr);
 	else
 		bnxt_hwrm_ring_stats_masks(bp, cpr);
@@ -824,6 +824,11 @@ int bnxt_get_ring_stats_ext(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, int
 		if (stat_ext_offsets->is_rx != rx)
 			continue;
 
+		/* P5 ext stats does not report rx_tpa_events */
+		if (BNXT_TPA_V2_P5(bp) &&
+		   stat_ext_offsets->dst_off == offsetof(struct bnxt_ring_stats_ext, rx_tpa_events))
+			continue;
+
 		*out = bnxt_pick_ring_stat(*prev,
 				rte_le_to_cpu_64(*bnxt_stat_ptr(curr_stats,
 								stat_ext_offsets->src_off)),
@@ -1014,7 +1019,7 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 	if (rc)
 		return rc;
 
-	if (BNXT_TPA_V2_P7(bp))
+	if (BNXT_TPA_V2_P7(bp) || BNXT_TPA_V2_P5(bp))
 		return bnxt_stats_get_ext(eth_dev, bnxt_stats, qstats);
 
 	bnxt_stats->oerrors += rte_atomic_load_explicit(&bp->func_error_info->oerrors,
@@ -1078,7 +1083,7 @@ static void bnxt_clear_prev_stat(struct bnxt *bp)
 	 * Clear the cached values of stats returned by HW in the previous
 	 * get operation.
 	 */
-	if (BNXT_TPA_V2_P7(bp)) {
+	if (BNXT_TPA_V2_P7(bp) || BNXT_TPA_V2_P5(bp)) {
 		memset(bp->prev_rx_ring_stats_ext, 0,
 		       sizeof(struct bnxt_ring_stats_ext) * bp->rx_cp_nr_rings);
 		memset(bp->prev_tx_ring_stats_ext, 0,
@@ -1218,7 +1223,7 @@ int bnxt_dev_xstats_get_op(struct rte_eth_dev *eth_dev,
 	if (rc)
 		return rc;
 
-	if (BNXT_TPA_V2_P7(bp))
+	if (BNXT_TPA_V2_P7(bp) || BNXT_TPA_V2_P5(bp))
 		sz = RTE_DIM(bnxt_func_stats_ext_strings);
 	else
 		sz = RTE_DIM(bnxt_func_stats_strings);
@@ -1242,7 +1247,7 @@ int bnxt_dev_xstats_get_op(struct rte_eth_dev *eth_dev,
 		if (!rxq->rx_started)
 			continue;
 
-		if (BNXT_TPA_V2_P7(bp))
+		if (BNXT_TPA_V2_P7(bp) || BNXT_TPA_V2_P5(bp))
 			rc = bnxt_get_ring_stats_ext(bp, cpr, i,
 						     &ring_stats_ext, true);
 		else
@@ -1252,7 +1257,7 @@ int bnxt_dev_xstats_get_op(struct rte_eth_dev *eth_dev,
 		if (unlikely(rc))
 			return rc;
 
-		if (BNXT_TPA_V2_P7(bp))
+		if (BNXT_TPA_V2_P7(bp) || BNXT_TPA_V2_P5(bp))
 			bnxt_fill_func_qstats_ext(&func_qstats_ext,
 						  &ring_stats_ext, true);
 		else
@@ -1268,7 +1273,7 @@ int bnxt_dev_xstats_get_op(struct rte_eth_dev *eth_dev,
 		if (!txq->tx_started)
 			continue;
 
-		if (BNXT_TPA_V2_P7(bp))
+		if (BNXT_TPA_V2_P7(bp) || BNXT_TPA_V2_P5(bp))
 			rc = bnxt_get_ring_stats_ext(bp, cpr, i,
 						     &ring_stats_ext, false);
 		else
@@ -1277,7 +1282,7 @@ int bnxt_dev_xstats_get_op(struct rte_eth_dev *eth_dev,
 		if (unlikely(rc))
 			return rc;
 
-		if (BNXT_TPA_V2_P7(bp))
+		if (BNXT_TPA_V2_P7(bp) || BNXT_TPA_V2_P5(bp))
 			bnxt_fill_func_qstats_ext(&func_qstats_ext,
 						  &ring_stats_ext, false);
 		else
@@ -1314,7 +1319,7 @@ int bnxt_dev_xstats_get_op(struct rte_eth_dev *eth_dev,
 		count++;
 	}
 
-	if (BNXT_TPA_V2_P7(bp)) {
+	if (BNXT_TPA_V2_P7(bp) || BNXT_TPA_V2_P5(bp)) {
 		for (i = 0; i < RTE_DIM(bnxt_func_stats_ext_strings); i++) {
 			xstats[count].id = count;
 			xstats[count].value = *(uint64_t *)((char *)&func_qstats_ext +
@@ -1428,7 +1433,7 @@ int bnxt_dev_xstats_get_names_op(struct rte_eth_dev *eth_dev,
 	if (rc)
 		return rc;
 
-	if (BNXT_TPA_V2_P7(bp))
+	if (BNXT_TPA_V2_P7(bp) || BNXT_TPA_V2_P5(bp))
 		sz = RTE_DIM(bnxt_func_stats_ext_strings);
 	else
 		sz = RTE_DIM(bnxt_func_stats_strings);
@@ -1458,7 +1463,7 @@ int bnxt_dev_xstats_get_names_op(struct rte_eth_dev *eth_dev,
 		count++;
 	}
 
-	if (BNXT_TPA_V2_P7(bp)) {
+	if (BNXT_TPA_V2_P7(bp) || BNXT_TPA_V2_P5(bp)) {
 		for (i = 0; i < RTE_DIM(bnxt_func_stats_ext_strings); i++) {
 			strlcpy(xstats_names[count].name,
 				bnxt_func_stats_ext_strings[i].name,
diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index e81a0a1860..15c7fca40b 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -890,7 +890,7 @@ int bnxt_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	/* reset the previous stats for the tx_queue since the counters
 	 * will be cleared when the queue is started.
 	 */
-	if (BNXT_TPA_V2_P7(bp))
+	if (BNXT_TPA_V2_P7(bp) || BNXT_TPA_V2_P5(bp))
 		memset(&bp->prev_tx_ring_stats_ext[tx_queue_id], 0,
 		       sizeof(struct bnxt_ring_stats_ext));
 	else
-- 
2.47.3

