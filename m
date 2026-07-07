Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44481C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:41:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F331A40A6E;
	Tue,  7 Jul 2026 18:40:34 +0200 (CEST)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id 518B5409FA
 for <dev@dpdk.org>; Tue,  7 Jul 2026 18:40:34 +0200 (CEST)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-2c354050c34so54482385ad.3
 for <dev@dpdk.org>; Tue, 07 Jul 2026 09:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783442433; x=1784047233; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=v7Ki2F6sbSLRF/GbnDXs1nXpD5Ik+b62ZP5jSFeukUo=;
 b=ZGIEEntgEQ5JALkzhFwyiUDK+M7oIzwwmtHKw3oVzALki4+E1QlPO3flx+NngbpSIc
 DF3muchDGI3S9KygG63THsuG4QNvkcOd0+6tcRPwzWxIrUSMHt7R7WbGO4i7x8pHFROo
 kZ8GcD/1zFj8lPUROlWd17f23lwVO7/EjK6KFaeBI+OSjuZmhvcvP4vITwx2LpmKW01Y
 iuoHyJyouRVTfR6j/KDiCR7pTx0yT5wh5BibccnZ7/nMrXLtFS6wT7U2ejtr23cbcodq
 D2fVeZzDML6FxFko1JAmtl/qDpv5WkvXOEQ32nJI5FvrOHt3ubX5mm8fsCCd/Qn0WHsi
 Jw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442433; x=1784047233;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v7Ki2F6sbSLRF/GbnDXs1nXpD5Ik+b62ZP5jSFeukUo=;
 b=c4VI7dIohRL3LOtmKDJagQxmBPOkg/l4fg31nciUV+DAHdmlMShArxASRdBYWtNkT2
 59MMF21ikfw9D//xCzF9eXdzn0hm2pB/iCnMlzqLLvgsIiMoQM63fGcOX1FzFuq8nlGG
 ZzUF3nVIhvmjv+B40hBtMTVt2Sp/t/4Kns+VYtP+C8n31612MPxiax84Jv76RgKpYDrn
 rdBfkHyUEEf+GSCCkR2ogla6824dHZlvDf/qsr7Bx3tIKNaqQCIeU5Gw98q4Nl+RgNwJ
 AuiodgLEK25Kv2t65+cfpCjiQUuf7L4V2+FU40TFTyZb5QdbZu25Fj6IsKLz3YCGVyH0
 gcbQ==
X-Gm-Message-State: AOJu0YwEb2hy6iwQoQrO0NgLLQIXYDppEnaeGiFk350LKx8dQTiQA3Ce
 C0L/LA9fpnbzwR90y9FmgFPjSmr2uOS8cL5Us+eCWrNuXvFUbuhmcgK24WOazDdKaGKvRRxzYe3
 ubXcb3q3p9d5bXg==
X-Received: from pjbrt18.prod.google.com ([2002:a17:90b:5092:b0:36b:dbd1:f512])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e8e:b0:37f:9ce0:af31 with SMTP id
 98e67ed59e1d1-387576a19b6mr5322132a91.28.1783442433251; 
 Tue, 07 Jul 2026 09:40:33 -0700 (PDT)
Date: Tue,  7 Jul 2026 09:40:16 -0700
In-Reply-To: <20260707164020.2936476-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
 <20260707164020.2936476-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707164020.2936476-7-joshwash@google.com>
Subject: [PATCH v3 6/9] net/gve: free ctx mbuf if packet dropped after first
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
2.55.0.rc2.803.g1fd1e6609c-goog

