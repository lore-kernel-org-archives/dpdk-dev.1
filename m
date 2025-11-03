Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4B4CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21DB2402F0;
	Mon,  3 Nov 2025 17:37:09 +0100 (CET)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 6A007402BB
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:37:08 +0100 (CET)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-7abe8442103so583707b3a.1
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762187827;
 x=1762792627; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TJug752yRk+a+DsC79ySgX2kPUXsXbsiZHrJPsi0dNQ=;
 b=Dwsx+egPu1cDY0W9ybGvcSGFtoiV12qvlRCwt0p4yew+37+gnZhcCJ1L+mvtqaC8AR
 WQzE4GyBnp0DoOUalNT4dKgjvkg+vjcrDOLs1jkr9W7jvrg+f0aPJg3OhPZCmEypTwIM
 DC6x1BAwfx+WXEUXgPI6Bo2Kkc75vQyqIw3Ov1YivaJMwjP9f6Nk+afdKvCJCScvGj42
 8UAOJ76+YsgxJh/IK04uSguDtEzmpdcVVaJ/SXtD1MchuaxK9ylGP9s+ChGchDWeCfdS
 Uxn8unom/o3hbHZcUsBm1FrZoegVfE4rS2/5qvdPWmGYS0KK4P2K1Wf+i3l+HToFOiSX
 mK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762187827; x=1762792627;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TJug752yRk+a+DsC79ySgX2kPUXsXbsiZHrJPsi0dNQ=;
 b=O5KZOvjtS9SLUQUAY3ru2iAeFRxRxfsRVxQ6qvKvdhLU/bQfmTO14entvvkWmP5t4L
 IBweQt8eZ3Ma2CenkBdQYDIbWClm8EyYO6qswVmwCZ6dlpBBptwatLFNmKar/As/fWDz
 atZQZN4nCoaYVv0tPnlWYTmlkWEaDunLxlh2fmPCKFUUGY1UdV6f7K0OjR07W2zw8qDs
 +Bn1ZChejrJWIrVAuyA/63XwAIOp+t2UQ9xMDMpjkrUgNac+cfazePCNYFUf7MP0JVcS
 7zx4n4E7SBKzVmadxTcFkIp+NPhjE1YBEHjuqKRKlzdtYGRV2j5FAVfg5dH2O8WJI023
 XcKQ==
X-Gm-Message-State: AOJu0YyaMfvUyiQ5wapgzpZc4YDxi04bHt6FNACc9GuD4jdLcHY9dHLo
 OkP/zNMtPOJpOjOo5vY4J4LwF62PlCUjnn0XzFCMUpicGFWH2MAOXfaLWAmslegg7hmuwrHHYl7
 oNfJg
X-Gm-Gg: ASbGnctZPYiY62qdLKGLMpRL3Z5CaDGm5tMhSkoYc1y0/Ou+9pOUSgA7lpdv+cXJo4j
 kAJiYg2WVlISFADW4zUPqizMFFTvXt5jTV4fkv4mw/lwdQb9i6n3Wxxn9HQkk0UmJOLYOX7ul7k
 eFh0q4zb2hxx7cLnfwUJ6mwWfhBpaZf7KmPvmmQG/Qua4nC24xLic2s5CajttnQDW/J585KbXkY
 rJJ2C9PZmpCRMR6PMbnGKOQz/3q3yK2R73IhEJO6dicJdKonJl0fEVdvA8HLgnNro51xOrtSpmT
 9hYczVMW1+EmM72oAPhYXxdoi3anX6JMfF9pg2oqa4jH5Dukh1hLby+PJNZG64dKbHsYUwwPfZh
 h5vqlHSBydi7Xpq2ntubyxBr4k93ESNo3RyVJ6UiSxaz5Co1Bai4ObNhoYWisktWPd1IF5/Vn9/
 Fql8M9YOC1u9Zk3+oYNJkyoukmMlTZ2QVUlkjuP60ioiOZVrgoxg==
X-Google-Smtp-Source: AGHT+IG3bDcf2h56zAhZcC4iErdoGJKFp+xM9JH/FG9BDOYGjguD2p2F0utxng+T5ks1FNCGJvL8kQ==
X-Received: by 2002:a05:6a20:3d07:b0:342:9487:7dee with SMTP id
 adf61e73a8af0-348c9f6791fmr17103801637.12.1762187827182; 
 Mon, 03 Nov 2025 08:37:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b93b8c8cdc0sm11019722a12.13.2025.11.03.08.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:37:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, longli@microsoft.com,
 stable@dpdk.org, Wei Hu <weh@microsoft.com>
Subject: [PATCH] net/netvsc: fix use after free in cache list cleanup
Date: Mon,  3 Nov 2025 08:37:03 -0800
Message-ID: <20251103163703.100238-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

The variable cache is referred to by LIST_FOREACH macro
after was freed. Replace by the standard LIST_FOREACH_SAFE
from BSD (and other drivers).

Fixes: 9a9d038c782e ("net/netvsc: cache device parameters for hotplug events")
Cc: longli@microsoft.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/netvsc/hn_ethdev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index dc765e88f7..6584819f4f 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -41,6 +41,13 @@
 #include "hn_nvs.h"
 #include "ndis.h"
 
+#ifndef LIST_FOREACH_SAFE
+#define LIST_FOREACH_SAFE(var, head, field, tvar)			\
+	for ((var) = LIST_FIRST((head));				\
+	    (var) && ((tvar) = LIST_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#endif
+
 #define HN_TX_OFFLOAD_CAPS (RTE_ETH_TX_OFFLOAD_IPV4_CKSUM | \
 			    RTE_ETH_TX_OFFLOAD_TCP_CKSUM  | \
 			    RTE_ETH_TX_OFFLOAD_UDP_CKSUM  | \
@@ -1479,14 +1486,14 @@ static int populate_cache_list(void)
 
 static void remove_cache_list(void)
 {
-	struct da_cache *cache;
+	struct da_cache *cache, *tmp;
 
 	rte_spinlock_lock(&netvsc_lock);
 	da_cache_usage--;
 	if (da_cache_usage)
 		goto out;
 
-	LIST_FOREACH(cache, &da_cache_list, list) {
+	LIST_FOREACH_SAFE(cache, &da_cache_list, list, tmp) {
 		LIST_REMOVE(cache, list);
 		free(cache);
 	}
-- 
2.51.0

