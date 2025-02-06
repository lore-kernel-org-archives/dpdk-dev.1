Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10C3C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 20:47:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3397541133;
	Thu,  6 Feb 2025 21:47:16 +0100 (CET)
Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com
 [209.85.167.97]) by mails.dpdk.org (Postfix) with ESMTP id 714B841133
 for <dev@dpdk.org>; Thu,  6 Feb 2025 21:47:14 +0100 (CET)
Received: by mail-lf1-f97.google.com with SMTP id
 2adb3069b0e04-54024ecc33dso1408222e87.0
 for <dev@dpdk.org>; Thu, 06 Feb 2025 12:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738874834; x=1739479634; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Dq9iiAFVUdH3vichyLAe7TUuqnpJIiyti68IVrNBY8=;
 b=h528/L9aQf77y6oIciIizOwhMhSAz01lXSjDgYC5YZr8UxNQzYO8kvuHxXtOkKnObI
 5QE5QzUGJnyCsARGQRsD+AHxgp6ugeijbAHWIAs2KpD+Drg+Kcaxb/FGWML8lpWEFi0X
 HpxGQlbs6/iyc6o/tIgv5Wg3ZW3blFCGdrM7PydFbW/gA7LC/YrT56OR+82lTrCx6OWZ
 OFawJQzd7nE7DXgxKHXJX+rJpYIoXKYX6MRY4R6fwKpofI9J93f5HdyYSBSPLHC9egKN
 NB/XA1/G8rwVmT7bmSX1MarYA28fMOSekzGdS5M00zW//ZBmL1coc7o/OxCnCLprcga5
 MZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738874834; x=1739479634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Dq9iiAFVUdH3vichyLAe7TUuqnpJIiyti68IVrNBY8=;
 b=NAeBW1EgzRRkKplTld1pKqjIbMVOz31gO5qvkxtw/e5VzG3osc5I/swu3qgMbfeQUO
 X6aJREe+AXPD5/RXZF5Q8FJniDBGb/cMI0isWX4gpkBn+W13hwk+JK111HvwzOw17TfE
 oJuoHG/1Fuj8wIu1XvPh9D4D4uqmoPUDZs694eFs81cRkVOVhI5/cl/I5wlVWB2EJlhH
 UdpmamwiZGN17FzAJj/5WV5S8GJ1u/1J/i6quyrARLbvEbT9Zy8Cax9XlpFTZCGYcJYt
 FFCmL2xZwrAFaE5s1PLLwaBbb/xggekNDI3NoCZ2Jq9BunmtZOB2Sdo4kn7c+w+RO6O+
 Amxg==
X-Gm-Message-State: AOJu0YxlU4OxDdlaAGoQtpqQfQfvLV9blInShAwG+mLtf99KVmes+Vzr
 6iEVG6HPRaisvPG32Z51iUDOjOG/GIvI9LklKG+KmbIFpNlA0DlMOjw7KsBmxrR4YVBa5hIjuh4
 3Ix2KD9be1d+R44h73YON7x9NmWxWU/898At0t7Ub
X-Gm-Gg: ASbGncv3xHbZ6elVdq7wrKD+gStNkul6Z5Ng6g5czpN0a6J9Qxu103oXX8TCkUeMtMQ
 JItheZmeJEyJcNO3VqZLZBmeoBXTuxqsnXg64+HS+TizJ/BRpGoD7WfVLZKS0StsVDcWUZZR4h6
 XYQZIN4bYdVTJlYT0vDSlRMexCphEYao+AsJ21nj9GX/irLxnnvJgcVe6CuGUzLidGX09G45etp
 U49o67w3IJJRsAUN8Nr3VDc7+2AGbCt3WHoKeTlz/x2YO+XI2in8yTCATFEgLdhYMtbGC/4tsy/
 D8mtRZs1XIEMDntgv/28rN9Xmr+vsPez/drOgqnDmBlkIPQMlg==
X-Google-Smtp-Source: AGHT+IHXIvkjLdwmwKYa9DYiKd3J3Tt3OdmrV0dUKkcIPWMBRuICbGQTb1GMzzX1WQCkPOFzmmbB+XUUegZu
X-Received: by 2002:a05:6512:3d18:b0:53e:37e4:1457 with SMTP id
 2adb3069b0e04-54414adfcdamr99205e87.33.1738874832781; 
 Thu, 06 Feb 2025 12:47:12 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 2adb3069b0e04-544105d4c37sm88695e87.79.2025.02.06.12.47.12; 
 Thu, 06 Feb 2025 12:47:12 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 5BDB61CE64;
 Thu,  6 Feb 2025 21:47:12 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Maryam Tahhan <mtahhan@redhat.com>, Ciara Loftus <ciara.loftus@intel.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v8 2/2] net/af_xdp: Refactor af_xdp_tx_zc
Date: Thu,  6 Feb 2025 21:46:45 +0100
Message-Id: <20250206204645.1564535-3-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250206204645.1564535-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250206204645.1564535-1-ariel.otilibili@6wind.com>
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
---
 drivers/net/af_xdp/rte_eth_af_xdp.c | 75 ++++++++++++++++-------------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 092bcb73aa0a..ce80f32041fb 100644
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
+			desc->len = local_mbuf->pkt_len;
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

