Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EC3CD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 20:36:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A08740693;
	Wed,  3 Jun 2026 22:36:01 +0200 (CEST)
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com
 [209.85.128.225])
 by mails.dpdk.org (Postfix) with ESMTP id 6E25040674
 for <dev@dpdk.org>; Wed,  3 Jun 2026 22:36:00 +0200 (CEST)
Received: by mail-yw1-f225.google.com with SMTP id
 00721157ae682-7dbcb505578so81035337b3.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 13:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780518960; x=1781123760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UQy7dXfPfzf47jsyiB4kB51iIDJjwW3r2G3n0E+evfc=;
 b=WdP3iSOIgIzHWU3sE4ofl/LMDVfF++LniDOnw0ygIt792FRbjsS4LDk7Pqq8mwn/+b
 +PRjJEETp6WKJLNy8d3TOFIpuOvDAHaWwLG+t8sK2kckpHHoZUkllIf6lGaZ5lC9lAl4
 aZm7T0jMGoxUWGfa9QCDB+hsaRGFnAYi2i0+xn5fa4uu9W51Ue7UKwK71dFNzuIMYxbb
 CHA0/hPUXhN7WIdInu4voZuVcNE2jnQe1RELr5YH/OcL0zlRrSY6cbu19J8HhXMsrR5O
 ivWt4Bln+iCHt+sORKhcoI8/qXj1WWE9QKhqZj9nOmxxNTPorkJCR/HQJntYqDxecg8m
 mV6Q==
X-Gm-Message-State: AOJu0YzoUIpB5F3Tt138BKXZXNW+0V5aKPX8nx1NorDTr8dsZf8PRnm1
 XIZEJLH9+5f2qGKabUxHmqJ/sFC99/DtcKYs7/eOMNKHBxLoXWuaL0dCzJWUrSGpOPW5fL72riw
 AMfi8L1NHG779y6qx7FeaXuDGrjSHYtr4704D9dCGZikpL4Q2tKGJDGbYMOvEU9w4eqj1hZjXsl
 NNPv318wh7m/WsN8zAtC6sEqOG/6fksWQ5sc+hcvjOUkJCxJn53JgZ+DoO6ZGbYad9fitOyt8wS
 RNV658wDMXc
X-Gm-Gg: Acq92OEEla8M/MprX8SVoOX7Mc3mk84zywijBje7RortJWdQQ/Cy/gE8i5VbwIw/ts6
 iF0wDsOgWQPpT99S0L6A8YXJ5vIWmmgTn36mqH/FqA5UIeLvAo5P7SgwjrRyCfidrCawfCei0vr
 4thURNBSo3iBMkzTVG5urM2e69vPf1SU3TaGRfl52OB3N2wcfRvQNiI8GFqIBOMn4weJoB2Tnp2
 5D4FtTMooEdovm5qMpy4J3gQd2CCUrOzEVsXOCjibk3l9qDmALrcmMjYmQTLA/VVe5VPDSVG1Ma
 QCGjgPsxZKuxHjiuNhkeBKq7M93WYXW4t165yPe12JsONKhjY5af/i8WSM3UJoDXLa7L2f8TQpe
 vt6tJItH8XF225AVL9gPpHYcsKAHynvIBZfnlq9pJRlkpGYgVOZcAg3aKf3mIj3E7jhuAiHSev+
 vi+qrd3yAKPuZgCG0gim1zduJxmRaEnkVGXs4Fzskm6NR5Z+czov0qqiR/ci8ncy56EH88R88Ep
 B2kHytNUHmn
X-Received: by 2002:a05:690c:e343:b0:7c0:e1ab:87fb with SMTP id
 00721157ae682-7ea4a254631mr48711547b3.12.1780518959631; 
 Wed, 03 Jun 2026 13:35:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-7ea23ea24bfsm2521377b3.25.2026.06.03.13.35.59
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 13:35:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915767b341eso405554385a.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 13:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780518959; x=1781123759; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQy7dXfPfzf47jsyiB4kB51iIDJjwW3r2G3n0E+evfc=;
 b=eufFCX4HS4pe1j3D9MXrSLDM/uIkfhoGY3oDI81a182+Muzz0O95xtgZtvg0HuNf7o
 ZNHMKinjaZHRuJIT8nNXmnSO384H4XAdHJkqlxpY6kwIoWsobJc3qEmu/zfIyhYcRwjw
 1FivwGRK5VLJeDDxvDZSpoTYaYSUTRSZnkefk=
X-Received: by 2002:a05:620a:2592:b0:90e:2f56:2f0b with SMTP id
 af79cd13be357-9158a6cd001mr872901185a.7.1780518958855; 
 Wed, 03 Jun 2026 13:35:58 -0700 (PDT)
X-Received: by 2002:a05:620a:2592:b0:90e:2f56:2f0b with SMTP id
 af79cd13be357-9158a6cd001mr872892985a.7.1780518957996; 
 Wed, 03 Jun 2026 13:35:57 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a22dbbesm340925085a.13.2026.06.03.13.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:35:57 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 3/4] net/bnxt: Support for Tx/Rx timestamp using HWRM on Wh+
Date: Wed,  3 Jun 2026 14:37:37 -0600
Message-ID: <20260603203738.2084478-4-Mohammad-Shuab.Siddique@broadcom.com>
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

The Rx/Tx timestamp will now be made available using the HWRM cmd
PORT_TS_QUERY on BCM57414 chips.
Get rid of the earlier code that was fetching this using register
access.

Fixes: b11cceb83a34 ("net/bnxt: support timesync")
Cc: stable@dpdk.org
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 109 +--------------------------------
 drivers/net/bnxt/bnxt_rxr.c    |  17 ++++-
 2 files changed, 19 insertions(+), 107 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 14d8fa705d..64b12ada9f 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -3754,99 +3754,6 @@ bnxt_dev_supported_ptypes_get_op(struct rte_eth_dev *dev,
 	return ptypes;
 }
 
-static uint64_t bnxt_cc_read(struct bnxt *bp)
-{
-	uint64_t ns;
-
-	ns = rte_le_to_cpu_32(rte_read32((uint8_t *)bp->bar0 +
-			      BNXT_GRCPF_REG_SYNC_TIME));
-	ns |= (uint64_t)(rte_le_to_cpu_32(rte_read32((uint8_t *)bp->bar0 +
-					  BNXT_GRCPF_REG_SYNC_TIME + 4))) << 32;
-	return ns;
-}
-
-static int bnxt_get_tx_ts(struct bnxt *bp, uint64_t *ts)
-{
-	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
-	uint32_t fifo;
-
-	fifo = rte_le_to_cpu_32(rte_read32((uint8_t *)bp->bar0 +
-				ptp->tx_mapped_regs[BNXT_PTP_TX_FIFO]));
-	if (fifo & BNXT_PTP_TX_FIFO_EMPTY)
-		return -EAGAIN;
-
-	fifo = rte_le_to_cpu_32(rte_read32((uint8_t *)bp->bar0 +
-				ptp->tx_mapped_regs[BNXT_PTP_TX_FIFO]));
-	*ts = rte_le_to_cpu_32(rte_read32((uint8_t *)bp->bar0 +
-				ptp->tx_mapped_regs[BNXT_PTP_TX_TS_L]));
-	*ts |= (uint64_t)rte_le_to_cpu_32(rte_read32((uint8_t *)bp->bar0 +
-				ptp->tx_mapped_regs[BNXT_PTP_TX_TS_H])) << 32;
-	rte_read32((uint8_t *)bp->bar0 + ptp->tx_mapped_regs[BNXT_PTP_TX_SEQ]);
-
-	return 0;
-}
-
-static int bnxt_clr_rx_ts(struct bnxt *bp, uint64_t *last_ts)
-{
-	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
-	struct bnxt_pf_info *pf = bp->pf;
-	uint16_t port_id;
-	int i = 0;
-	uint32_t fifo;
-
-	if (!ptp || (bp->flags & BNXT_FLAG_CHIP_P5))
-		return -EINVAL;
-
-	port_id = pf->port_id;
-	fifo = rte_le_to_cpu_32(rte_read32((uint8_t *)bp->bar0 +
-				ptp->rx_mapped_regs[BNXT_PTP_RX_FIFO]));
-	while ((fifo & BNXT_PTP_RX_FIFO_PENDING) && (i < BNXT_PTP_RX_PND_CNT)) {
-		rte_write32(1 << port_id, (uint8_t *)bp->bar0 +
-			    ptp->rx_mapped_regs[BNXT_PTP_RX_FIFO_ADV]);
-		fifo = rte_le_to_cpu_32(rte_read32((uint8_t *)bp->bar0 +
-					ptp->rx_mapped_regs[BNXT_PTP_RX_FIFO]));
-		*last_ts = rte_le_to_cpu_32(rte_read32((uint8_t *)bp->bar0 +
-					ptp->rx_mapped_regs[BNXT_PTP_RX_TS_L]));
-		*last_ts |= (uint64_t)rte_le_to_cpu_32(rte_read32((uint8_t *)bp->bar0 +
-					ptp->rx_mapped_regs[BNXT_PTP_RX_TS_H])) << 32;
-		i++;
-	}
-
-	if (i >= BNXT_PTP_RX_PND_CNT)
-		return -EBUSY;
-
-	return 0;
-}
-
-static int bnxt_get_rx_ts(struct bnxt *bp, uint64_t *ts)
-{
-	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
-	struct bnxt_pf_info *pf = bp->pf;
-	uint16_t port_id;
-	uint32_t fifo;
-
-	fifo = rte_le_to_cpu_32(rte_read32((uint8_t *)bp->bar0 +
-				ptp->rx_mapped_regs[BNXT_PTP_RX_FIFO]));
-	if (!(fifo & BNXT_PTP_RX_FIFO_PENDING))
-		return -EAGAIN;
-
-	port_id = pf->port_id;
-	rte_write32(1 << port_id, (uint8_t *)bp->bar0 +
-	       ptp->rx_mapped_regs[BNXT_PTP_RX_FIFO_ADV]);
-
-	fifo = rte_le_to_cpu_32(rte_read32((uint8_t *)bp->bar0 +
-				   ptp->rx_mapped_regs[BNXT_PTP_RX_FIFO]));
-	if (fifo & BNXT_PTP_RX_FIFO_PENDING)
-		return bnxt_clr_rx_ts(bp, ts);
-
-	*ts = rte_le_to_cpu_32(rte_read32((uint8_t *)bp->bar0 +
-				ptp->rx_mapped_regs[BNXT_PTP_RX_TS_L]));
-	*ts |= (uint64_t)rte_le_to_cpu_32(rte_read32((uint8_t *)bp->bar0 +
-				ptp->rx_mapped_regs[BNXT_PTP_RX_TS_H])) << 32;
-
-	return 0;
-}
-
 static int
 bnxt_timesync_write_time(struct rte_eth_dev *dev, const struct timespec *ts)
 {
@@ -3877,12 +3784,9 @@ bnxt_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts)
 	if (!ptp)
 		return -ENOTSUP;
 
-	/* TODO Revisit for Thor 2 */
 	if (BNXT_CHIP_P5(bp))
 		rc = bnxt_hwrm_port_ts_query(bp, BNXT_PTP_FLAGS_CURRENT_TIME,
 					     &systime_cycles);
-	else
-		systime_cycles = bnxt_cc_read(bp);
 
 	ns = rte_timecounter_update(&ptp->tc, systime_cycles);
 	*ts = rte_ns_to_timespec(ns);
@@ -3965,11 +3869,7 @@ bnxt_timesync_read_rx_timestamp(struct rte_eth_dev *dev,
 	if (!ptp)
 		return -ENOTSUP;
 
-	/* TODO Revisit for Thor 2 */
-	if (BNXT_CHIP_P5(bp))
-		rx_tstamp_cycles = ptp->rx_timestamp;
-	else
-		bnxt_get_rx_ts(bp, &rx_tstamp_cycles);
+	rx_tstamp_cycles = ptp->rx_timestamp;
 
 	ns = rte_timecounter_update(&ptp->rx_tstamp_tc, rx_tstamp_cycles);
 	*timestamp = rte_ns_to_timespec(ns);
@@ -3990,11 +3890,8 @@ bnxt_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 		return -ENOTSUP;
 
 	/* TODO Revisit for Thor 2 */
-	if (BNXT_CHIP_P5(bp))
-		rc = bnxt_hwrm_port_ts_query(bp, BNXT_PTP_FLAGS_PATH_TX,
-					     &tx_tstamp_cycles);
-	else
-		rc = bnxt_get_tx_ts(bp, &tx_tstamp_cycles);
+	rc = bnxt_hwrm_port_ts_query(bp, BNXT_PTP_FLAGS_PATH_TX,
+				     &tx_tstamp_cycles);
 
 	ns = rte_timecounter_update(&ptp->tx_tstamp_tc, tx_tstamp_cycles);
 	*timestamp = rte_ns_to_timespec(ns);
diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index 73fee40401..fb7c70fd45 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -727,6 +727,18 @@ bnxt_set_ol_flags(struct bnxt_rx_ring_info *rxr, struct rx_pkt_cmpl *rxcmp,
 	mbuf->ol_flags |= ol_flags;
 }
 
+static void bnxt_get_rx_ts(struct bnxt *bp)
+{
+	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+
+	if (!ptp)
+		return;
+
+	rte_spinlock_lock(&ptp->ptp_lock);
+	ptp->rx_timestamp = ptp->old_time;
+	rte_spinlock_unlock(&ptp->ptp_lock);
+}
+
 static void
 bnxt_get_rx_ts_p5(struct bnxt *bp, uint32_t rx_ts_cmpl)
 {
@@ -1198,7 +1210,10 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 		      bp->ptp_cfg) {
 		mbuf->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP |
 				  RTE_MBUF_F_RX_IEEE1588_TMST;
-		bnxt_get_rx_ts_p5(rxq->bp, rxcmp1->reorder);
+		if (BNXT_CHIP_P5(bp))
+			bnxt_get_rx_ts_p5(rxq->bp, rxcmp1->reorder);
+		else
+			bnxt_get_rx_ts(rxq->bp);
 #ifndef RTE_IOVA_IN_MBUF
 		bnxt_timestamp_dynfield_set(mbuf,
 					    bp->ptp_cfg->mb_rx_timestamp_offset,
-- 
2.47.3

