Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF3BC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 13:13:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3650140A6E;
	Fri,  3 Jul 2026 15:13:18 +0200 (CEST)
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com
 [209.85.216.73]) by mails.dpdk.org (Postfix) with ESMTP id B466340689
 for <dev@dpdk.org>; Fri,  3 Jul 2026 15:13:16 +0200 (CEST)
Received: by mail-pj1-f73.google.com with SMTP id
 98e67ed59e1d1-381250979d5so694036a91.0
 for <dev@dpdk.org>; Fri, 03 Jul 2026 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783084396; x=1783689196; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=AdVnBYWzyLFB84x8KOQIcIlgmZAXYE4ssoM5o7Md4O8=;
 b=H+0eIVXnf0yJa5zwk65G1OWZBZnv1fyCfFIV4fXp1yGC6ajlJoyclOV1AayKNOfsXS
 xJokjHvL0EW2h6Rb23MbC5b385nVKsokMZOiFPg7MR836VsepkMl0pBHvDHrnXb3wNY9
 0l1EMT0CGBszNu23s4HAbBh9VQvBz18jl6dmeGcGyfVi5qdFIXaH1fMD04D/8kC4Ocxs
 niqfJHgtVFlTOpl6WMcrISD5qX3erB9vxdzhCeAUHn6gpvDHgdGvYp9pdPUrF5fzxC1x
 D7f9XoaobCL2+YYLhL5PFQIxXRoBC5WDKKxhK4R5E8DAsnfCNdZGEhTtim+Q3f1rSmrG
 Kc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783084396; x=1783689196;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AdVnBYWzyLFB84x8KOQIcIlgmZAXYE4ssoM5o7Md4O8=;
 b=qoiOnoUgJqco33ilBCOCpTJYeaTnfuNfrzJOa47Hae0O7thChNhp2aazVxSi9EovVK
 Pw16I+4NVDyEer6Jgdz7BZVIpEkBn6b8kaf54vTJoBpmISspWNdH5ugg5l2oD/iWtKv6
 lp6Vs7+pRdgvNdg9dqcMc3sJbB7wGoFmWjus6p+ZU5JT3uZjkc9mGEMrmUlphWixkxjk
 CcjCJCReY77FlgvSNDs+Qao/0ukqYj+6U9BelOu7j12NEyDOXH5pqNzJunbJ1zvmy6wT
 v2ABwNp7m38aW6OcXc7QiaWs/Fmu+mNyI2JQbfFbtO22Q6PrmfqeF8RnyW7M0FhN9ZPz
 DD2w==
X-Gm-Message-State: AOJu0YyHyxWt5YKmKH2NfkdqlVRjCxZDN0lDjdswe040Ye3AmeqFO6KI
 59gLVnIXAdJ7lbrF0dnBxFctZnZpWCPNkOM6NLeSGfL5DLQBh2bTcVZWjzEtVMxLZEW6d9Ztr2M
 cw5Hhoy/c1eHjpg==
X-Received: from pjkx4.prod.google.com ([2002:a17:90a:7884:b0:37f:6c08:3ef1])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:582c:b0:37d:ac3a:2f4f with SMTP id
 98e67ed59e1d1-380ba8d079dmr11064706a91.13.1783084395535; 
 Fri, 03 Jul 2026 06:13:15 -0700 (PDT)
Date: Fri,  3 Jul 2026 06:13:00 -0700
In-Reply-To: <20260703131308.2507403-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703131308.2507403-4-joshwash@google.com>
Subject: [PATCH v2 3/9] net/gve: copy data to QPL buffer when mbuf read does
 not
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Xiaoyun Li <xiaoyun.li@intel.com>, Junfeng Guo <junfengg@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 "Jasper Tran O'Leary" <jtranoleary@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The rte_pktmbuf_read method does not guarantee that data will be copied
from an mbuf. If the requested data is all contiguous, the method will
instead return a pointer to the memory location within the buffer that
should be read from, leaving the destination buffer empty.

This is problematic for TSO/multi-segment TX packets which only make use
of two mbufs. If all data in the second mbuf is contiguous, the data
will not be read to QPL memory.

Update the QPL copy logic to copy if the rte_pktmbuf_read does not.

Fixes: a46583cf43c8 ("net/gve: support Rx/Tx")
Cc: stable@dpdk.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
v2:
  Removed unused declaration and definition of addr

 drivers/net/gve/gve_tx.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/gve/gve_tx.c b/drivers/net/gve/gve_tx.c
index 59c82b04ed..d220d5167a 100644
--- a/drivers/net/gve/gve_tx.c
+++ b/drivers/net/gve/gve_tx.c
@@ -255,10 +255,10 @@ gve_tx_burst_qpl(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct rte_mbuf **sw_ring = txq->sw_ring;
 	uint16_t mask = txq->nb_tx_desc - 1;
 	uint16_t tx_id = txq->tx_tail & mask;
-	uint64_t ol_flags, addr, fifo_addr;
 	uint32_t tx_tail = txq->tx_tail;
 	struct rte_mbuf *tx_pkt, *first;
 	uint16_t sw_id = txq->sw_tail;
+	uint64_t ol_flags, fifo_addr;
 	uint16_t nb_used, i;
 	uint64_t bytes = 0;
 	uint16_t nb_tx = 0;
@@ -273,6 +273,9 @@ gve_tx_burst_qpl(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		gve_tx_clean_swr_qpl(txq);

 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
+		const void *mbuf_header_addr;
+		void *qpl_write_addr;
+
 		tx_pkt = *tx_pkts++;
 		ol_flags = tx_pkt->ol_flags;

@@ -306,7 +309,6 @@ gve_tx_burst_qpl(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			if (!is_fifo_avail(txq, hlen))
 				goto end_of_tx;
 		}
-		addr = (uint64_t)(tx_pkt->buf_addr) + tx_pkt->data_off;
 		fifo_addr = gve_tx_alloc_from_fifo(txq, tx_id, hlen);

 		/* For TSO, check if there's enough fifo space for data first */
@@ -317,26 +319,32 @@ gve_tx_burst_qpl(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 					goto end_of_tx;
 			}
 		}
-		if (tx_pkt->nb_segs == 1 || ol_flags & RTE_MBUF_F_TX_TCP_SEG)
-			rte_memcpy((void *)(size_t)(fifo_addr + txq->fifo_base),
-				   (void *)(size_t)addr, hlen);
-		else
-			rte_pktmbuf_read(tx_pkt, 0, hlen,
-					 (void *)(size_t)(fifo_addr + txq->fifo_base));
+
+		qpl_write_addr = (void *)(size_t)(fifo_addr + txq->fifo_base);
+		mbuf_header_addr = rte_pktmbuf_read(tx_pkt, 0, hlen, qpl_write_addr);
+
+		/* Header data is linear in the mbuf head. Copy directly. */
+		if (mbuf_header_addr != qpl_write_addr)
+			rte_memcpy(qpl_write_addr, mbuf_header_addr, hlen);
+
 		gve_tx_fill_pkt_desc(txd, tx_pkt, nb_used, hlen, fifo_addr);

 		if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+			const void *mbuf_payload_addr;
+
 			tx_id = (tx_id + 1) & mask;
 			txd = &txr[tx_id];
-			addr = (uint64_t)(tx_pkt->buf_addr) + tx_pkt->data_off + hlen;
 			fifo_addr = gve_tx_alloc_from_fifo(txq, tx_id, tx_pkt->pkt_len - hlen);
-			if (tx_pkt->nb_segs == 1)
-				rte_memcpy((void *)(size_t)(fifo_addr + txq->fifo_base),
-					   (void *)(size_t)addr,
+			qpl_write_addr = (void *)(txq->fifo_base + fifo_addr);
+			mbuf_payload_addr = rte_pktmbuf_read(tx_pkt, hlen, tx_pkt->pkt_len - hlen,
+							     qpl_write_addr);
+
+			/* Payload data is contiguous. Take the offset from the
+			 * read request and copy from there.
+			 */
+			if (mbuf_payload_addr != qpl_write_addr)
+				rte_memcpy(qpl_write_addr, mbuf_payload_addr,
 					   tx_pkt->pkt_len - hlen);
-			else
-				rte_pktmbuf_read(tx_pkt, hlen, tx_pkt->pkt_len - hlen,
-						 (void *)(size_t)(fifo_addr + txq->fifo_base));

 			gve_tx_fill_seg_desc(txd, ol_flags, tx_offload,
 					     tx_pkt->pkt_len - hlen, fifo_addr);
--
2.55.0.rc0.799.gd6f94ed593-goog

