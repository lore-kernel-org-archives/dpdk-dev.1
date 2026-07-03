Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA69C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 13:13:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E4F640A82;
	Fri,  3 Jul 2026 15:13:23 +0200 (CEST)
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com
 [209.85.215.201])
 by mails.dpdk.org (Postfix) with ESMTP id B275640A82
 for <dev@dpdk.org>; Fri,  3 Jul 2026 15:13:22 +0200 (CEST)
Received: by mail-pg1-f201.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so484036a12.1
 for <dev@dpdk.org>; Fri, 03 Jul 2026 06:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783084402; x=1783689202; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hPNiI2UxOEsRYh7sQN5rqX699YZSlGx+zl1PI0isJU8=;
 b=TnwdUTbym6PFtyAiadHyqHPruYoVUSJzTqV6Uq+BvF6jSYTICt46hBM1Z+Hlb2TnZT
 fo63roeRjD+/CyVStWaslk8qvntQBJLcZMsCYd7qXs9E6jFPwDqbFzEugbJeccPvWFQ3
 FItbQq6D97+j4FS0jJ2OqWk4k5VEqzpafWOyt6wyweJT2G3rW8lSDYy5DliDYtBqAJNG
 srKyageu8KL54fLDeVBbj2qLfgI5lpBTOIm1zDWLXtztLcHSBTop5NNEh6NJtc3Paoop
 qt9OeqAQHoeEXUbWv/Y9OtfQPyoIQGpMYDXYV9yFC5YBK7MsrT6PDwWlJ/P9CH28KU6+
 +meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783084402; x=1783689202;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hPNiI2UxOEsRYh7sQN5rqX699YZSlGx+zl1PI0isJU8=;
 b=cYu5DT+p6qKOXHpqAeApg2tY/BP8H0ESLIzHaWrgc3oY6I+teAK5YMH7EH1XxW6Ncj
 mwYh87/txhEFemkfzqEVO+VE8fSDkuUzEO2R5NhMMPYdPZOYuwGqjPeeNMojDR2AuFmS
 Xtridaq25t+shdoRxLc2aYY2MtCw4uV1wQ30+3Jx8KEDtcdmtqfsyxGtnydhbV8VuhNN
 5T2ahZqmTy51h6+hP1+d/TlkGNRnoStjU84JzWF94zu0u4/ZMgT5kF8Kla5btsAykiAx
 8YJZOMST8gjh+I7RtmAdx+uSkIhOWeMvBTSnTU/Qier/320F4fJkQdTXavwzggYHSMgz
 /iGw==
X-Gm-Message-State: AOJu0YzNSs0PtLtElvNwe7ZrI+SKQg0ACXM8WVqSAACKA66PjzOoOsYC
 XcpGX7ssWc9r5zpicCm0DO8NjjjZGi4FJ1KXN8hUJFngqNyJIhEUVWIcAhorIJQanfw/tZkxv+e
 5xvDQYNCOAR9ZnA==
X-Received: from pfbbu3.prod.google.com ([2002:a05:6a00:4103:b0:847:70bd:6ca9])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2301:b0:847:7128:ecf1 with SMTP id
 d2e1a72fcca58-847c517038amr8946386b3a.42.1783084401564; 
 Fri, 03 Jul 2026 06:13:21 -0700 (PDT)
Date: Fri,  3 Jul 2026 06:13:03 -0700
In-Reply-To: <20260703131308.2507403-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703131308.2507403-7-joshwash@google.com>
Subject: [PATCH v2 6/9] net/gve: free ctx mbuf if packet dropped after first
 segment
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Rushil Gupta <rushilg@google.com>, Junfeng Guo <junfengg@nvidia.com>
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
to be dropped after the first descriptor has been processed an mbuf has
been added to the context. In such a case, the mbuf head should be freed
before clearing the context so that mbufs aren't leaked.

In addition, clear mbuf from sw_ring after adding the packet to the
context to avoid double-freeing buffers that have not been reposted, but
have been reported to the application.

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

