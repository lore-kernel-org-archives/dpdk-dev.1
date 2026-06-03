Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C08CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 20:36:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9718540676;
	Wed,  3 Jun 2026 22:36:05 +0200 (CEST)
Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
 by mails.dpdk.org (Postfix) with ESMTP id 0E71740670
 for <dev@dpdk.org>; Wed,  3 Jun 2026 22:36:04 +0200 (CEST)
Received: by mail-dl1-f99.google.com with SMTP id
 a92af1059eb24-137f27712fdso541458c88.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 13:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780518963; x=1781123763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fXRZAAZqVjmJHCLakx6MH83WDvngK5J7bocOC0nN+TA=;
 b=Y65cWPiGG7Xt0Qfj+mK+oOv0wXR1pDf1CNI73fgsQJAp8K4MsMinLQ6yvjz7zDyy+v
 vZiuEyUQeE/QrEB9GuD3jGWJzKdbV39qxf/EfUT7fxHQExdN4cNQ/6bjH/UZAtJAjt71
 sQsKB6W7810b0pVlaE1f2qYHOM4Hi5Ry6zgpaVQEv9F7wH0EvW4BQY1HeC4cP4lvjo36
 ssKp/ULU5B4AfinIFAKMIASz4O3EwKDp3OshB7Vha5+q5Lg9NNCnIn05JJPCTWXw6p2M
 zzPLSc9VWxitKgy1plk20gpQADY7rv7bpa15JwxzJh3EnY9ntzDfrLhFxah2Z1bN/j10
 o1uA==
X-Gm-Message-State: AOJu0YyyAASfAEm4xlXJF1l/jZ5y35JRkdpjrfqyVylLWQDkuqEIgvE4
 aEDWhGYBAbInNcLJ84v6ikizBNQ+wBH3lk+r+O76FnT4CVSSulsXDEtnFLoYKvSjFraDgzgWAVB
 dnkf6LkiIEmdLZrcrOAa56x5/3GHoYw9DJqzXuNGxeZ1PS4ZD/7MNJMUEN6+UIsrCVaBiaa6+HT
 XYriQ4uJNaVsPhKV0g8sp9EZjT66q0zip/R5INtx1Q0WQhbKPEJDCDURNhUOQkAF8rGa0O2b395
 99UisQnsDJt
X-Gm-Gg: Acq92OF2ZK3dkZN3sXIYL7wUdR0ehUBahGrijGwCOkaT0saUJPx2nKyN8oF23c5Q5Je
 fWtvOecmFlLCtT1AA1Y/G6d65y32qdRu/4a81vtJ9V4/s2DxPwXcwBToUAb+XbWKfgty0OPDRAG
 gGUTAvGConekoXprnDbZtfyq+gnJUwn2fbO+XsgymB0nju+QWBGWpzGIXdLJTRx/7owsjrwkgSP
 4io+KImQ0qDZ2HbBcRYw+/6WQK5wdMQndK0+KKOaewiK0nD0ZBapPHv0ww+/+3hpGzQI/f/dddC
 bVVpAky16YPsPtCmo0nxnYueEvc2cs7sXwDnekEmpBSqyz7xWssIEOcpAjOPiQdtw3DjAZOU10v
 LC15nfMXmewWFGvmAYzSfNYgu9Z204J9kKVUXCD+H0sfxUZeUS9DQpvrCTo949/EBIjLc+Siyen
 w2T/hfFfUUx+H8ESUJlcDQO6j59KhgyFhkujZdYW7hd9pINq6LJrpB+ZzXw2tCG9Iru1KAM2o3d
 ydN6w5FKMFQ
X-Received: by 2002:a05:7300:7fa4:b0:304:d75b:f5f4 with SMTP id
 5a478bee46e88-3074fbc6944mr2892037eec.16.1780518963030; 
 Wed, 03 Jun 2026 13:36:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-3074db4a2fesm214119eec.6.2026.06.03.13.36.02
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 13:36:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9157d38ab37so688685a.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780518962; x=1781123762; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXRZAAZqVjmJHCLakx6MH83WDvngK5J7bocOC0nN+TA=;
 b=Y1nr87zAVM8uTyk7iYlv0GwXW+DXKyDH0HuCtnQJsiPoLzRho6NhWuiVgJLABh9Lh1
 8ZRVFREq+Nc64ySMrvwXqojgmYFW7kxUJAD/2ABb2QgTzU3K38Ft1tdWeKMY/BlpAkXV
 MULRHWb7V3eh0AR/9k2ElDPffw0ncWvnHZlTU=
X-Received: by 2002:a05:620a:6601:b0:915:8502:f7f9 with SMTP id
 af79cd13be357-9158a811a3dmr810153085a.31.1780518961573; 
 Wed, 03 Jun 2026 13:36:01 -0700 (PDT)
X-Received: by 2002:a05:620a:6601:b0:915:8502:f7f9 with SMTP id
 af79cd13be357-9158a811a3dmr810143785a.31.1780518960762; 
 Wed, 03 Jun 2026 13:36:00 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a22dbbesm340925085a.13.2026.06.03.13.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:36:00 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 4/4] net/bnxt: Add PTP support for Thor2
Date: Wed,  3 Jun 2026 14:37:38 -0600
Message-ID: <20260603203738.2084478-5-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603203738.2084478-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603203738.2084478-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

If firmware advertises support for the TX timestamp completion and
PTP is also supported, then enable this feature when allocating TX
rings.

The new BCM5760X chips will return the timestamp of TX packets in a
new completion. Add logic to handle this completion type to retrieve
the timestamp.

Logic to retrieve Rx timestamp is same as Thor.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt.h        |  3 +++
 drivers/net/bnxt/bnxt_ethdev.c |  8 +++++---
 drivers/net/bnxt/bnxt_hwrm.c   |  8 +++++++-
 drivers/net/bnxt/bnxt_rxr.c    | 10 +++++-----
 drivers/net/bnxt/bnxt_txr.c    | 16 ++++++++++++++++
 5 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 7515f0564f..03df28e64a 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -410,6 +410,8 @@ struct bnxt_ptp_cfg {
 	uint64_t			current_time;
 	uint64_t			old_time;
 	rte_spinlock_t			ptp_lock;
+	/* On P7, the Tx timestamp is present in the Tx completion record */
+	uint64_t			tx_timestamp;
 };
 
 struct bnxt_coal {
@@ -892,6 +894,7 @@ struct bnxt {
 	 (bp)->hwrm_spec_code >= HWRM_VERSION_1_9_2 && \
 	 !BNXT_VF((bp)))
 #define BNXT_FW_CAP_UDP_GSO		BIT(13)
+#define BNXT_FW_CAP_TX_TS_CMP		BIT(16)
 #define BNXT_TRUFLOW_EN(bp)	((bp)->fw_cap & BNXT_FW_CAP_TRUFLOW_EN &&\
 				 (bp)->app_id != 0xFF)
 
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 64b12ada9f..72a31dfbb5 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -3889,9 +3889,11 @@ bnxt_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 	if (!ptp)
 		return -ENOTSUP;
 
-	/* TODO Revisit for Thor 2 */
-	rc = bnxt_hwrm_port_ts_query(bp, BNXT_PTP_FLAGS_PATH_TX,
-				     &tx_tstamp_cycles);
+	if (BNXT_CHIP_P7(bp))
+		tx_tstamp_cycles = ptp->tx_timestamp;
+	else
+		rc = bnxt_hwrm_port_ts_query(bp, BNXT_PTP_FLAGS_PATH_TX,
+					     &tx_tstamp_cycles);
 
 	ns = rte_timecounter_update(&ptp->tx_tstamp_tc, tx_tstamp_cycles);
 	*timestamp = rte_ns_to_timespec(ns);
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 68e75e43bd..e4ae27d3f4 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -1027,7 +1027,8 @@ static int bnxt_hwrm_ptp_qcfg(struct bnxt *bp)
 
 	HWRM_CHECK_RESULT();
 
-	if (!(resp->flags & HWRM_PORT_MAC_PTP_QCFG_OUTPUT_FLAGS_HWRM_ACCESS))
+	if (!BNXT_CHIP_P7(bp) &&
+	    !(resp->flags & HWRM_PORT_MAC_PTP_QCFG_OUTPUT_FLAGS_HWRM_ACCESS))
 		return 0;
 
 	if (resp->flags & HWRM_PORT_MAC_PTP_QCFG_OUTPUT_FLAGS_ONE_STEP_TX_TS)
@@ -1224,6 +1225,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_RX_ALL_PKT_TS;
 	if (flags_ext2 & HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT2_UDP_GSO_SUPPORTED)
 		bp->fw_cap |= BNXT_FW_CAP_UDP_GSO;
+	if (flags_ext2 & HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT2_TX_PKT_TS_CMPL_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_TX_TS_CMP;
 	if (flags_ext3 & HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT3_RX_RATE_PROFILE_SEL_SUPPORTED)
 		bp->fw_cap |= BNXT_FW_CAP_RX_RATE_PROFILE;
 
@@ -2192,6 +2195,9 @@ int bnxt_hwrm_ring_alloc(struct bnxt *bp,
 		if (stats_ctx_id != INVALID_STATS_CTX_ID)
 			enables |=
 			HWRM_RING_ALLOC_INPUT_ENABLES_STAT_CTX_ID_VALID;
+		if (bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP && bp->ptp_cfg)
+			req.flags =
+				rte_cpu_to_le_16(HWRM_RING_ALLOC_INPUT_FLAGS_TX_PKT_TS_CMPL_ENABLE);
 		break;
 	case HWRM_RING_ALLOC_INPUT_RING_TYPE_RX:
 		req.ring_type = ring_type;
diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index fb7c70fd45..293b5c03b6 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -740,13 +740,13 @@ static void bnxt_get_rx_ts(struct bnxt *bp)
 }
 
 static void
-bnxt_get_rx_ts_p5(struct bnxt *bp, uint32_t rx_ts_cmpl)
+bnxt_get_rx_ts_p5_p7(struct bnxt *bp, uint32_t rx_ts_cmpl)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
-	uint64_t last_hwrm_time = 0;
+	uint64_t last_hwrm_time;
 	uint64_t pkt_time = 0;
 
-	if (!BNXT_CHIP_P5(bp) || !ptp)
+	if (!ptp)
 		return;
 
 	/* On P5, Rx timestamps are provided directly in the
@@ -1210,8 +1210,8 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 		      bp->ptp_cfg) {
 		mbuf->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP |
 				  RTE_MBUF_F_RX_IEEE1588_TMST;
-		if (BNXT_CHIP_P5(bp))
-			bnxt_get_rx_ts_p5(rxq->bp, rxcmp1->reorder);
+		if (BNXT_CHIP_P5_P7(bp))
+			bnxt_get_rx_ts_p5_p7(rxq->bp, rxcmp1->reorder);
 		else
 			bnxt_get_rx_ts(rxq->bp);
 #ifndef RTE_IOVA_IN_MBUF
diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index 7ef5b15ae8..fb5be224d9 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -600,6 +600,20 @@ static bool bnxt_is_tx_cmpl_type(uint16_t type)
 		type == CMPL_BASE_TYPE_TX_L2);
 }
 
+static void bnxt_get_tx_ts_p7(struct bnxt *bp, struct tx_cmpl_packet_timestamp *txcmp)
+{
+	uint64_t tx_timestamp;
+
+	if (!(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
+		return;
+
+	if (!bp->ptp_cfg || !bp->ieee_1588)
+		return;
+
+	tx_timestamp = rte_le_to_cpu_16(txcmp->ts_ns_mid);
+	bp->ptp_cfg->tx_timestamp = (tx_timestamp << 32) | rte_le_to_cpu_32(txcmp->ts_ns_lo);
+}
+
 static int bnxt_handle_tx_cp(struct bnxt_tx_queue *txq)
 {
 	uint32_t nb_tx_pkts = 0, cons, ring_mask, opaque;
@@ -629,6 +643,8 @@ static int bnxt_handle_tx_cp(struct bnxt_tx_queue *txq)
 			RTE_LOG_DP_LINE(ERR, BNXT,
 					"Unhandled CMP type %02x",
 					CMP_TYPE(txcmp));
+		if (CMP_TYPE(txcmp) == CMPL_BASE_TYPE_TX_L2_PKT_TS)
+			bnxt_get_tx_ts_p7(txq->bp, (struct tx_cmpl_packet_timestamp *)txcmp);
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 	} while (nb_tx_pkts < ring_mask);
 
-- 
2.47.3

