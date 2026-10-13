Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E5BCC6B08
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 14:50:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42DAB40658;
	Tue, 13 Oct 2026 16:49:51 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 51562402A4
 for <dev@dpdk.org>; Tue, 13 Oct 2026 12:44:06 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-33fb4680717so157728eec.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 03:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791888245; x=1792493045; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ORhqCx0h0Jmi2KgbnB5MqN+I8egwBK53MNfVAIqogEE=;
 b=W/IFEX7YU9TOhv3PC53CZbca5jRjfgzP/3cbIq/p6NvQi3otEWRgtbY62w43+6aAMu
 EFPBVBKpx48n5ORvCe3VnLxf0oeR319eMSdPfzxRkJ4ypr599NDSzu44D+r1DmboQbMN
 dDo0vZQJw1t9+MYmzbIJ+JdVSpzEW0spWwZTlFARk6MUmQ0Vk4riSGsz5zElx6RXCJlS
 RavAAkV2PWFSO5b7d/d7FKvritFMYLjb+us82V1ucNvDQioSkIc47OU5BXHMu47L9YzS
 B+Oi1flxWgAKpnIeessm6TYg/RgHejeQubpOv0X0AQsL4Vu3dLmr5FEGwZXNSNOUxTUX
 d+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791888245; x=1792493045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ORhqCx0h0Jmi2KgbnB5MqN+I8egwBK53MNfVAIqogEE=;
 b=zU9M2u4ekKX+ksaI4QdqLQYl+p6Yx19ofWHe0AQ2eDpLQfS6O4XiXh/DzooTmTPddR
 jOn1hl7cMoF7hikJ5bqev9Gsvy77okT4aUNq2HkD0sl82bpoxyzu+5TF2N3tKaxrQ1eq
 3lYMCrDjQC2DQxWPpMe8sgONIjwz7CvOyepXuZYKTQ8Hp9yDqSjAoURRUQ13gJJpraMx
 4lxNiRKRIIVSKr7zptbNuEKu3YKph74DyjAbFOca5j5zgCHXtDecxLPrfNinBfFsN0oc
 grHFhOGMrsj1wbv9Yik5sjnz7vidLqYE8c+oO5VPyRqtrc2In78MSpTM/Z97+Bn1qySU
 wdyQ==
X-Gm-Message-State: AFq9FYLd9bvHUvzDk/TPb+lbJMB0xb/SIb/daLojQJwhUbigg2Su5Eo/
 LIofy+mxdfSKbl5YuiP9DQQmJFAH1IMbjPdCiwsNs2zPGZTBDf6SYXFBft/xDQ==
X-Gm-Gg: AYBFou06Ou1OEiN+1zDa1HiwVytEnzLFxrWoRZ/fzMa4TEKNiekprV+31rPD8GTpCVT
 ibJuVplS3u4ZONuELsbTqogvZ1XpsoFf9+JIQNczisHzBPYOq2qsDyaRIiImv4G/1Attjf4qX4e
 QRpuxfvAZJphXTLQl1uL3ONo/1gOB4uNcEXSgUj4grzLSmqJNi0AaCsMCYNTd8SduxrRbgoL2TO
 R8Nrs1cz8TLpuyu9Mms+BNaYmP+k/EZfw7KLyQINENiKryeD87maKr0t8pWjGC7vTsiFPveiSGd
 oAyt+1CKr4ffTvfKsV3sxP1BJCUVgZ9l8k+Fyhp/mAIBlkbF59v0OMMM4leDwsk1HGI+L9waznW
 nOxkzT7+Z1M5l9xKUr6warGIlyqP/pap26E0I4LhQWkUHRSrzMBbnUDgoETr+93M+ho16CQCMDB
 lBIV79NCqPMxShFWFajd/izBCMRCS8IK8YXhnVrRjNKsg3nQucWFHVbhnTH9xF1uwwFENPuybLb
 aggjjyGcXI=
X-Received: by 2002:a05:693c:69c3:b0:358:3426:d606 with SMTP id
 5a478bee46e88-3583426df51mr14744704eec.32.1791888245070; 
 Tue, 13 Oct 2026 03:44:05 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b19c6c7b4sm16695675eec.24.2026.10.13.03.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:44:04 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH v2 4/4] net/gve: add packet and TSO hardware constraints for
 DQO
Date: Tue, 13 Oct 2026 10:43:48 +0000
Message-ID: <20261013104348.714550-5-tathagat.dpdk@gmail.com>
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

The GVNIC DQO hardware restricts each packet (or MTU segment in TSO)
to at most 10 data descriptors (GVE_TX_MAX_DATA_DESCS), beyond which
the hardware drops traffic. In addition to this 10-descriptor limit,
the hardware imposes strict packet sizing and header constraints.

Previously, failing the descriptor limit or rte_mbuf_check() broke
from the Tx burst loop without consuming the invalid mbuf. This caused
tx_burst to return a short count, leading the application to retry the
same rejected packet indefinitely and causing Head-of-Line (HOL)
queue stalls.

Enforce hardware validation and prevent HOL blocking in DPDK:
- Validate packet and hardware constraints prior to ring space checks.
- When packet validation or rte_mbuf_check() fails, drop and free the
  invalid mbuf with rte_pktmbuf_free(), update stats, and continue the
  burst to prevent Head-of-Line (HOL) blocking.
- Exclude dropped packets from txq->stats.packets while returning the
  total consumed count to the caller.
- Rename too_many_descs in struct gve_tx_stats to dropped_pkts to reflect
  all validation and malformed mbuf drop events.
- Reject packets whose descriptor count exceeds the maximum capacity of
  the ring (accounting for reserved slots, cacheline overlap margin, and
  unreported descriptors), preventing permanent queue stalls.
- Define GVE_TX_MIN_PKT_SIZE_DQO (17 bytes) and GVE_TX_MAX_PKT_SIZE_DQO
  (9728 bytes) to enforce wire packet boundaries for non-TSO packets
  and TSO MSS.
- Define GVE_TX_MAX_TSO_LEN_DQO (262143 bytes) to enforce the hardware
  L4 payload limit in the 24-bit tso_total_len field.
- In gve_tx_validate_descs():
  * Enforce packet size in [17, 9728] for non-TSO packets alongside
    the 10-descriptor limit (nb_descs <= GVE_TX_MAX_DATA_DESCS).
  * Reject TSO packets missing an L4 header (l4_len == 0).
  * Reject packet with headers (L2-L4) not contiguous in first segment.
  * Reject TSO packets without payload (pkt_len <= headlen).
  * Enforce TSO total payload length limit (pkt_len - headlen <= 262143).
  * Enforce MSS limits [88, 9728] and header length limit <= 255.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Fixes: f4a70b449bfa ("net/gve: add DQO Tx descriptor limit")
Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/base/gve_desc_dqo.h |  3 +
 drivers/net/gve/gve_ethdev.h        |  2 +-
 drivers/net/gve/gve_tx_dqo.c        | 92 +++++++++++++++++++++++------
 3 files changed, 79 insertions(+), 18 deletions(-)

diff --git a/drivers/net/gve/base/gve_desc_dqo.h b/drivers/net/gve/base/gve_desc_dqo.h
index c1534959c2..53e394f01c 100644
--- a/drivers/net/gve/base/gve_desc_dqo.h
+++ b/drivers/net/gve/base/gve_desc_dqo.h
@@ -12,6 +12,9 @@
 
 #define GVE_TX_MAX_HDR_SIZE_DQO 255
 #define GVE_TX_MIN_TSO_MSS_DQO 88
+#define GVE_TX_MIN_PKT_SIZE_DQO 17
+#define GVE_TX_MAX_PKT_SIZE_DQO 9728
+#define GVE_TX_MAX_TSO_LEN_DQO ((256 * 1024) - 1)
 
 /* Basic TX descriptor (DTYPE 0x0C) */
 struct gve_tx_pkt_desc_dqo {
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 2033f49444..d6d71c31bb 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -113,7 +113,7 @@ struct gve_tx_stats {
 	uint64_t packets;
 	uint64_t bytes;
 	uint64_t errors;
-	uint64_t too_many_descs;
+	uint64_t dropped_pkts;
 };
 
 struct gve_rx_stats {
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index eee1f10df1..94ea426961 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -126,20 +126,67 @@ gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, uint16_t nb_descs) {
 		gve_tx_clean_dqo(txq);
 }
 
+/* Max descriptors a single packet may use. A larger packet can never pass
+ * gve_can_tx(): one slot is always reserved, the cacheline overlap margin
+ * must stay free, and up to GVE_TX_MIN_RE_INTERVAL - 1 descriptors posted
+ * after the last report_event are not reclaimed until more are posted.
+ */
+static inline int
+gve_tx_max_pkt_descs(const struct gve_tx_queue *txq)
+{
+	return (int)txq->nb_tx_desc - 1 - GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP -
+		(GVE_TX_MIN_RE_INTERVAL - 1);
+}
+
 /* GVE expects at most 10 data descriptors per mtu-sized segment. Beyond this,
  * the hardware will assume the driver is malicious and stop transmitting
  * packets altogether. Validate that a packet can be sent to avoid sending
  * posting descriptors for an invalid packet.
  */
 static inline bool
-gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16_t nb_descs, bool is_tso)
+gve_tx_validate_descs(const struct gve_tx_queue *txq, struct rte_mbuf *tx_pkt,
+		      uint16_t nb_descs, bool is_tso)
 {
-	if (!is_tso)
+	int num_descs, seg_offset, mbuf_len;
+	int tso_segsz, headlen;
+
+	/* Reject packets that can never fit in the ring */
+	if (unlikely(nb_descs > gve_tx_max_pkt_descs(txq)))
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
+	/* Reject missing TCP header on TSO */
+	if (unlikely(tx_pkt->l4_len == 0))
+		return false;
+
+	/* Reject packet with headers (L2-L4) not contiguous in first segment */
+	if (unlikely(tx_pkt->data_len < headlen))
+		return false;
+
+	/* Reject TSO packet without payload */
+	if (unlikely(tx_pkt->pkt_len <= (uint32_t)headlen))
+		return false;
+
+	/* Enforce GVE hardware TSO total length limit */
+	if (unlikely(tx_pkt->pkt_len - headlen > GVE_TX_MAX_TSO_LEN_DQO))
+		return false;
+
+	/* Enforce GVE hardware MSS and header limits */
+	if (unlikely(tx_pkt->tso_segsz < GVE_TX_MIN_TSO_MSS_DQO ||
+		     tx_pkt->tso_segsz > GVE_TX_MAX_PKT_SIZE_DQO ||
+		     headlen > GVE_TX_MAX_HDR_SIZE_DQO))
+		return false;
+
+	tso_segsz = tx_pkt->tso_segsz;
 
 	/* Headers will be split into their own buffer. */
 	num_descs = 1;
@@ -147,14 +194,18 @@ gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16_t nb_descs, bool is_tso)
 	mbuf_len = tx_pkt->data_len - headlen;
 
 	while (tx_pkt) {
+		int seg_remain;
+
 		if (!mbuf_len)
 			goto next_mbuf;
 
-		int seg_remain = tso_segsz - seg_offset;
+		seg_remain = tso_segsz - seg_offset;
 		if (num_descs == GVE_TX_MAX_DATA_DESCS && seg_remain)
 			return false;
 
 		if (seg_remain < mbuf_len) {
+			int mbuf_remain = tx_pkt->data_len % GVE_TX_MAX_BUF_SIZE_DQO;
+
 			seg_offset = mbuf_len % tso_segsz;
 			/* The MSS is bound from above by 9728B, so a
 			 * single TSO segment in the middle of an mbuf
@@ -162,7 +213,6 @@ gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16_t nb_descs, bool is_tso)
 			 * is not at risk of defying this limitation.
 			 * Thus, such segments are ignored.
 			 */
-			int mbuf_remain = tx_pkt->data_len % GVE_TX_MAX_BUF_SIZE_DQO;
 
 			/* For each TSO segment, HW will prepend
 			 * headers. The remaining bytes of this mbuf
@@ -184,7 +234,6 @@ gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16_t nb_descs, bool is_tso)
 			mbuf_len = tx_pkt->data_len;
 	}
 
-
 	return true;
 }
 
@@ -256,6 +305,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct rte_mbuf *tx_pkt;
 	struct gve_tx_pkt *pkts;
 	uint32_t last_desc_idx;
+	uint16_t nb_drop = 0;
 	uint16_t nb_tx = 0;
 	uint64_t bytes = 0;
 	const char *reason;
@@ -281,9 +331,13 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 					       txq->rs_thresh);
 
 
-		if (rte_mbuf_check(tx_pkt, true, &reason)) {
+		if (unlikely(rte_mbuf_check(tx_pkt, true, &reason))) {
 			PMD_DRV_DP_LOG(DEBUG, "Invalid mbuf: %s", reason);
-			break;
+			txq->stats.dropped_pkts++;
+			txq->stats.errors++;
+			rte_pktmbuf_free(tx_pkt);
+			nb_drop++;
+			continue;
 		}
 
 		ol_flags = tx_pkt->ol_flags;
@@ -292,6 +346,16 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		nb_descs = gve_tx_pkt_nb_data_descs(tx_pkt);
 		nb_descs += tso;
+
+		/* Drop packet if it doesn't adhere to hardware limits. */
+		if (unlikely(!gve_tx_validate_descs(txq, tx_pkt, nb_descs, tso))) {
+			txq->stats.dropped_pkts++;
+			txq->stats.errors++;
+			rte_pktmbuf_free(tx_pkt);
+			nb_drop++;
+			continue;
+		}
+
 		req_descs = nb_descs + GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP;
 
 		/* Clean if there aren't enough descriptors to send the packet
@@ -306,12 +370,6 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 				break;
 		}
 
-		/* Drop packet if it doesn't adhere to hardware limits. */
-		if (!gve_tx_validate_descs(tx_pkt, nb_descs, tso)) {
-			txq->stats.too_many_descs++;
-			break;
-		}
-
 		if (!gve_free_compl_tags_pop(txq, &compl_tag))
 			break;
 
@@ -357,7 +415,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	}
 
 	if (nb_tx > 0) {
-		txq->stats.packets += nb_tx;
+		txq->stats.packets += (nb_tx - nb_drop);
 		txq->stats.bytes += bytes;
 		txq->stats.errors += nb_pkts - nb_tx;
 	}
-- 
2.43.0

