Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91947606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KI/7a+8v
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74F1140DFB;
	Fri, 23 Oct 2026 18:51:40 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id 6E29640B8D
 for <dev@dpdk.org>; Fri, 23 Oct 2026 18:51:35 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so683483a91.0
 for <dev@dpdk.org>; Fri, 23 Oct 2026 09:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792774294; x=1793379094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bHypnYsTcqDh7oE4yncGcQ01vpZn9pvXgE95M1LZIMg=;
 b=OjZLNNxYZGPLLK34SKN50kd4ZqkA5tzXZb/VPpN461hqkWYAPCf1j7+Oqw+UmMdpgm
 +koi/MRwTjmhiQoxkRlZb0b5lQDRwqbqc3OObmrtznQO/1bLwfABrU84aHQdB2UXEDy+
 yGOmTy7I0wlZNbbeQe2mTYcvViv/w5noY3e5/Yf9Ai0hmxDMTVj4huT1ERYV0iXvvz0Y
 +CZ0oEKy1l5GGVdupIOO8wb39Zl6BCdv5i69XZW6z5e5F6Ok6qsBdmzGBf3bBA3HOwOJ
 GtrGRG3+wYEJyMDqH087Ck9mDp3fG7mY7MkuYBp+sy7uAivKccxTxiUEdoSfnL7spoB0
 RibA==
X-Gm-Message-State: AFq9FYKopMlHi8fGACOTmg23Yubl23qxHNiIVAvuPOhyoWt54OL9cf6m
 1kZ6l26K2s309sUUreo8L0mcr0K+NTxdI93ap0xShMTEM4DgLh+GO7BmkoH3NuOXOuRtSPKjdnY
 1M9wetA+/3nUhVSHgyacNkxxjQip3v6resVfhXErk68ZLKKh4DBNWtZMxgtqpLq8Wcfaf9bxU46
 MktXdwFFelIrg5pW4pBtwEXEg/nfFjyulCtUDzqvRgJKE9DSP0XgCm8u49Kx30M3LyCE6B2Qdcw
 bQmXS9WCfJX
X-Gm-Gg: AYBFou0vVWGYEi9pTwsMnzHM996UMY2mpa+kEEaazTPC+a6DfPTfcc9pWAoo3HnhoBj
 ZO0RsKmS8QksCQDDBV/17Wae5eDnFGAxbh16extZBm0SGEPhq1W2rv/fCaOCAm5+ugocQJnLRR7
 Kn++hx4rIMwA10NYMaLsdHtyKl9L93ZkMBrTG1AdZY39ziuJQOCCSWt0uPA/yj5mYvvYSwnSJ3h
 2Gv8/5eiKJeWgXAsskuHizMgYaLn480rtoWy9WZkldu5J8BoLxZS2bnY7yHlHEFmDZ9APt2BdKg
 Br7lOvgioY+9vM4mnSo5wt3g770CwnUjUZNsgKDQ3LNsnLwpnJWegZ9DbqBhwTCZ5B5zrRqa5fg
 NCvFf/0NTkHDeucaa8nGSj2i9iaAuynhjDfIha87BOGTLVQATCqtsdGUfHgOfM4Cht5vKzKwBaM
 6otJhF/uR8siQiVGTMeGNfTN27+sj6rD9InzNhUbK33uNkkUTB2JcB
X-Received: by 2002:a17:90b:3d86:b0:3ac:9259:1234 with SMTP id
 98e67ed59e1d1-3adce7a576fmr2237066a91.39.1792774294483; 
 Fri, 23 Oct 2026 09:51:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ade216cafcsm124436a91.0.2026.10.23.09.51.33
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Oct 2026 09:51:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5337ed1ba44so21848421cf.3
 for <dev@dpdk.org>; Fri, 23 Oct 2026 09:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792774293; x=1793379093; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bHypnYsTcqDh7oE4yncGcQ01vpZn9pvXgE95M1LZIMg=;
 b=KI/7a+8v15DsBY1fwS/mF7sxlPAOfpSsRbYhg0GFLRGWgeIp/C2H+PptXI9LpAP2Zm
 wwc5bvvA/9fVuN27B13fyhQzUhUQtOTYhOw/LAlevXLCvvekmphdVDiImQB6JFZfPOZ9
 tB0oTmXURbltgNhWqjUnExrHNIvC0ezoh/oaQ=
X-Received: by 2002:a05:622a:a0d:b0:532:e4bc:b80f with SMTP id
 d75a77b69052e-536c28f47camr35326601cf.60.1792774293185; 
 Fri, 23 Oct 2026 09:51:33 -0700 (PDT)
X-Received: by 2002:a05:622a:a0d:b0:532:e4bc:b80f with SMTP id
 d75a77b69052e-536c28f47camr35326131cf.60.1792774292266; 
 Fri, 23 Oct 2026 09:51:32 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c45228d8bsm5928056d6.21.2026.10.23.09.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:51:31 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Keegan Freyhof <keegan.freyhof@broadcom.com>, stable@dpdk.org
Subject: [PATCH 7/7] net/bnxt: fix cache thrashing for vector Rx and Tx paths
Date: Fri, 23 Oct 2026 10:54:56 -0600
Message-ID: <20261023165457.1225312-8-mohammad-shuab.siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023165457.1225312-1-mohammad-shuab.siddique@broadcom.com>
References: <20261023165457.1225312-1-mohammad-shuab.siddique@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

On Thor2 with 256 byte packets, Rx throughput dropped by about 60
percent. The AVX2 v3 Rx burst function rearmed the queue at the start
of a burst once rx_free_thresh buffers were pending, so a large bulk
of mbufs was fetched at once and pushed the Rx working set out of the
L1 cache.

Rearm once at the end of every Rx call instead, so that mbufs are
fetched in smaller batches as packets are received. Remove the
unlikely() hint on the early return in bnxt_rxq_rearm(), since it is
now taken on most calls.

Also bound the Tx completion loop in the vector Tx burst function by
the number of packets requested, so that a single call does not
reclaim an unbounded number of completions.

Fixes: ae347ed1b27d ("net/bnxt: add AVX2 Rx for Thor2")
Cc: stable@dpdk.org

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c   | 16 ++++++++++------
 drivers/net/bnxt/bnxt_rxtx_vec_common.h |  2 +-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
index ee14fe2c5d..aee0d24d2b 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
@@ -831,7 +831,7 @@ bnxt_crx_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 }
 
 static void
-bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq)
+bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq, uint16_t nb_pkts)
 {
 	struct bnxt_cp_ring_info *cpr = txq->cp_ring;
 	uint32_t raw_cons = cpr->cp_raw_cons;
@@ -869,7 +869,7 @@ bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq)
 			nb_tx_pkts += txcmp->opaque;
 		}
 		raw_cons = NEXT_RAW_CMP(raw_cons);
-	} while (nb_tx_pkts < ring_mask);
+	} while (nb_tx_pkts < nb_pkts && nb_tx_pkts < ring_mask);
 
 	if (nb_tx_pkts) {
 		if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
@@ -1025,7 +1025,7 @@ bnxt_xmit_pkts_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	/* Handle TX completions */
 	if (bnxt_tx_bds_in_hw(txq) >= txq->tx_free_thresh)
-		bnxt_handle_tx_cp_vec(txq);
+		bnxt_handle_tx_cp_vec(txq, nb_pkts);
 
 	while (nb_pkts) {
 		uint16_t ret, num;
@@ -1369,9 +1369,6 @@ bnxt_recv_pkts_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts,
 	while (nb_pkts) {
 		uint32_t cons, mbcons, valid_bit, num, num_vec, received = 0;
 
-		if (rxq->rxrearm_nb >= rxq->rx_free_thresh)
-			bnxt_rxq_rearm(rxq, rxr);
-
 		valid_bit = !!(cpr->cp_raw_cons & cp_ring_size);
 		cons = cpr->cp_raw_cons & (cp_ring_size - 1);
 		mbcons = (cpr->cp_raw_cons / 2) & (rx_ring_size - 1);
@@ -1416,5 +1413,12 @@ bnxt_recv_pkts_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts,
 			break;
 	}
 
+	/*
+	 * Rearm after every burst so that mbufs are fetched in small
+	 * batches rather than in one large bulk at rx_free_thresh, which
+	 * evicts the Rx working set from the L1 cache.
+	 */
+	bnxt_rxq_rearm(rxq, rxr);
+
 	return cnt;
 }
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_common.h b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
index 37aa9fb854..bc387d333f 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_common.h
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
@@ -67,7 +67,7 @@ bnxt_rxq_rearm(struct bnxt_rx_queue *rxq, struct bnxt_rx_ring_info *rxr)
 	 */
 	nb = RTE_MIN(rxq->rxrearm_nb & ~0x3,
 		     rxq->nb_rx_desc - rxq->rxrearm_start);
-	if (unlikely(nb == 0))
+	if (nb == 0)
 		return;
 
 	/* Allocate new mbufs into the software ring. */
-- 
2.47.3

