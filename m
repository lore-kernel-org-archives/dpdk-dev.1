Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1259EC98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 01:09:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C478242EE9;
	Wed, 23 Sep 2026 03:08:10 +0200 (CEST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by mails.dpdk.org (Postfix) with ESMTP id DF59640DD2
 for <dev@dpdk.org>; Wed, 23 Sep 2026 03:08:08 +0200 (CEST)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39de4e72b33so675241a91.2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790125688; x=1790730488; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D+jQmkaAQtp+MaSHgjDV7h5tShr3HmIdprpkTrCmwjs=;
 b=YCA4ZNsfwhKZw6hDeus/0bC+76Ihgdeqc0rWzpWvGzly0VewzYPEtiFE8pe/WZ4QCP
 f1yCJtGE09M7uAJqFvjTbAccQVSpqjm3saDxqzDnzmcbftyMbLj68ZqIg/445W2iYpm9
 cYqBvJolfqtdb08/mwFq8bV22fY2yRGGTQv6YO6e3ezEe+nTgHue8BA0FuFMha0Ktla7
 ZBrXx/9FD+8PyxV9/DroWZ0CmtYulCrPZaipJ2Upd1gbMf9XAtPKE/W7s2ekE6S96D1L
 vjuc/V6GWldhYskC154/FypfRmV8Oo8l5zeDvQREQt+EhgaOTiubmQPCJjvnUmnEtL7k
 K48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790125688; x=1790730488;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D+jQmkaAQtp+MaSHgjDV7h5tShr3HmIdprpkTrCmwjs=;
 b=SoNqVAxTiYGQayHpe0QmLUDiKAHwY2ZSAXdetn0+stNP7Xjiw2UcxkOntaR1xtvNOp
 ptiWaijW8bgz3AkKVCz2R31M6DMSdiPWYYzjCaTskC39SteY4GlkIQxdSZLv3/x1BRfi
 5gkne8KFm/yWp7xpoEDNQiS6hf2NsmZluEQ2bM5Jl1GBTiGYuyw2V65qH/MJDDdStWcF
 femR+Q+sitt2v3sEIbLQK1Ds2tFls53Y7rEAEB/dTS1q2TKHVXI59bXaTk8yAB3JMgIL
 KrH1AeHGj7ronDBonvUrf3dcdCjWC3ZyxBie4+qWcywBgILQR4L6rD3uJqWFz6u1lpr4
 kehA==
X-Gm-Message-State: AFuF++mk2HGYmP8+hDHsa8c4ceopoErbEiSqjPhb1OVRakdIk4nfnkSu
 hKVs9P3s6hHJd6ImYiOxBxwfbBcFh2NUOxXaYLqzvdsZ0YkGmPWzMIM7A6jWfYh2stl0HdsU1Fb
 fOZhs6e6u9hF+Sw==
X-Received: from pgbcc16.prod.google.com ([2002:a05:6a02:70:b0:cbe:e216:e75a])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5787:b0:39d:cbb1:c96f with SMTP id
 98e67ed59e1d1-3a07e4e936dmr946144a91.18.1790125687773; 
 Tue, 22 Sep 2026 18:08:07 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:07:36 -0700
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923010742.2468145-14-joshwash@google.com>
Subject: [PATCH v3 13/16] net/nfp: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Chaoyong He <chaoyong.he@corigine.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
Changes in v3:
  - Change commit subject prefix from "drivers:" to "net/nfp:".
  - Drop line rewraps in nfp_nfdk.h and nfp_nfdk_dp.c.
---
 drivers/common/nfp/nfp_platform.h  | 2 --
 drivers/net/nfp/nfdk/nfp_nfdk.h    | 2 +-
 drivers/net/nfp/nfdk/nfp_nfdk_dp.c | 2 +-
 drivers/net/nfp/nfpcore/nfp_nsp.c  | 2 +-
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/common/nfp/nfp_platform.h b/drivers/common/nfp/nfp_platform.h
index 0b02fcf1e8..814f90b5a2 100644
--- a/drivers/common/nfp/nfp_platform.h
+++ b/drivers/common/nfp/nfp_platform.h
@@ -10,8 +10,6 @@
 
 #include <rte_bitops.h>
 
-#define DIV_ROUND_UP(n, d)             (((n) + (d) - 1) / (d))
-
 #define DMA_BIT_MASK(n)    ((1ULL << (n)) - 1)
 
 #define BITS_PER_LONG      (__SIZEOF_LONG__ * 8)
diff --git a/drivers/net/nfp/nfdk/nfp_nfdk.h b/drivers/net/nfp/nfdk/nfp_nfdk.h
index 64c2b31308..df4d1eb8d9 100644
--- a/drivers/net/nfp/nfdk/nfp_nfdk.h
+++ b/drivers/net/nfp/nfdk/nfp_nfdk.h
@@ -168,7 +168,7 @@ static inline uint16_t
 nfp_net_nfdk_headlen_to_segs(uint16_t headlen)
 {
 	/* First descriptor fits less data, so adjust for that */
-	return DIV_ROUND_UP(headlen + NFDK_TX_MAX_DATA_PER_DESC - NFDK_TX_MAX_DATA_PER_HEAD,
+	return RTE_DIV_ROUND_UP(headlen + NFDK_TX_MAX_DATA_PER_DESC - NFDK_TX_MAX_DATA_PER_HEAD,
 			NFDK_TX_MAX_DATA_PER_DESC);
 }
 
diff --git a/drivers/net/nfp/nfdk/nfp_nfdk_dp.c b/drivers/net/nfp/nfdk/nfp_nfdk_dp.c
index 15867ab62f..777550b6df 100644
--- a/drivers/net/nfp/nfdk/nfp_nfdk_dp.c
+++ b/drivers/net/nfp/nfdk/nfp_nfdk_dp.c
@@ -103,7 +103,7 @@ nfp_net_nfdk_tx_maybe_close_block(struct nfp_net_txq *txq,
 	n_descs = nfp_net_nfdk_headlen_to_segs(pkt_temp->data_len);
 	while (pkt_temp->next != NULL) {
 		pkt_temp = pkt_temp->next;
-		n_descs += DIV_ROUND_UP(pkt_temp->data_len, NFDK_TX_MAX_DATA_PER_DESC);
+		n_descs += RTE_DIV_ROUND_UP(pkt_temp->data_len, NFDK_TX_MAX_DATA_PER_DESC);
 	}
 
 	if (unlikely(n_descs > NFDK_TX_DESC_GATHER_MAX))
diff --git a/drivers/net/nfp/nfpcore/nfp_nsp.c b/drivers/net/nfp/nfpcore/nfp_nsp.c
index 43c13baabe..bd02efcc4a 100644
--- a/drivers/net/nfp/nfpcore/nfp_nsp.c
+++ b/drivers/net/nfp/nfpcore/nfp_nsp.c
@@ -542,7 +542,7 @@ nfp_nsp_command_buf_dma_sg(struct nfp_nsp *nsp,
 	struct nfp_nsp_dma_desc *descs;
 
 	chunk_size = RTE_BIT64(chunk_order);
-	nseg = DIV_ROUND_UP(max_size, chunk_size);
+	nseg = RTE_DIV_ROUND_UP(max_size, chunk_size);
 
 	/* Malloc memory */
 	total_len = sizeof(struct nfp_nsp_dma_buf) +
-- 
2.55.0.1082.g2b9226bbc0-goog

