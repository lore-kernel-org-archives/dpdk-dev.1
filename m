Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA1AC02190
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Feb 2025 10:03:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE551402ED;
	Sat,  1 Feb 2025 11:03:14 +0100 (CET)
Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com
 [209.85.167.97]) by mails.dpdk.org (Postfix) with ESMTP id A10E7402E1
 for <dev@dpdk.org>; Sat,  1 Feb 2025 11:03:13 +0100 (CET)
Received: by mail-lf1-f97.google.com with SMTP id
 2adb3069b0e04-5401be44b58so2996764e87.0
 for <dev@dpdk.org>; Sat, 01 Feb 2025 02:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738404193; x=1739008993; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOt2tUR0ldEwDzpRqLO7TBVbBqDLGI4r7tf7PPRYcUc=;
 b=CiojqX6DcBO9TYLzF30+HQEc9wThS4Bw7/Sa+xrOmRidO0uKmDOexYuwjoqGtwwMGU
 RYBlsLI1gZqXoPBc9sViJ38NLx9hVg/2h0vJg1LGheNgGHPdorB4d7PJLquHcMpXS0wr
 e6CcHchtlPTGFEdlFNICHGmWTKIO5h+R7sOOFlQK7toExAGAZvJuHz+zRW1l8m7k3/xy
 BWLnqD4H/uP/WYtTXAoW97Zs1hrcENYrAgIrBe46eCK7zQ2z8X9TTPIfR7O+5GpSQcGR
 qT7YdIXXm2IBj0J21YCmdtx1dl7LrZN6OVorRXdV2zbZiAxng+pcqopoqlDWdNZmorRX
 +RKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738404193; x=1739008993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOt2tUR0ldEwDzpRqLO7TBVbBqDLGI4r7tf7PPRYcUc=;
 b=KvDDQh7PhTcIbznZEhs/sfY+4xeiZPnnP4X5FbF5E3OpTD4PPgO/whsm4FQ0UYvlYj
 HxouNaDOaJFsfyG4raTbBx7GtbmR44l2X+TjmHR6BEry/DVcDCo47bZLd5iGN9XoF4WB
 z+pSCvbeP4+a2CEgRxQqhZBgQ+F/U1wXcGAf5xto/RikVU9FQZQoW6gTOj6aORzyN7ql
 imP+DKya9Lx0sz62yeQmh+qwSdWC/OL9qb/vJrEd7mDc1M7ymP0y0+KrbMiA6ZskCuru
 xeVlPT/KSM8w9uC8aGgaBSwW+85BYS39XRktDkcaaiIYYouxdg6UskJDpAwQt/O44glz
 pc0w==
X-Gm-Message-State: AOJu0YwIrw1KuXbqTHw7EAQQ1sb38tSYoEs1WUQn8IcI7myw6U3g/KSQ
 ElXpVMGd07e0YpvUXPztsrwXnxmCr05+Qo+/Z98LpxYq45V/+cYTwJREcQoqpRhl0m0u0F9Yu1a
 DkkWrJ1Uey8Ts6t2ua9b4lEtRIfa+6NU1v7Sm5tE7
X-Gm-Gg: ASbGncteFXFZiYooRaCnSY07cxOgGA16HwoGa0T3WJF5oUlcfaPkJTu8+AT+2LXR9AU
 szQl4J9wg9Wxi87sisshpih8vvua5akEaeOl/TVii+9G5QBjIZ8pBldB/RsyPJqy98D9MYkObLN
 rbo5E7AS2eSxsibonGvVK4Q668YFfzUcGR3jPIKV1DtYDr9QtAq9r9W/1BdqI7+53hofKI47obC
 Wt8O8DC4XIn/ae6oiMhn4IyOxDuFhHKscDNZ5U7lHCnFMkKOSQL6Ywvw3Uj991ADTrjm06IGHOL
 N6H5ZRPBjIqxM/CXn9X0GaslDOXjxypuCW4AtvJQvkkh5ZxPwg==
X-Google-Smtp-Source: AGHT+IHdg8RS3hCRDUxVrgFBAlArCl5Pnjt3kIp74V0bVn0QRU+jl31ZnIoWiuq6c1fm0UvlQ5BTeBUeNhwh
X-Received: by 2002:a05:6512:3501:b0:540:1e5e:3876 with SMTP id
 2adb3069b0e04-543e4c3fcc9mr4281528e87.52.1738404193092; 
 Sat, 01 Feb 2025 02:03:13 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 2adb3069b0e04-543ebebdefdsm204444e87.126.2025.02.01.02.03.13; 
 Sat, 01 Feb 2025 02:03:13 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id B374A1A107;
 Sat,  1 Feb 2025 11:03:12 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Maryam Tahhan <mtahhan@redhat.com>, Ciara Loftus <ciara.loftus@intel.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v7 2/2] net/af_xdp: Refactor af_xdp_tx_zc
Date: Sat,  1 Feb 2025 11:03:00 +0100
Message-Id: <20250201100300.2194018-3-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250201100300.2194018-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250201100300.2194018-1-ariel.otilibili@6wind.com>
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

