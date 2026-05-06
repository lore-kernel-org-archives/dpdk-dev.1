Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F065CD3436
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 12:36:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5A8740652;
	Wed,  6 May 2026 14:36:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 797CF40395
 for <dev@dpdk.org>; Wed,  6 May 2026 14:36:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778070976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dPfTOhPmd7mTjDaqzfVMNwDzzLpmG3qG6znDGhlVxFw=;
 b=B+e983Hax2wZiUiaKKu7G866PaQ4ZcQYb7lM+rShI5EyFKi1QO7c4kDODpxr8kBvgbWLL+
 Y3+C6QwNPWIEXJA8yV2wyZaMuMAy4G55w4MBddhuOGAJp2p0Qckv9TRGFRsx9ia1aewmOB
 m2WEO3EjITHYj0zmG9BhsOAYe94PpZM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-iLRHbug5NcaJn4yrHQwFZw-1; Wed,
 06 May 2026 08:36:10 -0400
X-MC-Unique: iLRHbug5NcaJn4yrHQwFZw-1
X-Mimecast-MFC-AGG-ID: iLRHbug5NcaJn4yrHQwFZw_1778070969
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 938DD195609E; Wed,  6 May 2026 12:36:08 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.242])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E3091944CC4; Wed,  6 May 2026 12:36:05 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 1/5] ethdev: skip VMDq pools unless configured
Date: Wed,  6 May 2026 14:35:49 +0200
Message-ID: <20260506123554.2524136-2-david.marchand@redhat.com>
In-Reply-To: <20260506123554.2524136-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260506123554.2524136-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zHGmLDAtAODz4T8l9-vZTmv3p5oP7ifKPBvSSwTZyQQ_1778070969
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

The mac_addr_add API describes that only the 0 pool should be passed
unless VMDq has been enabled, though there was no validation so far.
Add such a check, then cleanup the related operations (adding, removing,
restoring).

As a side effect, the net/cnxk does not need to manually reset the
mac_pool_sel[] array.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/cnxk/cnxk_ethdev_ops.c |  1 -
 lib/ethdev/rte_ethdev.c            | 28 +++++++++++++++++++++-------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev_ops.c b/drivers/net/cnxk/cnxk_ethdev_ops.c
index 49e77e49a6..75decf7098 100644
--- a/drivers/net/cnxk/cnxk_ethdev_ops.c
+++ b/drivers/net/cnxk/cnxk_ethdev_ops.c
@@ -1240,7 +1240,6 @@ cnxk_nix_mc_addr_list_configure(struct rte_eth_dev *eth_dev, struct rte_ether_ad
 		/* Update address in NIC data structure */
 		rte_ether_addr_copy(&mc_addr_set[i], &data->mac_addrs[j]);
 		rte_ether_addr_copy(&mc_addr_set[i], &dev->dmac_addrs[j]);
-		data->mac_pool_sel[j] = RTE_BIT64(0);
 	}
 
 	roc_nix_npc_promisc_ena_dis(nix, true);
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 2edc7a362e..9577b7d848 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -1680,7 +1680,10 @@ eth_dev_mac_restore(struct rte_eth_dev *dev,
 				continue;
 
 			pool = 0;
-			pool_mask = dev->data->mac_pool_sel[i];
+			if ((dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) != 0)
+				pool_mask = dev->data->mac_pool_sel[i];
+			else
+				pool_mask = 1;
 
 			do {
 				if (pool_mask & UINT64_C(1))
@@ -5390,8 +5393,9 @@ rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *addr,
 			uint32_t pool)
 {
 	struct rte_eth_dev *dev;
-	int index;
 	uint64_t pool_mask;
+	bool vmdq;
+	int index;
 	int ret;
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
@@ -5416,6 +5420,12 @@ rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *addr,
 		RTE_ETHDEV_LOG_LINE(ERR, "Pool ID must be 0-%d", RTE_ETH_64_POOLS - 1);
 		return -EINVAL;
 	}
+	vmdq = (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) != 0;
+	if (!vmdq && pool != 0) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Port %u: VMDq is not configured (pool %d)",
+			port_id, pool);
+		return -EINVAL;
+	}
 
 	index = eth_dev_get_mac_addr_index(port_id, addr);
 	if (index < 0) {
@@ -5425,7 +5435,7 @@ rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *addr,
 				port_id);
 			return -ENOSPC;
 		}
-	} else {
+	} else if (vmdq) {
 		pool_mask = dev->data->mac_pool_sel[index];
 
 		/* Check if both MAC address and pool is already there, and do nothing */
@@ -5440,8 +5450,10 @@ rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *addr,
 		/* Update address in NIC data structure */
 		rte_ether_addr_copy(addr, &dev->data->mac_addrs[index]);
 
-		/* Update pool bitmap in NIC data structure */
-		dev->data->mac_pool_sel[index] |= RTE_BIT64(pool);
+		if (vmdq) {
+			/* Update pool bitmap in NIC data structure */
+			dev->data->mac_pool_sel[index] |= RTE_BIT64(pool);
+		}
 	}
 
 	ret = eth_err(port_id, ret);
@@ -5486,8 +5498,10 @@ rte_eth_dev_mac_addr_remove(uint16_t port_id, struct rte_ether_addr *addr)
 	/* Update address in NIC data structure */
 	rte_ether_addr_copy(&null_mac_addr, &dev->data->mac_addrs[index]);
 
-	/* reset pool bitmap */
-	dev->data->mac_pool_sel[index] = 0;
+	if ((dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) != 0) {
+		/* reset pool bitmap */
+		dev->data->mac_pool_sel[index] = 0;
+	}
 
 	rte_ethdev_trace_mac_addr_remove(port_id, addr);
 
-- 
2.53.0

