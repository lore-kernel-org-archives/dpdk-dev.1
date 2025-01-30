Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB23CC0218D
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jan 2025 22:19:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA8F840F16;
	Thu, 30 Jan 2025 23:19:23 +0100 (CET)
Received: from mail-ej1-f98.google.com (mail-ej1-f98.google.com
 [209.85.218.98]) by mails.dpdk.org (Postfix) with ESMTP id 9F4F2410D4
 for <dev@dpdk.org>; Thu, 30 Jan 2025 23:19:21 +0100 (CET)
Received: by mail-ej1-f98.google.com with SMTP id
 a640c23a62f3a-aaf57c2e0beso286914166b.3
 for <dev@dpdk.org>; Thu, 30 Jan 2025 14:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738275561; x=1738880361; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WG9BHdM8SNqVry6anHPgfAW9LybIxX4PlmGjSM/tBF0=;
 b=AMDEQB5lFDuZQW/rsFtMAL4EfmLewCbGIX5HehJ81Vy0ZeNhSGMkjGKygW5v+Gyu6L
 8t2Ga8a6XrIVicVKYj8E7SfZ1eB2v1Iqi8IQYOeIgcvGcUL5a3s5d4pqiCY8q3b6BqwO
 EZiUWZnQTEVM9MOenaJCYzCkGedJbP5pyMD71jKOFcpMpnntc8VRdI2R5SZ3GV7Mhjod
 rZLh8CsZcX4OL9p3S822xbUARDsaI9TIg4dap7k7HrnP4ZQbQpCJsW7Nz+pTSEJ5A8ZP
 f4/iwa9NqIoCC+S1FQkKeVMQIHiacF5zo05qYVs5wt7SjQgGJafgVAtQjrBLTvlaPsqx
 DZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738275561; x=1738880361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WG9BHdM8SNqVry6anHPgfAW9LybIxX4PlmGjSM/tBF0=;
 b=qhdnc7XF97DpKKk/fkCo/bqaWMa/Y3xQkthW8h5AhqNudC11iNUc8Ngov94AF62svg
 iBfAd8OEHB5gcyy75ZKc6aqKVr8Ek5WyR6OEwYdbAR5rIwpWHYr8nxEPx0UPBsDVn7lF
 n6dQI8rf/o9S3YDb1dGD7zj6uH9xZ8BYCxymiD+VNy59mQwD60zxiMiksrAynZpKfZYy
 /5OjaqtD2KXOUwVX9zbiEyJiJKTcOdZ9Hv0rIJ6txGdz9X8o7X6/IMjAy4r3wXUiakNm
 YjiXPHTtQKSgjTeB4gMx2sVWqEYqujD5DYC7maoSoKq+avR4DyIaJitBho7HtzIXTY0M
 2wvw==
X-Gm-Message-State: AOJu0Yzmwx0bccC/pqANky2dMShrPFSi56v75y76UrpVw4U9g6KQP9Yv
 K+l/4eqW0440DIAa2LIaBtWjOOe89iMTFKeI23gzC66XKtZQTjcnhZqN3fSpzY5+yxivniKPe7l
 Fbdogx5xXgiKskX8ZRgJIDvbiKOKQGVHYsi3LszzQ
X-Gm-Gg: ASbGncsYop/ebcrJMWEcoobEsukRskCB8rXUfn2m63Pdddxqdq8O2ITgowILZP7Gcow
 uzLHmL5jrOTezQE0Lw5sFm/1412o7tiFaw4IznKddkqsNhaQoqfKW5hA71n5+/yMl+taG/I6oNN
 nbSeztW3tIJbkxtv5PW0FMUevbl+P/Sxc8jR464iur03Sr0+v5CyJqxMLUGCS525KR8+XrNaG27
 1TFasuGz4UQq1aNn3c9NdNtGsi71Vr5l3/KHcpvXnr3vDRZM3aN2smi7SiFmQUPuAcUglUEwiUk
 f0D7JmbxJNrirYluvW3q1Q/zhMSy/xOqK/CKEuyNhm4p8Zt2AA==
X-Google-Smtp-Source: AGHT+IEZMRwpehk/vAc2chfeXEE5SQScXQIs3wNG9JXOhPKEEKhdTaVw52O3K8HTbbml4y+Yb/+3zCvtEWYo
X-Received: by 2002:a17:906:7951:b0:aa6:6885:e2fa with SMTP id
 a640c23a62f3a-ab6cfcbb89cmr919197966b.14.1738275561147; 
 Thu, 30 Jan 2025 14:19:21 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 a640c23a62f3a-ab6e48b8ccbsm7776566b.115.2025.01.30.14.19.21; 
 Thu, 30 Jan 2025 14:19:21 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 0183E194F6;
 Thu, 30 Jan 2025 23:19:21 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 2/2] net/af_xdp: Refactor af_xdp_tx_zc
Date: Thu, 30 Jan 2025 23:18:53 +0100
Message-Id: <20250130221853.789366-3-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250130221853.789366-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250130221853.789366-1-ariel.otilibili@6wind.com>
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
index 092bcb73aa0a..3f5de4d9cbda 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -536,6 +536,31 @@ kick_tx(struct pkt_tx_queue *txq, struct xsk_ring_cons *cq)
 		}
 }
 
+static inline struct xdp_desc*
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

