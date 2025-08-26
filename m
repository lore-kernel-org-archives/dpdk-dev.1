Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E0DCA0FF2
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 18:15:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9F94402CA;
	Tue, 26 Aug 2025 20:15:37 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id DCBDB402B6
 for <dev@dpdk.org>; Tue, 26 Aug 2025 20:15:35 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id EFA3E2110803; Tue, 26 Aug 2025 11:15:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EFA3E2110803
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1756232134;
 bh=+ndRhfcYNy+2OMY9Zc7BVgUc39jcA3/sWte+X6y7UxE=;
 h=From:To:Cc:Subject:Date:Reply-To:From;
 b=VR3HLQRJKEUEmeZjZ3R+VqM9kwN/tUV6sWnbJEzRIfwfCZdINQYwux5h0SN92i2Gd
 Np2f1P7u3xQK/cjw2kGZZakDk/vlSXjTL/bybS5qZ5ZMvgXU1TQoihNS9tC7tTJvmf
 l5qt/cE+bGCnfKpOTcwECYfdisUJtO0cq6eaQi+0=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v2] net/netvsc: cache device parameters for hot plug events
Date: Tue, 26 Aug 2025 11:15:32 -0700
Message-Id: <1756232132-20348-1-git-send-email-longli@linuxonhyperv.com>
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
Reply-To: longli@microsoft.com
Errors-To: dev-bounces@dpdk.org

From: Long Li <longli@microsoft.com>

If a device is hot removed and hot plugged, it needs the same driver
parameters that are passed to EAL. However, during device removal, all
EAL driver parameters are freed as part of the cleanup.

Cache those driver parameters for future hot plug events. Because we don't
know which device will show up, cache all the PCI driver parameters.

Signed-off-by: Long Li <longli@microsoft.com>
---
Change log
v2: replace strncpy with strlcpy to avoid CI warning

 drivers/net/netvsc/hn_ethdev.c | 107 ++++++++++++++++++++++++++++-----
 drivers/net/netvsc/hn_var.h    |   1 -
 drivers/net/netvsc/hn_vf.c     |   4 --
 3 files changed, 93 insertions(+), 19 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index ca626ccf60..77ae8298bd 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -95,6 +95,16 @@ static const uint8_t rss_default_key[NDIS_HASH_KEYSIZE_TOEPLITZ] = {
 	0x06, 0x3c, 0x25, 0xf3,	0xfc, 0x1f, 0xdc, 0x2a,
 };
 
+static rte_spinlock_t netvsc_lock = RTE_SPINLOCK_INITIALIZER;
+struct da_cache {
+	LIST_ENTRY(da_cache) list;
+	char name[RTE_DEV_NAME_MAX_LEN];
+	char drv_str[];
+};
+
+LIST_HEAD(da_cache_list, da_cache) da_cache_list;
+static unsigned int da_cache_usage;
+
 static struct rte_eth_dev *
 eth_dev_vmbus_allocate(struct rte_vmbus_device *dev, size_t private_data_size)
 {
@@ -623,22 +633,37 @@ static void netvsc_hotplug_retry(void *args)
 		       RTE_DIM(eth_addr.addr_bytes));
 
 		if (rte_is_same_ether_addr(&eth_addr, dev->data->mac_addrs)) {
+			struct da_cache *cache;
+			char *drv_str = NULL;
+
+			rte_spinlock_lock(&netvsc_lock);
+
+			LIST_FOREACH(cache, &da_cache_list, list) {
+				if (strcmp(cache->name, d->name) == 0)
+					break;
+			}
+
+			if (cache)
+				drv_str = strdup(cache->drv_str);
+
+			rte_spinlock_unlock(&netvsc_lock);
+
 			PMD_DRV_LOG(NOTICE,
-				    "Found matching MAC address, adding device %s network name %s",
-				    d->name, dir->d_name);
+				    "Found matching MAC address, adding device %s network name %s args %s",
+				    d->name, dir->d_name, drv_str ? drv_str : "");
 
 			/* If this device has been hot removed from this
 			 * parent device, restore its args.
 			 */
-			ret = rte_eal_hotplug_add(d->bus->name, d->name,
-						  hv->vf_devargs ?
-						  hv->vf_devargs : "");
+			ret = rte_eal_hotplug_add(d->bus->name, d->name, drv_str ? drv_str : "");
 			if (ret) {
 				PMD_DRV_LOG(ERR,
 					    "Failed to add PCI device %s",
 					    d->name);
 			}
 
+			free(drv_str);
+
 			break;
 		}
 	}
@@ -651,7 +676,7 @@ static void netvsc_hotplug_retry(void *args)
 	LIST_REMOVE(hot_ctx, list);
 	rte_spinlock_unlock(&hv->hotadd_lock);
 
-	rte_free(hot_ctx);
+	free(hot_ctx);
 }
 
 static void
@@ -672,8 +697,7 @@ netvsc_hotadd_callback(const char *device_name, enum rte_dev_event_type type,
 		if (hv->vf_ctx.vf_state > vf_removed)
 			break;
 
-		hot_ctx = rte_zmalloc("NETVSC-HOTADD", sizeof(*hot_ctx),
-				      rte_mem_page_size());
+		hot_ctx = calloc(1, sizeof(*hot_ctx));
 
 		if (!hot_ctx) {
 			PMD_DRV_LOG(ERR, "Failed to allocate hotadd context");
@@ -705,7 +729,7 @@ netvsc_hotadd_callback(const char *device_name, enum rte_dev_event_type type,
 		 * sent from VSP
 		 */
 free_ctx:
-		rte_free(hot_ctx);
+		free(hot_ctx);
 		break;
 
 	default:
@@ -1066,7 +1090,7 @@ hn_dev_close(struct rte_eth_dev *dev)
 		hot_ctx = LIST_FIRST(&hv->hotadd_list);
 		rte_eal_alarm_cancel(netvsc_hotplug_retry, hot_ctx);
 		LIST_REMOVE(hot_ctx, list);
-		rte_free(hot_ctx);
+		free(hot_ctx);
 	}
 	rte_spinlock_unlock(&hv->hotadd_lock);
 
@@ -1409,9 +1433,6 @@ eth_hn_dev_uninit(struct rte_eth_dev *eth_dev)
 	ret_stop = hn_dev_stop(eth_dev);
 	hn_dev_close(eth_dev);
 
-	free(hv->vf_devargs);
-	hv->vf_devargs = NULL;
-
 	hn_detach(hv);
 	hn_chim_uninit(eth_dev);
 	rte_vmbus_chan_close(hv->channels[0]);
@@ -1423,6 +1444,54 @@ eth_hn_dev_uninit(struct rte_eth_dev *eth_dev)
 	return ret_stop;
 }
 
+static int populate_cache_list(void)
+{
+	int ret = 0;
+	struct rte_devargs *da;
+
+	rte_spinlock_lock(&netvsc_lock);
+	da_cache_usage++;
+	if (da_cache_usage > 1) {
+		ret = 0;
+		goto out;
+	}
+
+	LIST_INIT(&da_cache_list);
+	RTE_EAL_DEVARGS_FOREACH("pci", da) {
+		struct da_cache *cache;
+
+		cache = calloc(1, sizeof(*cache) + strlen(da->drv_str) + 1);
+		if (!cache) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		strlcpy(cache->name, da->name, sizeof(cache->name));
+		strlcpy(cache->drv_str, da->drv_str, strlen(da->drv_str) + 1);
+		LIST_INSERT_HEAD(&da_cache_list, cache, list);
+	}
+out:
+	rte_spinlock_unlock(&netvsc_lock);
+	return ret;
+}
+
+static void remove_cache_list(void)
+{
+	struct da_cache *cache;
+
+	rte_spinlock_lock(&netvsc_lock);
+	da_cache_usage--;
+	if (da_cache_usage)
+		goto out;
+
+	LIST_FOREACH(cache, &da_cache_list, list) {
+		LIST_REMOVE(cache, list);
+		free(cache);
+	}
+out:
+	rte_spinlock_unlock(&netvsc_lock);
+}
+
 static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
 			struct rte_vmbus_device *dev)
 {
@@ -1432,10 +1501,14 @@ static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
 
 	PMD_INIT_FUNC_TRACE();
 
+	ret = populate_cache_list();
+	if (ret)
+		return ret;
+
 	ret = rte_dev_event_monitor_start();
 	if (ret) {
 		PMD_DRV_LOG(ERR, "Failed to start device event monitoring");
-		return ret;
+		goto fail;
 	}
 
 	eth_dev = eth_dev_vmbus_allocate(dev, sizeof(struct hn_data));
@@ -1452,6 +1525,7 @@ static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
 		ret = -ENOMEM;
 		goto priv_alloc_failed;
 	}
+
 	process_priv->vmbus_dev = dev;
 	eth_dev->process_private = process_priv;
 
@@ -1471,6 +1545,8 @@ static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
 vmbus_alloc_failed:
 	rte_dev_event_monitor_stop();
 
+fail:
+	remove_cache_list();
 	return ret;
 }
 
@@ -1495,6 +1571,9 @@ static int eth_hn_remove(struct rte_vmbus_device *dev)
 
 	eth_dev_vmbus_release(eth_dev);
 	rte_dev_event_monitor_stop();
+
+	remove_cache_list();
+
 	return 0;
 }
 
diff --git a/drivers/net/netvsc/hn_var.h b/drivers/net/netvsc/hn_var.h
index 3553d84f20..ccbd6b6a33 100644
--- a/drivers/net/netvsc/hn_var.h
+++ b/drivers/net/netvsc/hn_var.h
@@ -180,7 +180,6 @@ struct hn_data {
 
 	rte_spinlock_t	hotadd_lock;
 	LIST_HEAD(hotadd_list, hv_hotadd_context) hotadd_list;
-	char		*vf_devargs;
 };
 
 static inline struct vmbus_channel *
diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
index 4ff766ec8b..d922e685f4 100644
--- a/drivers/net/netvsc/hn_vf.c
+++ b/drivers/net/netvsc/hn_vf.c
@@ -130,10 +130,6 @@ static void hn_remove_delayed(void *args)
 		PMD_DRV_LOG(ERR, "rte_eth_dev_stop failed port_id=%u ret=%d",
 			    port_id, ret);
 
-	/* Record the device parameters for possible hotplug events */
-	if (dev->devargs && dev->devargs->args)
-		hv->vf_devargs = strdup(dev->devargs->args);
-
 	ret = rte_eth_dev_close(port_id);
 	if (ret)
 		PMD_DRV_LOG(ERR, "rte_eth_dev_close failed port_id=%u ret=%d",
-- 
2.25.1

