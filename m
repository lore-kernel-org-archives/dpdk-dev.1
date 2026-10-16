Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45197CCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:31:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82E42406A2;
	Fri, 16 Oct 2026 13:31:34 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id EFE6640291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:27:00 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-3535a54bed9so4281496eec.1
 for <dev@dpdk.org>; Thu, 15 Oct 2026 23:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792132020; x=1792736820; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z32gcMwPgs+QhZ7FtYyi7QFqu1rpFE1eKT7hc0Marpc=;
 b=Z2tVvSZNmWvqIkDP3uUW4tyX6TkpY3LUoDcKYbiIm1uHgyf83MaW8+c2H/J1WQ+5S1
 F/8WOv503SiY8ZiqPLKK4fCZRh12NZXHOHHRCN6yU5ViQIPDk6hSil2O5MnkZNilbc2F
 K2fuJX0FIMh5vT5cfXJoGka57UfoFOBU2kZPkwQY50kJF6dUrLuHk+u3iZ8JJRLNy4pL
 f6tgIg8qt02Hpc1ClcFPOZ+aIzMhURanbbnzq27jrVvHC/209H6tjsTGTDC5JByn/Aws
 jpMha8zjjxt5GTy38gE2qM4bOoLCGCRFYEBd8P95tny1U7IuqrRDuvXlfMiUjhAtRKu7
 Zy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132020; x=1792736820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z32gcMwPgs+QhZ7FtYyi7QFqu1rpFE1eKT7hc0Marpc=;
 b=jTp/wG/FMFUOfNfdPEac+mrM551x9P0v7m5896OYKf/IYxaGYKpIk98PDLV4zZSWrg
 U+S92U3+DbN4L0t6HjgU+VxmXLU1SCW+jWMiDmhnzGZJn39dr+Ja0ozqDxp9+fnbFoUT
 xWT2T1qeTPlcLakD1fSR4MS6S6IrM0NlgeAuls+SmzNGWVenv17FKVCcER4a12Hjcc35
 yXAXVyKhXi8sUSOp8Y2QMkHh3y0i+cLxTkxYA13GminV1bN2GValmxqLfzmY/jH6SXBw
 WsochFLWfem6ZsYk0qgBSpMkEN1mn2fEfaMj+XrIN8CGLSnrPc2Hyzd3HVJQmRKWXRLh
 GeXw==
X-Gm-Message-State: AFq9FYK++cRrcpYPI9u9A3bRoTg1Mm8JkFeNZ7Q6z1f804wybxDV9biP
 rwnZNic0qWcx5SPO2tX6xA7a2XUFBilor1wynuq8c+o7N/TEvo7E6a86l846cw==
X-Gm-Gg: AYBFou3WJiMFzZTtDXJNlM24Rx0oXDFShMKKsBtR/NzNe6T1zp+BWa7ZmIpdvMBIQNH
 fGx0Nh7Az8inmpzgKCmeZh37gQFFiM+598RqdXou8ZAyHwK0fQNujLPnOu3G5EvMTsBsVy4R+Xf
 xH7quVWLIrVs28l14iI5wW2oA4+CUukD/KH5r6np10FB/MRnkZcSdbPaHu93/M4bokq9OYU7GlQ
 25WODOp5iEBtw7mwJ3OfWvN+9dlMaQezx8b3fkw4TqgD8OBKWDCzS6H+vZtrgAZXavpkF9EmWNV
 GD/bGaRY8hLxdIoPuzef7AIqoPunUnSjElGex8OezMSgBZUqjdvmFrbxYpqzYqfE6XsL9cIea4N
 L0r1kgTuC2g7MVxrofJa5GhhXA+pZ70l+L4EYcthN8pfXxdMeXXiel+SPyrPxatnqO8bjPBbyva
 7SpGZ+gt7fhNon/slzUDwtOSeRdHPvaC3qa87+qik2fIRckSnVEfSvfn8UM96w14sIuDgpbJg5
X-Received: by 2002:a05:7022:3d14:b0:143:7001:7645 with SMTP id
 a92af1059eb24-16a62600d3emr38502622c88.47.1792132019928; 
 Thu, 15 Oct 2026 23:26:59 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm2743324c88.8.2026.10.15.23.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:26:59 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH v3 03/10] net/gve: fix DQO Tx report event interval
Date: Fri, 16 Oct 2026 06:26:40 +0000
Message-ID: <4939c366a9ded3a69a18361810372003354c12de.1792129992.git.tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792129992.git.tathagat.dpdk@gmail.com>
References: <cover.1792129992.git.tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:31:30 +0200
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

A descriptor completion is requested once every 32 packets, and Tx
descriptors are only reclaimed on these completions. With
multi-segment or TSO packets the ring can fill before 32 packets are
posted, so no completion is ever requested and the Tx queue stalls
for good.

Request a completion once GVE_TX_MIN_RE_INTERVAL descriptors have
been posted since the last one, as the Linux driver does.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/gve_ethdev.h |  2 +-
 drivers/net/gve/gve_tx_dqo.c | 22 ++++++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index c9a176ff17..8349b1c92e 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -194,7 +194,7 @@ struct gve_tx_queue {
 	uint8_t cur_gen_bit;
 	uint32_t last_desc_cleaned;
 	void **txqs;
-	uint16_t re_cnt;
+	uint16_t last_re_idx;
 
 	/* Only valid for DQO_RDA queue format */
 	struct gve_tx_queue *complq;
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index c864d722d9..a2ebadd0b8 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -254,6 +254,8 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	volatile union gve_tx_desc_dqo *txr;
 	volatile union gve_tx_desc_dqo *txd;
 	uint16_t mask = txq->nb_tx_desc - 1;
+	uint16_t last_re_interval;
+	uint16_t last_desc_idx;
 	struct gve_tx_pkt *pkts;
 	struct rte_mbuf *tx_pkt;
 	uint16_t compl_tag;
@@ -331,20 +333,23 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		txd = &txr[(tx_id - 1) & mask];
 		txd->pkt.end_of_packet = 1;
 
+		/* Request a descriptor completion once at least
+		 * GVE_TX_MIN_RE_INTERVAL descriptors have been posted
+		 * since the last request.
+		 */
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
 
@@ -445,6 +450,7 @@ gve_reset_tx_ring_state_dqo(struct gve_tx_queue *txq)
 	txq->nb_used = 0;
 
 	txq->last_desc_cleaned = 0;
+	txq->last_re_idx = 0;
 	txq->nb_free = txq->nb_tx_desc - 1;
 
 	txq->complq_tail = 0;
-- 
2.43.0

