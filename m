Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675AECA0EF5
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 00:24:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D6C040277;
	Tue, 19 Aug 2025 02:24:34 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id BFAE540267
 for <dev@dpdk.org>; Tue, 19 Aug 2025 02:24:32 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id BBA552113340; Mon, 18 Aug 2025 17:24:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BBA552113340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1755563071;
 bh=gB/HYwRrMmR+3xV8Aet2KCTwHAVibRJ9fUzY1j/AYuQ=;
 h=From:To:Cc:Subject:Date:From;
 b=Ghy4gmlg/P9X/Zb9domjQSGufvTaxRvcMilEQYR44bM4ce8Q+w9dsV1sCt2AD0mQi
 a86mChx31pAetBtj2pAeS33xBO4nBc8RDPv77z0CK1h4YPtNbiBUI0NV508NVGeAgF
 Huy1ekRVu8Sfbxv4cIqspyOhh7qFbErJ9dOwuwMo=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [PATCH v2] bus/vmbus: add device argument to configure if NUMA
 information on the device should be ignored
Date: Mon, 18 Aug 2025 17:24:26 -0700
Message-Id: <1755563066-2592-1-git-send-email-longli@linuxonhyperv.com>
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
This patch adds a device argument "numa" to allow the application to
configure if this vmbus device (netvsc) should be NUMA aware. The default
behavior is NUMA aware. Setting "numa=0" specifies this vmbus device is
not NUMA aware.

The device argument is parsed at the time of vmbus device probe to ensure
all the following memory allocations are done on the configured NUMA node.

Signed-off-by: Long Li <longli@microsoft.com>
---
Change log
v2: move the code for parsing device arguments to vmbus

 doc/guides/nics/netvsc.rst           |  8 ++++
 drivers/bus/vmbus/bus_vmbus_driver.h | 15 +++++++
 drivers/bus/vmbus/linux/vmbus_bus.c  | 64 +++++++++++++++++++++++-----
 drivers/net/netvsc/hn_ethdev.c       | 12 ------
 4 files changed, 76 insertions(+), 23 deletions(-)

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
diff --git a/drivers/bus/vmbus/bus_vmbus_driver.h b/drivers/bus/vmbus/bus_vmbus_driver.h
index bc394208de..2b431ac16e 100644
--- a/drivers/bus/vmbus/bus_vmbus_driver.h
+++ b/drivers/bus/vmbus/bus_vmbus_driver.h
@@ -17,6 +17,21 @@ extern "C" {
 struct vmbus_channel;
 struct vmbus_mon_page;
 
+#define NETVSC_ARG_LATENCY "latency"
+#define NETVSC_ARG_RXBREAK "rx_copybreak"
+#define NETVSC_ARG_TXBREAK "tx_copybreak"
+#define NETVSC_ARG_RX_EXTMBUF_ENABLE "rx_extmbuf_enable"
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
+
 /** Maximum number of VMBUS resources. */
 enum hv_uio_map {
 	HV_TXRX_RING_MAP = 0,
diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c b/drivers/bus/vmbus/linux/vmbus_bus.c
index ed18d4da96..d2fa14a69e 100644
--- a/drivers/bus/vmbus/linux/vmbus_bus.c
+++ b/drivers/bus/vmbus/linux/vmbus_bus.c
@@ -18,6 +18,7 @@
 #include <rte_memory.h>
 #include <rte_malloc.h>
 #include <rte_bus_vmbus.h>
+#include <rte_kvargs.h>
 
 #include <eal_export.h>
 #include "eal_filesystem.h"
@@ -231,6 +232,47 @@ rte_vmbus_unmap_device(struct rte_vmbus_device *dev)
 	vmbus_uio_unmap_resource(dev);
 }
 
+/* Check in dev args if numa should be used.
+ * By default returning true, meaning the device is numa aware
+ */
+static bool vmbus_use_numa(struct rte_vmbus_device *dev)
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
+	VMBUS_LOG(DEBUG, "device args %s %s", devargs->name, devargs->args);
+
+	kvlist = rte_kvargs_parse(devargs->args, valid_keys);
+	if (!kvlist) {
+		VMBUS_LOG(ERR, "invalid parameters");
+		return ret;
+	}
+
+	for (i = 0; i < kvlist->count; i++) {
+		pair = &kvlist->pairs[i];
+		if (!strcmp(pair->key, NETVSC_ARG_NUMA)) {
+			v = strtoul(pair->value, &endp, 0);
+			if (*pair->value == '\0' || *endp != '\0') {
+				VMBUS_LOG(ERR, "invalid parameter %s=%s",
+					  pair->key, pair->value);
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
 /* Scan one vmbus sysfs entry, and fill the devices list from it. */
 static int
 vmbus_scan_one(const char *name)
@@ -287,19 +329,19 @@ vmbus_scan_one(const char *name)
 		goto error;
 	dev->monitor_id = tmp;
 
-	/* get numa node (if present) */
-	snprintf(filename, sizeof(filename), "%s/numa_node",
-		 dirname);
+	dev->device.devargs = vmbus_devargs_lookup(dev);
 
-	if (access(filename, R_OK) == 0) {
-		if (eal_parse_sysfs_value(filename, &tmp) < 0)
-			goto error;
-		dev->device.numa_node = tmp;
-	} else {
-		dev->device.numa_node = SOCKET_ID_ANY;
-	}
+	dev->device.numa_node = SOCKET_ID_ANY;
+	if (vmbus_use_numa(dev)) {
+		/* get numa node (if present) */
+		snprintf(filename, sizeof(filename), "%s/numa_node", dirname);
 
-	dev->device.devargs = vmbus_devargs_lookup(dev);
+		if (access(filename, R_OK) == 0) {
+			if (eal_parse_sysfs_value(filename, &tmp) < 0)
+				goto error;
+			dev->device.numa_node = tmp;
+		}
+	}
 
 	/* Allocate interrupt handle instance */
 	dev->intr_handle =
diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 0a7ed155d3..e5cd57e4f4 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -52,11 +52,6 @@
 			    RTE_ETH_RX_OFFLOAD_VLAN_STRIP | \
 			    RTE_ETH_RX_OFFLOAD_RSS_HASH)
 
-#define NETVSC_ARG_LATENCY "latency"
-#define NETVSC_ARG_RXBREAK "rx_copybreak"
-#define NETVSC_ARG_TXBREAK "tx_copybreak"
-#define NETVSC_ARG_RX_EXTMBUF_ENABLE "rx_extmbuf_enable"
-
 /* The max number of retry when hot adding a VF device */
 #define NETVSC_MAX_HOTADD_RETRY 10
 
@@ -199,13 +194,6 @@ static int hn_parse_args(const struct rte_eth_dev *dev)
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

