Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DB0C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:41:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09D8940B8F;
	Tue,  7 Jul 2026 18:40:37 +0200 (CEST)
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com
 [209.85.215.202])
 by mails.dpdk.org (Postfix) with ESMTP id 3B1D940B94
 for <dev@dpdk.org>; Tue,  7 Jul 2026 18:40:36 +0200 (CEST)
Received: by mail-pg1-f202.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so7399300a12.0
 for <dev@dpdk.org>; Tue, 07 Jul 2026 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783442435; x=1784047235; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=i1klkBMJP+vLWIvYSLdsnGSz7x+JvslwJYaQm7t/3IE=;
 b=RbHvopcJTPWtZDS2uFOcwYcep3NjYtPy4i/RvgCLmHg1X1pL3wZu9Jabt2v4GmYhQa
 KPQk2tAhCwtgS6LXSpwF5wET6G9MbVSroiDDMVkJkBt4DYRf9qzm1afKvRvhZvZvXVQV
 MA7PZzCzHlR5ocb1Z+qKqPlo1SguzTFgDPHLuvh1et9L2L8QatirecTykZgSblPqqkEt
 bH1u/pFgaGLF+BIuYZYrTBNGNDlgC+jGabZ6yo3n35t5Lt0w9Ymo1IP6tYj/CWp+OSoD
 8OiVXNipd2be3QBR2aa7QcxdMSlA68WXZP6H8yN9CyowFncl5AXmEz9EgRoaY/krbr4R
 +Xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442435; x=1784047235;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i1klkBMJP+vLWIvYSLdsnGSz7x+JvslwJYaQm7t/3IE=;
 b=F886ypTsDMGHmibxIPKJbHyr4SnZuvNtpoTLCy0beM3tTCokbJznfxaRJlzGBfJKJZ
 HNDx8Kq8AIE+sZU6lSQgvIADcwqdUTWQVvjP4bKt/V62O0Eh291FxFwDEmY03HleIqTz
 iDvLsfgwQywBWe+RWlyGo++KgVx3JdhQnQp1GZL0gMcHdCNUqWxEDAJ1dd7yNhXRxrJ5
 Rl7g5KucvyGwKfM2xxusSgKeMHGMCyP0FQ7GWEL6VI76BH7DavI+7VB+NJSeKz3TZK8G
 Zyag5TqhCvTb8N4fKqfP/tQ7zon2pEzkEgXIUPqWvJQU83dvT9P4Yr5YnQsQEmUvFZGf
 MjFg==
X-Gm-Message-State: AOJu0Yw5te5QLATQDe+5IrQ/ntuKDePCPAvganaPugvMcx6ztGjVjFVc
 P7YpxQaS7Z1B66K/0+u27pFmYG1MkGegjVvPRyPWs1uAcHVOt41DcVT7jbWHafdtuEpGs13LDeU
 p3J7ohPo4xRjtbg==
X-Received: from pgbcv1.prod.google.com ([2002:a05:6a02:4201:b0:c93:c605:e4a0])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7983:b0:3c0:9c19:6592 with SMTP id
 adf61e73a8af0-3c09c1968bcmr3482414637.76.1783442435270; 
 Tue, 07 Jul 2026 09:40:35 -0700 (PDT)
Date: Tue,  7 Jul 2026 09:40:17 -0700
In-Reply-To: <20260707164020.2936476-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
 <20260707164020.2936476-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707164020.2936476-8-joshwash@google.com>
Subject: [PATCH v3 7/9] net/gve: increase range of DMA memzone ids to 64 bits
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Xiaoyun Li <xiaoyun.li@intel.com>, Junfeng Guo <junfengg@nvidia.com>, 
 Haiyue Wang <haiyue.wang@intel.com>
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
2.55.0.rc2.803.g1fd1e6609c-goog

