Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65F8CD6E55
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 03:17:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17AE540673;
	Thu,  4 Jun 2026 05:17:17 +0200 (CEST)
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com
 [209.85.128.226])
 by mails.dpdk.org (Postfix) with ESMTP id DD70C4067E
 for <dev@dpdk.org>; Thu,  4 Jun 2026 05:17:14 +0200 (CEST)
Received: by mail-yw1-f226.google.com with SMTP id
 00721157ae682-7dbcb505578so3242817b3.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780543034; x=1781147834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GBOsZYouCfyI4mu0LOIydUDFszNJXLjBsX/mwnmnesc=;
 b=bSRNSNrjgamCY8XyTEf77kHethmaBpofrPzkZ5vtSC/qqeCd5MoW/IaaCa8Vvfj6rS
 JAFdGNnlKEdY0AalvBOhK9rrps0c5/3niHC+W1pHk1eedPbTCDfoad1YiWStAtvBHt+i
 iCGAXBy96XhX1+hcGMWpyuWz2vWDjM6aPEBetMNMfxRGEHjv4zvqDJygRNcSvDYJJghr
 JXYC2MULJ2XMxK4DywB6GHfgo7CR98DW8NqAMArpmZEinxgvJnMoREB84WCXxH6maJ7C
 u5r2VjRPSJHbcd9rUoilz55/9j9PE2cSZARd0KCfqIUBLG6PKRQi1cQ38SrmW5/AhC8k
 rtOQ==
X-Gm-Message-State: AOJu0YzG5XYeAeAx+A79ileZtY+C5Bly8/EM/1QRCmBWIMY9uTXIN3wR
 GuogHExQUWg7P5bhP/0KjBIfB/qlevkj67ew2M6+YtkG2ExODB1Wn1mHpbsupMZthJ0JeS0mkIs
 8MgnfD6CDSxXA+AypCVrMsmuPAT1rA0xXqpRCRheevNVQydoq4ctt+yZUk9tLy5KybwdSjbZUFV
 7wmyDT6nBsOdwwaiBzio/ILSDvO7fcXCXPjvkqY7Yh0oyxpX8PVYKjuiuwe0TKuEuKs4zeonH9h
 9qm34fQLumM
X-Gm-Gg: Acq92OEP8NSmkJLb2ZBXkXmna07VlJS0qvXp5kA/7tSdrPwN+yksxRICv/xHx/TzPuH
 +h8YooBhn52mVL+2wwh7L+ZRs5kgVdCDhXjJ5GmVxxknR4B0LpecjLdKGeepin3Jjb6ES+qJ8+m
 FenG2dE8Bb5RkwlTevaVBiAgrDuvHpfLs5Zu1Jtt0rQqcpReukQc3e99T60eQGWyqA/Fa/AwgTG
 JlnR6KEDmcwceqGVfQc+4Z+7VlFL380+7drB6KPUl3CTA+xi1YVL+woEmUeKpW3dp3GPx6ZQncj
 aqUEm5Z4F834UyRFSXqjUfNz4WDLJvMTUH9OiD0idXcjtMmVWITsRNsEE7sB0css2F9p6HvieVV
 +kc1oqFmsfE46CPYZb68286VJuZh5s3yvvju5xn+E0I9qj8yZR/SLofhLg7a64spPG7cnCfwGOU
 zDfrXavyoRLAlaiMMTE2cwTGvATEJII0dsRsJ9qrEX15BpBw1Y4fx3k1I7vFjEOf4PyGs3IjG5I
 mldpzeRSQ==
X-Received: by 2002:a05:690c:698b:b0:7bd:4a12:f08c with SMTP id
 00721157ae682-7ea4cb8e64emr58538727b3.39.1780543033996; 
 Wed, 03 Jun 2026 20:17:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-7ea20fa1126sm3112017b3.5.2026.06.03.20.17.13
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 20:17:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91598af506cso30361385a.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780543033; x=1781147833; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBOsZYouCfyI4mu0LOIydUDFszNJXLjBsX/mwnmnesc=;
 b=MuftsugdLwYjdAIaTt0FKx8WCYh2B6ZUmcXLoW6nATZaJFJWRtFQJl4t3dMbmkmi+e
 D1rN0HJdd5CIDO3MHaGHE7W0vF9plYv9mCBWFZeDnvgIAuNW4ZTH/pU/AueSKQkDZths
 VaYr7dAabZC6mBMcNSbaHWKSatSONZTrJfyD8=
X-Received: by 2002:a05:620a:3724:b0:8f1:5e8f:fff3 with SMTP id
 af79cd13be357-9158a77af60mr1052300385a.26.1780543032773; 
 Wed, 03 Jun 2026 20:17:12 -0700 (PDT)
X-Received: by 2002:a05:620a:3724:b0:8f1:5e8f:fff3 with SMTP id
 af79cd13be357-9158a77af60mr1052295985a.26.1780543032152; 
 Wed, 03 Jun 2026 20:17:12 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a009fe7sm446421685a.8.2026.06.03.20.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 20:17:11 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Zoe Cheimets <zoe.cheimets@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 06/10] net/bnxt: fix packet burst truncation after invalid Tx
 descriptor descriptor
Date: Wed,  3 Jun 2026 21:18:47 -0600
Message-ID: <20260604031851.2267548-7-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Zoe Cheimets <zoe.cheimets@broadcom.com>

When bnxt_start_xmit() returned -EINVAL for a bad packet, the burst
loop broke immediately, dropping all subsequent valid packets. The
Tx ring was also left in a corrupt state because tx_raw_prod was not
rolled back after a partial descriptor write. Additionally, the
tx_mbuf_drop oerrors accumulation was gated behind a tx_started
check, silently omitting drops from the statistics.

Fix by rolling back tx_raw_prod and any partially-written ring slots
on the drop path, replacing the break with continue so the burst
loop keeps processing remaining packets, and moving the tx_mbuf_drop
read to before the tx_started guard in both stats paths. Return
value is corrected to RTE_MIN(nb_tx_pkts + dropped, nb_pkts) to
accurately report consumed packet count.

Fixes: 220de9869bc3 ("net/bnxt: optimize Tx batching")
Cc: stable@dpdk.org
Signed-off-by: Zoe Cheimets <zoe.cheimets@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_txr.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index a6b062637c..bb9917d705 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -239,15 +239,17 @@ static int bnxt_start_xmit(struct rte_mbuf *tx_pkt,
 				uint16_t *coal_pkts,
 				struct tx_bd_long **last_txbd)
 {
+	struct tx_bd_long *last_txbd_save = *last_txbd;
 	struct bnxt_tx_ring_info *txr = txq->tx_ring;
 	struct bnxt_ring *ring = txr->tx_ring_struct;
+	uint16_t tx_raw_prod_save = txr->tx_raw_prod;
 	uint32_t outer_tpid_bd = 0;
 	struct tx_bd_long *txbd;
 	struct tx_bd_long_hi *txbd1 = NULL;
 	uint32_t vlan_tag_flags;
 	bool long_bd = false;
 	unsigned short nr_bds;
-	uint16_t prod;
+	uint16_t prod, idx;
 	bool pkt_needs_ts = 0;
 	struct rte_mbuf *m_seg;
 	struct rte_mbuf **tx_buf;
@@ -507,6 +509,24 @@ static int bnxt_start_xmit(struct rte_mbuf *tx_pkt,
 
 	return 0;
 drop:
+	/* Roll back any descriptors and tx_buf_ring slots that were written
+	 * for this packet before the failure was detected.  Walking from the
+	 * saved producer index up to (but not including) the current one is
+	 * safe because we hold the Tx lock and the HW has not been notified
+	 * (the doorbell is only rung after bnxt_start_xmit() returns
+	 * successfully).
+	 */
+	idx = tx_raw_prod_save;
+
+	while (idx != txr->tx_raw_prod) {
+		uint16_t slot = RING_IDX(ring, idx);
+
+		txr->tx_buf_ring[slot] = NULL;
+		txr->tx_desc_ring[slot].address = 0;
+		idx = RING_NEXT(idx);
+	}
+	txr->tx_raw_prod = tx_raw_prod_save;
+	*last_txbd = last_txbd_save;
 	rte_pktmbuf_free(tx_pkt);
 ret:
 	return rc;
@@ -836,22 +856,28 @@ uint16_t _bnxt_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 		if (unlikely(rc)) {
 			if (rc == -EINVAL) {
+				coal_pkts--;
 				rte_atomic_fetch_add_explicit(&txq->tx_mbuf_drop, 1,
 							      rte_memory_order_relaxed);
 				dropped++;
+				continue;
 			}
 			break;
 		}
 	}
 
-	if (likely(nb_tx_pkts)) {
+	/* last_txbd is used to check for if any packets have been sent in
+	 * the burst as bnxt_start_xmit will update it to the most recent
+	 * non-dropped buffer descriptor in the burst.
+	 */
+	if (likely(last_txbd != NULL)) {
 		/* Request a completion on the last packet */
 		last_txbd->flags_type &= ~TX_BD_LONG_FLAGS_NO_CMPL;
 		bnxt_db_write(&txq->tx_ring->tx_db, txq->tx_ring->tx_raw_prod);
 	}
 
-	nb_tx_pkts += dropped;
-	return nb_tx_pkts;
+	return RTE_MIN((uint16_t)(nb_tx_pkts + dropped), nb_pkts);
+
 }
 
 int bnxt_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
-- 
2.47.3

