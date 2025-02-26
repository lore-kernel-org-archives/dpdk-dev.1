Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14C1C19776
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 19:55:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0901240664;
	Wed, 26 Feb 2025 20:55:53 +0100 (CET)
Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com
 [209.85.218.99]) by mails.dpdk.org (Postfix) with ESMTP id 9377640659
 for <dev@dpdk.org>; Wed, 26 Feb 2025 20:55:51 +0100 (CET)
Received: by mail-ej1-f99.google.com with SMTP id
 a640c23a62f3a-abec8b750ebso21444966b.0
 for <dev@dpdk.org>; Wed, 26 Feb 2025 11:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1740599751; x=1741204551; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhhuRDDB3LRiPIWIJf85Y+mnxcsa9XIjUBNSZDC6M2Y=;
 b=RIsnSC/dH4PuSzwthASGhYWHYL3IYcyajICkiaSjM6kxNxjAtOVFI3kuElOL60vZp0
 OEQGez6uHNm9hRuC7gyc756ketRGXIVJ4FYryBEEh0G9SYxpLnwm6MzYSsu1ElEWG+r9
 HM9l0j4bndcZVAOSFz7vZ9fqZpGfMEnUFVhal+SiD05U31rzICYonBOYuIODGbisYE+f
 URMNILm4GL/4vPvfdsl6UN6SetmKAeb96mH4Dy6isWlG6L6L4QLJzFyokaNQTblUIegG
 JZjwT3NG4w5L/Psbxe/Jnqjh2dhXmypgP8Tp/r86MLbMqZoTkIVBOBwP6ApNu40vdT2C
 JKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740599751; x=1741204551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhhuRDDB3LRiPIWIJf85Y+mnxcsa9XIjUBNSZDC6M2Y=;
 b=EaluarlxLmcZV4Z7aUE1gENs4RLwgL1pZy8G31cvFXH92xR80i+sQaqsLVMoyinouW
 UlwtE5CpOwmqnSNWUBdS15jYO3stkqCrKQd0Mud5UNUzbPH+Ka/7grEOZ9wNY31C3/Hs
 HLWW/39JvMkkUQN2MuIgyNeItBW6wGJMo2vJXIj4uBQnsPx06Kv5yWTlcC2/M0kw9hFv
 zf/LoaxwsW0JpGT8rQEMRVs6tBikT4GG0a+e3h+cWSZavDhvql7/k7mhlR8hcSdbR1au
 ECzpMZu/3WI4fPc5JEJ7ya5hOxNt4+xV5QetJ826UmGu7r2oegk9lWeQwfrWVngRggT2
 udGA==
X-Gm-Message-State: AOJu0YzzJcDfQG0cu0e9glKTJbPWQpAh8DEIIvkqu2dN9NKGu9lHy0ws
 xb2jqmLNJdgqHimFzDIGEMwG/F/0DvMeAzUZtRogoD4mquUADY78Y8NDvjNXw35EZp8CetgClFk
 qhAMooa6SiCwDoWds6KTCz+p9uVURvTPhP05X14C9
X-Gm-Gg: ASbGncs0rnHxVfoyJmTIAiVxzunC8GCkUIIOzYiKb8omIcBi/EnimxWB3Vc4bpfFaCi
 EVGFmldX62m8AFZG8E9zGPyyaNU5QsSOSiXYKDlTZTRZWOt46BCegaUpwCZc/c6PAAPl7P7MePb
 3PY2m/28JF9Mcgfj/vEOcUYjpRYGhb9rf8K7X6xTWWYbM9qg+aPFWoVdCh7RU1fmx3dCvlsKVTw
 lSa22IzRbAjRAVWm+5W1WU7mWuZ2v35/mtqvo5WdVXxmW5YoDRBJyr33fkg64tXMrIl/wwHsMFU
 rH4BrNxp2eDK3hZD5lOwxFF144VFrn5GkB0YtiXWq7rA6LbRkFeHVgKfKRC2
X-Google-Smtp-Source: AGHT+IHkbhUWybAJ3OYhQwmQn3jozcV053QYj/efLqzg98q12m+XLYJBWoNGcwJq8+UdHcMqLoyK6oSIpe0A
X-Received: by 2002:a17:907:9619:b0:abe:ebe2:6747 with SMTP id
 a640c23a62f3a-abeebe26b4amr701713666b.9.1740599751193; 
 Wed, 26 Feb 2025 11:55:51 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 a640c23a62f3a-abed1b14785sm26701966b.95.2025.02.26.11.55.51; 
 Wed, 26 Feb 2025 11:55:51 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 08FA2175F1;
 Wed, 26 Feb 2025 20:55:51 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v11 2/2] net/af_xdp: Refactor af_xdp_tx_zc
Date: Wed, 26 Feb 2025 20:55:04 +0100
Message-Id: <20250226195504.2340737-3-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250226195504.2340737-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250226195504.2340737-1-ariel.otilibili@6wind.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Both legs of the loop share the same logic: the common parts are about
reserving and filling both address and length into the description.

This is moved into reserve_and_fill().

Bugzilla ID: 1440
Suggested-by: Maryam Tahhan <mtahhan@redhat.com>
Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com>
Acked-by: Maryam Tahhan <mtahhan@redhat.com>
---
 drivers/net/af_xdp/rte_eth_af_xdp.c | 75 ++++++++++++++++-------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 092bcb73aa0a..013f30dfc3bf 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -536,21 +536,49 @@ kick_tx(struct pkt_tx_queue *txq, struct xsk_ring_cons *cq)
 		}
 }
 
+static inline struct xdp_desc *
+reserve_and_fill(struct pkt_tx_queue *txq, struct rte_mbuf *mbuf,
+		 struct xsk_umem_info *umem, void **pkt_ptr)
+{
+	struct xdp_desc *desc = NULL;
+	uint64_t addr, offset;
+	uint32_t idx_tx;
+
+	if (!xsk_ring_prod__reserve(&txq->tx, 1, &idx_tx))
+		goto out;
+
+	desc = xsk_ring_prod__tx_desc(&txq->tx, idx_tx);
+	desc->len = mbuf->pkt_len;
+
+	addr = (uint64_t)mbuf - (uint64_t)umem->buffer
+		- umem->mb_pool->header_size;
+	offset = rte_pktmbuf_mtod(mbuf, uint64_t) - (uint64_t)mbuf
+		+ umem->mb_pool->header_size;
+
+	if (pkt_ptr)
+		*pkt_ptr = xsk_umem__get_data(umem->buffer, addr + offset);
+
+	offset = offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT;
+	desc->addr = addr | offset;
+
+out:
+	return desc;
+}
+
 #if defined(XDP_UMEM_UNALIGNED_CHUNK_FLAG)
 static uint16_t
 af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	struct pkt_tx_queue *txq = queue;
 	struct xsk_umem_info *umem = txq->umem;
-	struct rte_mbuf *mbuf;
+	struct rte_mbuf *mbuf, *local_mbuf = NULL;
 	unsigned long tx_bytes = 0;
 	int i;
-	uint32_t idx_tx;
 	uint16_t count = 0;
 	struct xdp_desc *desc;
-	uint64_t addr, offset;
 	struct xsk_ring_cons *cq = &txq->pair->cq;
 	uint32_t free_thresh = cq->size >> 1;
+	void *pkt;
 
 	if (xsk_cons_nb_avail(cq, free_thresh) >= free_thresh)
 		pull_umem_cq(umem, XSK_RING_CONS__DEFAULT_NUM_DESCS, cq);
@@ -559,51 +587,32 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		mbuf = bufs[i];
 
 		if (mbuf->pool == umem->mb_pool) {
-			if (!xsk_ring_prod__reserve(&txq->tx, 1, &idx_tx)) {
+		  desc = reserve_and_fill(txq, mbuf, umem, NULL);
+		  if (!desc) {
 				kick_tx(txq, cq);
-				if (!xsk_ring_prod__reserve(&txq->tx, 1,
-							    &idx_tx))
+				desc = reserve_and_fill(txq, mbuf, umem, NULL);
+				if (!desc)
 					goto out;
 			}
-			desc = xsk_ring_prod__tx_desc(&txq->tx, idx_tx);
-			desc->len = mbuf->pkt_len;
-			addr = (uint64_t)mbuf - (uint64_t)umem->buffer -
-					umem->mb_pool->header_size;
-			offset = rte_pktmbuf_mtod(mbuf, uint64_t) -
-					(uint64_t)mbuf +
-					umem->mb_pool->header_size;
-			offset = offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT;
-			desc->addr = addr | offset;
+
 			tx_bytes += desc->len;
 			count++;
 		} else {
-			struct rte_mbuf *local_mbuf =
-					rte_pktmbuf_alloc(umem->mb_pool);
-			void *pkt;
-
-			if (local_mbuf == NULL)
+			local_mbuf = rte_pktmbuf_alloc(umem->mb_pool);
+			if (!local_mbuf)
 				goto out;
 
-			if (!xsk_ring_prod__reserve(&txq->tx, 1, &idx_tx)) {
+			desc = reserve_and_fill(txq, local_mbuf, umem, &pkt);
+			if (!desc) {
 				rte_pktmbuf_free(local_mbuf);
 				goto out;
 			}
 
-			desc = xsk_ring_prod__tx_desc(&txq->tx, idx_tx);
 			desc->len = mbuf->pkt_len;
-
-			addr = (uint64_t)local_mbuf - (uint64_t)umem->buffer -
-					umem->mb_pool->header_size;
-			offset = rte_pktmbuf_mtod(local_mbuf, uint64_t) -
-					(uint64_t)local_mbuf +
-					umem->mb_pool->header_size;
-			pkt = xsk_umem__get_data(umem->buffer, addr + offset);
-			offset = offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT;
-			desc->addr = addr | offset;
 			rte_memcpy(pkt, rte_pktmbuf_mtod(mbuf, void *),
-					desc->len);
-			tx_bytes += desc->len;
+				   desc->len);
 			rte_pktmbuf_free(mbuf);
+			tx_bytes += desc->len;
 			count++;
 		}
 	}
-- 
2.30.2

