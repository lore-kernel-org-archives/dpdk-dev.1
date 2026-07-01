Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3571EC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 18:35:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7C4A40264;
	Wed,  1 Jul 2026 20:35:38 +0200 (CEST)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74]) by mails.dpdk.org (Postfix) with ESMTP id 90AC8406BA
 for <dev@dpdk.org>; Wed,  1 Jul 2026 20:35:37 +0200 (CEST)
Received: by mail-pj1-f74.google.com with SMTP id
 98e67ed59e1d1-37e1f96b248so1194127a91.3
 for <dev@dpdk.org>; Wed, 01 Jul 2026 11:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782930937; x=1783535737; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=1QcECGCyy2zRwSHBHxA9ZQm/a+z1rwJxyaJEr94G0sk=;
 b=bofcNz+2nNK8GVRARXFEJphMfuQooLXuJklXWpZ0V5dxj/AEdQNCEzsPjwxRlv4Ilu
 3hhVut3wHu0iFxXo8LXisfkUz3e6NRf63qB9LgxH+Y43HOswe+SNidSHuFyrpiJW61na
 K06o09dplgxOZ6zbGsvSAFvGqti50/G3Ejj3ForefUqa9/fLCaZV7yiaoXuBvDu+ovW2
 KUQcxlXmdwHHsWXUND3LJ+VsXeVRaghwhri5L1B/a38gjiuTleCJ6B3NtbAqXrHkSnYm
 BdpYhcW11ExkxvDXJzc/yNeBFpFPAvaJXzJ0iTrDSjIzKvjA7EiNedE8uhLDboa0Azab
 fj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782930937; x=1783535737;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1QcECGCyy2zRwSHBHxA9ZQm/a+z1rwJxyaJEr94G0sk=;
 b=CUNMuv6aBEYcIHCU/WLq8K0lViWmcDNB75WFwA9tq63n8/DpnHW4rTbt8r7H2khfva
 XqaiDcWCcXkHC76oc+CAklSdcezZ/Nj9Uuh8FX6cMupehtPB/zOLz/A2rnjJPSZKKrv3
 a7cuPLu5Ao+1jGcPCgwaYAytlUYG3wN5s5KrkywvT/SBrNeYgVXihHTSKomTbT7Q5wJq
 Gb3dEfSiV5gOxes7Ln7aVDwMSUsvOvwXJHkWHQ6guJb7mDe56RBAZ44qYodDroJ+Si2O
 UoB2LiU03Kx7w0N54V7fjVWwMvtFPeioTugOu5JOpB++FxEJCLrOMNzKgKU9WXMAKMjG
 fG8g==
X-Gm-Message-State: AOJu0Yy4KKnPsS3jUaU9/NxBYJrCkSiJhLoB4NIP93sslRg1CF+IeLX+
 qkItq6DG22s9dR6nbw7FZt7JW7B+n6H+OClwb86MXx2p4YtxsFFKiLdvTef6zye3sSe+GnRfDYq
 GCDcCxjQ4pTfoXg==
X-Received: from pjbay5.prod.google.com ([2002:a17:90b:305:b0:380:1d3a:97e9])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c04:b0:37f:f4ae:5f25 with SMTP id
 98e67ed59e1d1-380aa1c7afdmr2469416a91.20.1782930936430; 
 Wed, 01 Jul 2026 11:35:36 -0700 (PDT)
Date: Wed,  1 Jul 2026 11:35:21 -0700
In-Reply-To: <20260701183528.2443032-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260701183528.2443032-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701183528.2443032-4-joshwash@google.com>
Subject: [PATCH 3/9] net/gve: copy data to QPL buffer when mbuf read does not
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Junfeng Guo <junfengg@nvidia.com>, Xiaoyun Li <xiaoyun.li@intel.com>
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
 drivers/net/gve/gve_tx.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/gve/gve_tx.c b/drivers/net/gve/gve_tx.c
index 59c82b04ed..2f5a7b0a2e 100644
--- a/drivers/net/gve/gve_tx.c
+++ b/drivers/net/gve/gve_tx.c
@@ -273,6 +273,9 @@ gve_tx_burst_qpl(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		gve_tx_clean_swr_qpl(txq);
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
+		const void *mbuf_header_addr;
+		void *qpl_write_addr;
+
 		tx_pkt = *tx_pkts++;
 		ol_flags = tx_pkt->ol_flags;
 
@@ -317,26 +320,33 @@ gve_tx_burst_qpl(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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
 			addr = (uint64_t)(tx_pkt->buf_addr) + tx_pkt->data_off + hlen;
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

