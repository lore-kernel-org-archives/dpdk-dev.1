Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43894C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 04:08:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF25140A67;
	Thu,  9 Jul 2026 06:07:58 +0200 (CEST)
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com
 [209.85.215.201])
 by mails.dpdk.org (Postfix) with ESMTP id 6B8E1406B8
 for <dev@dpdk.org>; Thu,  9 Jul 2026 06:07:55 +0200 (CEST)
Received: by mail-pg1-f201.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so1094402a12.1
 for <dev@dpdk.org>; Wed, 08 Jul 2026 21:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783570074; x=1784174874; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U1rkUYkZd6Cf/wWJwTsjaHaph72sAKJGLKcoW6N1npc=;
 b=XUBhpJiSmpm8KqopYkadBKwnp0DH3ATUsZd0ZBgJsRaghARsa4Vr61gcHcvQ0YHOAL
 RTsio3pZwe1VaxqDN6JJUJ41WV+InL/wwGt/4LfRInEDKVN4WD0LyDHxVxm4ekJfBulf
 h/XXASqcFLcdxyHXlQSeN2gKfgCxhZgCTptJglkc4kv2DyugN2Z79SX1/TFNpQbmbyCy
 fTcev6MgOxdFqHvpMO9x4VqAJag75tOc7xO9MexXS2t8OUpERFLQucQ9Ox02NFrueeLr
 pPlpexoUrCtAComJ2yO6QTscrbKSyAvqlLW7jabbrXDD7S2+7gLSAwdGaDOl95FuJgUF
 a3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783570074; x=1784174874;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U1rkUYkZd6Cf/wWJwTsjaHaph72sAKJGLKcoW6N1npc=;
 b=HaW1D2tkbaaFUVrmNd9bOC7vszU8bkBp8+C49vAQoRJ51MhLu+KXVEjXwQ2KJSag0R
 H1ieG3JULvtHOeUGLKfBmotExNULEVKcSjZ5Y4W7AeSUBxNJjE8RTylKb5Q2mSJ7ysQ0
 CINoi/MMO5rrU/3EIT5SEnjVWxG3MIIdiUDXz0+rPbi9RSgEckc9J9uhg3Lv1ECbWd2S
 Ms8VBfcz/UjuXXjeQb0AwpIGK1eZrOPFU2VEPiklixHpLF4bYAz17mGT0ejzUyqrWEx/
 /IWQVzqpa49IZfjM2LqojmivgRjZgFA1Ka1rZsTVgUpvbmjIyHIavwoIhCjxavpt8Fpe
 tlbQ==
X-Gm-Message-State: AOJu0YyHjMgDJlWnh6qCRjEvt4/gT6kc1y7foi6y8IyJtDMnq8IIdRqh
 VmcdlWvv8YIsxgktba4T2LumHZ24ZxVj1in0viV6uMh8C+MhIJvnKRYXRn1j1drmzOrozudeigJ
 OQ0mERjrB1P7laQ==
X-Received: from pgmo35.prod.google.com ([2002:a63:5d63:0:b0:c8b:41eb:d711])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3e12:b0:848:2f71:b654 with SMTP id
 d2e1a72fcca58-84842fcf8e4mr4420504b3a.63.1783570074332; 
 Wed, 08 Jul 2026 21:07:54 -0700 (PDT)
Date: Wed,  8 Jul 2026 21:07:35 -0700
In-Reply-To: <20260709040739.3184955-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260707164020.2936476-1-joshwash@google.com>
 <20260709040739.3184955-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709040739.3184955-8-joshwash@google.com>
Subject: [PATCH v4 7/9] net/gve: increase range of DMA memzone ids to 64 bits
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Junfeng Guo <junfengg@nvidia.com>, Haiyue Wang <haiyue.wang@intel.com>, 
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
2.55.0.795.g602f6c329a-goog

