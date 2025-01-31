Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4C4C02193
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 18:35:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56CB240652;
	Fri, 31 Jan 2025 19:34:51 +0100 (CET)
Received: from mail-wr1-f100.google.com (mail-wr1-f100.google.com
 [209.85.221.100])
 by mails.dpdk.org (Postfix) with ESMTP id C088B402C4
 for <dev@dpdk.org>; Fri, 31 Jan 2025 19:34:47 +0100 (CET)
Received: by mail-wr1-f100.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so1257088f8f.2
 for <dev@dpdk.org>; Fri, 31 Jan 2025 10:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738348487; x=1738953287; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJiSYXomcKgQ6URfcKk6SSuJt0D8q2gQscNv88xSzLk=;
 b=PPtMsqGoN/7pGnBF+KR7c/ohfUpXEUv/oO/oCRInh9yexBFdT2m7Wh5fLdD9CFVAda
 IteP1Vj+zk+uik7+twKvrlwEIAfMg8gWdk4m24bTerRy5oHTjhXmA+vagct4PdCPjYUa
 2/6FnievqNNbuIPTwKFx4QPy2v7T7/zbDilp80Dze95/LdpepkK83WVWzF7clpZNMk20
 +XTUVkg5zuzC5+0r3gweQF9VVlG6MyKh6iGT20buqvYfktvIosMFhxAd+IIKg+WDvPYP
 /VUhf7Rz4AQtP5qYuGO+ZpP4Ske31dP38xqo7u33B1HI2KPPo1aH4afyBwuc6Lz7XSsS
 wesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738348487; x=1738953287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qJiSYXomcKgQ6URfcKk6SSuJt0D8q2gQscNv88xSzLk=;
 b=gx87VTsFod6TVEUJvWLsAtza2zFnPCHnISHwSycCBLSv6fR1oYsm95/HSyEHW7ghA7
 ewfBPTbatGX1TGtXJV37o9J9aKLZARuGz6aaCXVjKInEgFKRp2kA+Z56vKIMFSL6klgo
 s6rOIgJ8h1cvaqJSZEpGX0+tIC9VXXKC5Q5ZGvoqNfRTV0m+RuQAStB05NjU3CHltsjp
 qq4ciRRzuONzmhlmxJiNr3BVOndmV6AHs8x7d6BDU2ADkSP0UG3+hASa/EORfmbEBBEj
 gnGrBpvH9ofD27AYEIf4f86IX8r9p40SA8YVd+1G5Wt62HSp66ZICMgm6HlAG3lD1sjH
 rF5w==
X-Gm-Message-State: AOJu0Yxibkym5aWm2eQwnIp6x35Mm4dp+/7NoTLvS+1QmjB0WgeR37ul
 jIBk5VQCHbEjUGcF08B/eAx9oOx2UYMBtgZTcaMhMWrKm0InUQObYMMMgvcVogn4Ibrv5pGxuhh
 zG8HlLsg1nrXXH5gWZwiDXUjATNnnY2UyvwLl3sAe
X-Gm-Gg: ASbGncsTq011MX0j1ql8CLTHb+a0N8aoFMb1tPmudinI0jUZ0tJiLBOnhVZQ8fcJBXG
 dwpNey7DEC3KW0cWi1dxXpC48FBM86iK5X8RbJJ4YteNmqIeIVGywodyuHJed6BZ5c3DWl+XxQp
 CUnHQzK8wcDy5/gxkitP7dvPJGC1H1lklcXQgvwg8zjd6YFZwQSeporZys3HF8uNzVP16TMBbAf
 HyXifcfvklTuw7Q8XBt7gbBOpUQ0/J4p0NjdDFi477HDw67DkuP19vGU4xm6rHwajYR7aI8qB7P
 3pBddMd16VjsuFvqLW81r7AWr5NDsOqCnz2Ef5HHAszrLWcG0w==
X-Google-Smtp-Source: AGHT+IHaRjJM9xzqz7bLcnyCZ/Aj/mdWJm+vritJ+rwSLFu112Is5sXY7Jp0Ym2eTxiKpG0qYh2nprvNUCvk
X-Received: by 2002:a5d:5f4d:0:b0:385:f470:c2c6 with SMTP id
 ffacd0b85a97d-38c51932045mr10221866f8f.11.1738348487450; 
 Fri, 31 Jan 2025 10:34:47 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 5b1f17b1804b1-438e23e6b2dsm4903755e9.19.2025.01.31.10.34.47; 
 Fri, 31 Jan 2025 10:34:47 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 5BA4119C95;
 Fri, 31 Jan 2025 19:34:47 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v5 2/2] net/af_xdp: Refactor af_xdp_tx_zc
Date: Fri, 31 Jan 2025 19:34:39 +0100
Message-Id: <20250131183439.909831-3-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250131183439.909831-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250131183439.909831-1-ariel.otilibili@6wind.com>
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
Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com>
---
 drivers/net/af_xdp/rte_eth_af_xdp.c | 62 ++++++++++++++++-------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 092bcb73aa0a..840a12dbf508 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -536,6 +536,31 @@ kick_tx(struct pkt_tx_queue *txq, struct xsk_ring_cons *cq)
 		}
 }
 
+static inline struct xdp_desc *
+reserve_and_fill(struct pkt_tx_queue *txq, struct rte_mbuf *mbuf,
+		 struct xsk_umem_info *umem)
+{
+	struct xdp_desc *desc = NULL;
+	uint32_t *idx_tx = NULL;
+	uint64_t addr, offset;
+
+	if (!xsk_ring_prod__reserve(&txq->tx, 1, idx_tx))
+		goto out;
+
+	desc = xsk_ring_prod__tx_desc(&txq->tx, *idx_tx);
+	desc->len = mbuf->pkt_len;
+
+	addr = (uint64_t)mbuf - (uint64_t)umem->buffer
+		- umem->mb_pool->header_size;
+	offset = rte_pktmbuf_mtod(mbuf, uint64_t) - (uint64_t)mbuf
+		+ umem->mb_pool->header_size;
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
@@ -545,10 +570,8 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	struct rte_mbuf *mbuf;
 	unsigned long tx_bytes = 0;
 	int i;
-	uint32_t idx_tx;
 	uint16_t count = 0;
 	struct xdp_desc *desc;
-	uint64_t addr, offset;
 	struct xsk_ring_cons *cq = &txq->pair->cq;
 	uint32_t free_thresh = cq->size >> 1;
 
@@ -559,21 +582,12 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		mbuf = bufs[i];
 
 		if (mbuf->pool == umem->mb_pool) {
-			if (!xsk_ring_prod__reserve(&txq->tx, 1, &idx_tx)) {
+			if (!(desc = reserve_and_fill(txq, mbuf, umem))) {
 				kick_tx(txq, cq);
-				if (!xsk_ring_prod__reserve(&txq->tx, 1,
-							    &idx_tx))
+				if (!(desc = reserve_and_fill(txq, mbuf, umem)))
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
@@ -584,26 +598,18 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			if (local_mbuf == NULL)
 				goto out;
 
-			if (!xsk_ring_prod__reserve(&txq->tx, 1, &idx_tx)) {
+			if (!(desc = reserve_and_fill(txq, local_mbuf, umem))) {
 				rte_pktmbuf_free(local_mbuf);
 				goto out;
 			}
 
-			desc = xsk_ring_prod__tx_desc(&txq->tx, idx_tx);
-			desc->len = mbuf->pkt_len;
-
-			addr = (uint64_t)local_mbuf - (uint64_t)umem->buffer -
-					umem->mb_pool->header_size;
-			offset = rte_pktmbuf_mtod(local_mbuf, uint64_t) -
-					(uint64_t)local_mbuf +
-					umem->mb_pool->header_size;
-			pkt = xsk_umem__get_data(umem->buffer, addr + offset);
-			offset = offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT;
-			desc->addr = addr | offset;
+			pkt = xsk_umem__get_data(umem->buffer,
+						 (desc->addr & ~0xFFF)
+						 + (desc->addr & 0xFFF));
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

