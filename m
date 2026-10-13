Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA157CC6B08
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 14:49:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D6A04060C;
	Tue, 13 Oct 2026 16:49:49 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id D54664042E
 for <dev@dpdk.org>; Tue, 13 Oct 2026 12:44:00 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-15756f82e8aso3723301c88.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 03:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791888240; x=1792493040; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=idUxCp9GEF892cGWADR1EtkP6fg/AUzOx93KCqYPPZE=;
 b=gJ7Q0ODyp1tsfHqMjtqILe0xTH6tgNRLa04J9Z3SSpiqB7HqgDdcjQzhkwfsjEIgCS
 V6TaCgRTtW7QHLeUGTdYglVwo0Vg62JLIm4c0mFg2ks3Enx5gUuASjHNnRq3rbq/Hvb0
 KhDrO68qau7VaKjyvJXIR4q/lGxB3DQc5n/6sYeEqZv+NbrqHZlW77cr43VDb16SEWUl
 QZTTeGgoQfoD71gkAJVvUshoNB2+mvUQRlDbfUrV7Pjm9//yU1Fw+CDux/4PaHLtOuOU
 sHVXBXZquQqdioZwafLIZ/E7Wf71JK10y/BwO6yER4LJ9UqDRmitxUGqsb7nQUfprKtk
 padg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791888240; x=1792493040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=idUxCp9GEF892cGWADR1EtkP6fg/AUzOx93KCqYPPZE=;
 b=y2Y46kAl4izNHV1Bd4p9KPYcfNHwPQ1rob4pv5TJllCPEaQ9GfWDKYdc0ifVpYZmOl
 bUkHO1Yqwv3DB67zPmCUtAaqPQYccVAhWOVOu9jpP2Ai31InWNUkoFs2G4vOFLA2cMOI
 4hwtSIKdgogbwD/y7CP1/QYSInNfZD79+bCA+z/ERDWh0rUBT+uqqJia7bVqEorctPON
 ZSv2sFrY8Vd2WzqNitH9/IbbxMtGDktewYB8KocRt0uakAkB+zkuG/Ub1Ui1vsiZm/z3
 SgXl8nKMuqxc95uarhgmSC/fQdLwnIdoHTtUpgksvkNOLe7nJMxYGr8+9ZtBRDtZWau6
 0Weg==
X-Gm-Message-State: AFq9FYI8f5KhH9RzDHdNa5I9tnBrLfIh3U9/sqwXTE3C3EebiOullbZn
 t7gsHJXNlW3PCgTaKyjujyAVltFPiaaDCbMi3LpivzWf4LXBBl/BYS5RJs3QMg==
X-Gm-Gg: AYBFou1nBeQU2Be5uBqUkGvkBpuwDzMEXWNCFlKm8+HG/dfWBzV9wCpSduZsE4eimq1
 hjg2AUj71lze4Cmwqg3X5/Jegq4jXoDcBKcLreedLiCsCOzldy3FOZ/oHbaf2HQd7xUupim+X9I
 Vp3ObrKpC3mQFlg6pOyFcnpuiR9GOTcUFuA801Yq27ikPkh8whmO5mv+HKkcIn442RKpUAAurYP
 BEL/RDQlDZpj5gxckHK1u+JHfjwSPTt5vP3FoSIL5T87ScOwe+NQsG9qA8yvqJfxIQnVThechYv
 Ux/qQrSNAlz2iEJ4iduDmjT0FnJlOr+VFOLxwWk5qF8lyVp92s+yF3+vLiTueBA8uVw+eRU5DY6
 7CTHY48X4aCTNvIEMuyO+9rY5E+yyHX1+J6Mmtxt6lvJocLzcQYWmFKesnhzvkcvzfvlQlzrX2P
 Ik0DPKvdSJcJzR+3Czckyj1wmSaz2O8JX6eS0VCabsjA67d8kVLKIiCo8pGVrGv+CxqVDVpiKqo
 9vFadhDRIk=
X-Received: by 2002:a05:7023:a4b:20b0:143:3769:c680 with SMTP id
 a92af1059eb24-16a1555df9dmr16157215c88.25.1791888239832; 
 Tue, 13 Oct 2026 03:43:59 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b19c6c7b4sm16695675eec.24.2026.10.13.03.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:43:59 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH v2 2/4] net/gve: fix DQO Tx queue stall on multi-seg and TSO
Date: Tue, 13 Oct 2026 10:43:46 +0000
Message-ID: <20261013104348.714550-3-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013104348.714550-1-tathagat.dpdk@gmail.com>
References: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
 <20261013104348.714550-1-tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 16:49:47 +0200
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

The DPDK GVE driver previously tracked transmitted packet count (re_cnt)
at the end of each burst rather than tracking descriptor intervals per
packet against GVE_TX_MIN_RE_INTERVAL (32).

In multi-segment and TSO transmissions, each packet consumes multiple
descriptors. The descriptor ring could exhaust before 32 packets were
sent, resulting in zero descriptors requesting report_event and
preventing the hardware DMA engine from returning GVE_COMPL_TYPE_DQO_DESC
completions. Without these completions, txq->nb_free was never
replenished, permanently stalling the TX queue.

Align with the Linux kernel driver (gve_tx_update_tail()) by tracking
descriptor indices with last_re_idx:
- Replace re_cnt with last_re_idx in struct gve_tx_queue.
- Reset last_re_idx = 0 in gve_reset_tx_ring_state_dqo().
- On each packet transmission, check descriptor interval
  (last_desc_idx - last_re_idx) & mask >= GVE_TX_MIN_RE_INTERVAL.
  When met, set report_event on the packet's last descriptor and
  update last_re_idx.
- Ring the transmit doorbell immediately upon setting report_event to
  kick hardware processing early and reduce device fetch latency during
  bursts of multi-descriptor TSO packets, amortizing MMIO writes over
  RE_INTERVAL descriptors.
- Defensively pop completion tags before writing TSO context descriptors
  to avoid partial descriptor ring updates if completion tags are
  exhausted.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/gve_ethdev.h |  2 +-
 drivers/net/gve/gve_tx_dqo.c | 46 ++++++++++++++++++++----------------
 2 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index c9a176ff17..2033f49444 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -193,8 +193,8 @@ struct gve_tx_queue {
 	uint16_t sw_size;
 	uint8_t cur_gen_bit;
 	uint32_t last_desc_cleaned;
+	uint32_t last_re_idx;
 	void **txqs;
-	uint16_t re_cnt;
 
 	/* Only valid for DQO_RDA queue format */
 	struct gve_tx_queue *complq;
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index c864d722d9..0839179d7f 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -250,21 +250,23 @@ gve_fill_tx_pkt_desc(struct gve_tx_queue *txq, uint16_t *tx_id,
 uint16_t
 gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
+	volatile union gve_tx_desc_dqo *txr, *txd;
 	struct gve_tx_queue *txq = tx_queue;
-	volatile union gve_tx_desc_dqo *txr;
-	volatile union gve_tx_desc_dqo *txd;
-	uint16_t mask = txq->nb_tx_desc - 1;
-	struct gve_tx_pkt *pkts;
+	uint32_t last_re_interval;
 	struct rte_mbuf *tx_pkt;
-	uint16_t compl_tag;
-	const char *reason;
+	struct gve_tx_pkt *pkts;
+	uint32_t last_desc_idx;
 	uint16_t nb_tx = 0;
 	uint64_t bytes = 0;
+	const char *reason;
+	uint16_t compl_tag;
 	uint64_t ol_flags;
 	uint16_t nb_descs;
-	bool csum, tso;
 	uint16_t tx_id;
+	bool csum, tso;
+	uint16_t mask;
 
+	mask = txq->nb_tx_desc - 1;
 	pkts = txq->pkt_ring_dqo;
 	txr = txq->tx_ring;
 
@@ -306,15 +308,15 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			break;
 		}
 
+		if (!gve_free_compl_tags_pop(txq, &compl_tag))
+			break;
+
 		if (tso) {
 			txd = &txr[tx_id];
 			gve_tx_fill_seg_desc_dqo(txd, tx_pkt);
 			tx_id = (tx_id + 1) & mask;
 		}
 
-		if (!gve_free_compl_tags_pop(txq, &compl_tag))
-			break;
-
 		pkts[compl_tag].mbuf = tx_pkt;
 		while (tx_pkt) {
 			/* Skip writing descriptors if mbuf has no data. */
@@ -331,23 +333,26 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		txd = &txr[(tx_id - 1) & mask];
 		txd->pkt.end_of_packet = 1;
 
+		last_desc_idx = (tx_id - 1) & mask;
+		last_re_interval = (last_desc_idx - txq->last_re_idx) & mask;
+		if (unlikely(last_re_interval >= GVE_TX_MIN_RE_INTERVAL)) {
+			txd->pkt.report_event = true;
+			txq->last_re_idx = last_desc_idx;
+			rte_write32(tx_id, txq->qtx_tail);
+			txq->tx_tail = tx_id;
+		}
+
 		txq->nb_free -= nb_descs;
 		txq->nb_used += nb_descs;
 	}
 
-	/* update the tail pointer if any packets were processed */
-	if (nb_tx > 0) {
-		/* Request a descriptor completion on the last descriptor */
-		txq->re_cnt += nb_tx;
-		if (txq->re_cnt >= GVE_TX_MIN_RE_INTERVAL) {
-			txd = &txr[(tx_id - 1) & mask];
-			txd->pkt.report_event = true;
-			txq->re_cnt = 0;
-		}
-
+	/* update the tail pointer if any uncommitted descriptors remain */
+	if (txq->tx_tail != tx_id) {
 		rte_write32(tx_id, txq->qtx_tail);
 		txq->tx_tail = tx_id;
+	}
 
+	if (nb_tx > 0) {
 		txq->stats.packets += nb_tx;
 		txq->stats.bytes += bytes;
 		txq->stats.errors += nb_pkts - nb_tx;
@@ -445,6 +450,7 @@ gve_reset_tx_ring_state_dqo(struct gve_tx_queue *txq)
 	txq->nb_used = 0;
 
 	txq->last_desc_cleaned = 0;
+	txq->last_re_idx = 0;
 	txq->nb_free = txq->nb_tx_desc - 1;
 
 	txq->complq_tail = 0;
-- 
2.43.0

