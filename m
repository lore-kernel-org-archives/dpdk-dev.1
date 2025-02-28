Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939E6C19F32
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 01:09:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1B0140E0C;
	Fri, 28 Feb 2025 02:09:08 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7D85C4027F
 for <dev@dpdk.org>; Fri, 28 Feb 2025 02:09:06 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id B86C6210EAC3; Thu, 27 Feb 2025 17:09:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B86C6210EAC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1740704945;
 bh=N2/rRbHbA8AexzieN4476UwLB3Zkj2Ks2EXZv409NFQ=;
 h=From:To:Cc:Subject:Date:From;
 b=C0mH7wivK2hXloNhSGXZ3c2X6+9zkm+vCrglcWJHSmvUUIuExELE+S8YxzLKoG33K
 rFhFiFdXRQDfwHT5h+avBhRu6VGaIiPv2d9L0aWSIjWR7eUfu76FIj7LVGyspLJrii
 HzYRcVNUDJ0nWf+9Z7I1mZAqa8FNd0fGbngis9rg=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [PATCH 1/6] net/netvsc: introduce private data for storing vmbus
 device for secondary process
Date: Thu, 27 Feb 2025 17:08:56 -0800
Message-Id: <1740704941-1631-2-git-send-email-longli@linuxonhyperv.com>
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

To prepare for supporting to set hyperv event from secondary process
when the channel has monitoring disable, introduce a private data
region for storing the vmbus device. The secondary process will get
access to its vmbus device in case it needs to signal the host.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/netvsc/hn_ethdev.c | 44 +++++++++++++++++++++++++++-------
 drivers/net/netvsc/hn_nvs.h    |  4 ++++
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index f8cb05a118..4b7b557b5c 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -1423,7 +1423,8 @@ static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
 			struct rte_vmbus_device *dev)
 {
 	struct rte_eth_dev *eth_dev;
-	int ret;
+	struct hn_nvs_process_priv *process_priv;
+	int ret = 0;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -1434,16 +1435,37 @@ static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
 	}
 
 	eth_dev = eth_dev_vmbus_allocate(dev, sizeof(struct hn_data));
-	if (!eth_dev)
-		return -ENOMEM;
+	if (!eth_dev) {
+		ret = -ENOMEM;
+		goto vmbus_alloc_failed;
+	}
 
-	ret = eth_hn_dev_init(eth_dev);
-	if (ret) {
-		eth_dev_vmbus_release(eth_dev);
-		rte_dev_event_monitor_stop();
-	} else {
-		rte_eth_dev_probing_finish(eth_dev);
+	process_priv = rte_zmalloc_socket("netvsc_proc_priv",
+					  sizeof(struct hn_nvs_process_priv),
+					  RTE_CACHE_LINE_SIZE,
+					  dev->device.numa_node);
+	if (!process_priv) {
+		ret = -ENOMEM;
+		goto priv_alloc_failed;
 	}
+	process_priv->vmbus_dev = dev;
+	eth_dev->process_private = process_priv;
+
+	ret = eth_hn_dev_init(eth_dev);
+	if (ret)
+		goto dev_init_failed;
+
+	rte_eth_dev_probing_finish(eth_dev);
+	return ret;
+
+dev_init_failed:
+	rte_free(process_priv);
+
+priv_alloc_failed:
+	eth_dev_vmbus_release(eth_dev);
+
+vmbus_alloc_failed:
+	rte_dev_event_monitor_stop();
 
 	return ret;
 }
@@ -1451,6 +1473,7 @@ static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
 static int eth_hn_remove(struct rte_vmbus_device *dev)
 {
 	struct rte_eth_dev *eth_dev;
+	struct hn_nvs_process_priv *process_priv;
 	int ret;
 
 	PMD_INIT_FUNC_TRACE();
@@ -1463,6 +1486,9 @@ static int eth_hn_remove(struct rte_vmbus_device *dev)
 	if (ret)
 		return ret;
 
+	process_priv = eth_dev->process_private;
+	rte_free(process_priv);
+
 	eth_dev_vmbus_release(eth_dev);
 	rte_dev_event_monitor_stop();
 	return 0;
diff --git a/drivers/net/netvsc/hn_nvs.h b/drivers/net/netvsc/hn_nvs.h
index 3766d2ee34..88f413f6aa 100644
--- a/drivers/net/netvsc/hn_nvs.h
+++ b/drivers/net/netvsc/hn_nvs.h
@@ -65,6 +65,10 @@
 #define NVS_TYPE_SUBCH_RESP	133	/* same as SUBCH_REQ */
 #define NVS_TYPE_TXTBL_NOTE	134	/* notification */
 
+/* Private data for primary/secondary processes */
+struct hn_nvs_process_priv {
+	struct rte_vmbus_device *vmbus_dev;
+};
 
 /* NVS message common header */
 struct hn_nvs_hdr {
-- 
2.34.1

