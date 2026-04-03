Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0BEE7E345
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 09:18:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 016AC40E26;
	Fri,  3 Apr 2026 11:18:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CEF0E4028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 11:18:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775207934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dPfTOhPmd7mTjDaqzfVMNwDzzLpmG3qG6znDGhlVxFw=;
 b=A5XUt7YgUgLcu9z3JcwjUy83Fa/gCENi6KqZ8k1xt26KOj4ySSja5d+X1tOtMKYsVeGV2i
 Ik1zmtKj60na3L4rWcte6SB1gkyFo6jf0a/W6LLVOEem+UzePuJI3bbgEgSnK6ITK27j5q
 mbXr5LdQhv1AETkosdivzk3ftM1AtUo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-tVgBVxFZN9Cui47iDtUrNg-1; Fri,
 03 Apr 2026 05:18:50 -0400
X-MC-Unique: tVgBVxFZN9Cui47iDtUrNg-1
X-Mimecast-MFC-AGG-ID: tVgBVxFZN9Cui47iDtUrNg_1775207929
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C07B19560A7; Fri,  3 Apr 2026 09:18:49 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.35])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6BD9430002D2; Fri,  3 Apr 2026 09:18:45 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 1/4] ethdev: skip VMDq pools unless configured
Date: Fri,  3 Apr 2026 11:18:32 +0200
Message-ID: <20260403091836.1073484-2-david.marchand@redhat.com>
In-Reply-To: <20260403091836.1073484-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7IZdc0yPmZWd9TN-CXrC9ApjzBqSf8-6yADDItvUF80_1775207929
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

