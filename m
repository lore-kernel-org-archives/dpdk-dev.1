Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6EF606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hLyTT6lE
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4E2840663;
	Mon, 26 Oct 2026 20:09:35 +0100 (CET)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98])
 by mails.dpdk.org (Postfix) with ESMTPS id AB5A5402B0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 20:09:29 +0100 (CET)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-3ac6794fe45so2509637a91.0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793041768; x=1793646568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O3KUGFkdQ56O+K0FM2AbSmvmeU7oipJBtY8dqRJdhvs=;
 b=myccERsfzEpYwHG5gel3j9ul504juR7B90rl+g3Tqk9eIU3jn/HIJ1bGXrQ33Nsu47
 A9ijDKXIg/9rcX6UXeCRpikkoscn/sEosJBFPk3NykKIXdvaA80JsbQjXyLmXglQMpTy
 yugnOS95+qNc7otwAa2wWN02UkUGltj+RapIpF10/TPJ4hZffkVZsgmIRNTu0437Qqsv
 +V7Q1pSu9ytOgBbLyn8Yrlr12tlUqdbgdXu/cymn/mVkBolACXKFzITTzGLmgMnHDazv
 no4Z7na5kfNC6DDR4JVmVMtGEgUCG4OnHd7Qr/fulD7IsYlJdCWXd/Jpt05BdgBJGuIC
 m7jQ==
X-Gm-Message-State: AFq9FYIaKf240wEpz04bjCRh+oSv1kEV3iumEiXYU8U7LpVtLBQ9esBr
 sAND6bdiYG36om1W49iQm3CnNnchfuapr5TDRhzFup+vYPj/ih0mTWs15+25Pamffb+Rx1uvxVI
 Y86XU1qEeE3pesrbnqb9vMxJugXkDzhWxL+/JHC9ysh9H6gS1TO1zPSXMsakf9+I11R1pq5APRv
 NGYUiYIBAuPJXYvQA3lfOn742I66hPEfBQl1+yP6Pyo9nIW8iBaHbLyqWqsc+K7sdnPzMiNM5B1
 3nNbmdzndjd
X-Gm-Gg: AYBFou2omxVo3P+h5tM4RmYpVmDLDaYG2ciC2nLYG+GLlAtrvCdwkvRzn8Dvr63OXi1
 gQHA/jGD6l9OkfbOEqsUkGhGWj+/NAPNVFkrX5HH7xthE9fnERKTHGqOD/DXd7QcuZzUTWyeHk8
 dFqT+xqHGicWoHWRiZTesKVKOxCFxsJO55WOnORpD2XNmcfnMD3nNgYqq5J1xTaoMmgS+nemRSm
 wvmhFGAnN9nTkbkebtKNV6u1IxgOgINcxB8U8P5Q7mPPAPHEl9bnF2ODYX4ECZkXAkC9WL7QuFY
 g+cDJkNukyjTzjS09P7CaizzNRR8wBZRaUzve0m22OWUvU3454yVoRgiXQRA32f2tuUm3zHKs/G
 U65WIOM9OWFF6kKtH1atocxfw1sjZWUbh9LiH6yLv5d9P7kbhjMJxBPrfIjZG2C6eSNohWXdR6D
 FFiIuukTZYQYs0B0+8Yw+149kMszXK/nVaOwTbtJtTgP2HIe5HwA==
X-Received: by 2002:a17:90b:528c:b0:3ac:8897:7b9d with SMTP id
 98e67ed59e1d1-3ade9b2ee97mr6858575a91.1.1793041768121; 
 Mon, 26 Oct 2026 12:09:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3adeba6ac8fsm3465523a91.2.2026.10.26.12.09.27
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Oct 2026 12:09:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so15787607eec.0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793041766; x=1793646566; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O3KUGFkdQ56O+K0FM2AbSmvmeU7oipJBtY8dqRJdhvs=;
 b=hLyTT6lEpZd9UO7pimiAgpX59aynBbjudpYkc8LjWxmS6BKBM6sNtSc8v6JAoWK+AB
 A1HwgDhlXCat5KsEacx5fsr3gNsLOPw63tAlW9NrPQHvid92IGxvFnS17hvIeFyv5Od2
 Lk3pvRQWUgkks7pNXrEN6kHAzo8+KeDEyES84=
X-Received: by 2002:a05:7301:5511:b0:339:7b3b:236d with SMTP id
 5a478bee46e88-369e84b8e4fmr11490016eec.15.1793041766292; 
 Mon, 26 Oct 2026 12:09:26 -0700 (PDT)
X-Received: by 2002:a05:7301:5511:b0:339:7b3b:236d with SMTP id
 5a478bee46e88-369e84b8e4fmr11489982eec.15.1793041765548; 
 Mon, 26 Oct 2026 12:09:25 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db7b23sm37103906eec.19.2026.10.26.12.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:09:25 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, kishore.padmanabha@broadcom.com,
 Keegan Freyhof <keegan.freyhof@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 7/7] net/bnxt: fix cache thrashing for vector Rx and Tx
 paths
Date: Mon, 26 Oct 2026 13:12:51 -0600
Message-ID: <20261026191251.1274062-8-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026191251.1274062-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20261023165457.1225312-1-mohammad-shuab.siddique@broadcom.com>
 <20261026191251.1274062-1-Mohammad-Shuab.Siddique@broadcom.com>
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
index 3f0de7bd5fb..6b22616a0f1 100644
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
@@ -1368,9 +1368,6 @@ bnxt_recv_pkts_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts,
 	while (nb_pkts) {
 		uint32_t cons, mbcons, valid_bit, num, num_vec, received = 0;
 
-		if (rxq->rxrearm_nb >= rxq->rx_free_thresh)
-			bnxt_rxq_rearm(rxq, rxr);
-
 		valid_bit = !!(cpr->cp_raw_cons & cp_ring_size);
 		cons = cpr->cp_raw_cons & (cp_ring_size - 1);
 		mbcons = (cpr->cp_raw_cons / 2) & (rx_ring_size - 1);
@@ -1415,5 +1412,12 @@ bnxt_recv_pkts_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts,
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
index 37aa9fb8546..bc387d333f1 100644
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
