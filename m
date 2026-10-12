Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DF2CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 20:39:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DD5140655;
	Mon, 12 Oct 2026 22:38:45 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id D7EDC40041
 for <dev@dpdk.org>; Mon, 12 Oct 2026 12:50:39 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-3535bf8b3e0so2872367eec.0
 for <dev@dpdk.org>; Mon, 12 Oct 2026 03:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791802239; x=1792407039; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ebWV2MOKcp7mD14V8HZhiwSLfQ4kH6XH8ifowgQaDXs=;
 b=mMFFPUx3obPqZl7MQbQYdCdvtKKb/8mvL5yuOclMl3KF2YQ17XBI5aocbmQCzSn9hk
 D6U8NFFWRTXgiTU933rCyogPnhhq+vPR5hr0Fb5el9gehsB8tC8t8GgZ7mLWxvmPlRSu
 Ncu4WWwJbBc2k1qnpvlErmL9BseL0gSRpiwpCj2QnILnQe9MO2Ti1+tzN9yvnr7gUScS
 ZLQHQMvxEr1/T3iVSnb2aQeEFfJwByZPUjpCveFiOb+7jV46DYHeBbLowBR25T1u5zCm
 Q0fw0C8MeDsdrMBA/SC1zX5PVBg9xh94uY3KRZA34AZ+YgWZHcOuKdGsQCZbvoSWF0sb
 UocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791802239; x=1792407039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ebWV2MOKcp7mD14V8HZhiwSLfQ4kH6XH8ifowgQaDXs=;
 b=RAa27D8ox0AqnGqg6HGYWoDqDhQkcCAHFAk30gLT0BrHE+s4OwoFLhIsC3k2bYPZCT
 i4UfAldBfh9/5EfF7SmkPCyfWG6jHEZ8hBj/ca3JJwbsLF1wNZ9UrQ23nfWL0kXdWe9f
 CMdTTtiaNT8+YZ24KwpnUh+Pd+lUdVvNQkKOc1b6ptzcImib8H8zDRT3FjQXJVSOAfbq
 zxoVO0vzQPT/oVtO9p1/rIsUxkng2Md3ECk56i2NLtPF17rXxtrcwlcM/7Ldqv758XPZ
 +nCs062EjT9PY0FkTk+xzxyO+u0VxMeUqA4ZmtFG91F0rB7i2t0Xiqg0HuXs5Ce3ojwb
 nVdA==
X-Gm-Message-State: AFq9FYIG2DxsZvVVzx3QbVXvbs3L5a3JRyGAhgQA/5Ajhx5d0mZvVRx3
 G/2pTcYPP+efqL3NpRi6LHS6ts4qW92ZnX0zKAiTiUVZYVRlmnsamByH7fQXRg==
X-Gm-Gg: AYBFou1pJmsqwroRRZ9ni7D63X7vD3imgoxUH8alFM07dxKSBxLiWClfnt56ou5fyik
 Z4gY+t27l81XLTtEYMwnxDY2ytZMJv9lNDC1f31q/QXwvcmnZlPiJN01VG8JyNlmS6Ye3fgcG0Y
 Lv3k9EkWXUT805jSOuQ6XwquQPSrPHkoGomg1cuepUpaZxQQno5mO7XdeZWsOF00XXGHmniWPJ5
 /oMDOVdR/Nau0w3uCXs71hMGRqjrzocl8AwMbtosOasotG4HmqYe2Yd7+zkqxSQ2S+Aq7OOg2a/
 WiLrV7QGYrD1ecHPnwZM/XD0NTSaaSlKCmI8vvgvEtWNxEchEv+k1WQGg/ndP2MWsLeHUb+BVFI
 HkUJN9p1m0Kdckv0Onv1PCtIRWSVN6Gokh7h2VEwODAmUYKRfboV5nq1hn2mB4O27RVLnIn9Iai
 dE82bw4i89MHIm2RN/2eV2WJ4cPWMAB8fAKLjItLkzuy+bK29yoeVKC3Kag0Ey3jKUH1+AHqc9
X-Received: by 2002:a05:7301:787:b0:35b:2f6b:a981 with SMTP id
 5a478bee46e88-35b2f6babb4mr1810800eec.15.1791802237483; 
 Mon, 12 Oct 2026 03:50:37 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm36875760eec.17.2026.10.12.03.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:50:37 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stable@dpdk.org
Subject: [PATCH 4/4] net/gve: add packet and TSO hardware constraints for DQO
Date: Mon, 12 Oct 2026 10:50:23 +0000
Message-ID: <20261012105023.669486-5-tathagat.dpdk@gmail.com>
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

The GVNIC DQO hardware restricts each packet (or MTU segment in TSO)
to at most 10 data descriptors (GVE_TX_MAX_DATA_DESCS), beyond which
the hardware drops traffic. In addition to this 10-descriptor limit,
the hardware imposes strict packet sizing and header constraints.

Enforce these hardware packet and TSO validation constraints in DQO
RDA mode within gve_tx_validate_descs() matching the upstream Linux
kernel driver:
- Define GVE_TX_MAX_TSO_MSS_DQO (9728 bytes) to avoid 14-bit MSS
  field overflow in struct gve_tx_tso_context_desc_dqo.
- Define GVE_TX_MIN_PKT_SIZE_DQO (17 bytes) and GVE_TX_MAX_PKT_SIZE_DQO
  (9728 bytes) to reject runts (which cause hardware DMA parse errors)
  and oversized non-TSO packets.
- In gve_tx_validate_descs():
  * Reject zero-length mbufs (nb_descs == 0 or pkt_len == 0).
  * Enforce packet size in [17, 9728] for non-TSO packets alongside
    the 10-descriptor limit (nb_descs <= GVE_TX_MAX_DATA_DESCS).
  * Reject split transport headers across mbuf segments
    (data_len < headlen).
  * Reject TSO packets missing an L4 header (l4_len == 0).
  * Reject TSO packets without payload (pkt_len <= headlen).
  * Enforce MSS limits [88, 9728] and header length limit <= 255.

Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
Cc: stable@dpdk.org

Acked-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/base/gve_desc_dqo.h |  3 ++
 drivers/net/gve/gve_tx_dqo.c        | 44 ++++++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/net/gve/base/gve_desc_dqo.h b/drivers/net/gve/base/gve_desc_dqo.h
index c1534959c2..1740f69d73 100644
--- a/drivers/net/gve/base/gve_desc_dqo.h
+++ b/drivers/net/gve/base/gve_desc_dqo.h
@@ -12,6 +12,9 @@
 
 #define GVE_TX_MAX_HDR_SIZE_DQO 255
 #define GVE_TX_MIN_TSO_MSS_DQO 88
+#define GVE_TX_MAX_TSO_MSS_DQO 9728
+#define GVE_TX_MIN_PKT_SIZE_DQO 17
+#define GVE_TX_MAX_PKT_SIZE_DQO 9728
 
 /* Basic TX descriptor (DTYPE 0x0C) */
 struct gve_tx_pkt_desc_dqo {
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 9210b02eb1..03ac3bd5dd 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -134,12 +134,43 @@ gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, uint16_t nb_descs) {
 static inline bool
 gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16_t nb_descs, bool is_tso)
 {
-	if (!is_tso)
+	int tso_segsz, seg_remain, mbuf_remain;
+	int num_descs, seg_offset, mbuf_len;
+	int headlen;
+
+	/* Reject zero-length packet */
+	if (unlikely(nb_descs == 0 || tx_pkt->pkt_len == 0))
+		return false;
+
+	if (!is_tso) {
+		/* Reject packets that violate hardware length constraints */
+		if (unlikely(tx_pkt->pkt_len < GVE_TX_MIN_PKT_SIZE_DQO ||
+			     tx_pkt->pkt_len > GVE_TX_MAX_PKT_SIZE_DQO))
+			return false;
 		return nb_descs <= GVE_TX_MAX_DATA_DESCS;
+	}
 
-	int tso_segsz = tx_pkt->tso_segsz;
-	int num_descs, seg_offset, mbuf_len;
-	int headlen = tx_pkt->l2_len + tx_pkt->l3_len + tx_pkt->l4_len;
+	headlen = tx_pkt->l2_len + tx_pkt->l3_len + tx_pkt->l4_len;
+
+	/* Reject split transport header */
+	if (unlikely(tx_pkt->data_len < headlen))
+		return false;
+
+	/* Reject missing TCP header on TSO */
+	if (unlikely(tx_pkt->l4_len == 0))
+		return false;
+
+	/* Reject TSO packet without payload */
+	if (unlikely(tx_pkt->pkt_len <= (uint32_t)headlen))
+		return false;
+
+	/* Enforce GVE hardware MSS and header limits */
+	if (unlikely(tx_pkt->tso_segsz < GVE_TX_MIN_TSO_MSS_DQO ||
+		     tx_pkt->tso_segsz > GVE_TX_MAX_TSO_MSS_DQO ||
+		     headlen > GVE_TX_MAX_HDR_SIZE_DQO))
+		return false;
+
+	tso_segsz = tx_pkt->tso_segsz;
 
 	/* Headers will be split into their own buffer. */
 	num_descs = 1;
@@ -150,7 +181,7 @@ gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16_t nb_descs, bool is_tso)
 		if (!mbuf_len)
 			goto next_mbuf;
 
-		int seg_remain = tso_segsz - seg_offset;
+		seg_remain = tso_segsz - seg_offset;
 		if (num_descs == GVE_TX_MAX_DATA_DESCS && seg_remain)
 			return false;
 
@@ -162,7 +193,7 @@ gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16_t nb_descs, bool is_tso)
 			 * is not at risk of defying this limitation.
 			 * Thus, such segments are ignored.
 			 */
-			int mbuf_remain = tx_pkt->data_len % GVE_TX_MAX_BUF_SIZE_DQO;
+			mbuf_remain = tx_pkt->data_len % GVE_TX_MAX_BUF_SIZE_DQO;
 
 			/* For each TSO segment, HW will prepend
 			 * headers. The remaining bytes of this mbuf
@@ -184,7 +215,6 @@ gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16_t nb_descs, bool is_tso)
 			mbuf_len = tx_pkt->data_len;
 	}
 
-
 	return true;
 }
 
-- 
2.43.0

