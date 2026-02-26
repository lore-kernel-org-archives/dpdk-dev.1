Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FDEFC5910
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 10:16:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0795240647;
	Thu, 26 Feb 2026 11:16:41 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 157C7400D6;
 Thu, 26 Feb 2026 03:39:51 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 9AE5020B6F04; Wed, 25 Feb 2026 18:39:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9AE5020B6F04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1772073590;
 bh=4RNivKb0gYicpyZi7nReIb1b1FG7ENoUKHK57yqs6kc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RM+20a4/NGn5+Dq2TkDzFc0EybtrYKBxi8d89eISXbSyQNZF8Rski972RWS1RF/MF
 x39O520IXO6wMhCMidpiJiF7lHb/w2dr62W5jBXZFsLB73Huq2E3JQt593i5MZe0Yx
 23YqGpMywxaFM9T8f20+lkXXDuia2SJ+3Ssk+snQ=
From: longli@linux.microsoft.com
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v4 2/7] net/netvsc: add multi-process VF device removal support
Date: Wed, 25 Feb 2026 18:39:33 -0800
Message-ID: <20260226023940.961844-3-longli@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260226023940.961844-1-longli@linux.microsoft.com>
References: <20260226023940.961844-1-longli@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Feb 2026 11:16:38 +0100
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

When a VF device is hot-removed by the primary process, secondary
processes must be notified to release their references to the VF port.
Without this, secondary processes retain stale port references leading
to crashes or undefined behavior when accessing the removed device.

This patch adds multi-process communication infrastructure to coordinate
VF removal across all processes:

- Shared memory (netvsc_shared_data) to track secondary process count
- Multi-process message handlers (NETVSC_MP_REQ_VF_REMOVE) to notify
  secondaries when primary removes a VF device
- Secondary handler calls rte_eth_dev_release_port() to cleanly release
  the VF port in its own process space
- Primary waits for all secondaries to acknowledge removal before
  proceeding

The implementation uses rte_mp_request_sync() to ensure all secondary
processes respond within NETVSC_MP_REQ_TIMEOUT_SEC (5 seconds) before
the primary completes the VF removal sequence.

Fixes: 7fc4c0997b04 ("net/netvsc: fix hot adding multiple VF PCI devices")
Cc: stable@dpdk.org

Signed-off-by: Long Li <longli@microsoft.com>
---
v4:
- Move counter decrement and netvsc_uninit_once() to after device
  cleanup in eth_hn_remove() to prevent use-after-free of shared data
- Clear netvsc_shared_data pointer on primary and secondary init
  failure paths to prevent dangling pointer
v3:
- Fix review comments from v2
 drivers/net/netvsc/hn_ethdev.c | 290 ++++++++++++++++++++++++++++++++-
 drivers/net/netvsc/hn_nvs.h    |   6 +
 drivers/net/netvsc/hn_vf.c     |   4 +
 3 files changed, 295 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index b51c11554c..d22595ce95 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -48,6 +48,31 @@
 	    (var) = (tvar))
 #endif
 
+/* Spinlock for netvsc_shared_data */
+static rte_spinlock_t netvsc_shared_data_lock = RTE_SPINLOCK_INITIALIZER;
+
+static struct netvsc_shared_data {
+	RTE_ATOMIC(uint32_t) secondary_cnt;
+} *netvsc_shared_data;
+
+static const struct rte_memzone *netvsc_shared_mz;
+#define MZ_NETVSC_SHARED_DATA "netvsc_shared_data"
+
+static struct netvsc_local_data {
+	bool init_done;
+	unsigned int primary_cnt;
+	unsigned int secondary_cnt;
+} netvsc_local_data;
+
+#define NETVSC_MP_NAME "net_netvsc_mp"
+#define NETVSC_MP_REQ_TIMEOUT_SEC 5
+
+struct netvsc_mp_param {
+	enum netvsc_mp_req_type type;
+	int vf_port;
+	int result;
+};
+
 #define HN_TX_OFFLOAD_CAPS (RTE_ETH_TX_OFFLOAD_IPV4_CKSUM | \
 			    RTE_ETH_TX_OFFLOAD_TCP_CKSUM  | \
 			    RTE_ETH_TX_OFFLOAD_UDP_CKSUM  | \
@@ -1505,6 +1530,217 @@ static void remove_cache_list(void)
 	rte_spinlock_unlock(&netvsc_lock);
 }
 
+static int
+netvsc_mp_primary_handle(const struct rte_mp_msg *mp_msg __rte_unused,
+			  const void *peer __rte_unused)
+{
+	/* Stub function required for multi-process message handling registration */
+	return 0;
+}
+
+static void
+mp_init_msg(struct rte_mp_msg *msg, enum netvsc_mp_req_type type, int vf_port)
+{
+	struct netvsc_mp_param *param;
+
+	strlcpy(msg->name, NETVSC_MP_NAME, sizeof(msg->name));
+	msg->len_param = sizeof(*param);
+
+	param = (struct netvsc_mp_param *)msg->param;
+	param->type = type;
+	param->vf_port = vf_port;
+}
+
+static int netvsc_secondary_handle_device_remove(int vf_port)
+{
+	if (!rte_eth_dev_is_valid_port(vf_port)) {
+		/* VF not probed in this secondary — nothing to release */
+		PMD_DRV_LOG(DEBUG, "VF port %u not present in secondary, skipping",
+			    vf_port);
+		return 0;
+	}
+
+	PMD_DRV_LOG(DEBUG, "Secondary releasing VF port %d", vf_port);
+	return rte_eth_dev_release_port(&rte_eth_devices[vf_port]);
+}
+
+static int
+netvsc_mp_secondary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
+{
+	struct rte_mp_msg mp_res = { 0 };
+	struct netvsc_mp_param *res = (struct netvsc_mp_param *)mp_res.param;
+	const struct netvsc_mp_param *param =
+		(const struct netvsc_mp_param *)mp_msg->param;
+	int ret = 0;
+
+	mp_init_msg(&mp_res, param->type, param->vf_port);
+
+	switch (param->type) {
+	case NETVSC_MP_REQ_VF_REMOVE:
+		res->result = netvsc_secondary_handle_device_remove(param->vf_port);
+		ret = rte_mp_reply(&mp_res, peer);
+		break;
+
+	default:
+		PMD_DRV_LOG(ERR, "Unknown primary MP type %u", param->type);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int netvsc_mp_init_primary(void)
+{
+	int ret;
+	ret = rte_mp_action_register(NETVSC_MP_NAME, netvsc_mp_primary_handle);
+	if (ret && rte_errno != ENOTSUP) {
+		PMD_DRV_LOG(ERR, "Failed to register primary handler %d %d",
+			ret, rte_errno);
+		return -1;
+	}
+
+	return 0;
+}
+
+static void netvsc_mp_uninit_primary(void)
+{
+	rte_mp_action_unregister(NETVSC_MP_NAME);
+}
+
+static int netvsc_mp_init_secondary(void)
+{
+	return rte_mp_action_register(NETVSC_MP_NAME, netvsc_mp_secondary_handle);
+}
+
+static void netvsc_mp_uninit_secondary(void)
+{
+	rte_mp_action_unregister(NETVSC_MP_NAME);
+}
+
+int netvsc_mp_req_vf(struct hn_data *hv, enum netvsc_mp_req_type type,
+		     int vf_port)
+{
+	struct rte_mp_msg mp_req = { 0 };
+	struct rte_mp_msg *mp_res;
+	struct rte_mp_reply mp_rep = { 0 };
+	struct netvsc_mp_param *res;
+	struct timespec ts = {.tv_sec = NETVSC_MP_REQ_TIMEOUT_SEC, .tv_nsec = 0};
+	int i, ret;
+
+	/* if secondary count is 0, return */
+	if (rte_atomic_load_explicit(&netvsc_shared_data->secondary_cnt,
+			rte_memory_order_acquire) == 0)
+		return 0;
+
+	mp_init_msg(&mp_req, type, vf_port);
+
+	ret = rte_mp_request_sync(&mp_req, &mp_rep, &ts);
+	if (ret) {
+		if (rte_errno != ENOTSUP)
+			PMD_DRV_LOG(ERR, "port %u failed to request VF remove",
+				    hv->port_id);
+		else
+			ret = 0;
+		goto exit;
+	}
+
+	if (mp_rep.nb_sent != mp_rep.nb_received) {
+		PMD_DRV_LOG(ERR, "port %u not all secondaries responded type %d",
+			    hv->port_id, type);
+		ret = -1;
+		goto exit;
+	}
+	for (i = 0; i < mp_rep.nb_received; i++) {
+		mp_res = &mp_rep.msgs[i];
+		res = (struct netvsc_mp_param *)mp_res->param;
+		if (res->result) {
+			PMD_DRV_LOG(ERR, "port %u request failed on secondary %d",
+				    hv->port_id, i);
+			ret = -1;
+			goto exit;
+		}
+	}
+
+exit:
+	free(mp_rep.msgs);
+	return ret;
+}
+
+static int netvsc_init_once(void)
+{
+	int ret = 0;
+	const struct rte_memzone *secondary_mz;
+
+	if (netvsc_local_data.init_done)
+		return 0;
+
+	switch (rte_eal_process_type()) {
+	case RTE_PROC_PRIMARY:
+		netvsc_shared_mz = rte_memzone_reserve(MZ_NETVSC_SHARED_DATA,
+				sizeof(*netvsc_shared_data), SOCKET_ID_ANY, 0);
+		if (!netvsc_shared_mz) {
+			PMD_DRV_LOG(ERR, "Cannot allocate netvsc shared data");
+			return -rte_errno;
+		}
+		netvsc_shared_data = netvsc_shared_mz->addr;
+		rte_atomic_store_explicit(&netvsc_shared_data->secondary_cnt,
+				0, rte_memory_order_release);
+
+		ret = netvsc_mp_init_primary();
+		if (ret) {
+			rte_memzone_free(netvsc_shared_mz);
+			netvsc_shared_mz = NULL;
+			netvsc_shared_data = NULL;
+			break;
+		}
+
+		PMD_DRV_LOG(DEBUG, "MP INIT PRIMARY");
+		netvsc_local_data.init_done = true;
+		break;
+
+	case RTE_PROC_SECONDARY:
+		secondary_mz = rte_memzone_lookup(MZ_NETVSC_SHARED_DATA);
+		if (!secondary_mz) {
+			PMD_DRV_LOG(ERR, "Cannot attach netvsc shared data");
+			return -rte_errno;
+		}
+		netvsc_shared_data = secondary_mz->addr;
+		ret = netvsc_mp_init_secondary();
+		if (ret) {
+			netvsc_shared_data = NULL;
+			break;
+		}
+
+		PMD_DRV_LOG(DEBUG, "MP INIT SECONDARY");
+		netvsc_local_data.init_done = true;
+		break;
+
+	default:
+		/* Impossible */
+		ret = -EPROTO;
+		break;
+	}
+
+	return ret;
+}
+
+static void netvsc_uninit_once(void)
+{
+	if (netvsc_local_data.primary_cnt ||
+	    netvsc_local_data.secondary_cnt)
+		return;
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		netvsc_mp_uninit_primary();
+		rte_memzone_free(netvsc_shared_mz);
+		netvsc_shared_mz = NULL;
+		netvsc_shared_data = NULL;
+	} else {
+		netvsc_mp_uninit_secondary();
+	}
+	netvsc_local_data.init_done = false;
+}
+
 static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
 			struct rte_vmbus_device *dev)
 {
@@ -1518,10 +1754,26 @@ static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
 	if (ret)
 		return ret;
 
+	rte_spinlock_lock(&netvsc_shared_data_lock);
+	ret = netvsc_init_once();
+	if (!ret) {
+		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+			netvsc_local_data.primary_cnt++;
+		} else {
+			rte_atomic_fetch_add_explicit(
+				&netvsc_shared_data->secondary_cnt,
+				1, rte_memory_order_release);
+			netvsc_local_data.secondary_cnt++;
+		}
+	}
+	rte_spinlock_unlock(&netvsc_shared_data_lock);
+	if (ret)
+		goto fail;
+
 	ret = rte_dev_event_monitor_start();
 	if (ret) {
 		PMD_DRV_LOG(ERR, "Failed to start device event monitoring");
-		goto fail;
+		goto init_once_failed;
 	}
 
 	eth_dev = eth_dev_vmbus_allocate(dev, sizeof(struct hn_data));
@@ -1547,6 +1799,7 @@ static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
 		goto dev_init_failed;
 
 	rte_eth_dev_probing_finish(eth_dev);
+
 	return ret;
 
 dev_init_failed:
@@ -1558,6 +1811,19 @@ static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
 vmbus_alloc_failed:
 	rte_dev_event_monitor_stop();
 
+init_once_failed:
+	rte_spinlock_lock(&netvsc_shared_data_lock);
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		netvsc_local_data.primary_cnt--;
+	} else {
+		rte_atomic_fetch_sub_explicit(
+			&netvsc_shared_data->secondary_cnt,
+			1, rte_memory_order_release);
+		netvsc_local_data.secondary_cnt--;
+	}
+	netvsc_uninit_once();
+	rte_spinlock_unlock(&netvsc_shared_data_lock);
+
 fail:
 	remove_cache_list();
 	return ret;
@@ -1572,12 +1838,14 @@ static int eth_hn_remove(struct rte_vmbus_device *dev)
 	PMD_INIT_FUNC_TRACE();
 
 	eth_dev = rte_eth_dev_allocated(dev->device.name);
-	if (!eth_dev)
-		return 0; /* port already released */
+	if (!eth_dev) {
+		ret = 0; /* port already released */
+		goto uninit;
+	}
 
 	ret = eth_hn_dev_uninit(eth_dev);
 	if (ret)
-		return ret;
+		goto uninit;
 
 	process_priv = eth_dev->process_private;
 	rte_free(process_priv);
@@ -1587,7 +1855,19 @@ static int eth_hn_remove(struct rte_vmbus_device *dev)
 
 	remove_cache_list();
 
-	return 0;
+uninit:
+	rte_spinlock_lock(&netvsc_shared_data_lock);
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		netvsc_local_data.primary_cnt--;
+	} else {
+		rte_atomic_fetch_sub_explicit(&netvsc_shared_data->secondary_cnt,
+				1, rte_memory_order_release);
+		netvsc_local_data.secondary_cnt--;
+	}
+	netvsc_uninit_once();
+	rte_spinlock_unlock(&netvsc_shared_data_lock);
+
+	return ret;
 }
 
 /* Network device GUID */
diff --git a/drivers/net/netvsc/hn_nvs.h b/drivers/net/netvsc/hn_nvs.h
index bf10621927..67dbfd7be7 100644
--- a/drivers/net/netvsc/hn_nvs.h
+++ b/drivers/net/netvsc/hn_nvs.h
@@ -243,3 +243,9 @@ hn_nvs_send_sglist(struct hn_data *hv, struct vmbus_channel *chan,
 	return rte_vmbus_chan_send_sglist(hn_nvs_get_vmbus_device(hv), chan, sg, sglen, nvs_msg,
 					  nvs_msglen, (uint64_t)sndc, need_sig);
 }
+
+enum netvsc_mp_req_type {
+	NETVSC_MP_REQ_VF_REMOVE = 1,
+};
+int netvsc_mp_req_vf(struct hn_data *hv, enum netvsc_mp_req_type type,
+		     int vf_port);
diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
index dfd328d550..d9efa7e96f 100644
--- a/drivers/net/netvsc/hn_vf.c
+++ b/drivers/net/netvsc/hn_vf.c
@@ -155,6 +155,10 @@ static void hn_remove_delayed(void *args)
 		PMD_DRV_LOG(ERR, "rte_eth_dev_close failed port_id=%u ret=%d",
 			    port_id, ret);
 
+	ret = netvsc_mp_req_vf(hv, NETVSC_MP_REQ_VF_REMOVE, port_id);
+	if (ret)
+		PMD_DRV_LOG(ERR, "failed to request secondary VF remove");
+
 	/* Remove the rte device when all its eth devices are removed */
 	all_eth_removed = true;
 	RTE_ETH_FOREACH_DEV_OF(port_id, dev) {
-- 
2.43.0

