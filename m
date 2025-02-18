Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63DEC021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 20:59:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE573402A0;
	Tue, 18 Feb 2025 21:59:33 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6E7B640264;
 Tue, 18 Feb 2025 21:59:32 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 9B5BA20376E5; Tue, 18 Feb 2025 12:59:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B5BA20376E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1739912371;
 bh=ez/T0pBEmOLjpoDEpva/Fu5O1u7hfz4e0+QArrxT6NE=;
 h=From:To:Cc:Subject:Date:From;
 b=MoquvT5/5dNfw9EkxVh14IVioKflRuSulWwgN25IRzCTQJTcXVYQt81NcBGL739nT
 2OimcS3c4aDePZSyUXb1KwJCU5pymI9S1wB60zS8UbflRa4g0gs+fAE0l2As5Y+mon
 Sj9paXIFQoDJDBYrLnoStkMAYOTfVtQJq6KhHNV4=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v2] net/mana: use mana_local_data for tracking usage data for
 primary process
Date: Tue, 18 Feb 2025 12:59:26 -0800
Message-Id: <1739912366-6052-1-git-send-email-longli@linuxonhyperv.com>
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

 drivers/net/mana/mana.c | 99 +++++++++++++++++++++++------------------
 drivers/net/mana/mana.h |  6 +--
 drivers/net/mana/mp.c   |  2 +-
 3 files changed, 57 insertions(+), 50 deletions(-)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index c37c4e3444..69cb7ab13f 100644
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
+		rte_atomic32_set(&mana_shared_data->secondary_cnt, 0);
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
+		rte_atomic32_inc(&mana_shared_data->secondary_cnt);
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
+		rte_atomic32_dec(&mana_shared_data->secondary_cnt);
+		RTE_VERIFY(rte_atomic32_read(&mana_shared_data->secondary_cnt) >= 0);
 
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
index 41a0ca6dfe..b60b1f1977 100644
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
+	rte_atomic32_t secondary_cnt;
 };
 
 #define MANA_MAX_MTU	9000
diff --git a/drivers/net/mana/mp.c b/drivers/net/mana/mp.c
index 34b45ed832..e7eecfcc30 100644
--- a/drivers/net/mana/mp.c
+++ b/drivers/net/mana/mp.c
@@ -306,7 +306,7 @@ mana_mp_req_on_rxtx(struct rte_eth_dev *dev, enum mana_mp_req_type type)
 		return;
 	}
 
-	if (!mana_shared_data->secondary_cnt)
+	if (rte_atomic32_read(&mana_shared_data->secondary_cnt) <= 0)
 		return;
 
 	mp_init_msg(&mp_req, type, dev->data->port_id);
-- 
2.34.1

