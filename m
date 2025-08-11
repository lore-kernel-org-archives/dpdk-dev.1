Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1ECCA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 22:48:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB8A840270;
	Tue, 12 Aug 2025 00:48:48 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 9FFC54026C
 for <dev@dpdk.org>; Tue, 12 Aug 2025 00:48:46 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id A661B2118276; Mon, 11 Aug 2025 15:48:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A661B2118276
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1754952525;
 bh=1fNA3OPiP+gxUnbUAEzmS6bLaKnQJtkV9DoadcU37hk=;
 h=From:To:Cc:Subject:Date:From;
 b=fKgqZFaulP0RZ5bSHpLVqv0T+HkRj9MBOkqlggH53/9SjOdwo2C/SJ3Aizb/dJvcJ
 x0JJWUsCMb80jl+oMvfaDo+a+qfgBdLF5PPKWNk3DaWDXkZ0wHy6kS1qYOtEvYAGJ+
 n+BXXMihvhvsIjxA5jyX4t0WBgUOC6NV7IooP9nE=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [PATCH] net/netvsc: add device argument to configure if NUMA
 information on the device should be ignored
Date: Mon, 11 Aug 2025 15:48:07 -0700
Message-Id: <1754952487-30601-1-git-send-email-longli@linuxonhyperv.com>
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

In most cases, netvsc is used with a VF device. The application generally
runs with better performance when all the device memory is allocated on
VF's NUMA node, as the VF device carries most of the data packets.

But sometimes netvsc may run on a different NUMA node than that of the VF.
This patches adds a device argument "numa" to allow the application to
configure if netvsc should be NUMA aware. The default behavior for netvsc
is that it is NUMA aware. Setting "numa=0" tells netvsc not to be NUMA
aware.

Signed-off-by: Long Li <longli@microsoft.com>
---
 doc/guides/nics/netvsc.rst     |  8 +++++
 drivers/net/netvsc/hn_ethdev.c | 66 +++++++++++++++++++++++++++++-----
 2 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/doc/guides/nics/netvsc.rst b/doc/guides/nics/netvsc.rst
index 2c0ea6ac9e..e052b31dcc 100644
--- a/doc/guides/nics/netvsc.rst
+++ b/doc/guides/nics/netvsc.rst
@@ -141,3 +141,11 @@ The user can specify below argument in devargs.
     A non-zero value tells netvsc to attach external buffers to mbuf on
     receiving packets, thus avoid copying memory. Use of external buffers
     requires the application is able to read data from external mbuf.
+
+#. ``numa``:
+   The numa is used to configure if netvsc driver should be NUMA aware. The
+   default value is 1 (meaning the netvsc driver is NUMA aware). When used
+   with a VF device, the VF device's NUMA node may not be the same as netvsc's
+   NUMA node. The application generally runs with better performance if all the
+   device queues are allocated on VF's NUMA node, as the VF carries most of the
+   data packets. Setting this value to 0 makes netvsc driver not NUMA aware.
diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 0a7ed155d3..1ad4542d64 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -56,6 +56,16 @@
 #define NETVSC_ARG_RXBREAK "rx_copybreak"
 #define NETVSC_ARG_TXBREAK "tx_copybreak"
 #define NETVSC_ARG_RX_EXTMBUF_ENABLE "rx_extmbuf_enable"
+#define NETVSC_ARG_NUMA "numa"
+
+static const char * const valid_keys[] = {
+	NETVSC_ARG_LATENCY,
+	NETVSC_ARG_RXBREAK,
+	NETVSC_ARG_TXBREAK,
+	NETVSC_ARG_RX_EXTMBUF_ENABLE,
+	NETVSC_ARG_NUMA,
+	NULL
+};
 
 /* The max number of retry when hot adding a VF device */
 #define NETVSC_MAX_HOTADD_RETRY 10
@@ -105,6 +115,48 @@ struct da_cache {
 LIST_HEAD(da_cache_list, da_cache) da_cache_list;
 static unsigned int da_cache_usage;
 
+/* Check in dev args if numa should be used.
+ * By default returning true, meaning the device is numa aware
+ */
+static bool hn_use_numa(struct rte_vmbus_device *dev)
+{
+	struct rte_devargs *devargs = dev->device.devargs;
+	struct rte_kvargs *kvlist;
+	const struct rte_kvargs_pair *pair;
+	unsigned long v;
+	unsigned int i;
+	char *endp = NULL;
+	bool ret = true;
+
+	if (!devargs)
+		return ret;
+
+	PMD_INIT_LOG(DEBUG, "device args %s %s",
+		     devargs->name, devargs->args);
+
+	kvlist = rte_kvargs_parse(devargs->args, valid_keys);
+	if (!kvlist) {
+		PMD_DRV_LOG(ERR, "invalid parameters");
+		return ret;
+	}
+
+	for (i = 0; i < kvlist->count; i++) {
+		pair = &kvlist->pairs[i];
+		if (!strcmp(pair->key, NETVSC_ARG_NUMA)) {
+			v = strtoul(pair->value, &endp, 0);
+			if (*pair->value == '\0' || *endp != '\0') {
+				PMD_DRV_LOG(ERR, "invalid parameter %s=%s",
+					    pair->key, pair->value);
+			}
+			ret = v ? true : false;
+		}
+	}
+
+	rte_kvargs_free(kvlist);
+
+	return ret;
+}
+
 static struct rte_eth_dev *
 eth_dev_vmbus_allocate(struct rte_vmbus_device *dev, size_t private_data_size)
 {
@@ -116,6 +168,11 @@ eth_dev_vmbus_allocate(struct rte_vmbus_device *dev, size_t private_data_size)
 
 	name = dev->device.name;
 
+	if (!hn_use_numa(dev)) {
+		PMD_DRV_LOG(NOTICE, "NUMA mode disabled");
+		dev->device.numa_node = SOCKET_ID_ANY;
+	}
+
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		eth_dev = rte_eth_dev_allocate(name);
 		if (!eth_dev) {
@@ -126,7 +183,7 @@ eth_dev_vmbus_allocate(struct rte_vmbus_device *dev, size_t private_data_size)
 		if (private_data_size) {
 			eth_dev->data->dev_private =
 				rte_zmalloc_socket(name, private_data_size,
-						     RTE_CACHE_LINE_SIZE, dev->device.numa_node);
+						   RTE_CACHE_LINE_SIZE, dev->device.numa_node);
 			if (!eth_dev->data->dev_private) {
 				PMD_DRV_LOG(NOTICE, "can not allocate driver data");
 				rte_eth_dev_release_port(eth_dev);
@@ -199,13 +256,6 @@ static int hn_parse_args(const struct rte_eth_dev *dev)
 {
 	struct hn_data *hv = dev->data->dev_private;
 	struct rte_devargs *devargs = dev->device->devargs;
-	static const char * const valid_keys[] = {
-		NETVSC_ARG_LATENCY,
-		NETVSC_ARG_RXBREAK,
-		NETVSC_ARG_TXBREAK,
-		NETVSC_ARG_RX_EXTMBUF_ENABLE,
-		NULL
-	};
 	struct rte_kvargs *kvlist;
 	int ret;
 
-- 
2.34.1

