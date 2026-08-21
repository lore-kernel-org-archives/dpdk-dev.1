Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572BDC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:29:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C39E9406A2;
	Fri, 21 Aug 2026 21:29:08 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id E82104069D
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:29:07 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-84eb992a881so1019056b3a.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340547;
 x=1787945347; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aIT++unJwIwuU+aCgjdBPE+0+JgMyMKnC4RXBYg/jy0=;
 b=P8yJChJT5qYplRVGdVZPlFy020hWqMghEOfaxRkFZDOgvf5zlp28tzXccrpMq2pVH4
 j3b7MTb5ma9SV0AgTVWD/Tkvw/NdnEECHNU8KpA+ssd26N+VKARdzaAWLFy1y+NDkHkR
 txP/bx2TshGcUVfFAswWPi6DU1BLVWo34eyJXguCf8xBq/6KmU15Pmgu1UL3nxewLw6t
 m2CTelql+PzGiGkuOQUcNw0Tc91ndn/MTdly08aRisOTJ9KpGgSSwAe5At3//aJZKCfv
 uHDcZ6c0z13t5VQYWkOTddcpzVlxh4PJdtO0v3s/aMXbw9ED8V7sUor+2M2f070irbOZ
 rAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340547; x=1787945347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aIT++unJwIwuU+aCgjdBPE+0+JgMyMKnC4RXBYg/jy0=;
 b=b8mTj+rLtKjesuv2cZGO7daHI9ccL/1txJQniddsgMxVi7LPQn6rjvODEDy5Esiy1G
 o4I+wnvZ0etyuDCjqDRkQuYIQsscdIznsddDmh7etCQzgOg2NqkXcKc4jckPCAP5jaQt
 //RI33FsAWapkdTp6BWrwZL0ok2J6oc2DaXF/KhIJidSbTfOn5N26UXseOd1ZYOa7OCO
 3YLy20tq4RDOr/2yy4mvnRbS8dhVuvDpVGPv+ED91mo6IRl9QyU0wow0xFiQEo7O4mT/
 n9cYxtmeMiVa/GgJzaDk8+aJMkW1nTiIkXJLr7lJ1kcqyIEo5ALZ4X2kP+lMbynp6tes
 ejqQ==
X-Gm-Message-State: AFuF++nA5zLBeYGNSwWGdCoRg+cs+4O69OLQTspcgyzuCZRPjvd+IZQf
 2nu5kIqsH25QPZNT+mn7evLB/RTz6Ogmxpafg42mSKo4wmAPBMm+SAekqZtEJcxFXIyqREO/8I/
 xsHHv
X-Gm-Gg: AR+sD10WXusz8SIkKiCihJbfmFZEirP6E/x0Y9dHiwgiiaz2ykrwrIuKlKl3TfzFV2z
 cggAZyAPdJCSidtsZ0SYLaMQOVc0hF8deiOgD+fFOwLe0Ve/i9M/L/o14EAjFl7oRQPSzU8fGRt
 nr2FE4TB4hLMQh8VGGGIrKSieb5zNjDoRMWEpph+0Lpc/xGgL8x09iVzrvkDy1pNQNa0KtC74c7
 xrnLmNGMP/vO+UMzrpsBN4HLnEVzTtPCOiFa4kbqS7xX6WxDtR9HH1ywTIwuHuTW0EqmsAgmnkp
 LH5850Dj4m94h7oBJsQcsqiKeSEI8JiOnyTgoMP5/GDqZXEH6jMOXPQ5i23xYiCXqmJSk5aBXFW
 WPuoJPbwf6EBsPooKkzPLOYkeZdFz6kr2ZEsEC+EL206z54T6YomZKs64JBDkQqHadrn0QdIQrZ
 NyFSo7K2r+P9Z9sRYpqe1Hliet26OijTls/WvqWZdsi7kkiyuNBgDpbAZkiJ+XU7E7GRUyy3aHZ
 dTQCP6e+X1wHQA7sCxTY0V8PxU=
X-Received: by 2002:a05:6a20:12d3:b0:3c3:7cd0:fc27 with SMTP id
 adf61e73a8af0-3cd2fd4d795mr16568321637.3.1787340547114; 
 Fri, 21 Aug 2026 12:29:07 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:29:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 20/68] eal: replace rte_memcpy of cpuset
Date: Fri, 21 Aug 2026 12:24:15 -0700
Message-ID: <20260821192646.146382-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Simple structure assignment is better than rte_memcpy.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_options.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 42cdef632f..c0e97d21ae 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -29,7 +29,6 @@
 #include <rte_tailq.h>
 #include <rte_version.h>
 #include <rte_devargs.h>
-#include <rte_memcpy.h>
 #ifndef RTE_EXEC_ENV_WINDOWS
 #include <rte_telemetry.h>
 #endif
@@ -1446,7 +1445,7 @@ eal_parse_lcores(const char *lcores)
 
 		/* without '@', by default using lcore_set as cpuset */
 		if (*lcores != '@')
-			rte_memcpy(&cpuset, &lcore_set, sizeof(cpuset));
+			cpuset = lcore_set;
 
 		set_count = CPU_COUNT(&lcore_set);
 		/* start to update lcore_set */
@@ -1469,8 +1468,7 @@ eal_parse_lcores(const char *lcores)
 
 			if (check_cpuset(&cpuset) < 0)
 				goto err;
-			rte_memcpy(&lcore_config[idx].cpuset, &cpuset,
-				   sizeof(rte_cpuset_t));
+			lcore_config[idx].cpuset = cpuset;
 		}
 
 		/* some cores from the lcore_set can't be handled by EAL */
-- 
2.53.0

