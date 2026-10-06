Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B948CA5FFD
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 02:32:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1C2840E50;
	Tue,  6 Oct 2026 04:31:20 +0200 (CEST)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mails.dpdk.org (Postfix) with ESMTP id 91E5F40EE4
 for <dev@dpdk.org>; Tue,  6 Oct 2026 04:31:19 +0200 (CEST)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-88a46301d92so1919495b3a.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 19:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791253879; x=1791858679; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CbCvf5tJoGnZ3dxTlzx93PxOoXOuNQoNRDjjB367zkg=;
 b=rqC14aB1sGPZzScO8ZSDAxsniE61rz2bL1W0NjEj+/vgJCS5c4b2QdsJ8FPCjKpIWG
 DC4V10oxmcQEQpdFnVtlcLSl+rKshwRExBdxTtH7RlX8vZKV6Jl5Q/TYI0rCZMCK0men
 M+QGCEGuupBgjoShpXnwgxSDleKwcv7naoZPwnuG5nDLuxxIFJRSsYg3hO20A5yYHkBp
 IdQE1xIBEIMLOU1qzjZTBqA4RW9zPyf7J6XSIleXpca+WW2JDTPvFmxwEaSQhgDnWuH9
 AOQc7gCbAbfjYQXQR8nfF+6tJFTDZJvNu/VrP8VBHxBbnt/8tHPn5Naj73vJo9UkYUqe
 PQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791253879; x=1791858679;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CbCvf5tJoGnZ3dxTlzx93PxOoXOuNQoNRDjjB367zkg=;
 b=Dxqz/7lpHktJSUbS8QV0p8EmzsWrg9xb4TP5RgLgc4llkirJnuQgZgETo5ralmRbWn
 Y2kJ2i+sYhyF0J6ZidUxjA1QGC/MiOuobiacQR8MJso5hvmqjXl9s7Kgbfb4R1EeSjKm
 DkT/oVrl98ZXc8jolwlhZzl4Rb2bqKAZSWo3ylL9bPBEaj78WH6cW86ZFPljoj7WVz/r
 h6CvfPGLRwwktw2WEYCdv3nSPfTeJUOHQRui6q3gmW+JWTPRaZXRL6O74YGb8VrpIsCV
 NOHlmLLd/xDYzQvbErCokYIkQJTOgQ7kpha4KEAFmeGlHDjfctPi2ZSKAsEStPfcG9aq
 FN4g==
X-Gm-Message-State: AFuF++nxaaUQqWbkQ8AdhlPPk7IDbQqck51BsEIiBppb/wLD8ATNEjHA
 VO/MS4fpNLyaC8khS0PAsF+A6P/RZutBvlFYoBaQ4ojQFoVvRrxqdJMD61k0aYhN5c3P65TB6Yj
 +DrffTFEgQzn1b1dvMvvGRLJeeFZNimI/XIx7MDYB8SoiK5EoN8CNJkCNCXFW/tYjF2d+tlTwP8
 2awNjSeSFft8o4aRUGj7GffbHfz7SdlQi47g==
X-Received: from pgcv5.prod.google.com ([2002:a05:6a02:5305:b0:cc7:8504:4675])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c885:b0:3de:dc6:e6b3 with SMTP id
 adf61e73a8af0-3e12449f89dmr5163637.6.1791253878231; 
 Mon, 05 Oct 2026 19:31:18 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:30:48 -0700
In-Reply-To: <20261006023053.2572501-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260923010742.2468145-1-joshwash@google.com>
 <20261006023053.2572501-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006023053.2572501-13-joshwash@google.com>
Subject: [PATCH v4 12/15] net/nfp: use common division round up macro
From: Joshua Washington <joshwash@google.com>
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
Changes in v4:
  - Add rte_common.h include.
Changes in v3:
  - Change commit subject prefix from "drivers:" to "net/nfp:".
  - Drop line rewraps in nfp_nfdk.h and nfp_nfdk_dp.c.
---
 drivers/common/nfp/nfp_platform.h  | 2 --
 drivers/net/nfp/nfdk/nfp_nfdk.h    | 3 ++-
 drivers/net/nfp/nfdk/nfp_nfdk_dp.c | 2 +-
 drivers/net/nfp/nfpcore/nfp_nsp.c  | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

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
index 64c2b31308..d843162be0 100644
--- a/drivers/net/nfp/nfdk/nfp_nfdk.h
+++ b/drivers/net/nfp/nfdk/nfp_nfdk.h
@@ -7,6 +7,7 @@
 #define __NFP_NFDK_H__
 
 #include <nfp_platform.h>
+#include <rte_common.h>
 
 #include "../nfp_rxtx.h"
 #include "nfp_net_common.h"
@@ -168,7 +169,7 @@ static inline uint16_t
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
2.56.0.rc1.315.gc6ed9934b7-goog

