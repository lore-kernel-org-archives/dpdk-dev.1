Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F79C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 18:36:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C84140B8C;
	Wed,  1 Jul 2026 20:35:46 +0200 (CEST)
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com
 [209.85.216.73]) by mails.dpdk.org (Postfix) with ESMTP id 785CF40A82
 for <dev@dpdk.org>; Wed,  1 Jul 2026 20:35:45 +0200 (CEST)
Received: by mail-pj1-f73.google.com with SMTP id
 98e67ed59e1d1-380cf335604so331826a91.1
 for <dev@dpdk.org>; Wed, 01 Jul 2026 11:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782930944; x=1783535744; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Uk1XlcuHNdnM2pHLeImIt849f0PFTPH+gP8PyJO/xYg=;
 b=E8vlb4q/VNLS6i2iB9Rext5NQH0/n3ihTTUWubVc2yK9o2pKKGugUFkLiQR+ukW06h
 miZPpTxEdYJFQzIq1sgfGeKa7SKPOFYlVKO414JfBORilqEZxajCgF4T0YnlnWh18nbk
 nzwvJxfhyRRAfydFhniRgE+AGOVVGtZm3uS2ikmIjUGb5VKcOOjZVekoo4KUs1g0A58+
 TVFvk0rHQCjq5FVKYdLAoUsWoOhnMyHfYHkfueqIeoipExo2yIh8Xk14mexjLf534kIv
 fKPRVzTlb0OLy7Zi6uG/O5h9FIqPEoA55FqhfSXs4SJQ3zlZ1MIfu0VKZDn3/4QiV0N7
 gpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782930944; x=1783535744;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uk1XlcuHNdnM2pHLeImIt849f0PFTPH+gP8PyJO/xYg=;
 b=SxUCcKcZ6H9eXllLH2Rpl/o7Uso+8mVYLhR5bGOwi7C4sdzULoFPD6CBVHryELBzcH
 +bZXqfG+hHu2k48q2xrzVTO2r3GQ0fqXCkbPvqVbY004dpBvIs2IAbJpqD2V+l0613Ha
 1f3OU99fJDWUKvFVU7ONnmjzcARQxjBacnwDV1J7So/1Gp8a9+6wdWC2+AoEcBIBxd9b
 KBa04fEX41nAfUT+leI/jYCjxXGOiJQGmG2EW4/kCrXS5o6cSAesAPkVA2ZFw05xcAv1
 agmqzTFZPmsLQDc7tjC6vJCIslXyUswc4JrHkpxBFLrLaKoF8fK+JGSsZytIYVjDAGZA
 J3dg==
X-Gm-Message-State: AOJu0YztQWqfRk1lgHlWIQHgXEPcd4UjeAD8lKJUZhRkefJirzLlDwdI
 kdLVetLoNVuKD8u7n8i4bWvU2RjkgmWYxlk+cWNcMH9R26T/n79XtjCMaBgYUrjsGuBdx95p90g
 EJdtoDZzkDRP6qg==
X-Received: from pjys10.prod.google.com ([2002:a17:90a:e68a:b0:377:2d20:59ff])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d05:b0:37f:c2a8:ce45 with SMTP id
 98e67ed59e1d1-380ba84ba5bmr1905924a91.4.1782930944292; 
 Wed, 01 Jul 2026 11:35:44 -0700 (PDT)
Date: Wed,  1 Jul 2026 11:35:25 -0700
In-Reply-To: <20260701183528.2443032-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260701183528.2443032-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701183528.2443032-8-joshwash@google.com>
Subject: [PATCH 7/9] net/gve: increase range of DMA memzone ids to 64 bits
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Haiyue Wang <haiyue.wang@intel.com>, Junfeng Guo <junfengg@nvidia.com>, 
 Xiaoyun Li <xiaoyun.li@intel.com>
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

Long running programs can very easily eclipse this 16-bit range, leading
to name collisions and failed DMA region allocations despite there being
plenty of available memory.

Fixes: c9ba2caf6302 ("net/gve/base: add OS-specific implementation")
Cc: stable@dpdk.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/base/gve_osdep.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gve/base/gve_osdep.h b/drivers/net/gve/base/gve_osdep.h
index c47ce4da85..55629a0e1a 100644
--- a/drivers/net/gve/base/gve_osdep.h
+++ b/drivers/net/gve/base/gve_osdep.h
@@ -175,14 +175,14 @@ struct gve_dma_mem {
 static inline void *
 gve_alloc_dma_mem(struct gve_dma_mem *mem, u64 size)
 {
-	static RTE_ATOMIC(uint16_t) gve_dma_memzone_id;
+	static RTE_ATOMIC(uint64_t) gve_dma_memzone_id;
 	const struct rte_memzone *mz = NULL;
 	char z_name[RTE_MEMZONE_NAMESIZE];
 
 	if (!mem)
 		return NULL;
 
-	snprintf(z_name, sizeof(z_name), "gve_dma_%u",
+	snprintf(z_name, sizeof(z_name), "gve_dma_%" PRIu64,
 		 rte_atomic_fetch_add_explicit(&gve_dma_memzone_id, 1, rte_memory_order_relaxed));
 	mz = rte_memzone_reserve_aligned(z_name, size, SOCKET_ID_ANY,
 					 RTE_MEMZONE_IOVA_CONTIG,
-- 
2.55.0.rc0.799.gd6f94ed593-goog

