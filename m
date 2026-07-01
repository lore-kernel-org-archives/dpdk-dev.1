Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988C7C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 18:36:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A48F40A7A;
	Wed,  1 Jul 2026 20:35:45 +0200 (CEST)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74]) by mails.dpdk.org (Postfix) with ESMTP id 9706040A77
 for <dev@dpdk.org>; Wed,  1 Jul 2026 20:35:43 +0200 (CEST)
Received: by mail-pj1-f74.google.com with SMTP id
 98e67ed59e1d1-380a0925d7bso921446a91.2
 for <dev@dpdk.org>; Wed, 01 Jul 2026 11:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782930943; x=1783535743; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=MZ55g7MoRrFsBPiBM/eSYTGS/5048Ftti28zXggoNWc=;
 b=rr6PtvaPHiLXR2DIbGaBbtw2niHI10MqVC2LIETDlsvCcuvpOwFAlb1sf5I+485lbp
 NoIGZX/iMsqge/wu0+5lP9UyfIQ+FONsN3waH8k3kbSPTHkWeJEErgA+T5HlkA/xYs5K
 hoR4mRDYnDju4smYopkY5rx4HxqDn7p9JeQ72GQeIBnYdmI/ZRKFA7aLWIOXNB2DhIma
 KePyLWxSjz5FZ8Cnu3Z1nVTo6TY7ppxpO/CJRiFuQyphxQ7/KkHUVzgxO0bNMlR0M8n3
 43KGhlgvyJri2g573b05USJ5bJxf9fO0IjlwOpB4Axv3PBDrsMKvTpla9F54bfJB+L5U
 MkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782930943; x=1783535743;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MZ55g7MoRrFsBPiBM/eSYTGS/5048Ftti28zXggoNWc=;
 b=ncKGdyOHheIv4Bal7Vy++5n/Eqmlm185mXjYwX1NdvGekc3xVY8gb5D5SN3Vhhd3Z4
 XX9kQUFnZDJFoEROczexW6ATWItww2Vs6ftcxEYD9vm6uVgIbfP+MTxtosb+Pw0Ks3aO
 qMmF7cOVS78NDlsJ2++bXdYxxvHQ4sU70keS4lF2gvfD60HWIXcLvBHNDxuEXnQnEIOk
 KxjotrzfMUthU52ZBotdx9Mvlo2VNfBvOelNJz0jYcaMFowDCBl1WyxYSFztvOHxTGG0
 85MLQ9GHbCLnYeW9YXBoBxvlYKL/Hmwmyxm/tHSQUAjWysW80IEClKD+EEPb1bSfkuML
 K/6w==
X-Gm-Message-State: AOJu0YxO/BRsXQLF/CIZ1rEqTpz7j4fYEbYRRuUFy8eohYhBFdyF65wO
 InZ9h/wX2g8U55EqyJO2QU+yiQy+dLQPIWZgDfkf4N1EpMLdmVx9HWzGbNTdD6UdnZTV9OknVs1
 WGke2kH0IHI8ptQ==
X-Received: from pjblj3.prod.google.com ([2002:a17:90b:3443:b0:37c:a0c9:c61f])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d88:b0:37f:bfd6:8b40 with SMTP id
 98e67ed59e1d1-380aa0952c0mr2399478a91.5.1782930942370; 
 Wed, 01 Jul 2026 11:35:42 -0700 (PDT)
Date: Wed,  1 Jul 2026 11:35:24 -0700
In-Reply-To: <20260701183528.2443032-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260701183528.2443032-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701183528.2443032-7-joshwash@google.com>
Subject: [PATCH 6/9] net/gve: free ctx mbuf if packet dropped after first
 segment
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Junfeng Guo <junfengg@nvidia.com>, Rushil Gupta <rushilg@google.com>
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

GVE GQ has support for multi-descriptor RX. It is possible for a packet
to be dropped after the first descriptor has been processed and an mbuf
has been added to the context. In such a case, the mbuf head should be
freed before clearing the context so that mbufs aren't leaked.

Fixes: 496d4d2c8b54 ("net/gve: support jumbo frame for GQI")
Cc: stable@dpdk.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/gve_rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/gve/gve_rx.c b/drivers/net/gve/gve_rx.c
index cda87af294..567b82d020 100644
--- a/drivers/net/gve/gve_rx.c
+++ b/drivers/net/gve/gve_rx.c
@@ -205,6 +205,8 @@ gve_rx_burst(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		if (gve_rx(rxq, rxd, rx_id)) {
 			if (!ctx->drop_pkt)
 				rx_pkts[nb_rx++] = ctx->mbuf_head;
+			else if (ctx->mbuf_head != NULL)
+				rte_pktmbuf_free(ctx->mbuf_head);
 			rxq->nb_avail += ctx->total_frags;
 			gve_rx_ctx_clear(ctx);
 		}
--
2.55.0.rc0.799.gd6f94ed593-goog

