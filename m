Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BE0C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 23:32:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FF94402A8;
	Fri, 21 Feb 2025 00:32:07 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 407E24026D
 for <dev@dpdk.org>; Fri, 21 Feb 2025 00:32:05 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 879D7205A9C4; Thu, 20 Feb 2025 15:32:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 879D7205A9C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1740094324;
 bh=EbBl4xuQJVMotl3EtVSHAKomy2/VKs7EsNZHmqN0c0A=;
 h=From:To:Cc:Subject:Date:From;
 b=iYe7PyyJt5x6e+vDVREGA0mvgJfPlpt6sQpI/IT31WiSKODqC9lcYg3zG9Nns+vfy
 zAOTGK00xocTFNVVD25kxY9DAAvf2CmFAjJckV05UwRBa8d//s8qxCQxn9EzeY8tmt
 MGr05wguRGKH4/n90rO43VYWLI5DPuQfHiZXSgIU=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v3] net/mana: use mana_local_data for tracking usage data for
 primary process
Date: Thu, 20 Feb 2025 15:32:02 -0800
Message-Id: <1740094322-10919-1-git-send-email-longli@linuxonhyperv.com>
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
memory is freed.

Move the usage count tracking to mana_local_data and fix the race
condition in mana_pci_remove().

Fixes: 517ed6e2d590 ("net/mana: add basic driver with build environment")
Signed-off-by: Long Li <longli@microsoft.com>
---
Changes:
v2: use atomic variable to track the secondary_cnt in shared memory, remove the spinlock for shared memory
v3: use RTE_ATOMIC and stdatomic for atomic

 drivers/net/mana/mana.c | 99 +++++++++++++++++++++++------------------
 drivers/net/mana/mana.h |  6 +--
 drivers/net/mana/mp.c   |  2 +-
 3 files changed, 57 insertions(+), 50 deletions(-)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index c37c4e3444..d53dd9faa7 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -23,9 +23,14 @@
 #include "mana.h"
 
 /* Shared memory between primary/secondary processes, per driver */
-/* Data to track primary/secondary usage */
 struct mana_shared_data *mana_shared_data;
-static struct mana_shared_data mana_local_data;
+
+/* Local data to track device instance usage for primary/secondary processes */
+static struct mana_local_data {
+	int init_done;
+	unsigned int primary_cnt;
+	unsigned int secondary_cnt;
+} mana_local_data;
 
 /* The memory region for the above data */
 static const struct rte_memzone *mana_shared_mz;
@@ -1167,8 +1172,12 @@ mana_init_shared_data(void)
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
@@ -1181,8 +1190,7 @@ mana_init_shared_data(void)
 		}
 
 		mana_shared_data = mana_shared_mz->addr;
-		memset(mana_shared_data, 0, sizeof(*mana_shared_data));
-		rte_spinlock_init(&mana_shared_data->lock);
+		rte_atomic_store_explicit(&mana_shared_data->secondary_cnt, 0, rte_memory_order_relaxed);
 	} else {
 		secondary_mz = rte_memzone_lookup(MZ_MANA_SHARED_DATA);
 		if (!secondary_mz) {
@@ -1192,7 +1200,6 @@ mana_init_shared_data(void)
 		}
 
 		mana_shared_data = secondary_mz->addr;
-		memset(&mana_local_data, 0, sizeof(mana_local_data));
 	}
 
 exit:
@@ -1213,11 +1220,11 @@ mana_init_once(void)
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
@@ -1225,7 +1232,7 @@ mana_init_once(void)
 			break;
 		DRV_LOG(ERR, "MP INIT PRIMARY");
 
-		mana_shared_data->init_done = 1;
+		mana_local_data.init_done = 1;
 		break;
 
 	case RTE_PROC_SECONDARY:
@@ -1248,7 +1255,7 @@ mana_init_once(void)
 		break;
 	}
 
-	rte_spinlock_unlock(&mana_shared_data->lock);
+	rte_spinlock_unlock(&mana_shared_data_lock);
 
 	return ret;
 }
@@ -1319,11 +1326,6 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 		eth_dev->tx_pkt_burst = mana_tx_burst;
 		eth_dev->rx_pkt_burst = mana_rx_burst;
 
-		rte_spinlock_lock(&mana_shared_data->lock);
-		mana_shared_data->secondary_cnt++;
-		mana_local_data.secondary_cnt++;
-		rte_spinlock_unlock(&mana_shared_data->lock);
-
 		rte_eth_copy_pci_info(eth_dev, pci_dev);
 		rte_eth_dev_probing_finish(eth_dev);
 
@@ -1406,10 +1408,6 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 		goto failed;
 	}
 
-	rte_spinlock_lock(&mana_shared_data->lock);
-	mana_shared_data->primary_cnt++;
-	rte_spinlock_unlock(&mana_shared_data->lock);
-
 	eth_dev->device = &pci_dev->device;
 
 	DRV_LOG(INFO, "device %s at port %u", name, eth_dev->data->port_id);
@@ -1552,13 +1550,37 @@ mana_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
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
+	/* At least one eth_dev is probed, increase counter for shared data */
+	rte_spinlock_lock(&mana_shared_data_lock);
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		mana_local_data.primary_cnt++;
+	} else {
+		rte_atomic_fetch_add_explicit(&mana_shared_data->secondary_cnt, 1, rte_memory_order_relaxed);
+		mana_local_data.secondary_cnt++;
+	}
+	rte_spinlock_unlock(&mana_shared_data_lock);
+
+	return 0;
 }
 
 static int
@@ -1573,45 +1595,34 @@ mana_dev_uninit(struct rte_eth_dev *dev)
 static int
 mana_pci_remove(struct rte_pci_device *pci_dev)
 {
+	rte_spinlock_lock(&mana_shared_data_lock);
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-		rte_spinlock_lock(&mana_shared_data_lock);
-
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
-
-		rte_spinlock_unlock(&mana_shared_data_lock);
 	} else {
-		rte_spinlock_lock(&mana_shared_data_lock);
-
-		rte_spinlock_lock(&mana_shared_data->lock);
-		RTE_VERIFY(mana_shared_data->secondary_cnt > 0);
-		mana_shared_data->secondary_cnt--;
-		rte_spinlock_unlock(&mana_shared_data->lock);
+		RTE_VERIFY(rte_atomic_load_explicit(&mana_shared_data->secondary_cnt, rte_memory_order_relaxed) > 0);
+		rte_atomic_fetch_sub_explicit(&mana_shared_data->secondary_cnt, 1, rte_memory_order_relaxed);
 
 		RTE_VERIFY(mana_local_data.secondary_cnt > 0);
 		mana_local_data.secondary_cnt--;
 		if (!mana_local_data.secondary_cnt) {
 			DRV_LOG(DEBUG, "mp uninit secondary");
 			mana_mp_uninit_secondary();
+			mana_shared_data = NULL;
 		}
-
-		rte_spinlock_unlock(&mana_shared_data_lock);
 	}
+	rte_spinlock_unlock(&mana_shared_data_lock);
 
 	return rte_eth_dev_pci_generic_remove(pci_dev, mana_dev_uninit);
 }
diff --git a/drivers/net/mana/mana.h b/drivers/net/mana/mana.h
index 41a0ca6dfe..855d98911b 100644
--- a/drivers/net/mana/mana.h
+++ b/drivers/net/mana/mana.h
@@ -8,12 +8,8 @@
 #define	PCI_VENDOR_ID_MICROSOFT		0x1414
 #define PCI_DEVICE_ID_MICROSOFT_MANA	0x00ba
 
-/* Shared data between primary/secondary processes */
 struct mana_shared_data {
-	rte_spinlock_t lock;
-	int init_done;
-	unsigned int primary_cnt;
-	unsigned int secondary_cnt;
+	RTE_ATOMIC(uint32_t) secondary_cnt;
 };
 
 #define MANA_MAX_MTU	9000
diff --git a/drivers/net/mana/mp.c b/drivers/net/mana/mp.c
index 34b45ed832..5467d385ce 100644
--- a/drivers/net/mana/mp.c
+++ b/drivers/net/mana/mp.c
@@ -306,7 +306,7 @@ mana_mp_req_on_rxtx(struct rte_eth_dev *dev, enum mana_mp_req_type type)
 		return;
 	}
 
-	if (!mana_shared_data->secondary_cnt)
+	if (rte_atomic_load_explicit(&mana_shared_data->secondary_cnt, rte_memory_order_relaxed) == 0)
 		return;
 
 	mp_init_msg(&mp_req, type, dev->data->port_id);
-- 
2.34.1

