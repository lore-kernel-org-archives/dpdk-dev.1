Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79FBC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 04:08:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB87B406BA;
	Thu,  9 Jul 2026 06:07:49 +0200 (CEST)
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com
 [209.85.214.201])
 by mails.dpdk.org (Postfix) with ESMTP id 572B8406B8
 for <dev@dpdk.org>; Thu,  9 Jul 2026 06:07:48 +0200 (CEST)
Received: by mail-pl1-f201.google.com with SMTP id
 d9443c01a7336-2cce870a060so12056575ad.2
 for <dev@dpdk.org>; Wed, 08 Jul 2026 21:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783570067; x=1784174867; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WFsZkRcMOp0Iw7LNEL/TnpSo3O33fK+tV1PO7htKmZ8=;
 b=GP7YNXysOvCdsBUCjcsADIEUwhNbyYnFWNu669RL4MSHL9rGlk8K3y/UqA0OFnCi4A
 08m3SM4VaHEysdDl0AuO6n+ptwV0oHJA8xrO7b8vvGL8VqcZWBhUp0ecqCjtdT/eiLL/
 J4s3Xeou3qiwRpvl5sXHikZpLRveqwKuAlzZaG8b2R7J8RubOJMQOON4N6UeARG8d7P9
 Ha8kpcm4KBn5DCaZCkRTvcowrLQVnogfk9jqc5PxReimow6vR9/Jc0frA+MumzegyrcA
 mdYVJe7Fym7ZGvYwseoF8INqyli86y37wREGxVSYL7aFiM4ppBpc3rTfG8LDIICf6Nsq
 JjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783570067; x=1784174867;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WFsZkRcMOp0Iw7LNEL/TnpSo3O33fK+tV1PO7htKmZ8=;
 b=L8zcdVBZewGbZPyVbkVLpVYjpZQRY5R1+sYZtd3RUudrLpK+ijJDZYPuLSgXKfxryg
 Zy3Y/VdgadZnucNyLEHa//kPjbe+ZnS5MDwZNwn/KVI5b+0c9Z8IBQzVuP1zXkiE/86V
 /WOgDUx8e0nQDmP/KZYsI1ZVM+jzZ/7X1DkH9jUmbPihgqn0xWjiXXlWeEwqjcnIK1kH
 JpWi8SyQpjr3mKTdM24qHHdG1CBEDmy/D2N8jwNk5ELx+OtBQeTHUnEP7WVqfKVcnu6e
 2X9jThx+aFsz+R3hhk+RSP+JNJtWrO0oPgClgdDaMxV0MnxL7ii2vwv5g5tj7Qi7Lq0O
 Kpgw==
X-Gm-Message-State: AOJu0Yz5MW8NL1Hkb40OlwMa7gCmrWCYJWr5IqQABimbmyk7kDe4ZMNt
 Fr7aAj0HGsq/TbtAnGIuo3X8ZGEe9y6lgSzyDCrfz4S8kGHKDveG5mmht3Wx3iItouuH7VHGjG1
 t9E9z5ZAmreGRTQ==
X-Received: from plse12.prod.google.com ([2002:a17:902:b78c:b0:2c8:1c50:a617])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b4e:b0:2ca:d151:382d with SMTP id
 d9443c01a7336-2ccea3a3cc7mr55793975ad.14.1783570067239; 
 Wed, 08 Jul 2026 21:07:47 -0700 (PDT)
Date: Wed,  8 Jul 2026 21:07:31 -0700
In-Reply-To: <20260709040739.3184955-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260707164020.2936476-1-joshwash@google.com>
 <20260709040739.3184955-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709040739.3184955-4-joshwash@google.com>
Subject: [PATCH v4 3/9] net/gve: copy data to QPL buffer when mbuf read does
 not
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
v3:
  - Fix 32-bit compile issue.
v2:
  - Remove unused declaration and definition of addr
---
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
2.55.0.795.g602f6c329a-goog

