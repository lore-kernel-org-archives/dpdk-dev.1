Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164D6C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 17:23:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0941642DC1;
	Thu, 13 Aug 2026 19:23:18 +0200 (CEST)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mails.dpdk.org (Postfix) with ESMTP id 59BFB42E6F
 for <dev@dpdk.org>; Thu, 13 Aug 2026 19:23:15 +0200 (CEST)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8486c3411c8so1334724b3a.2
 for <dev@dpdk.org>; Thu, 13 Aug 2026 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786641795; x=1787246595; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lrI9X/YHm61dzQbBYMk0qg8057xIbpcSq9Cc1SyC82s=;
 b=MPoqmaa4W9v04ZA4ApzN7y++9l8M+mZSdeyFhCoQ6eB9WDR99R57yWtCYirCEhEey6
 0YudXb9oPelB4t4X02CPylWRBQpdDVfsyVaBoGjfSdIfrK8+EhedfFbxcOfyHC72/KfB
 2hT8HQfEJyD7ERv491wf5Xkjs8qKTtUi8UJIB116Ernu+N6rW2g/WiegQ8auiheAD/XS
 HYzu55BLkP3bqgp+vdUHuLj+F6twFiayg+De2vfNntqcFB9+seg1i7fU9abyB1v8EHZv
 G/2iMYBiBSww+DITvSQL3Zk2115WfkXZaXFUycnlmawIicXT403C/F8NKD8B2BsIibhl
 IIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641795; x=1787246595;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lrI9X/YHm61dzQbBYMk0qg8057xIbpcSq9Cc1SyC82s=;
 b=i5mKEGZ71LXzpsmKxpT0iDT9hoHG4BSr9BF0g4fYs1HZAY1Pw8wXufJpujJStJUGNs
 xVwyCA7iVK7wRPzu35wbBca8y6j1OYCwYWbBdsWscHJU3DyN21Gtra0EaDD+KxeLN7vZ
 reoxzSpALlEIUpcuNQgMNWwZ5kA2eYknkVNGiyBd1HlEDSPUhW653K+XfH8bKwaC8PUt
 rQbDQZxGRQfdoEufyDqooZT5iwV2I2xOoHgg5RX2j9QYJV8/+PxALVLNj61vqbVlABzJ
 +/rXaqTVYwJEfTfkKw7Z/jkvVI8mTvmDKFbOiAWnp6LdwTYvLwhTVemjChzYbKMyBT9V
 JUyg==
X-Gm-Message-State: AOJu0YyjWC17xbK2c+jdXsrRwonrFv25L+VrFMAZiRYVkvgvg+qEjrot
 ejaxPmwPL6wBaNOxuCmeM5x1utNwHrt3tVRkNso8WNG1QScpG26rll/KIm58NdFLE41GqxGUGi3
 Hmbgvz6JGBa1lIg==
X-Received: from pfx15.prod.google.com ([2002:a05:6a00:a44f:b0:848:7bbd:284b])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:b4c:b0:84e:24f:2677 with SMTP id
 d2e1a72fcca58-84fc6ce905fmr6896390b3a.4.1786641794395; 
 Thu, 13 Aug 2026 10:23:14 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:22:38 -0700
In-Reply-To: <20260813172241.964736-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260813172241.964736-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813172241.964736-14-joshwash@google.com>
Subject: [PATCH v2 13/14] drivers: use common division round up macro
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
 drivers/common/nfp/nfp_platform.h  | 2 --
 drivers/net/nfp/nfdk/nfp_nfdk.h    | 5 +++--
 drivers/net/nfp/nfdk/nfp_nfdk_dp.c | 3 ++-
 drivers/net/nfp/nfpcore/nfp_nsp.c  | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

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
index 64c2b31308..b831e0d69e 100644
--- a/drivers/net/nfp/nfdk/nfp_nfdk.h
+++ b/drivers/net/nfp/nfdk/nfp_nfdk.h
@@ -168,8 +168,9 @@ static inline uint16_t
 nfp_net_nfdk_headlen_to_segs(uint16_t headlen)
 {
 	/* First descriptor fits less data, so adjust for that */
-	return DIV_ROUND_UP(headlen + NFDK_TX_MAX_DATA_PER_DESC - NFDK_TX_MAX_DATA_PER_HEAD,
-			NFDK_TX_MAX_DATA_PER_DESC);
+	return RTE_DIV_ROUND_UP(headlen + NFDK_TX_MAX_DATA_PER_DESC -
+				NFDK_TX_MAX_DATA_PER_HEAD,
+				NFDK_TX_MAX_DATA_PER_DESC);
 }
 
 /* Set TX CSUM offload flags in TX descriptor of nfdk */
diff --git a/drivers/net/nfp/nfdk/nfp_nfdk_dp.c b/drivers/net/nfp/nfdk/nfp_nfdk_dp.c
index 15867ab62f..86b3c5b64a 100644
--- a/drivers/net/nfp/nfdk/nfp_nfdk_dp.c
+++ b/drivers/net/nfp/nfdk/nfp_nfdk_dp.c
@@ -103,7 +103,8 @@ nfp_net_nfdk_tx_maybe_close_block(struct nfp_net_txq *txq,
 	n_descs = nfp_net_nfdk_headlen_to_segs(pkt_temp->data_len);
 	while (pkt_temp->next != NULL) {
 		pkt_temp = pkt_temp->next;
-		n_descs += DIV_ROUND_UP(pkt_temp->data_len, NFDK_TX_MAX_DATA_PER_DESC);
+		n_descs += RTE_DIV_ROUND_UP(pkt_temp->data_len,
+					    NFDK_TX_MAX_DATA_PER_DESC);
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
2.55.0.691.gc56d675ccc-goog

