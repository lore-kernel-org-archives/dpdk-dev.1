Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C700C02196
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 10:46:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9617042D7B;
	Fri,  7 Feb 2025 11:46:07 +0100 (CET)
Received: from mail-wr1-f100.google.com (mail-wr1-f100.google.com
 [209.85.221.100])
 by mails.dpdk.org (Postfix) with ESMTP id 43C3A42D27
 for <dev@dpdk.org>; Fri,  7 Feb 2025 11:46:05 +0100 (CET)
Received: by mail-wr1-f100.google.com with SMTP id
 ffacd0b85a97d-38dae70f5d9so935429f8f.1
 for <dev@dpdk.org>; Fri, 07 Feb 2025 02:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738925165; x=1739529965; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=16Rr/5wfajjGtupsp1PblW6UGJO9Qa9fGbpTsw3sxr4=;
 b=etd68FPc1/PJ28ZR6bHJ1NUbiooGFPeZK9avtA3/mOjgUclO6iH8IS8roXHmm93P7H
 NF/vwNh/87x4eE4TVvygdUENSGoSqIIAQ8e98FWKmaphrxHBZcG3QNXhCgV/6Anc1UCD
 TeGCbrFj4b/M0YJfb0L7aHc0lcyJHUQAejp8HdNIm9ASqyLaoG1365HBOaFaLdYrkMjk
 aTpGARD/qwOvE77yyJLV/nzdGuN2G/SSwmqDMDck68hGyI99E21vYPNgJvRP3G1rC1K6
 Zlo8nm7D00TE/WqqZEQhbpPe3VGeqdR9An7KQB7BtGOrpRtZESATZEtORK1ys0Cl4oBL
 IHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738925165; x=1739529965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=16Rr/5wfajjGtupsp1PblW6UGJO9Qa9fGbpTsw3sxr4=;
 b=i/BBrfU6G6M/rZRH26uvmDooOWas25OLXWF+efLmVDtbBm7p89QLjIl3jYutTTF9FA
 vRVQd5FLFptQVDR7q0hyq453BhO1BrGYfELpWLxD0ENE+vWiO7FD0Bq0yW+b1qgdm/nB
 zpzB3q8ggN9R5LQNEqaWKAorl6DTiqpwnzeMzaiDp4T4mlGQY0fws0JxLpOJmDkOrUYq
 XzYyY7IObp8+aGfi89OEmQgODr1MVqrvEJxTTMhFT32M9FoDvUzOaUL4HWhIWJNGetkV
 2Jin5rPLDPmvXZEEyiyi3TdVQrnAU2QxxkIxPuJlDiRD5QJ42dfZEPjv1Z4J56ZLamk3
 8JxA==
X-Gm-Message-State: AOJu0Yy/9Ucy641/RyhemNRYjXhcso6VWiIlkyC3kSDLbOWIoXCRM0Kb
 tt7U/W0UGI/SgXJyr/nA0h7O3mqnjyLMggtON9/3LWfJBW33VFBA/W2TQjcHdZgwiy+Fjhei6d3
 IMGNarFfw1Q4RYE00oj6A8FpR1A+wvB3UqyVfdK0h
X-Gm-Gg: ASbGncv0fQwmnkkne2l/ScauA8sGAkHPPbCRh3xJ6mN6ZcoJG+JfGIm6zMJ8vQAUdVF
 eam71ezYAoWvTNp3jQjwGs2qf1dwbxEvugDaUpKxnmr/9wWpBr16ZrbcS37eplAYq0jiLyDv5eA
 H+otz5Ngr/nYRImoAFGi9uqG+ZqYpSe+leUAAFlxDWstyVYIejSEvTljXnhF94rrppVk9N5/UkS
 9QhhBMFl1ySCttdl9sv4W/BLbpplozlWWGJK4pTDCspSG1iVQkShZbNt92nzEweuF1iXuGXjC3W
 gOcZBClGDHl+eBzQv12oogpJbFFwwrtvJUXr9A9nFH/gO1Go2A==
X-Google-Smtp-Source: AGHT+IHebFeHoV7AeTYpjTfFChtcCugvvoNoz8ALznpf0MXr+Fb566QdanUauxeKLia5ORp4m7MNROpJ/UBg
X-Received: by 2002:a5d:6c6d:0:b0:38d:c433:a97 with SMTP id
 ffacd0b85a97d-38dc935f7b6mr1431627f8f.47.1738925164723; 
 Fri, 07 Feb 2025 02:46:04 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 ffacd0b85a97d-38dbdd814a1sm71419f8f.50.2025.02.07.02.46.04; 
 Fri, 07 Feb 2025 02:46:04 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 930261D387;
 Fri,  7 Feb 2025 11:46:04 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Maryam Tahhan <mtahhan@redhat.com>, Ciara Loftus <ciara.loftus@intel.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v9 2/2] net/af_xdp: Refactor af_xdp_tx_zc
Date: Fri,  7 Feb 2025 11:45:52 +0100
Message-Id: <20250207104552.1663519-3-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250207104552.1663519-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250207104552.1663519-1-ariel.otilibili@6wind.com>
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

