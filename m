Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E01C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 21:43:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 299E14060C;
	Mon, 10 Mar 2025 22:43:08 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 32D66402E6
 for <dev@dpdk.org>; Mon, 10 Mar 2025 22:43:06 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 516B82038F53; Mon, 10 Mar 2025 14:43:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 516B82038F53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1741642985;
 bh=2pzfn5ajydzrGV6QuOVia0h9CVtai9wH7uIisf1Ys+k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BTWEyXYVt0La7vctms6+I+KrHHCW5PJH0+gzHQVU+6DK27ZqFeSjEb2WmUAyQAAzN
 F4RJ6FU8qgCARhfP6XXzBNHA78YLR0ziMZuyLTI8Qax8P2EwR7AZ5A/q/33/jUbULg
 6Kqeq6+LOlCmRU0eHKfIXCAX1v4Y4+EnPsy8zzrM=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [patch v2 1/6] net/netvsc: introduce private data for storing vmbus
 device for secondary process
Date: Mon, 10 Mar 2025 14:42:52 -0700
Message-Id: <1741642977-14297-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741642977-14297-1-git-send-email-longli@linuxonhyperv.com>
References: <1741642977-14297-1-git-send-email-longli@linuxonhyperv.com>
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
index f848157b49..e5b052d569 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -1427,7 +1427,8 @@ static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
 			struct rte_vmbus_device *dev)
 {
 	struct rte_eth_dev *eth_dev;
-	int ret;
+	struct hn_nvs_process_priv *process_priv;
+	int ret = 0;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -1438,16 +1439,37 @@ static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
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
@@ -1455,6 +1477,7 @@ static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
 static int eth_hn_remove(struct rte_vmbus_device *dev)
 {
 	struct rte_eth_dev *eth_dev;
+	struct hn_nvs_process_priv *process_priv;
 	int ret;
 
 	PMD_INIT_FUNC_TRACE();
@@ -1467,6 +1490,9 @@ static int eth_hn_remove(struct rte_vmbus_device *dev)
 	if (ret)
 		return ret;
 
+	process_priv = eth_dev->process_private;
+	rte_free(process_priv);
+
 	eth_dev_vmbus_release(eth_dev);
 	rte_dev_event_monitor_stop();
 	return 0;
diff --git a/drivers/net/netvsc/hn_nvs.h b/drivers/net/netvsc/hn_nvs.h
index 2843ef7b96..3950749359 100644
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
 struct __rte_packed_begin hn_nvs_hdr {
-- 
2.34.1

