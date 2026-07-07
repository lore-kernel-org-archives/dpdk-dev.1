Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1415BC43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:40:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7C6F40A87;
	Tue,  7 Jul 2026 18:40:32 +0200 (CEST)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id 5420940A82
 for <dev@dpdk.org>; Tue,  7 Jul 2026 18:40:32 +0200 (CEST)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-2cae134ab3aso76478455ad.2
 for <dev@dpdk.org>; Tue, 07 Jul 2026 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783442431; x=1784047231; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=8wyzghUjN7qYZ/KQP9A80JfZZmxqSjTbxILs+lsLLDQ=;
 b=uEDvjnTG9SPeOxBzFXodWFgRXXJMa0oxGW9PP5aj4Xynrrd+DvBOA3Zr5Yt/Gd2ij0
 TxArFo8TtLl/sfTBaeX8cD6ZTBczrZsKECIZODWTpX0XFVtfFukhZV5f06Fe9+3JVOu0
 CUneCGq/zSKSP5Q+aarKJ9QJJrVBbMVpIusjiJ9VJE4STqBMKguqiwCpPslWjNxfWc6d
 oSrKxPQIBECoknxQlS5U+zXvS15yirY9xVJR8t//JTd2+BpBfU+RjquQqulMNhugJsxZ
 DWCWQYNMGDzRijAUtk6zFNPXuvIyOPC2hkcWk2d37dTxpt2nHJcHWLHi2HcVxKzmOSbj
 APUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442431; x=1784047231;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8wyzghUjN7qYZ/KQP9A80JfZZmxqSjTbxILs+lsLLDQ=;
 b=gDjTdWLk9ff8NG9C49ZNVsoH6G0xvDQzx++inzYiiISMmFwdjTdozmVys8v1yd/JLl
 u4SzOS8n0xvn3GLsznyDpV9BMvd0rr6YVS8oX9BWNTW7hXTtw/bOlAy26zQUMMzpMjPw
 dyhkjf5v9vgf+jM/rzV9xIgdzSv163ZiIhaIRKeAaTv0ShQUbKpezY5dqH7Az7rxw77W
 AMAoJQbeX0+0Qp8EC9RC5f4YkdmmDV/fzRmUbtJbR1i/f5cNwq02kdDgmpkgDt+lIPco
 Wqx9T4E+CsDkCFj7hz5mvkijCYafOSUBOacrcfqZB5roFA81vwlGZphapBKzYdAeSyGq
 6DVA==
X-Gm-Message-State: AOJu0Yx7Ume5aSMmnVR/R85+igymOyrMrpTg2VHC72aeSOxzELZ3jv80
 i6o8GJPcHHEIcVizI8w8rS4r/vdIWnAA6KgtQLuxGhFhBHydx6en9fYcjchv4c9g0QBBFBGY8cS
 A4h7LHFPPfRHwwA==
X-Received: from plblf8.prod.google.com ([2002:a17:902:fb48:b0:2ca:c3ac:bb34])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2c0c:b0:2c9:97a7:71ae with SMTP id
 d9443c01a7336-2ccbf185901mr70404425ad.41.1783442431262; 
 Tue, 07 Jul 2026 09:40:31 -0700 (PDT)
Date: Tue,  7 Jul 2026 09:40:15 -0700
In-Reply-To: <20260707164020.2936476-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
 <20260707164020.2936476-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707164020.2936476-6-joshwash@google.com>
Subject: [PATCH v3 5/9] net/gve: set mbuf to null in software ring after use
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Junfeng Guo <junfengg@nvidia.com>, Xiaoyun Li <xiaoyun.li@intel.com>, 
 Rushil Gupta <rushilg@google.com>
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

Currently, it is possible for mbufs to be uncleared in the sw_ring after
being returned to the application. This causes an erroneous
dual-ownership over the buffer until GVE cleans the buffer queue and
posts new mbufs, overwriting the older pointers. It is possible in such
a case for a double free to occur while tearing down rings, as both
the application and the driver could attempt to free the same mbuf.
Release ownership of the mbuf from the sw_ring as soon as appropriate to
avoid such a scenario.

Fixes: a46583cf43c8 ("net/gve: support Rx/Tx")
Fixes: 45da16b5b181 ("net/gve: support basic Rx data path for DQO")
Cc: stable@dpdk.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/gve_rx.c     | 1 +
 drivers/net/gve/gve_rx_dqo.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/gve/gve_rx.c b/drivers/net/gve/gve_rx.c
index 625649cdcf..cda87af294 100644
--- a/drivers/net/gve/gve_rx.c
+++ b/drivers/net/gve/gve_rx.c
@@ -152,6 +152,7 @@ gve_rx(struct gve_rx_queue *rxq, volatile struct gve_rx_desc *rxd, uint16_t rx_i
 
 	rxe = rxq->sw_ring[rx_id];
 	gve_rx_mbuf(rxq, rxe, frag_size, rx_id);
+	rxq->sw_ring[rx_id] = NULL;
 	rxq->stats.bytes += frag_size;
 
 	if (is_first_frag) {
diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index c4e2d32067..3665d9e4cd 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -207,6 +207,7 @@ gve_rx_burst_dqo(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 
 		rxm = rxq->sw_ring[rx_buf_id];
 		gve_completed_buf_list_push(rxq, rx_buf_id);
+		rxq->sw_ring[rx_buf_id] = NULL;
 
 		/* Free buffer and report error. */
 		if (unlikely(rx_desc->rx_error)) {
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

