Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094DEC02199
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 23:22:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D267B40280;
	Sat,  8 Feb 2025 00:22:03 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id E27BC40270;
 Sat,  8 Feb 2025 00:22:01 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id CFD6D210730A; Fri,  7 Feb 2025 15:22:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CFD6D210730A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1738970520;
 bh=xHqc/FEDVAzK85ZgH0ekdP2faYBKRyeNqw7qWXiiawI=;
 h=From:To:Cc:Subject:Date:From;
 b=tFKPcctUoGwulOcpVW0+Pgtj1bP51yGj0hivhPZcEoHSSuVlVG5/JLHsgzRZ3JFso
 +IKH2kOgOKqy5NlX/pvPPMsJlLRqH4TZcUSSKdtnrAxAr2+7urtG2ApDk4XpYcJXpG
 bPbL4958Z+7vhwEUD7sbzKIGwDHI+EhD2xerfqTo=
From: longli@linuxonhyperv.com
To: Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>,
	stable@dpdk.org
Subject: [PATCH] net/mana: use mana_local_data for tracking usage data for
 primary process
Date: Fri,  7 Feb 2025 15:21:45 -0800
Message-Id: <1738970505-7864-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
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

From: Long Li <longli@microsoft.com>

The driver uses mana_shared_data for tracking usage count for primary
process. This is not correct as the mana_shared_data is allocated
by the primary and is meant to track usage of secondary process by the
primary process. And it creates a race condition when the device is
removed because the counter is no longer available if this shared
memory is being freed.

Move the usage count tracking to mana_local_data and fix the race
condition in mana_pci_remove().

Fixes: 517ed6e2d590 ("net/mana: add basic driver with build environment")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/mana/mana.c | 76 ++++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index c37c4e3444..da4a54144f 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -1167,8 +1167,12 @@ mana_init_shared_data(void)
 	rte_spinlock_lock(&mana_shared_data_lock);
 
 	/* Skip if shared data is already initialized */
-	if (mana_shared_data)
+	if (mana_shared_data) {
+		DRV_LOG(INFO, "shared data is already initialized");
 		goto exit;
+	}
+
+	memset(&mana_local_data, 0, sizeof(mana_local_data));
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		mana_shared_mz = rte_memzone_reserve(MZ_MANA_SHARED_DATA,
@@ -1192,7 +1196,6 @@ mana_init_shared_data(void)
 		}
 
 		mana_shared_data = secondary_mz->addr;
-		memset(&mana_local_data, 0, sizeof(mana_local_data));
 	}
 
 exit:
@@ -1213,11 +1216,11 @@ mana_init_once(void)
 	if (ret)
 		return ret;
 
-	rte_spinlock_lock(&mana_shared_data->lock);
+	rte_spinlock_lock(&mana_shared_data_lock);
 
 	switch (rte_eal_process_type()) {
 	case RTE_PROC_PRIMARY:
-		if (mana_shared_data->init_done)
+		if (mana_local_data.init_done)
 			break;
 
 		ret = mana_mp_init_primary();
@@ -1225,7 +1228,7 @@ mana_init_once(void)
 			break;
 		DRV_LOG(ERR, "MP INIT PRIMARY");
 
-		mana_shared_data->init_done = 1;
+		mana_local_data.init_done = 1;
 		break;
 
 	case RTE_PROC_SECONDARY:
@@ -1248,7 +1251,7 @@ mana_init_once(void)
 		break;
 	}
 
-	rte_spinlock_unlock(&mana_shared_data->lock);
+	rte_spinlock_unlock(&mana_shared_data_lock);
 
 	return ret;
 }
@@ -1319,11 +1322,6 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 		eth_dev->tx_pkt_burst = mana_tx_burst;
 		eth_dev->rx_pkt_burst = mana_rx_burst;
 
-		rte_spinlock_lock(&mana_shared_data->lock);
-		mana_shared_data->secondary_cnt++;
-		mana_local_data.secondary_cnt++;
-		rte_spinlock_unlock(&mana_shared_data->lock);
-
 		rte_eth_copy_pci_info(eth_dev, pci_dev);
 		rte_eth_dev_probing_finish(eth_dev);
 
@@ -1406,10 +1404,6 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 		goto failed;
 	}
 
-	rte_spinlock_lock(&mana_shared_data->lock);
-	mana_shared_data->primary_cnt++;
-	rte_spinlock_unlock(&mana_shared_data->lock);
-
 	eth_dev->device = &pci_dev->device;
 
 	DRV_LOG(INFO, "device %s at port %u", name, eth_dev->data->port_id);
@@ -1552,13 +1546,42 @@ mana_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 		count = mana_pci_probe_mac(pci_dev, NULL);
 	}
 
+	/* If no device is found, clean up resources if this is the last one */
 	if (!count) {
-		rte_memzone_free(mana_shared_mz);
-		mana_shared_mz = NULL;
-		ret = -ENODEV;
+		rte_spinlock_lock(&mana_shared_data_lock);
+		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+			if (!mana_local_data.primary_cnt) {
+				mana_mp_uninit_primary();
+				rte_memzone_free(mana_shared_mz);
+				mana_shared_mz = NULL;
+				mana_shared_data = NULL;
+			}
+		} else {
+			if (!mana_local_data.secondary_cnt) {
+				mana_mp_uninit_secondary();
+				mana_shared_data = NULL;
+			}
+		}
+		rte_spinlock_unlock(&mana_shared_data_lock);
+		return -ENODEV;
 	}
 
-	return ret;
+	/* At least one eth_dev is probed, init shared data */
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		rte_spinlock_lock(&mana_shared_data_lock);
+		mana_local_data.primary_cnt++;
+		rte_spinlock_unlock(&mana_shared_data_lock);
+	} else {
+		rte_spinlock_lock(&mana_shared_data_lock);
+		mana_local_data.secondary_cnt++;
+		rte_spinlock_unlock(&mana_shared_data_lock);
+
+		rte_spinlock_lock(&mana_shared_data->lock);
+		mana_shared_data->secondary_cnt++;
+		rte_spinlock_unlock(&mana_shared_data->lock);
+	}
+
+	return 0;
 }
 
 static int
@@ -1576,22 +1599,18 @@ mana_pci_remove(struct rte_pci_device *pci_dev)
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		rte_spinlock_lock(&mana_shared_data_lock);
 
-		rte_spinlock_lock(&mana_shared_data->lock);
+		RTE_VERIFY(mana_local_data.primary_cnt > 0);
+		mana_local_data.primary_cnt--;
 
-		RTE_VERIFY(mana_shared_data->primary_cnt > 0);
-		mana_shared_data->primary_cnt--;
-		if (!mana_shared_data->primary_cnt) {
+		if (!mana_local_data.primary_cnt) {
 			DRV_LOG(DEBUG, "mp uninit primary");
 			mana_mp_uninit_primary();
-		}
-
-		rte_spinlock_unlock(&mana_shared_data->lock);
 
-		/* Also free the shared memory if this is the last */
-		if (!mana_shared_data->primary_cnt) {
+			/* Also free the shared memory if this is the last */
 			DRV_LOG(DEBUG, "free shared memezone data");
 			rte_memzone_free(mana_shared_mz);
 			mana_shared_mz = NULL;
+			mana_shared_data = NULL;
 		}
 
 		rte_spinlock_unlock(&mana_shared_data_lock);
@@ -1608,6 +1627,7 @@ mana_pci_remove(struct rte_pci_device *pci_dev)
 		if (!mana_local_data.secondary_cnt) {
 			DRV_LOG(DEBUG, "mp uninit secondary");
 			mana_mp_uninit_secondary();
+			mana_shared_data = NULL;
 		}
 
 		rte_spinlock_unlock(&mana_shared_data_lock);
-- 
2.34.1

