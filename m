Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69251CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 20:39:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ACAC40609;
	Mon, 12 Oct 2026 22:38:43 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 3A0EA4026D
 for <dev@dpdk.org>; Mon, 12 Oct 2026 12:50:34 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-3514b90bb89so3318498eec.1
 for <dev@dpdk.org>; Mon, 12 Oct 2026 03:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791802233; x=1792407033; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jrNDYfCR07jonPKbi9Whp4gAg54eRWbbhRUSmtdECtY=;
 b=AYdcptZDRSJwhOsZdUFAMmEf7L6oC4DUHRhpVxZHWmC/BmQBs87a3YuJwGFqMywd+3
 ok/qiJVVIDTqlXNSKBykFNO+gAa+Ka8ezA0wuPjieAaSoSs1lsoc7MvFTYjv4iUCJ3ho
 3e36VkUO3rSO5nPh4tG/hZnlPwMAKKGhwMvBQakiCGrVGL6qbcES+EtD80B1PIrmtZxb
 BKlZDgNqH5tM2n44A8MAcfMM+hIZ2emrm7GQQk3Wks0vk3gC39qIdN0TkMJtcdeZ8zXK
 f5ddkE1fwCHESK3S8eKoV6bb7bcydX5NvT7BiBD/fkHNNGYbado7MUk1sBsIE4MGjsA9
 1jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791802233; x=1792407033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jrNDYfCR07jonPKbi9Whp4gAg54eRWbbhRUSmtdECtY=;
 b=LGIBszhigRiXwybTQ00bRw9eF5lFnseqPynKo9+RIXObVKz9yk4Y1re052S//ldAkF
 JFLXIGN79lGt4pkoAllepat8Hp0V98a3jSGTOfftfkVXgNc6Z630Z3Ah4EURa8UvtMxY
 eRbpueAfre/2JBg2BcUAu8CUJxk4W1nVi4BAdKBYNanB3knSJ+s623yvUTZfCLAD9KF/
 cQpqoSFxuytYZFND/7hmeDp4irW9uVx7U7ljjMP6I89ciE9PQ56fBDsu2GlkzJe/4qlN
 GZfVtMUsEHG43xWHW8spXrhymmGm3GEX4quufIThcpisjQOe+J4Op2whg4of/lh1j17a
 xotA==
X-Gm-Message-State: AFq9FYJF/A0HchSAE5qFB9RQgu+ovuy7kR0KlzR/Xr6SQ1/mlBq8mjvW
 EOvwqmOWdGI4cONYx8BqUlYuqxOC+uxi2NSEJOUoTEKf2GJQ0X48QDPqGRPbzA==
X-Gm-Gg: AYBFou1ZcKOMk+jPTGAOItdaWqZP97bnKYzP1vO5G+qWAMHZt2l/htyxthfi9NzRAb3
 p4CCT6+l3gGOjI9yQZvta7Ugidm4l9SDuKK0GCC9cIs1bO7XH/Ib3PEyQ0joPjhkYp8+cNkqs3v
 3Fm5yfXrHr3MfmkRxA3mth/km7hqZiCUZ7nDHykQblcA/6sa7quH9mYYX2CPPETMFh/fhV6oswH
 Jlade1hi49lLniRgY+me0CuQOya3KFME/weHl1CA9dNnS4IW+fn0saYxdeZUtoRrhHf9NuS+pzg
 LorKKlC/aUNBiO507xFGTflwYS1PVHiZOjpY9a+kKWsFC6URY4QcujjCc9CUrWsU3tAf//LOp5b
 iw8xcbjAVZ3HM38hIvHPEl7DPJQk0bei3wipsseTqZj0OYeRf/o+R2aGdmEP/tGgjPhRJQXwnFr
 gL05ZA6t/bKZH9PTGwcSt79pJAosfj2PBd3QxnWaFCNfRwXu1M21zLDHAYvx/LY5tFXQVAeKBL
X-Received: by 2002:a05:7300:881a:b0:351:29c8:643 with SMTP id
 5a478bee46e88-3537dfb8649mr15110110eec.18.1791802233120; 
 Mon, 12 Oct 2026 03:50:33 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm36875760eec.17.2026.10.12.03.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:50:32 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stable@dpdk.org
Subject: [PATCH 2/4] net/gve: fix DQO TX queue stall on multi-seg and TSO
Date: Mon, 12 Oct 2026 10:50:21 +0000
Message-ID: <20261012105023.669486-3-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
References: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 22:38:37 +0200
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

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
Cc: stable@dpdk.org

Acked-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/gve_ethdev.h |  2 +-
 drivers/net/gve/gve_tx_dqo.c | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

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
index c864d722d9..a8382ff3c4 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -264,6 +264,8 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	uint16_t nb_descs;
 	bool csum, tso;
 	uint16_t tx_id;
+	uint32_t last_desc_idx;
+	uint32_t last_re_interval;
 
 	pkts = txq->pkt_ring_dqo;
 	txr = txq->tx_ring;
@@ -331,20 +333,19 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		txd = &txr[(tx_id - 1) & mask];
 		txd->pkt.end_of_packet = 1;
 
+		last_desc_idx = (tx_id - 1) & mask;
+		last_re_interval = (last_desc_idx - txq->last_re_idx) & mask;
+		if (unlikely(last_re_interval >= GVE_TX_MIN_RE_INTERVAL)) {
+			txd->pkt.report_event = true;
+			txq->last_re_idx = last_desc_idx;
+		}
+
 		txq->nb_free -= nb_descs;
 		txq->nb_used += nb_descs;
 	}
 
 	/* update the tail pointer if any packets were processed */
 	if (nb_tx > 0) {
-		/* Request a descriptor completion on the last descriptor */
-		txq->re_cnt += nb_tx;
-		if (txq->re_cnt >= GVE_TX_MIN_RE_INTERVAL) {
-			txd = &txr[(tx_id - 1) & mask];
-			txd->pkt.report_event = true;
-			txq->re_cnt = 0;
-		}
-
 		rte_write32(tx_id, txq->qtx_tail);
 		txq->tx_tail = tx_id;
 
@@ -445,6 +446,7 @@ gve_reset_tx_ring_state_dqo(struct gve_tx_queue *txq)
 	txq->nb_used = 0;
 
 	txq->last_desc_cleaned = 0;
+	txq->last_re_idx = 0;
 	txq->nb_free = txq->nb_tx_desc - 1;
 
 	txq->complq_tail = 0;
-- 
2.43.0

