Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F070C19776
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 20:08:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B754D4067D;
	Wed, 26 Feb 2025 21:08:51 +0100 (CET)
Received: from mail-wr1-f98.google.com (mail-wr1-f98.google.com
 [209.85.221.98]) by mails.dpdk.org (Postfix) with ESMTP id 0002F4029A
 for <dev@dpdk.org>; Wed, 26 Feb 2025 21:08:46 +0100 (CET)
Received: by mail-wr1-f98.google.com with SMTP id
 ffacd0b85a97d-38f504f087eso80116f8f.1
 for <dev@dpdk.org>; Wed, 26 Feb 2025 12:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1740600526; x=1741205326; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ElBrWPjpset7vRFXvFajL/VkSevGKchRJ8ObYeh19zQ=;
 b=a7pv/Y7DEg/XM/To4xLpigNjEh7Uq4ENJIK0zGB1u3GmLv0WvRMcBVvtLXW9niadUV
 /vM0KvX6F2us44l8XFLHn9xc3WPoVmDYmMnAVax/7sBlNv79FWmtzqQkCuh2ESFb1J7Y
 sDaM26aaEqPoRFM6+yj1GvRIxNmPhCgo8ZTVkbNSvyrlb4cQeG0mDuUYyKq4p0v88lQb
 qS60pUVrc80/KgYmyKEFFAIB8YYBETq6WF/v80EWTQOc/vlmgPuEBjfOrjmegk+llPVb
 U1BEppwdpm/r2IaLkg63V1e8VeU7O7QcIqeCiiMGBzqGOkvQin/6g6DaOQT5sVCbZCzA
 Lkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740600526; x=1741205326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ElBrWPjpset7vRFXvFajL/VkSevGKchRJ8ObYeh19zQ=;
 b=chcIj3snCDcvwM34mDpNYrXYHGFqhs290OWeYHDV/zi9pjc0DKqE/3vQ6NX5+TTsJD
 BA8GYogC0TY3H4NMQrzsl0UqQkRVOnNfTfOAZQhepubVVKzO3d82UZUkBtf1m6Ac5hXw
 jAmAFL35bFb2FQju1sCH20TCFORtfDX9P1VZocNB33131kvTHhqiyaGUtTBW7sEohnXE
 UyJS1qkpMVWvslnDhnhFRnkC3HZEaKkNN69C7mTYw/uiILO4bPxYSmlWRsUO1PASwjc/
 Gzg+nYCPd5RqEGuoJMIOXUTfEjlCQB7QFkIxTHpaccqKOh7ehOT5Piddd71zOIlcbqD2
 HPbg==
X-Gm-Message-State: AOJu0YxPl3vQ+lws6spB8IyBhfdtHwXYroXh46WkBq+d/kY3nQZpydv7
 6lthhyZkoutAByub0Jpfu3HgYwnEqPZeR7V7mQLeKsxMP7mKmeCZTAgrbtAVTZOMsxfdpBWUmhE
 1eJ3Xi87GUWE/EIWSw649fvB1nN9axChgKp2GuKMd
X-Gm-Gg: ASbGncum5Co9v9Io4Om7Hj/XXJO2GjT1Iv9yhVwpDpyi0038F8SavIYZkk1hXP1hFGG
 fyYaYTRi8Uht1dZEFfEzCpfki17c51IqwDLPcB51fdjipTrEqgaBx7T2DkGDNtxulWZHwpFbwVK
 wJ1AKgnaBEetsBpc+EQwniItAArZHplru9Ejxx2WZ5Q5fmuTA8Jp/IJCnMQKEhWK5KrdvVgzMk7
 9NTO5RuOSCVJ6BXOQapiq/8gZvaJ3UyKEhR6Omth7Ozs1B9nKFpSpoRJAgxdAFJRoaQ0YY1p6qZ
 HGTvHdcFpDshhEKkGJfbnb5XNBqmh+NTYN2RqTm7jf+DZfTLn9+dkBzzZMLv
X-Google-Smtp-Source: AGHT+IH365pOPlQXvaHlP4cZX8wYiUb5LqW76l6Ee5ELelSakp8QDv6Fwtek5dPogoP+p5kmzEJm+kkBtAy2
X-Received: by 2002:a05:6000:18ad:b0:38f:2766:759f with SMTP id
 ffacd0b85a97d-390d4f8b640mr4201296f8f.41.1740600526516; 
 Wed, 26 Feb 2025 12:08:46 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 ffacd0b85a97d-390cd8e63cesm181687f8f.67.2025.02.26.12.08.46; 
 Wed, 26 Feb 2025 12:08:46 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 65A7B17601;
 Wed, 26 Feb 2025 21:08:46 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v12 2/2] net/af_xdp: Refactor af_xdp_tx_zc
Date: Wed, 26 Feb 2025 21:08:41 +0100
Message-Id: <20250226200841.2342632-3-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250226200841.2342632-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250226200841.2342632-1-ariel.otilibili@6wind.com>
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
index 092bcb73aa0a..05115150a7b9 100644
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
+			desc = reserve_and_fill(txq, mbuf, umem, NULL);
+			if (!desc) {
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

