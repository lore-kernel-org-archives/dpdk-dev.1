Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0874C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 13:13:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BDB540A6D;
	Fri,  3 Jul 2026 15:13:25 +0200 (CEST)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id BBD91406B6
 for <dev@dpdk.org>; Fri,  3 Jul 2026 15:13:24 +0200 (CEST)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-2c79e5de32cso8452155ad.2
 for <dev@dpdk.org>; Fri, 03 Jul 2026 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783084404; x=1783689204; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Uk1XlcuHNdnM2pHLeImIt849f0PFTPH+gP8PyJO/xYg=;
 b=PGP6DjP1ANvXl4gPTiFPgkZHKm32K6yuOAlXqgmKmke/C5tKGXNbo1oBHJHoOhw1Jp
 Sm6ecxgHrDpnhWSIpuMq0/EXUxhN8KjmufT67X6FIKMC3v8nuHYkEII6Sh+KmDSjcjmr
 IV+XvuozbHfxR4ew7/GMfMkN03DgsJEKj4Mz3lcDpHqWEeEpHSoGOlATJWLWOfwI6Ipi
 7auJD5r5IyHfsn5YgyKvbRDGVmBizdc3qrcSoYqbIr2LM33l2rTK76/4h29M8d7yMSEj
 tBudKbnl3COsxsZmtyWn/PdQL0ug9KZ7/oPDuHvTFNR4kEk8OhlXXnhFYujV4iGhjuYv
 Z2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783084404; x=1783689204;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uk1XlcuHNdnM2pHLeImIt849f0PFTPH+gP8PyJO/xYg=;
 b=nnzg2CXPLBFYz8LIDwQ2OKPlAsskOGoQfYLuAwUCuVyJIM/pUER5bxON+DcRq8k3Yz
 13rj8pRg6VxqKdg1sjtYQA2jG6G0p5K+qExcVarFzcfAtQHtV9m1z0zOxAkq9JdeteD0
 FlOjwKJTy8sdBNkWc+iny7BJ6d7vo3c1hkylJCZf7W/CDBBAai7SFLTrsShdxqpGEYE+
 IC3dMfnxrWuy5IBQ197a12GUSwUJAdYx+1AWeME878d7v1jBfu+0cnm2UEDDBxZ7fMys
 SRDZfiBwphSWBfpuuGJnIzE+ytJXgHhralggdOFRVWZ0fmMUSct5YGkmrTWuNkFXXNFu
 Ou6w==
X-Gm-Message-State: AOJu0YwhMmTzxR03iooQ5o9wXECBs+uTiqoeHKxHD0EvWVOpgZOCcUhr
 5vN57A4Iu+xtj/pjLL5KE4ELlFvMvUZG/NtOIQaBBCxSOtb19X3aTJLzz+f3GUWLeGf84iasU2B
 93Y4z3Vkqy7gtDQ==
X-Received: from plsa11.prod.google.com ([2002:a17:902:b58b:b0:2bd:3ebe:ef7e])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:26cd:b0:2c8:2808:3ec9 with SMTP id
 d9443c01a7336-2ca9114d983mr98955335ad.12.1783084403495; 
 Fri, 03 Jul 2026 06:13:23 -0700 (PDT)
Date: Fri,  3 Jul 2026 06:13:04 -0700
In-Reply-To: <20260703131308.2507403-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703131308.2507403-8-joshwash@google.com>
Subject: [PATCH v2 7/9] net/gve: increase range of DMA memzone ids to 64 bits
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
2.55.0.rc0.799.gd6f94ed593-goog

