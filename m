Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD369C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 23:11:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17FE640430;
	Sat,  1 Feb 2025 00:11:39 +0100 (CET)
Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com
 [209.85.167.99]) by mails.dpdk.org (Postfix) with ESMTP id 2B752402EF
 for <dev@dpdk.org>; Sat,  1 Feb 2025 00:11:37 +0100 (CET)
Received: by mail-lf1-f99.google.com with SMTP id
 2adb3069b0e04-5401bd6cdb7so2554358e87.2
 for <dev@dpdk.org>; Fri, 31 Jan 2025 15:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738365096; x=1738969896; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOt2tUR0ldEwDzpRqLO7TBVbBqDLGI4r7tf7PPRYcUc=;
 b=c5YcvTfb20qPp2UmzeDNuv3oejdx1xpS+fpqidbldoUkKn956PJRM2ggg5FNmk/ZBl
 PKODrt3OBFaiVjo4DcvZsbR5Lxga2NseJyGQ/p5S0e0Ws3Qj/OD7h1XlbGiHtb7clV0w
 1cgXZXrlw3YqjaAQTxKl17weByUGyeeaQ0SaNybg6obvuFbKCHm+ueavJ9BYwWksW6Th
 q6QymoykM5Rz0f2/LVDYbJAcuim4xJPoCQaaXDTBwSoz8rddFPP/mkMRThdojP+d4WI+
 Z5D+NgCMDvfvh4sJouJwf6XkWseLrkvKFRcPcgLNV/TpNY56AqaTV38CDIXgvIjUJPmQ
 i5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738365096; x=1738969896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOt2tUR0ldEwDzpRqLO7TBVbBqDLGI4r7tf7PPRYcUc=;
 b=NerH1scl9/V4EzBif0zM4rMwKOzm5qXnz3qruyioo0AjYN6v9c/i4uOnQTt4/cGebO
 ZQvnfe6lgKlyyX1+Aqkpxegc0/lbNeW3116is/sVq6YrMJ9hrY2+LEzykcS1Jkgu0ntL
 47F6YqrZGw7kSamr/OPCmD/jddpgtk+UC8GCCseHGNvQ/Yk4oqCxtBG8Jl8vFqVHEQk6
 y7R5pI1qEzVXcbGuGESGJnGrWUlgth0yqFZZNTmWfHbtHUS7xvaCP4FGVcx70wnqBRKU
 UOS8uxWrRq8a38qyEvlgDOyWv0y6aVN9GhJ66UCmctPNS7zbHrwfh7IOYs6t1t7UGqre
 u20w==
X-Gm-Message-State: AOJu0YzgqWElcrLz/fSsenwqXip1uRxHi5ezy5B3M46WSXXpZ74hYTfC
 ZGL7/ILQ5TK+emeAjalmH7CcSuUzdcD7Kr6OGuOxJ3XWCo+9KcyDquNWCNalgI+trRhBsB8/l2i
 7w7IOkoZj+5ZKHghbrTmk+wtyZzljtmXy7Sh4TFyX
X-Gm-Gg: ASbGncsaLlFHo6jTSaJkn322qN4FXrQldVto+yh0Xm1kAHcKpLyPSlTFzRA2WTASWQg
 WgSb/2NBT7KOXPKq8884fYnFkBDttalfHWoCsGHSh+1gGYiCOGEnWt7tnU3lqQDqaE3lHpDkS3p
 8cwPZs9LGl8jJn1HLFgfBvU9SYXjyu+8FDDeK1O6yIj+zKJBR3FJWFLXGqtBrIzeI1BalHJCrbP
 DiiWzj/s0b1HYNvxadU1Yzhq58h4ak0yKDQXARBdF3ydGR7E7OPOnJjMBuwtsqEJA5W3z1+tB2z
 jh+AkDc6wWKhN3bAob4N0xOgktl5P5H/DoVxLAw6doHbQIHz0Q==
X-Google-Smtp-Source: AGHT+IHGjh0pa53nM0YeFoE6OWWSnILlK4qTZv8zv/jjhEc5Q2yfvA/sLH1tHw5p1t/F1A8+z6RiKxX1BXUo
X-Received: by 2002:ac2:4c24:0:b0:53e:3a73:6ddc with SMTP id
 2adb3069b0e04-543e4c299b2mr3623354e87.33.1738365096468; 
 Fri, 31 Jan 2025 15:11:36 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 2adb3069b0e04-543ebeb7471sm154663e87.116.2025.01.31.15.11.36; 
 Fri, 31 Jan 2025 15:11:36 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 1D97019E13;
 Sat,  1 Feb 2025 00:11:36 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Maryam Tahhan <mtahhan@redhat.com>, Ciara Loftus <ciara.loftus@intel.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v6 2/2] net/af_xdp: Refactor af_xdp_tx_zc
Date: Sat,  1 Feb 2025 00:10:21 +0100
Message-Id: <20250131231018.2163893-3-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250116195640.68885-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
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

