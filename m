Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF04C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:28:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 665C9406FF;
	Fri, 21 Aug 2026 21:28:19 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id A20DF40678
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:28:17 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso1766553b3a.1
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340497;
 x=1787945297; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/gb2HNHOwY8s0WFnMZHH0YmGvDO8yBve98yXwbRkY2A=;
 b=BfaNZVIRsYfytSmoHTlSr0gHC+tVeA2uxb+eTYGvhZ7cSiZXID0+Tm9fsQ55fHKJdP
 SBPXLcyIpBlzU2Zx2l2NVwwXR8asl3YiPQyoFCdzjchir/lkV6/mnP0baCnW1LEdnhHO
 1GrElY1G0DIwn/JasjC4FzSN+MFDHcb6V/xXqkd1Rll4qeItZk5312XBcRPI5+j+Rg9r
 8lBFV79CAYhBenV7mR79hZcHIwI3AzatcpJEUbJKi5Hu42lAPpbYmuCShV5+yIYGvBBp
 zfGCbfDQjW2SQBddKwShvlvMLejmnnwwISjnnp4JLL0upkpZ4AZL71C2Ccs5kkQzp0tQ
 B8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340497; x=1787945297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/gb2HNHOwY8s0WFnMZHH0YmGvDO8yBve98yXwbRkY2A=;
 b=fSvgPVjPmyuCSfwgMbBSup8D5W/n12J33vkBcucURjfX1evWSYeRcDt8hKk39mrubu
 eZc791vJ/CJtd+BH/R2hrohcOIkCALnMLCrvxf1PGHbAPWWhXRKM4JE3BeQTUfQbJU3J
 RE40SmwLak7knCef4CQGQah0BW0TxT+ANlp9ra5flVJRBV036shHRGDgOSJMKUNimM7h
 BAnb9NpHJh+1Us+lO4MDtElRgI9q/DDUtU+JYWvjtUWk/6dQTO9zPxi+ve6orX3xMGT6
 V4GhjnLAO3Mdh+RQ28baGWhbqwGm/fINgJS6k71SNrh3HCTiG3zzprLBNRNGeseakfCq
 ygUA==
X-Gm-Message-State: AFuF++kxJbZcn8A0Iv1D5noI06SgRfCDPmhVbh3IoJ3waVJZYL4wwuWR
 qOo10PvjGGWxEFHV9rEzT3drQCV0r9h++NZX6zFEo6GxrJzfphGhy8jpCUUpJH6HCvB6q/z9TK2
 v4jvw
X-Gm-Gg: AR+sD12OSVIBXfz9oKHgvV9Utl0EzK3NFEDDW3kBIEitohn4XBhuz9t13Ks6R80F0/B
 jeP48vMeuPY1faQ54itIBZUySncAsWusQjykxHF8/ppxNBh+ScNzqXnInS7A2muEXQUk+WeeLzR
 dT/vQJ4mnSxDmutkm2QdJFWaJnJ4RXKt92lIfoh6jdiiej6jOdw0k81y2MCl7Vv4sXK6vnZX5j4
 LN/2bIOyWTpQEKX5VLM5H3OA5/qSIm86xJs1fIbY4kmlE1Js/NMJykjyTgwWNPhfPC/ykttVGwM
 0KddBqIyHwoMcw9bxCbSvsKJDrn8tNVpTpBhN/VIxSL29bsA7O3V6v9s0/Um3sXnY8IFOYz4R8F
 Ugo9cTqQ4PaRHduVWNf3vxXStDs4fz787oZV3dpyrGdmOVF26qzaeSKP+Xtapouh0w0mImVvst6
 zSExNS99hxa5HH0OlkbuR23CCsnBUSH1zTUOWu15JbnIYTBLmqxIpVsTqJEMdCtVcPeVmVilQy1
 HOvW1yUNQOv4/7LYMnNb96Wx3QfRum8oRcMNQ==
X-Received: by 2002:a05:6a21:1786:b0:3cc:ebeb:3efe with SMTP id
 adf61e73a8af0-3cd2ffc3d9emr19207307637.9.1787340496840; 
 Fri, 21 Aug 2026 12:28:16 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:28:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH v2 07/68] examples: add missing include of rte_memcpy.h
Date: Fri, 21 Aug 2026 12:24:02 -0700
Message-ID: <20260821192646.146382-8-stephen@networkplumber.org>
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

These files use rte_memcpy() but relied on rte_memcpy.h being
included indirectly via another header. Add the direct include
so that later patches which remove now-unnecessary includes of
rte_memcpy.h do not break the build.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/bbdev_app/main.c  | 1 +
 examples/dma/dmafwd.c      | 1 +
 examples/ipsec-secgw/esp.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/examples/bbdev_app/main.c b/examples/bbdev_app/main.c
index 5ac70dab59..4ef72245c9 100644
--- a/examples/bbdev_app/main.c
+++ b/examples/bbdev_app/main.c
@@ -29,6 +29,7 @@
 #include <rte_malloc.h>
 #include <rte_mbuf.h>
 #include <rte_mbuf_dyn.h>
+#include <rte_memcpy.h>
 #include <rte_memory.h>
 #include <rte_mempool.h>
 #include <rte_log.h>
diff --git a/examples/dma/dmafwd.c b/examples/dma/dmafwd.c
index a8ed09e6ae..ea2cc586d8 100644
--- a/examples/dma/dmafwd.c
+++ b/examples/dma/dmafwd.c
@@ -12,6 +12,7 @@
 #include <rte_malloc.h>
 #include <rte_ethdev.h>
 #include <rte_dmadev.h>
+#include <rte_memcpy.h>
 
 /* size of ring used for software copying between rx and tx. */
 #define RTE_LOGTYPE_DMA RTE_LOGTYPE_USER1
diff --git a/examples/ipsec-secgw/esp.c b/examples/ipsec-secgw/esp.c
index 46c3ad3ec7..7aaa81c458 100644
--- a/examples/ipsec-secgw/esp.c
+++ b/examples/ipsec-secgw/esp.c
@@ -15,6 +15,7 @@
 #include <rte_common.h>
 #include <rte_crypto.h>
 #include <rte_cryptodev.h>
+#include <rte_memcpy.h>
 #include <rte_random.h>
 
 #include "ipsec.h"
-- 
2.53.0

