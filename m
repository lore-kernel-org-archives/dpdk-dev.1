Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74781C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 13:13:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A49C5402DF;
	Fri,  3 Jul 2026 15:13:16 +0200 (CEST)
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com
 [209.85.214.201])
 by mails.dpdk.org (Postfix) with ESMTP id 990F140653
 for <dev@dpdk.org>; Fri,  3 Jul 2026 15:13:14 +0200 (CEST)
Received: by mail-pl1-f201.google.com with SMTP id
 d9443c01a7336-2c80be91ea3so10442235ad.1
 for <dev@dpdk.org>; Fri, 03 Jul 2026 06:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783084394; x=1783689194; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=vfmDWPlPa2XqDYErLOH8U7YHV4NQmH+0QZ8uuCF7YCA=;
 b=siRriqm7NPikwStJTAhyHJUHcaIysx4FJRb9wKKCGi78DX4VH0EdFu3uZUcO4lm/4t
 rs/2WHFz8jQlXdNKp6I+7nhmpjzb/vorp6WYo0MF5RE4o9ncK2Bushf8FA696rD5UxR4
 xa14Zajfs/5rr8zRYshUw4wQd5OkuGE6zeueoIDTh4PzwnmpwmfpMKSNd5Pxo2Cyf7O2
 YcJAHLQLBADDT4XEU6kBB+nV+dNmr05/ptyfVSeT2sTJwQaVISZnR/2AgkqNqsfh53cY
 c/yr8tOWANyNcJxVjaTQSWtv22ba3DAlqxcZoA7h+UGvr0B3JQdV/5NxCz3gluEMUejT
 1gEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783084394; x=1783689194;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vfmDWPlPa2XqDYErLOH8U7YHV4NQmH+0QZ8uuCF7YCA=;
 b=VBJ8+Y1yRStbJgH5dtezavKjbm0jXoE2a3RHUjqBv7wLpaRM8juPDsMqUqw0kvWnPx
 mIbSufuToYpYbzGF4NvyS/HQZHOnffLHuzeo4GG68bDA0culYrfcu/eSBVD7n9CuF/l3
 HvreXDEJpO0bo8RyAnNTfbGjmHRGCFd2w21lOMshwNXw+ZQJGFoYHIcKt9yy4e+EXQrl
 yPQhykxYnIKgw+KoWA1SEcFPDL0uYldXSCXCOhq9aTOzqxuaewDKo6faArIxFt+Cl+0z
 NG8f0JiKz4K8yqHl7n6cXh6fwTJxxH4MjmrwT1M+8vw6SHwProweY++zrO8MD12IgsoU
 uahg==
X-Gm-Message-State: AOJu0YxshS7JpoEiXhWPJu/1H0lIkjNt+wkd4feSdXIQ2QHTMQyi6Wpq
 NtzyT27tkhU1w4C3Tm8FnXxS2b2EjWcyZWgp85adYcUvc5hWZeP2xzLftUs7XqsDe8wSuUg3Iz5
 a5XnKEuLtrSboOw==
X-Received: from plbmf4.prod.google.com ([2002:a17:902:fc84:b0:2c7:f19d:bb15])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2f8e:b0:2c9:ff83:41e3 with SMTP id
 d9443c01a7336-2ca7e6e1653mr107445765ad.21.1783084393420; 
 Fri, 03 Jul 2026 06:13:13 -0700 (PDT)
Date: Fri,  3 Jul 2026 06:12:59 -0700
In-Reply-To: <20260703131308.2507403-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703131308.2507403-3-joshwash@google.com>
Subject: [PATCH v2 2/9] net/gve: delay adding mbuf head to software ring
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Junfeng Guo <junfengg@nvidia.com>, Xiaoyun Li <xiaoyun.li@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 "Jasper Tran O'Leary" <jtranoleary@google.com>
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

The GQ TX datapath was set up to write the mbuf head into the sw_ring
before writing the descriptors. This poses a problem because it's
possible for the packet to be dropped due to lacking the FIFO space to
do a proper TX. In such a case, the packet won't be sent, and will lead
to leaked mbufs in the subsequent segments.

There is also no real reason that the head mbuf must be set in the
sw_ring separately from the others; the mbuf chain is not actually
walked as part of GQ TX.

Fixes: a46583cf43c8 ("net/gve: support Rx/Tx")
Cc: stable@dpdk.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/gve_tx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/gve/gve_tx.c b/drivers/net/gve/gve_tx.c
index 5c73c21b8d..59c82b04ed 100644
--- a/drivers/net/gve/gve_tx.c
+++ b/drivers/net/gve/gve_tx.c
@@ -301,7 +301,6 @@ gve_tx_burst_qpl(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			(uint32_t)(tx_offload.l2_len + tx_offload.l3_len + tx_offload.l4_len) :
 			tx_pkt->pkt_len;
 
-		sw_ring[sw_id] = tx_pkt;
 		if (!is_fifo_avail(txq, hlen)) {
 			gve_tx_clean(txq);
 			if (!is_fifo_avail(txq, hlen))
@@ -344,13 +343,14 @@ gve_tx_burst_qpl(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		}
 
 		/* record mbuf in sw_ring for free */
-		for (i = 1; i < first->nb_segs; i++) {
+		for (i = 0; i < first->nb_segs; i++) {
+			if (!tx_pkt)
+				break;
+			sw_ring[sw_id] = tx_pkt;
 			sw_id = (sw_id + 1) & mask;
 			tx_pkt = tx_pkt->next;
-			sw_ring[sw_id] = tx_pkt;
 		}
 
-		sw_id = (sw_id + 1) & mask;
 		tx_id = (tx_id + 1) & mask;
 
 		txq->nb_free -= nb_used;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

