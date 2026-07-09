Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B56AC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 04:08:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CECAD40B8F;
	Thu,  9 Jul 2026 06:07:55 +0200 (CEST)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mails.dpdk.org (Postfix) with ESMTP id E461240A84
 for <dev@dpdk.org>; Thu,  9 Jul 2026 06:07:53 +0200 (CEST)
Received: by mail-pf1-f202.google.com with SMTP id
 d2e1a72fcca58-8485d853b08so403730b3a.1
 for <dev@dpdk.org>; Wed, 08 Jul 2026 21:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783570073; x=1784174873; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jJxp0WU4vSMPbXcvua3rO4JxVeMjYQ0VvkPu50RhSJs=;
 b=Y4ZZkipVu6gXRjBnqh8RNuWFbODzpD82P9yg9eJuS6X7CR8Fms+CNfxvI0wnHrNwcl
 /29KvxgTDGyLrSG+ZrhvI69aKZLf82fGRhFkFGwV0l/prBUkx5utaYg5p/ZqpgEi0B4b
 vQr1u2kMj/xQhpo5lRTIkHUxPSe9CJyJC525iSdKgh/GbdykMF7pnNuROJlA0PVjaUVz
 3zhMbn6WVjIeGIUEJg2TXfW+tnsU9fvWklNOvdDIhxnzJjUbMuav2TV6Q61ztozVnt3U
 E8BRi+TLsa6sbWfLgk8YgyuhZ/GM9t5IZF6aqTPhabldO4mKozcKJs5qLUIL6MqFSW6p
 XjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783570073; x=1784174873;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jJxp0WU4vSMPbXcvua3rO4JxVeMjYQ0VvkPu50RhSJs=;
 b=e55Wpp9CJdtMsKeFNULhrU00qCOFPtYKq+VTNxmolISTCOYIByjT+J/GlSR84L9xrR
 UbdoDC4rQGOwClQJeCfI2hd1yc+6j/IJVcS5EprlMjhJjyh+AU7NS7H5ijB/5C1UtG0+
 63WWrAA68NG/ySfVPcDAInpyvSutTdpRZ5Vhh7PnWEVvuFkfsllek8FK115+ozp6Xv8u
 /wiK+LGHZsoB4D/RkVGHROUWfWnMcmZnJyZp2GP6sLwAGIM59qDBuDgAeWhKbiO89ebd
 r4I+enO9LHP9dPc+b+pYNaY+BT/7XsFwX5p8UOoDsy5iMFrY9wtl9pdhQQ/kSQZu2OLU
 sU6A==
X-Gm-Message-State: AOJu0YzeJl16c4X3sz5dyt/3ZQUqi3wcy0BgiURnvaWZU9SOAQ6sCVlc
 uoyvRoyDVE8LTdXU+i4rMy2ZNFm2dbWuCgFkH8Mzz5oN9sL/0M/+9JtUZm1mBoXOqoKvB8eSK57
 rnkP8ADcEXgNV/g==
X-Received: from pfhp11.prod.google.com ([2002:a05:6a00:a0b:b0:847:a59c:14f8])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1826:b0:848:2f84:730 with SMTP id
 d2e1a72fcca58-8484303c9dbmr4494019b3a.67.1783570072556; 
 Wed, 08 Jul 2026 21:07:52 -0700 (PDT)
Date: Wed,  8 Jul 2026 21:07:34 -0700
In-Reply-To: <20260709040739.3184955-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260707164020.2936476-1-joshwash@google.com>
 <20260709040739.3184955-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709040739.3184955-7-joshwash@google.com>
Subject: [PATCH v4 6/9] net/gve: free ctx mbuf if packet dropped after first
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
2.55.0.795.g602f6c329a-goog

