Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731E1C021B3
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 21:53:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DD43402F2;
	Sun, 23 Feb 2025 22:53:08 +0100 (CET)
Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com
 [209.85.128.100])
 by mails.dpdk.org (Postfix) with ESMTP id 8D33D402DE
 for <dev@dpdk.org>; Sun, 23 Feb 2025 22:53:05 +0100 (CET)
Received: by mail-wm1-f100.google.com with SMTP id
 5b1f17b1804b1-43994ef3872so22249225e9.2
 for <dev@dpdk.org>; Sun, 23 Feb 2025 13:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1740347585; x=1740952385; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2oDOJc93e6C6OhSIE3mk2tu0aiFmVYFWdqY06gEsSk8=;
 b=ZRN2JP5yuuSJXk463teyB4TyHhOblyLwjbkJ2DisxREpDfSbezmFBlkWGbo9PPjmug
 dcvujJ0UHqV73kAzzswtY/jqrHZIZI+SlHyEKdeshILgOFA1391EoNU9S/lWV/lTTUDi
 j746DrFSwr16a5WveD7WCQORHojWXKcoEFsARBFz65PgHuv9QpPgIlC90xx63iU71jeZ
 ccGl799tVJBzo5PFVd4TuEy9EqDzYJCWNFFtMGEsbpb/vbnY9i/L/DKENZLdDuOFHbfn
 pyCXxIOIcQsXZRlwuzha5vNw0YIssvrbD9DAlP6FhtYDXL1QzGZwXlMc+ERJ6v57IEzL
 WhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740347585; x=1740952385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2oDOJc93e6C6OhSIE3mk2tu0aiFmVYFWdqY06gEsSk8=;
 b=d29/fBl9eJIu2CAakX3Xe1yO0XPQ8EqYCi5f+uH7fg2PpSUABgS99d5h2ebtUiC4hc
 Bby2E1RFobqG+jG4PUYao3x3TsVYmJmDIG5m3fdFF4eAe8e59ihYpFT3r+SmdEYamSzT
 m7x4NvIPIoS/fqf19bSIZY8uzlwARja3e6kolRAXWBn5lJ8AjsD/Nq2mQaoJoCIsZEgR
 gZ9i2TDC8loMbCLZo++8/4wLObPMDrp4/T9tbE2DqELMHxHPZnwhPa09uvitzTIneVKB
 TbGBHknOnXVOjqhfQWCIN2o/TPderkt6TfeliHMyx4DpNyUcoLxnt+6PaWC2j8HxpV21
 5zkg==
X-Gm-Message-State: AOJu0YyED5mBfcUmYpVjIvHL3GyPNqKZnhl9D1Op+se/Ktth/n6VYZlI
 iHYHwUr5IDrx/hAKjdKfslEEEkr5mt79LnIKcIAQ6WgS426noH7s3WJ1qC9ZQ38hgPhDS/LCBJ6
 EWFEysoxCONRJxOgdyZgX2AKhg226SkC4mRXYEyBU
X-Gm-Gg: ASbGnct6vMrcsCExRWXqte7ng2ZexVZqzlcJ5BfhyzTt1u1dwRuep1J0160t7V1+JKY
 tRzQYrtM/LxaU3qmu1OLFN8lSwXpY+/tkRsGg0PQdmsBGuIov7PMDwrgmczbG+wPdw9kemi1cb0
 PE7gJsCO7f951nCpdLp5BVtH7ENn9l3GMembmCtpxr4+LqVyppeV4WfmloGzZoUk4R1xqfRN+/T
 6ac90Ye/9Y2UhmmZKA7zj9iwj0Jc+7cPo4A8YWXo9zz+UyESt6v3cyTAXUb2NdlBzLpOErSanG2
 qSILbR8Rre8GJ/al+puSf8fMsYix7/dxtxOPDXlPX8cWpMWse1bigTuh9kOA
X-Google-Smtp-Source: AGHT+IG/BiYso2ph+6HjoGOiBdVg3X1gAOsbQxgzUQdSOtHUfppBJCjmkb9/WZkAU6aRsX09A8wVYeTDeylC
X-Received: by 2002:a05:6000:178e:b0:38d:b448:65c4 with SMTP id
 ffacd0b85a97d-38f6f0da5b1mr8615258f8f.55.1740347585160; 
 Sun, 23 Feb 2025 13:53:05 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 5b1f17b1804b1-439b02d4c3fsm4625395e9.16.2025.02.23.13.53.05; 
 Sun, 23 Feb 2025 13:53:05 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 109DE14F05;
 Sun, 23 Feb 2025 22:53:05 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v10 2/2] net/af_xdp: Refactor af_xdp_tx_zc
Date: Sun, 23 Feb 2025 22:52:59 +0100
Message-Id: <20250223215259.448723-3-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250223215259.448723-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250223215259.448723-1-ariel.otilibili@6wind.com>
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
 drivers/net/af_xdp/rte_eth_af_xdp.c | 73 ++++++++++++++++-------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 092bcb73aa0a..8d30d307fa0c 100644
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
@@ -559,51 +587,30 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		mbuf = bufs[i];
 
 		if (mbuf->pool == umem->mb_pool) {
-			if (!xsk_ring_prod__reserve(&txq->tx, 1, &idx_tx)) {
+		  if (!(desc = reserve_and_fill(txq, mbuf, umem, NULL))) {
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
+			if (!(local_mbuf = rte_pktmbuf_alloc(umem->mb_pool)))
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

