Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDA7C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 18:36:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EB2140A71;
	Wed,  1 Jul 2026 20:35:43 +0200 (CEST)
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com
 [209.85.215.201])
 by mails.dpdk.org (Postfix) with ESMTP id 93C2340697
 for <dev@dpdk.org>; Wed,  1 Jul 2026 20:35:41 +0200 (CEST)
Received: by mail-pg1-f201.google.com with SMTP id
 41be03b00d2f7-c892143db7fso624991a12.1
 for <dev@dpdk.org>; Wed, 01 Jul 2026 11:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782930941; x=1783535741; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rj4KCs8B3o4jz+ud9hwdG0BppzIfIi5ePThlnHYXGwA=;
 b=p6vX7SoIY08WNNG9ADrX6JNxnDHSF2qUlBV254Pppt3Rb0TSBacJVgYLA1FKq8yqpp
 i8h5ujwVwMpxXAoUlSgpC0BYEMheF52jMlXwiX8TwTbwJQnKtF29ToFTQ5mvYm9dwJzb
 Vmibk3pbXuV1YgNbXqed80ARc/EkE1Im/6mZ3zl3KW+/XiMx8HRrZ7Qd4xyrEZgwEjus
 H0hfk9HkPYPtOotil3B7XXXmmb+aCWGjXCmMWjdmYkSHOQrPYydxUEJ5+Q15oLKf9Fy1
 SmPp1CDdswpYKkmGYwvByOmVqDH4p7GJD1c6FpszahH621X4NuzFjwPHjx8ctkwtiqP6
 6y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782930941; x=1783535741;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rj4KCs8B3o4jz+ud9hwdG0BppzIfIi5ePThlnHYXGwA=;
 b=giN8JNvjIiPYlm978dY3MkJnuVUwjmoP3gLbcfCCeV6fGEazbpz1pQy1eno7jMs/8v
 KOk6fwvXLkQzpwsDy84B3YybNd0GkcWbvEmD+yS7G2tl9gzwN04vNrxSrWY/j9jRIwhu
 H6GnhZkGePFXW15vKmRGKo/8dAAxrgYK8ZsLg7rs0WzbSGi+Fq9qhaghTyvgYngT/Zo9
 MJHRvjQ1dy3QUd2anR+t5EOc6y5/nC74Ng2ikAuMxc82ZMXKV/FF9uGVi41HHEaVVFtC
 kEgw6Ngz13PS1vfRiLRe5p/nkcTF6hyPYlnKkEnzMYYHgJvsAN8KNqota2Y297qy0f2+
 jzGA==
X-Gm-Message-State: AOJu0YxMuel3GoRlTFdL5ulgLd4DHNCg9HePpvBhf9qP43P4Lj3tO9OZ
 kfk7x3xKqHhzQCbB9D9LZoO6DTCLx/q9+1Jdx3pHw3v2WP2wAOh7l2ay1V1h3X7rR61XZnP5yV1
 WVvwFKMKxpmCkuw==
X-Received: from pgjp1.prod.google.com ([2002:a63:e641:0:b0:c99:aff5:7085])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a123:b0:3a3:327:c5c8 with SMTP id
 adf61e73a8af0-3bff3c57934mr2212545637.0.1782930940524; 
 Wed, 01 Jul 2026 11:35:40 -0700 (PDT)
Date: Wed,  1 Jul 2026 11:35:23 -0700
In-Reply-To: <20260701183528.2443032-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260701183528.2443032-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701183528.2443032-6-joshwash@google.com>
Subject: [PATCH 5/9] net/gve: set mbuf to null in software ring after use
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Xiaoyun Li <xiaoyun.li@intel.com>, Junfeng Guo <junfengg@nvidia.com>, 
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
2.55.0.rc0.799.gd6f94ed593-goog

