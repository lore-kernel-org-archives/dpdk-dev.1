Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FE6CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 18:48:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D49C40B94;
	Wed, 29 Apr 2026 20:47:52 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 1AAFC40A73
 for <dev@dpdk.org>; Wed, 29 Apr 2026 20:47:50 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2dee127b3c5so251273eec.1
 for <dev@dpdk.org>; Wed, 29 Apr 2026 11:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777488469;
 x=1778093269; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HpKwj4BdSL8wDNVSz7hSlFENX2M8//xZmDUFGBRWoZk=;
 b=aDw1L/3R/+gJ/9VQvTW0EfuVs+iX8yCXTIhdPZL8x2Ithzji0BmFngnSmUFLKInSa/
 tk0hlFLu8+9mUC6OiPfDrnSbmzJfR45i/AmLjYA1t8qkx0PaDcJd2vJ/e7nR7QGBgSca
 igTCsm+1WIRN70xL3/Me6zbxt5EaEhzbezTzsuuz/OCONNTYp92Xv4W0cOb8WPrKDNV0
 A6jWXWDtvxjhCrgAqD8FMJzywk+U1ZjnRBJEfRfhFug6+eexjoFbSaKFOHD3oCQ9b9PS
 KFQgVMX20egBJ6aHKg8KbZERi/WrEFoj5nhQYdXzzXBB2C6BVYdNGP4xNGgduZrqd0Rh
 n7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777488469; x=1778093269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HpKwj4BdSL8wDNVSz7hSlFENX2M8//xZmDUFGBRWoZk=;
 b=nhmQPkowPFerrfWmWlIOYY0YBT+52DNRIvw2mhJlSeAZYBZ/6e3NKnL7nYBrf7dL6c
 rzX+rf/fxCyeibaLNS4r097eSFTNEgAQtAHh/cA7uhEK65KJkM7qE9gDNHNnjkZ5y9o1
 IFyhOQhL3VXG8VbnsBtAoqVBNxzqVdvNFBCfhqLTKoo0XtT95+HxIeN2JnK0lS7FqrLO
 vSCNRw9E2+H7lu7mQwjmXsrLh5V9uQlIxOB+PeMu8tNoPHFaQ+MIHz1JqWFauOteWJdC
 Wkngeuo5mho+vYicVJSa0GgNYhD6z2I+xoCklHtQwQbM/PpXzO4hWBLg7XlZdPCTDlDE
 UZ/w==
X-Gm-Message-State: AOJu0YxURxKc9jGdc2VZ5srBNlI2ES8/ENqOOb0HM6l3K1EEeeW67SAZ
 2maYh9qHLR1rHKm3oxsGKKf3kIo3DARgFSD+qhVEEtuhpgi3Hoqfma37VuF1aa3PVDpC7AMU9CA
 ZPWEJ
X-Gm-Gg: AeBDietzIeWOlXt09dyYSLkcpgXWlPciF+WRwV8IAD4AcbNyPoA0RtmGLIr/wtZizxZ
 3F3UoUrayfjr8SS7I+MyLaszp4PVqVpX2SkmFTpYAMQeaLdSIep0IRl09wwZKTELdTKOcmjnHQf
 IouzZFsSoZV5yMzmEnTZRg8xwrmlzKocGH37Q18yMBrxxrUi+DWEd/PZtly/hY64Zd5vVgT5naZ
 Opj3DCCYVYmyzJ3zg+wQGy8YxP3mnG33EEA/2Co8GdplAtHaLppwqMa8cDI6sIWr6vQsb2VWH5x
 TfuZGpa6BLN9ScYSMspTwHYiHtqfwvnXJe1dV9uM2PCxpKv4wTVQkectntcP1gn0GVSU/hh6JjJ
 pJQoGONmG2VbUj/l6w7/TpUvN7NW4rYN1fZvOFvKhpGpuH+9ehZE/v3w3Y4XxOtTxP0JWLj+ITK
 1s9jwIkqCbTaj6FTJs9Zr2yDjaFpHTYWBWd4hExoNLVrE=
X-Received: by 2002:a05:7300:22c6:b0:2ed:27a3:eae2 with SMTP id
 5a478bee46e88-2ed27a3eb1bmr525389eec.15.1777488468997; 
 Wed, 29 Apr 2026 11:47:48 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c09ca30sm3271027eec.24.2026.04.29.11.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 11:47:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Ravi Kumar <ravi1.kumar@amd.com>
Subject: [PATCH v3 5/7] net/axgbe: fix mutexes for multi-process
Date: Wed, 29 Apr 2026 11:46:42 -0700
Message-ID: <20260429184739.706250-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429184739.706250-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260429184739.706250-1-stephen@networkplumber.org>
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

The AXGBE driver supports secondary processes. The xpcs_mutex,
i2c_mutex, an_mutex and phy_mutex in axgbe_port live in dev_private
(shared memory) and must be initialized with PTHREAD_PROCESS_SHARED.

Also, make headers use standard <> format when accessing
DPDK EAL includes.

Bugzilla ID: 662
Fixes: 572890ef6625 ("net/axgbe: add structs for MAC init and reset")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/axgbe/axgbe_ethdev.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index cfcd880961..9491f18b7c 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -8,10 +8,10 @@
 #include "axgbe_common.h"
 #include "axgbe_phy.h"
 #include "axgbe_regs.h"
-#include "rte_time.h"
-
-#include "eal_filesystem.h"
 
+#include <rte_thread.h>
+#include <rte_time.h>
+#include <eal_filesystem.h>
 #include <rte_vect.h>
 
 #ifdef RTE_ARCH_X86
@@ -2419,10 +2419,10 @@ eth_axgbe_dev_init(struct rte_eth_dev *eth_dev)
 
 	pdata->tx_desc_count = AXGBE_MAX_RING_DESC;
 	pdata->rx_desc_count = AXGBE_MAX_RING_DESC;
-	pthread_mutex_init(&pdata->xpcs_mutex, NULL);
-	pthread_mutex_init(&pdata->i2c_mutex, NULL);
-	pthread_mutex_init(&pdata->an_mutex, NULL);
-	pthread_mutex_init(&pdata->phy_mutex, NULL);
+	rte_thread_mutex_init_shared(&pdata->xpcs_mutex);
+	rte_thread_mutex_init_shared(&pdata->i2c_mutex);
+	rte_thread_mutex_init_shared(&pdata->an_mutex);
+	rte_thread_mutex_init_shared(&pdata->phy_mutex);
 
 	ret = pdata->phy_if.phy_init(pdata);
 	if (ret) {
-- 
2.53.0

