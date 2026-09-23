Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C3CC982FE
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 01:09:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D7B942EF4;
	Wed, 23 Sep 2026 03:08:14 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mails.dpdk.org (Postfix) with ESMTP id 1FEA142EEC
 for <dev@dpdk.org>; Wed, 23 Sep 2026 03:08:10 +0200 (CEST)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d6df0a1e18so4260455ad.1
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790125690; x=1790730490; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yaw34uANE1kdCOoEY7/RdQqjWYFpNLOTmdPs3HaLIos=;
 b=X17C+00ioN0vVCuzIYcfEER1vLPzFbZrkVKiyRML8h6Zj+hLAU4m22/2k2/TwrWkON
 8Mft4DMCNA0PiEweqexveYgiavGMUatPan8U5n0geH/FMsIhYi9GFIq1UbSajGPWG+wq
 U1RCV5tXOwL9MDSOSYYxtRy2qKYZaw9T5G8NGeE7EloGfjR0yZlCb1N82EzvLlgBFx1W
 0+HZl+QKb0NTQI8wcs4VJLS11Ik/s+X2a66U400OleUcEjhORgCjtW7+8C/0J3XGhkSN
 UEJN8oW0u5mfH4Fvej2yXAw/VjevF63Ql/26hfxfOe7j5OU/Tyz5Yt7kdzXr6yAUkwm+
 X3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790125690; x=1790730490;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yaw34uANE1kdCOoEY7/RdQqjWYFpNLOTmdPs3HaLIos=;
 b=DB6ibtNImVcfqC5G9KkrZauH6lT9xxpWI78XWDCegM6pPJZ7InoPVtdbIssEc+P0ZI
 /3FU2rKUOqW6Z60fzbLFTfL+lcDcZcoDDdnV1zfF7fkZ1H/XQtnwvy6J3+uzaqfUbXDZ
 kFQL3GNc6MO86c0F+ZLFU+YfBdlnHREj6W0bMn4mvdkSw1f8W9H7xa5RCzf8IlkdVyNs
 xyi76I8UpEzpbOVICqR1qxG/J/rpN+TiXglh+GVoJGzlvAsbvGRZbtEWXGnVzf6r5o7S
 THqyVsqMkiaJ/qgWnorfNRSTSWAaIpPd1cRAHnoDLmIyeuhXPR3VWnynIuhEAPmznxxB
 asnA==
X-Gm-Message-State: AFuF++kJ0q+BXCNpGq/mrvqexbeE8fvKYaWcOqbpb95kLEYSswuWSDvf
 gWaZkvJhD84dtQlphTBnJIsW3a4i4oAE6x4XQRiZ5TA2q26aCM20zKVWNVNnLC14ZeWb+KyMXiv
 u/x17mI3+QKKZOg==
X-Received: from plao17.prod.google.com ([2002:a17:903:3011:b0:2df:4aa4:16d4])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f686:b0:2df:69e3:7395 with SMTP id
 d9443c01a7336-2df69e374admr9686955ad.18.1790125689812; 
 Tue, 22 Sep 2026 18:08:09 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:07:37 -0700
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923010742.2468145-15-joshwash@google.com>
Subject: [PATCH v3 14/16] app/procinfo: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Reshma Pattan <reshma.pattan@intel.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/proc-info/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index 5925bbb765..9c22fb8f01 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -48,7 +48,6 @@
 
 #define ETHDEV_FWVERS_LEN 32
 #define RTE_RETA_CONF_GROUP_NUM 32
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define EEPROM_DUMP_CHUNKSIZE 1024
 
 #define STATS_BDR_FMT "========================================"
@@ -1830,7 +1829,7 @@ show_port_rss_reta_info(void)
 			return;
 		}
 
-		num = DIV_ROUND_UP(dev_info.reta_size, RTE_ETH_RETA_GROUP_SIZE);
+		num = RTE_DIV_ROUND_UP(dev_info.reta_size, RTE_ETH_RETA_GROUP_SIZE);
 		memset(reta_conf, 0, sizeof(reta_conf));
 		for (i = 0; i < num; i++)
 			reta_conf[i].mask = ~0ULL;
-- 
2.55.0.1082.g2b9226bbc0-goog

