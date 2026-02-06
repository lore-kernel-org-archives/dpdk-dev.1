Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCC7EE20B9
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 17:04:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A0284060A;
	Fri,  6 Feb 2026 18:04:41 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 51D9B40276
 for <dev@dpdk.org>; Fri,  6 Feb 2026 18:04:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770397479;
 bh=wgeVlo8IdwPSBjleyjodzVsnx/Fjb/PPXHT/KIC2RPg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BAj0RrFhDktnBPfVd6QxtoAQzQTwoq/QRHPDm75M8HUYTIwtR8nrax4rg6QUbGKAM
 Ub7qY2sQ/rOB+VB01URtGHMk8lwNcI3nojq4X/TwU3aZFGY5k0KpV9kruR0w0E/Kyw
 RkGEYqnLZ601KKT/D7a70aonY8OMYAw8SgG3/r7owc2lBTQ4ZPdXvcvlmbNP66dv7b
 N3phsxVkwDOSjGlgz3f1HQxiHmbcw3FkVJw1eZkAaiJqsQNSuza7fAQ/iUQlQZUdkI
 U4pqBtcsO54a4EmBIAwhKAFxNZWeitS5oeoyi2pu43Hbtq8EIAi1o4hub1mPXaDEYF
 fR3gNlFlJhn1Q==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 0FF70118007E;
 Fri,  6 Feb 2026 18:04:39 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH 1/7] net/nfb: use MAC address assigned to card
Date: Fri,  6 Feb 2026 18:04:29 +0100
Message-ID: <20260206170435.302184-2-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206170435.302184-1-spinler@cesnet.cz>
References: <20260206170435.302184-1-spinler@cesnet.cz>
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
index 157f04a891..ca3dbad879 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -11,6 +11,7 @@
 
 #include <nfb/nfb.h>
 #include <nfb/ndp.h>
+#include <netcope/eth.h>
 #include <netcope/rxmac.h>
 #include <netcope/txmac.h>
 
@@ -639,10 +640,14 @@ nfb_eth_dev_init(struct rte_eth_dev *dev, void *init_data)
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

