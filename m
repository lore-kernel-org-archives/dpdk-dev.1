Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6C7CD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 19:59:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAD9440A82;
	Sat, 23 May 2026 21:58:58 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 452A1406B7
 for <dev@dpdk.org>; Sat, 23 May 2026 21:58:53 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2ef2a1cc06dso13945918eec.0
 for <dev@dpdk.org>; Sat, 23 May 2026 12:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566332;
 x=1780171132; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wy0LWLsrRgN2Tir69nk6vc0zGehOJuqPUdF+aOw17wg=;
 b=qHw9rRF8hLR8ffxjkJ5rFqlYwUcfbbr0iOA+T8+H6Z8LVuobOvJ7vyMisqArnpMlCp
 /GPwJ/kp8C3Aa5+YLw7gH9/LYKEX2dqG5sfXPnTjUUkg61pk95KhkEd6KPrFWc0/EQXJ
 liVCJ2ZWI+QIXXUYS5zFQzcY5suyX9XZrO8Z83M2achD4cF0G3w2Rzv1lpKUUE4NNNAA
 7ox2Y6pzSjySONowk7LytvyP8N3oVttlmCkAUJ8nZX7hnoiQEZtWpHf2yb7vmQNWsUoL
 UJEaOwxFhvDhP+iyasG4F7IgfRMTBih1K7xJ6H2DdP897Rxmm+r8aBa8JZ4EBbHitn8R
 RH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566332; x=1780171132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wy0LWLsrRgN2Tir69nk6vc0zGehOJuqPUdF+aOw17wg=;
 b=TYWqkM4cZU9OHMfs74SBClMm5DuIuE2s/QK2YsPvCa0WADrBAjJK3H65qUBOyTERl/
 pvBjunsvZ9KbLL7Nz8A78ps+gXQ7zh8cETPs6+iKIDDBYPTfinXkb6UETwr6Bbtji8m+
 ntfghvw+Eu08jd05DY0thHEnBqZc2mPVxsFsMoD7Kg3WZBiv5EIE/ozjPh1sBXhQ25cZ
 pSWqfJvCkgfIPjjwx2gorRuy3fPQ+tOtnjHCxH5QcxsQ+1+uTFFieZwPpsI/7vrGPee7
 2U67UQ3wBr0+BdjmC6ZGm0P3YbH79ZP/J43fBNFTV8ajXruwYpukyyJu328rqLeu6Q/V
 MxbQ==
X-Gm-Message-State: AOJu0YyynBk6sZcKDfFxvDUUwpDIyKGUEHWL30y70i4wzyWeiRVTSrqK
 fecn/dixfZIVhrrLebw4Dbio1P52yIOtJz6IOIj4aNvMUUA9yZXTUU9M57YyffmL8x59aUhl7s2
 DwrC3
X-Gm-Gg: Acq92OEe+PFrgYlwGRLFakoziZ8+4Qwenj4Ip00pABqkrbQV30HkwcdVM5cUzvH5eDq
 Ur+Msm48DIhhke8yxhwgonL7IhMqsMptmB92pmc1RvDid7bC5ayxzPm0EhNqcvWIGKFTchHR0Yf
 i/3D8A9YkWQQRNyrAKEecVAfuQoOJxSO7ppx2jgQPE/Xi355+dOweBG4MZxmpF6KxT1I6zGWW1y
 SsbCHwzwzkfrKQJseG545LvRNP2VOYKbnnoGE5m1qn7rtBg/HJDurysYFazaBKjF8AsTAIVucSN
 rFDQn6Df7hnsJ0I8TkHwDdaMfmA7JFt0+YqefbBhdhMGk3wr4zSJ1gZ5hqXnA2yMtpsTObIGq3s
 40PC+vD+EsRxDB6ScKmJya+/ocK/JAJh47BtAL9orfsvuqbumarJww2MyGZ9jD4mcRBDJFIs1Mr
 MOL8KJdIcJLidfyGMlOdKdFifJjSEndUXmt77l3WBhhax+z+tTJ2kbD55FNnwX82XcSOs910A1
X-Received: by 2002:a05:7301:7c0e:b0:2bd:c285:2fe with SMTP id
 5a478bee46e88-3044905fcc3mr4767732eec.9.1779566332338; 
 Sat, 23 May 2026 12:58:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:58:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v3 10/27] net/pfe: use ethdev linkstatus helpers
Date: Sat, 23 May 2026 12:56:24 -0700
Message-ID: <20260523195839.454952-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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

Rather than open coding with deprecated rte_atomic64,
use the existing ethdev helpers to get and set link status.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pfe/pfe_ethdev.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/net/pfe/pfe_ethdev.c b/drivers/net/pfe/pfe_ethdev.c
index 1efa17539e..1b183ab1f3 100644
--- a/drivers/net/pfe/pfe_ethdev.c
+++ b/drivers/net/pfe/pfe_ethdev.c
@@ -531,34 +531,6 @@ pfe_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 	return NULL;
 }
 
-static inline int
-pfe_eth_atomic_read_link_status(struct rte_eth_dev *dev,
-				struct rte_eth_link *link)
-{
-	struct rte_eth_link *dst = link;
-	struct rte_eth_link *src = &dev->data->dev_link;
-
-	if (rte_atomic64_cmpset((uint64_t *)dst, *(uint64_t *)dst,
-				*(uint64_t *)src) == 0)
-		return -1;
-
-	return 0;
-}
-
-static inline int
-pfe_eth_atomic_write_link_status(struct rte_eth_dev *dev,
-				 struct rte_eth_link *link)
-{
-	struct rte_eth_link *dst = &dev->data->dev_link;
-	struct rte_eth_link *src = link;
-
-	if (rte_atomic64_cmpset((uint64_t *)dst, *(uint64_t *)dst,
-				*(uint64_t *)src) == 0)
-		return -1;
-
-	return 0;
-}
-
 static int
 pfe_eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 {
@@ -570,7 +542,7 @@ pfe_eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 	memset(&old, 0, sizeof(old));
 	memset(&link, 0, sizeof(struct rte_eth_link));
 
-	pfe_eth_atomic_read_link_status(dev, &old);
+	rte_eth_linkstatus_get(dev, &old);
 
 	/* Read from PFE CDEV, status of link, if file was successfully
 	 * opened.
@@ -601,7 +573,7 @@ pfe_eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 	link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
 	link.link_autoneg = RTE_ETH_LINK_AUTONEG;
 
-	pfe_eth_atomic_write_link_status(dev, &link);
+	rte_eth_linkstatus_set(dev, &link);
 
 	PFE_PMD_INFO("Port (%d) link is %s", dev->data->port_id,
 		     link.link_status ? "up" : "down");
-- 
2.53.0

