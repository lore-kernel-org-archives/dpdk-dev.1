Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AFDCD37B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 10 May 2026 17:03:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C84B40649;
	Sun, 10 May 2026 19:03:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 27BDB4060F
 for <dev@dpdk.org>; Sun, 10 May 2026 19:03:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778432606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jm3x8PVV6n5pp+VMlFRRZMUjsmbN6Zb5X+wp3xlyebI=;
 b=A71wlSldT8NOicosd2rGQ/Tcl8iGLg2pVAx60oQs6G7IjZDVjFlchQy9HNOb6O0buKWUYo
 mFH0wCqXUpeffTe9BYTSG1CzKYoDB0fkNtk+MbmoxYB2w3VJo0OUwR9c1UUdgGPFYATG3W
 hU74bP95y45wjZrXXmNleV2rgkcAQU8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-N61jNRetPnS8edCsfkUfiw-1; Sun,
 10 May 2026 13:03:24 -0400
X-MC-Unique: N61jNRetPnS8edCsfkUfiw-1
X-Mimecast-MFC-AGG-ID: N61jNRetPnS8edCsfkUfiw_1778432603
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2EB61800578; Sun, 10 May 2026 17:03:22 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.242])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6742730001BE; Sun, 10 May 2026 17:03:19 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 2/5] ethdev: skip VMDq pools unless configured
Date: Sun, 10 May 2026 19:03:02 +0200
Message-ID: <20260510170306.3406045-3-david.marchand@redhat.com>
In-Reply-To: <20260510170306.3406045-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260510170306.3406045-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2BS4MdtDtR7awDngcLhg5NXKzX0kvfUhYurh3zlLDeo_1778432603
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
Add such a check, then cleanup the MAC related operations (adding,
removing, restoring).

As a side effect, the net/cnxk does not need to manually reset the
mac_pool_sel[] array.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v2:
- added an entry in release notes,
- fixed duplicate mac address handling for !vmdq,
- rewrote update of eth_dev_mac_restore to isolate the !vmdq case,

---
 doc/guides/rel_notes/release_26_07.rst |  2 +
 drivers/net/cnxk/cnxk_ethdev_ops.c     |  1 -
 lib/ethdev/rte_ethdev.c                | 52 ++++++++++++++++++--------
 3 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index b59793f177..3d2e71102b 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -97,6 +97,8 @@ API Changes
   * At port configuration time, the number of VMDq pools advertised by a driver is now used to
     validate VMDq related Rx and Tx modes (``RTE_ETH_MQ_RX_VMDQ_FLAG``, ``RTE_ETH_MQ_TX_VMDQ_DCB``,
     ``RTE_ETH_MQ_TX_VMDQ_ONLY``).
+  * A check was added in ``rte_eth_dev_mac_addr_add`` to validate that the ``pool`` parameter is 0
+    when VMDq is not configured.
 
 
 ABI Changes
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
index eae34954e2..a628a7661a 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -1677,7 +1677,7 @@ eth_dev_mac_restore(struct rte_eth_dev *dev,
 {
 	struct rte_ether_addr *addr;
 	uint16_t i;
-	uint32_t pool = 0;
+	uint32_t pool;
 	uint64_t pool_mask;
 
 	/* replay MAC address configuration including default MAC */
@@ -1685,9 +1685,11 @@ eth_dev_mac_restore(struct rte_eth_dev *dev,
 	if (dev->dev_ops->mac_addr_set != NULL)
 		dev->dev_ops->mac_addr_set(dev, addr);
 	else if (dev->dev_ops->mac_addr_add != NULL)
-		dev->dev_ops->mac_addr_add(dev, addr, 0, pool);
+		dev->dev_ops->mac_addr_add(dev, addr, 0, 0);
 
 	if (dev->dev_ops->mac_addr_add != NULL) {
+		bool vmdq = (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) != 0;
+
 		for (i = 1; i < dev_info->max_mac_addrs; i++) {
 			addr = &dev->data->mac_addrs[i];
 
@@ -1695,15 +1697,19 @@ eth_dev_mac_restore(struct rte_eth_dev *dev,
 			if (rte_is_zero_ether_addr(addr))
 				continue;
 
-			pool = 0;
-			pool_mask = dev->data->mac_pool_sel[i];
-
-			do {
-				if (pool_mask & UINT64_C(1))
-					dev->dev_ops->mac_addr_add(dev, addr, i, pool);
-				pool_mask >>= 1;
-				pool++;
-			} while (pool_mask);
+			if (!vmdq) {
+				dev->dev_ops->mac_addr_add(dev, addr, i, 0);
+			} else {
+				pool = 0;
+				pool_mask = dev->data->mac_pool_sel[i];
+
+				do {
+					if (pool_mask & UINT64_C(1))
+						dev->dev_ops->mac_addr_add(dev, addr, i, pool);
+					pool_mask >>= 1;
+					pool++;
+				} while (pool_mask);
+			}
 		}
 	}
 }
@@ -5406,8 +5412,9 @@ rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *addr,
 			uint32_t pool)
 {
 	struct rte_eth_dev *dev;
-	int index;
 	uint64_t pool_mask;
+	bool vmdq;
+	int index;
 	int ret;
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
@@ -5432,6 +5439,12 @@ rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *addr,
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
@@ -5442,6 +5455,9 @@ rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *addr,
 			return -ENOSPC;
 		}
 	} else {
+		if (!vmdq)
+			return 0;
+
 		pool_mask = dev->data->mac_pool_sel[index];
 
 		/* Check if both MAC address and pool is already there, and do nothing */
@@ -5456,8 +5472,10 @@ rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *addr,
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
@@ -5502,8 +5520,10 @@ rte_eth_dev_mac_addr_remove(uint16_t port_id, struct rte_ether_addr *addr)
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

