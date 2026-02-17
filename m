Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7D0E6816B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 11:03:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1245C40430;
	Tue, 17 Feb 2026 12:03:29 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 92C9D402A2
 for <dev@dpdk.org>; Tue, 17 Feb 2026 12:03:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771326206;
 bh=CbPyMwuwYy3k4jwacnnY3BHmbIF2GUgGK8YrR0oCTi0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VrFVmlEZgW/1hkgfT+UaWXjADz7dZIXa3qhyhIwWuSFBujN8QiGjydByFdK2489Yl
 nYpnQB2YRkbORnTbzMbBxtfjV/r2LMFacMTFS1xH11HAWNsfKMYmdf6oKCZj4n6bS3
 HsoND0Z6fD7I0+oDhm64eL/jmhb9oDl9XUsz2bosAvziAZH7vQmU3iIO6D1DG7Q4Ax
 xu4zLJGDQgj0fkgQ9UJL0+X6Y+7VaTErlC3jfhNyBq0WF6yS4vbdujJSB1rSoqQwLj
 LUZClPVhlWK3Z9THArX4tSa2jfuJItfIzCyuISAsscctSc1QC4mi+05mutZlEPsJJI
 +8rBnNTRsMqIw==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 5C368118013E;
 Tue, 17 Feb 2026 12:03:26 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v2 1/6] net/nfb: use MAC address assigned to card
Date: Tue, 17 Feb 2026 12:03:19 +0100
Message-ID: <20260217110324.3344310-2-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217110324.3344310-1-spinler@cesnet.cz>
References: <20260206170435.302184-1-spinler@cesnet.cz>
 <20260217110324.3344310-1-spinler@cesnet.cz>
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

From: Martin Spinler <spinler@cesnet.cz>

Check for a specific MAC address assigned to a card.
If there is no assigned MAC address, then use a random MAC as fallback.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb_ethdev.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 9737ccc65b..b99785cc22 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -11,6 +11,7 @@
 
 #include <nfb/nfb.h>
 #include <nfb/ndp.h>
+#include <netcope/eth.h>
 #include <netcope/rxmac.h>
 #include <netcope/txmac.h>
 
@@ -665,10 +666,14 @@ nfb_eth_dev_init(struct rte_eth_dev *dev, void *init_data)
 			goto err_malloc_mac_addrs;
 		}
 
-		rte_eth_random_addr(eth_addr_init.addr_bytes);
-		eth_addr_init.addr_bytes[0] = eth_addr.addr_bytes[0];
-		eth_addr_init.addr_bytes[1] = eth_addr.addr_bytes[1];
-		eth_addr_init.addr_bytes[2] = eth_addr.addr_bytes[2];
+		ret = nc_ifc_get_default_mac(internals->nfb, ifc->id, eth_addr_init.addr_bytes,
+			sizeof(eth_addr_init.addr_bytes));
+		if (ret != 0) {
+			rte_eth_random_addr(eth_addr_init.addr_bytes);
+			eth_addr_init.addr_bytes[0] = eth_addr.addr_bytes[0];
+			eth_addr_init.addr_bytes[1] = eth_addr.addr_bytes[1];
+			eth_addr_init.addr_bytes[2] = eth_addr.addr_bytes[2];
+		}
 
 		nfb_eth_mac_addr_set(dev, &eth_addr_init);
 		rte_ether_addr_copy(&eth_addr_init, &data->mac_addrs[0]);
-- 
2.53.0

