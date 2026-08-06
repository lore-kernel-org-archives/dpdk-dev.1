Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071E0C55ABA
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:26:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64914406B6;
	Thu,  6 Aug 2026 05:25:58 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 34CDD4064E
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:25:56 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cf50c6f235so21424895ad.0
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986755;
 x=1786591555; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wy0LWLsrRgN2Tir69nk6vc0zGehOJuqPUdF+aOw17wg=;
 b=YMVwWi19fd/8SJUkVHw/8ZBY8nl060rMtT9rYZddFf5QA9Wuw/p52UyFPSujQkJf+L
 5hr9w3gJA/avyL/Q7N+618iF8qO+sweP9Sdey8SZtMncW1DHhPsxci+CYjfzDbSE67CB
 54Y3OhWY+SGL8flWp0Re7G1SOr5Jki0oYifRs7Oa62oBa+LuvgMbzgnSTOB3atAf1bcI
 EGp4MP+iCfT0ryvk3ziLfyrkT2R9mbq6GeuCQKFjGmDj0diygrShR7BqJGKDpJYcZY4U
 /PRgFGvcqxxEmEqz+W5ueXl1YnE16NJY4FAdZNlt16XlmcbapUgKKPIbjZG9l9y/oWjU
 CxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986755; x=1786591555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wy0LWLsrRgN2Tir69nk6vc0zGehOJuqPUdF+aOw17wg=;
 b=jXV4xBJOMdDqT5CRIKYgS/Ev1zjIx1XB63Xaegu80HxGHftS2CgZkQNtrv+0KsQbba
 AOAFqTIMF5JSxC33q0EwT+W9vVt/ck7xe3hau7h+AHbXOk/8lPzmHfg63E2qaGsSz5/K
 QBro9YaoDqRH+FnUJtTbrwmQwLG+sTwnrk/ak6XJwGNwsLAcCe3vhUey1z09kGDgmhPG
 J9G9E4AMwkrjWUsBa1Co+6DjwpmyTMoiXFyJrlcoDtw/YGIf5v4uuDAMdDvHaktcyJ6q
 SyHVLCNYwp7wvYY9/wqkYnfYnICIntfYxzHBFEkYo+iOKi9FupdNUNFPNYiEwz93Q0BA
 nvJg==
X-Gm-Message-State: AOJu0Yx4/ndBlHXooZBZpfQWSM6Xv2GK9/znUWZJFOqBQfHsqigIw7+k
 Vg4dpJevKER4iWSkFYkWsVStjAu0oN5x27QE7gljwP5li+cyfra1xVEW72CQiJvY8+f9TVz9GXp
 WivgI6Ho=
X-Gm-Gg: AR+sD13yAUJTO6YVo0uOa7Ixjtd+WhV8p8cV928G2R4QLAm/Ccuyk3ocV9TSqi/6lOT
 YVLwrQ86JEq94EygWQYLOwenOKbFCeGOSTOn1saQs7Pk9WsjeRek5urf6p6H7OjCrZG+Z22WAjg
 LMcfSD3lMOoNbP8Bzx7LihB2kmG/Pa+fIEP3ALZiDA2fPiUbRjFhnHNrhTjm/N5OneLLL5MLYlF
 o1TMSMZ/rh6o1Q+DydbzZTKrU3KWcZjzQqSeL2pek3rXzPyfoX9vrpbkBG3FY5f783yfR7EQhWH
 KixrWRsJFR/5ntpQrTbQbPhuoHFoIsWt1Yv8xUfqmxYltdES5J91tRAKcLb+8Z9/9omQnNOFy7j
 hQ9tpE0WdbkOjMTTWppuLEc8Ab65BebTWIbpDAGSfaE8CXSN2JH0Jp3+ThiWU+O3UkYSamuSyHf
 KGmOQHXwg4sJBhiaDW4NDrTtKgmcfh9gPhliipF3yx77IW4h8APKxbBqp+ExpV1arj8Vv1DDtpL
 DHThXMypn9ca3Y30Ix3Xgxg5FDyBFhzaTuY6rg=
X-Received: by 2002:a17:903:2a90:b0:2ca:d666:df72 with SMTP id
 d9443c01a7336-2d0caa03f3bmr141578665ad.21.1785986755393; 
 Wed, 05 Aug 2026 20:25:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:25:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v7 07/24] net/pfe: use ethdev linkstatus helpers
Date: Wed,  5 Aug 2026 20:22:59 -0700
Message-ID: <20260806032544.21337-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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

