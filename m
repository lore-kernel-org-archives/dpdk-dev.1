Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD194C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:40:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76E8340689;
	Tue,  7 Jul 2026 18:40:30 +0200 (CEST)
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com
 [209.85.215.202])
 by mails.dpdk.org (Postfix) with ESMTP id 8BF9E406B7
 for <dev@dpdk.org>; Tue,  7 Jul 2026 18:40:28 +0200 (CEST)
Received: by mail-pg1-f202.google.com with SMTP id
 41be03b00d2f7-c8894570b58so3309409a12.3
 for <dev@dpdk.org>; Tue, 07 Jul 2026 09:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783442428; x=1784047228; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lPwMgO0NOCZKyjDIfuNR78Ho+Bm1zb2y8TYfBFWq2Xc=;
 b=dVmDAtfCdjeU/cfvf/vYXOj8gG+/ZCOmHUDyhr4jDLNyb8d/GD3Nzb8ZTEr1Z7z+rO
 jM/n1vYSwBByiMhnK6oJYQPo7koSdYR007p1c2OYyQVPETOfI2zfsNFzanKer7P17bUA
 qzNhQjxK7UPs7FgnOWyBk4XJROGuMm0C7jkaxEApCUkGef7hf8ncSzJuDqCNzY8w7MXp
 wys88Mg//vG22EIE64WAxUZNyMrOOw3oZYBvjhBSlRb8kAICaWx1M58azhfpoR4b9PgZ
 Xr10mxXqeHK/uFJ5m4VpBibZIybEAG5PI9c3KjAJhDLdmFFj4mpKhMTOXtjT1I6O8tQZ
 OdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442428; x=1784047228;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lPwMgO0NOCZKyjDIfuNR78Ho+Bm1zb2y8TYfBFWq2Xc=;
 b=DWgL4w42Q0hOnjC+2kh21IyFfR34O/jVps4msPdXVAsZTD8/xbgavo3nO2egZe4JNg
 2kVdPKO17IA0zMqc/amttC2Ky9aFNuBMxcgbf4HNsmCD2kHrrmPLEdbt7x482gMVPjZ2
 3S/WOlmVnsBlAV8Rmt/j7NiM8Jfs2YwmBiit13uivuFPtt+ItouCwj4foRkDA3Ew27ES
 Prd85AMabFOTl5w7wEsrblC+wQQtsdJyvPAlRIMP+OENtEHVgtm/bWvK0ob5S/3N47lE
 GLQf59tiSRihxrbh9uBMfGqRsFOWocZgPn2pCThaessXabwSsI2hvoG8bQKPVEEQUYQ4
 iCpA==
X-Gm-Message-State: AOJu0Yw+oFQbyq8O+pAvc2q5Gz5zULObzqFq7XJKkKq6um2ubx2dzizc
 uXewRvrpxpEC/dD1YGb7D8lvMcZrIFlQhXLF9WFRrYsqoHphlltL+HsaguLjdFJJapKeoMQHcOO
 JzS+5dTRjcU3bcA==
X-Received: from pgvz19.prod.google.com ([2002:a65:6653:0:b0:c9a:3f28:8c06])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:b787:b0:3c0:9c19:b275 with SMTP id
 adf61e73a8af0-3c09c19b2eemr4270772637.67.1783442427472; 
 Tue, 07 Jul 2026 09:40:27 -0700 (PDT)
Date: Tue,  7 Jul 2026 09:40:13 -0700
In-Reply-To: <20260707164020.2936476-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
 <20260707164020.2936476-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707164020.2936476-4-joshwash@google.com>
Subject: [PATCH v3 3/9] net/gve: copy data to QPL buffer when mbuf read does
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
v3:
  Fix 32-bit compile issue
v2:
  Removed unused declaration and definition of addr

 drivers/net/gve/gve_tx.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/gve/gve_tx.c b/drivers/net/gve/gve_tx.c
index 59c82b04ed..c0400b07bf 100644
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
+			qpl_write_addr = (void *)(size_t)(txq->fifo_base + fifo_addr);
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
2.55.0.rc2.803.g1fd1e6609c-goog

