Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD3ACD6E55
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 03:17:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F3E940677;
	Thu,  4 Jun 2026 05:17:13 +0200 (CEST)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by mails.dpdk.org (Postfix) with ESMTP id 1D2414060B
 for <dev@dpdk.org>; Thu,  4 Jun 2026 05:17:12 +0200 (CEST)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2bf77d4a4e2so7975125ad.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780543031; x=1781147831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GTujN6l1EpUlhmoph8POqrXkrYpyLmAd1vLOS+xC6TM=;
 b=LO1VBby2QojNOQ07Peg7TBLxuNE4x3ruHBU6Exmi8pj5BmrVZ34SU7ZP7Xk+EwnXwT
 NA3g1IVQqY6jxZ0g1ED4KBuUGQ4aHQ/HMjAeRd4WCPt/qTLl97ca2sktLKTdriDDERJY
 awYve5H8xLkNHGQ7Akc8dH+DxAm0oXQk/TDlxsmek8fQ/gCBPigeoeY1VkMVuEPNM/cM
 R8zxdbWpGKBtSt+IluC7VV3BaawEV917Wkzw1AoPB3KJexiykzAByVveMuB9jKQWU1jo
 9nbZ1h6F8wT614+7D83ZCxX/t3SzZhK1bEyt2oKP8OuNcEedLwPoEFiOgdWBaK9NQI6b
 MYDg==
X-Gm-Message-State: AOJu0YyYnvivvZGWk9hb9ZMCuda01vMkAfMQdnk/k8L28w86Q1o9m39h
 IsocDQNTVcDsQKGvfJPfH45c9FUKjRUeb/JHABpv20C+dlahfI5DfrYXB+J3r3gUthgvRT9mkjG
 Tnlpyzbn8jX0LdSeVOFLzhIlRcOqJsnRT1u0rLY6ZWWp9EYy8qhhihLLxgQIL/iXNVBjZFIZpoU
 84ZY1CWuLbpkXmJoux5Pk4Pr8hXooychOoqXXGgZ/1B8r74RmRISdZsv44rmy1TbbYmj6aKQF4q
 jMWDGJsk62o
X-Gm-Gg: Acq92OGIwJbTBud+Iy0zPUSg/IqdxXpHpFNzKLXqNQLgEXJ0VJtcatrCjTDdTLsFRIE
 BTbmz3aDHAWkpmUHHxV190TKnnbMxYI3zPuML3UNP7P3MqSgKnIano0Sbd+fPhzRI1jp3VYkJmx
 jc6xgSPRAmvEpxQxkivFxDbUgNXlvbUDK4Z2TDvr4U9LlHxnJtWupZ0euRONP+956WQv89GloXr
 4oHpWNRYZV23Kq9fkNhO2zYVz+1uq4hCoPZx18HNqqLzUVRIjiKDb97z5fxhjgKme32Lc30tF5C
 cRrTQndKnE65FfxYBQrcLBRZWH+6lcm1BDsKTm2QD5lKFSQv/uhEDIzOa7IVZq6ijP2KfIqTbNv
 kifQC2NUnVVP4yurZumzPXSDQ8PdXnU45pjuNnbF5vbZCPczse9+HubDY46i0GpiJOq2z9S2bg0
 jYY0Zhhymu86D3lcuJBxn6O/8ZTFaGoQZzGVUejSGFTnSkMZxexZmgDE0Eu/wukS/Qylgv1eXip
 V60y6CcBQ==
X-Received: by 2002:a17:902:ea0d:b0:2c0:ccdf:5e61 with SMTP id
 d9443c01a7336-2c197c31660mr17513005ad.6.1780543031120; 
 Wed, 03 Jun 2026 20:17:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2c165f9fd3csm3986995ad.31.2026.06.03.20.17.10
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 20:17:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9159c4b210aso46112585a.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780543030; x=1781147830; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GTujN6l1EpUlhmoph8POqrXkrYpyLmAd1vLOS+xC6TM=;
 b=IBEOAE6LZI1QTy1ZpHBAQ0ZQAlhwURgUxLcdB/Ys0/EmhJid7jHH1x6/FQz2vXO8hz
 olbkZyaRLMVHGtsHUctp71160ZSGaB3jSbCmqIoGp1mUqUJnPKNGVGa3wmG3StR5SMmQ
 /NHxw1lROVuILSllhzS+siguqgMIrmOlT4+Ig=
X-Received: by 2002:a05:620a:1a13:b0:915:83b1:fc43 with SMTP id
 af79cd13be357-9159aeadfa5mr337130685a.12.1780543029873; 
 Wed, 03 Jun 2026 20:17:09 -0700 (PDT)
X-Received: by 2002:a05:620a:1a13:b0:915:83b1:fc43 with SMTP id
 af79cd13be357-9159aeadfa5mr337128485a.12.1780543029399; 
 Wed, 03 Jun 2026 20:17:09 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a009fe7sm446421685a.8.2026.06.03.20.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 20:17:07 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 Keegan Freyhof <keegan.freyhof@broadcom.com>
Subject: [PATCH 04/10] net/bnxt: scalar rx path disregarded rxcmp flags for
 setting ptp mbuf flag setting ptp mbuf flag
Date: Wed,  3 Jun 2026 21:18:45 -0600
Message-ID: <20260604031851.2267548-5-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604031851.2267548-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260604031851.2267548-1-Mohammad-Shuab.Siddique@broadcom.com>
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

Added a check so that if bp->ptp_all_rx_tstamp is true
- it is always set to true when set fwd ieee1588 is called via
bnxt_timesync_enable - the hardware must also report that the packet
is ptp. Also changed the code so that the path properly reports if
the packet has a timestamp.

Fixes: 925cd0705836 ("net/bnxt: update PTP support on Thor")
Cc: stable@dpdk.org
Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c |  2 --
 drivers/net/bnxt/bnxt_hwrm.c   | 28 +++-------------------------
 drivers/net/bnxt/bnxt_rxr.c    | 13 ++++++++-----
 drivers/net/bnxt/bnxt_stats.c  |  3 +++
 drivers/net/bnxt/bnxt_txr.c    | 34 ++++++++++++++++++++++++++++++----
 4 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 5bd51de3cd..791a89f040 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -1493,8 +1493,6 @@ bnxt_receive_function(struct rte_eth_dev *eth_dev)
 		bp->flags |= BNXT_FLAG_RX_VECTOR_PKT_MODE;
 		if (bnxt_compressed_rx_cqe_mode_enabled(bp))
 			return bnxt_crx_pkts_vec_avx2;
-		if (BNXT_TRUFLOW_EN(bp) && bnxt_ulp_explicit_mark_enabled(bp))
-			goto use_scalar_rx;
 		if (BNXT_CHIP_P7(bp))
 			return bnxt_recv_pkts_vec_avx2_v3;
 		else
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 590543ad6a..4a5b83d29c 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -4347,6 +4347,9 @@ static int bnxt_hwrm_set_tpa(struct bnxt *bp)
 	bool tpa_flags = 0;
 	int rc, i;
 
+	if (!BNXT_SUPPORTS_TPA(bp))
+		return 0;
+
 	tpa_flags = (rx_offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO) ?  true : false;
 	for (i = 0; i < bp->max_vnics; i++) {
 		struct bnxt_vnic_info *vnic = &bp->vnic_info[i];
@@ -4946,31 +4949,6 @@ int bnxt_hwrm_pf_evb_mode(struct bnxt *bp)
 	return rc;
 }
 
-static int bnxt_hwrm_set_tpa(struct bnxt *bp)
-{
-	struct rte_eth_conf *dev_conf = &bp->eth_dev->data->dev_conf;
-	uint64_t rx_offloads = dev_conf->rxmode.offloads;
-	bool tpa_flags = 0;
-	int rc, i;
-
-	if (!BNXT_SUPPORTS_TPA(bp))
-		return 0;
-
-	tpa_flags = (rx_offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO) ?  true : false;
-	for (i = 0; i < bp->max_vnics; i++) {
-		struct bnxt_vnic_info *vnic = &bp->vnic_info[i];
-
-		if (vnic->fw_vnic_id == INVALID_HW_RING_ID)
-			continue;
-
-		rc = bnxt_hwrm_vnic_tpa_cfg(bp, vnic, tpa_flags);
-		if (rc)
-			return rc;
-	}
-	return 0;
-}
-
-
 int bnxt_hwrm_tunnel_dst_port_alloc(struct bnxt *bp, uint16_t port,
 				uint8_t tunnel_type)
 {
diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index ab2175d21a..046276f931 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -1203,11 +1203,14 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 	mbuf->data_len = mbuf->pkt_len;
 	mbuf->port = rxq->port_id;
 
-	if (unlikely(((rte_le_to_cpu_16(rxcmp->flags_type) &
-		      RX_PKT_CMPL_FLAGS_MASK) ==
-		      RX_PKT_CMPL_FLAGS_ITYPE_PTP_W_TIMESTAMP) ||
-		      bp->ptp_all_rx_tstamp) && bp->ieee_1588 &&
-		      bp->ptp_cfg) {
+	if (unlikely((((rte_le_to_cpu_16(rxcmp->flags_type) &
+			RX_PKT_CMPL_FLAGS_MASK) ==
+			RX_PKT_CMPL_FLAGS_ITYPE_PTP_W_TIMESTAMP) ||
+			((rte_le_to_cpu_16(rxcmp->flags_type) &
+			RX_PKT_CMPL_FLAGS_MASK) ==
+			RX_PKT_CMPL_FLAGS_ITYPE_PTP_WO_TIMESTAMP)) &&
+			bp->ptp_all_rx_tstamp) && bp->ieee_1588 &&
+			bp->ptp_cfg) {
 		mbuf->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP |
 				  RTE_MBUF_F_RX_IEEE1588_TMST;
 		if (BNXT_CHIP_P5_P7(bp))
diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index 49367588e4..ba858710a5 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -695,6 +695,9 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 		struct bnxt_cp_ring_info *cpr = txq->cp_ring;
 		struct bnxt_ring_stats_ext ring_stats = {0};
 
+		bnxt_stats->oerrors += rte_atomic_load_explicit(&txq->tx_mbuf_drop,
+							     rte_memory_order_relaxed);
+
 		if (!txq->tx_started)
 			continue;
 
