Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31280CA0FE7
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 21:50:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AF604021E;
	Mon, 25 Aug 2025 23:50:33 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 01A9440156
 for <dev@dpdk.org>; Mon, 25 Aug 2025 23:50:30 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 1542F211829C; Mon, 25 Aug 2025 14:50:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1542F211829C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1756158630;
 bh=npHLgcNfF8xigggxhmOH9XnXahVdKo9AMFU86HjTmb0=;
 h=From:To:Cc:Subject:Date:From;
 b=QUXgwJ7q4vllpSrZQ4mDpxhay9XPFsLKcgDQgu3yzEdUWdjrCflgvhwpYdtybsii0
 FJktYk0lXFzdsKwQ4w7m12+tFHID5RZouvHQRvEIaIovfsnvXK1aSsnGKZvQHcIssw
 lxcBZUCnT7PSAIaD31qIoWVvJCM6xLuQbo6NwRwA=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v3] net/netvsc: add device argument to configure if NUMA
 information on the device should be used
Date: Mon, 25 Aug 2025 14:50:27 -0700
Message-Id: <1756158627-6548-1-git-send-email-longli@linuxonhyperv.com>
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
This patches adds a device argument "numa_aware" to allow the application
to configure if netvsc should be NUMA aware. The default behavior for
netvsc is that it is not NUMA aware. Setting "numa_aware=1" tells netvsc
to be NUMA aware.

Signed-off-by: Long Li <longli@microsoft.com>
---
Change log
v2: move the code for parsing device arguments to vmbus
v3: change default to be not NUMA aware. Use VMBUS code to parse "numa_aware" only

 doc/guides/nics/netvsc.rst           |  9 ++++
 drivers/bus/vmbus/bus_vmbus_driver.h |  2 +
 drivers/bus/vmbus/linux/vmbus_bus.c  | 66 +++++++++++++++++++++++-----
 drivers/net/netvsc/hn_ethdev.c       |  1 +
 4 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/doc/guides/nics/netvsc.rst b/doc/guides/nics/netvsc.rst
index 2c0ea6ac9e..cdeefbe1e1 100644
--- a/doc/guides/nics/netvsc.rst
+++ b/doc/guides/nics/netvsc.rst
@@ -141,3 +141,12 @@ The user can specify below argument in devargs.
     A non-zero value tells netvsc to attach external buffers to mbuf on
     receiving packets, thus avoid copying memory. Use of external buffers
     requires the application is able to read data from external mbuf.
+
+#. ``numa_aware``:
+   The numa_aware is used to configure if netvsc driver should be NUMA aware.
+   The default value is 0 (meaning the netvsc driver is not NUMA aware). When
+   used with a VF device, the VF device's NUMA node may not be the same as
+   netvsc's NUMA node. The application generally runs with better performance
+   if all the device queues are allocated on VF's NUMA node, as the VF carries
+   most of the data packets. Setting this value to 1 makes netvsc driver NUMA
+   aware.
diff --git a/drivers/bus/vmbus/bus_vmbus_driver.h b/drivers/bus/vmbus/bus_vmbus_driver.h
index bc394208de..9b8ebe7891 100644
--- a/drivers/bus/vmbus/bus_vmbus_driver.h
+++ b/drivers/bus/vmbus/bus_vmbus_driver.h
@@ -17,6 +17,8 @@ extern "C" {
 struct vmbus_channel;
 struct vmbus_mon_page;
 
+#define NETVSC_ARG_NUMA_AWARE "numa_aware"
+
 /** Maximum number of VMBUS resources. */
 enum hv_uio_map {
 	HV_TXRX_RING_MAP = 0,
diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c b/drivers/bus/vmbus/linux/vmbus_bus.c
index ed18d4da96..a1ff8f65bc 100644
--- a/drivers/bus/vmbus/linux/vmbus_bus.c
+++ b/drivers/bus/vmbus/linux/vmbus_bus.c
@@ -18,6 +18,7 @@
 #include <rte_memory.h>
 #include <rte_malloc.h>
 #include <rte_bus_vmbus.h>
+#include <rte_kvargs.h>
 
 #include <eal_export.h>
 #include "eal_filesystem.h"
@@ -231,6 +232,48 @@ rte_vmbus_unmap_device(struct rte_vmbus_device *dev)
 	vmbus_uio_unmap_resource(dev);
 }
 
+/* Check in dev args if NUMA should be used by checking for "numa_aware" in the
+ * device arguments.
+ * By default returning false, meaning this vmbus device is not NUMA aware.
+ */
+static bool vmbus_use_numa(struct rte_vmbus_device *dev)
+{
+	struct rte_devargs *devargs = dev->device.devargs;
+	struct rte_kvargs *kvlist;
+	const struct rte_kvargs_pair *pair;
+	unsigned long v;
+	unsigned int i;
+	char *endp = NULL;
+	bool ret = false;
+
+	if (!devargs)
+		return ret;
+
+	VMBUS_LOG(DEBUG, "device args %s %s", devargs->name, devargs->args);
+
+	kvlist = rte_kvargs_parse(devargs->args, NULL);
+	if (!kvlist) {
+		VMBUS_LOG(ERR, "invalid parameters");
+		return ret;
+	}
+
+	for (i = 0; i < kvlist->count; i++) {
+		pair = &kvlist->pairs[i];
+		if (!strcmp(pair->key, NETVSC_ARG_NUMA_AWARE)) {
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
@@ -287,19 +330,20 @@ vmbus_scan_one(const char *name)
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
+		snprintf(filename, sizeof(filename), "%s/numa_node",
+			 dirname);
 
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
index 0a7ed155d3..cc4099bec4 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -204,6 +204,7 @@ static int hn_parse_args(const struct rte_eth_dev *dev)
 		NETVSC_ARG_RXBREAK,
 		NETVSC_ARG_TXBREAK,
 		NETVSC_ARG_RX_EXTMBUF_ENABLE,
+		NETVSC_ARG_NUMA_AWARE,
 		NULL
 	};
 	struct rte_kvargs *kvlist;
-- 
2.34.1

