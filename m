Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31806C5518E
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:10:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67EFB4065A;
	Fri, 20 Feb 2026 11:09:38 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id A8EA440276;
 Fri, 20 Feb 2026 02:10:20 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 25AD920B6F00; Thu, 19 Feb 2026 17:10:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25AD920B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1771549820;
 bh=Pg2dfkvFT8c23KkYmR4gKca/GpTLJyU6FjwfyttzIn8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CCzRmCrzCio9GNZo4Neo2bcgwy5YeKtNwBMNDGjLK1WYtO2U3rhMJMjpO+miU63IQ
 uJqlq7ol2QRkKQNwNkJqWgIuLO/jK4TKJWVkzTPZlGbVsDaKYHMIc+o1koqSWNn1xB
 /a8k+zjIZavsfQQtOoG/gNLs5Zqtu5bfTl1LQNWU=
From: longli@linux.microsoft.com
To: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Wei Hu <weh@microsoft.com>, stable@dpdk.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 3/8] net/netvsc: add multi-process VF device removal support
Date: Thu, 19 Feb 2026 17:09:33 -0800
Message-ID: <20260220010938.595319-4-longli@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260220010938.595319-2-longli@linux.microsoft.com>
References: <20260220010938.595319-2-longli@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Feb 2026 11:09:31 +0100
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
 drivers/net/netvsc/hn_ethdev.c | 274 ++++++++++++++++++++++++++++++++-
 drivers/net/netvsc/hn_nvs.h    |   5 +
 drivers/net/netvsc/hn_vf.c     |   4 +
 3 files changed, 282 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 1dcab189e2..62e6f49d3d 100644
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
+static const char *MZ_NETVSC_SHARED_DATA = "netvsc_shared_data";
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
+	int port_id;
+	int result;
+};
+
 #define HN_TX_OFFLOAD_CAPS (RTE_ETH_TX_OFFLOAD_IPV4_CKSUM | \
 			    RTE_ETH_TX_OFFLOAD_TCP_CKSUM  | \
 			    RTE_ETH_TX_OFFLOAD_UDP_CKSUM  | \
@@ -1509,6 +1534,224 @@ static void remove_cache_list(void)
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
+mp_init_msg(struct rte_mp_msg *msg, enum netvsc_mp_req_type type, int port_id)
+{
+	struct netvsc_mp_param *param;
+
+	strlcpy(msg->name, NETVSC_MP_NAME, sizeof(msg->name));
+	msg->len_param = sizeof(*param);
+
+	param = (struct netvsc_mp_param *)msg->param;
+	param->type = type;
+	param->port_id = port_id;
+}
+
+static int netvsc_secondary_handle_device_remove(struct hn_data *hv)
+{
+	uint16_t port_id = hv->vf_ctx.vf_port;
+	struct rte_eth_dev *dev;
+
+	PMD_DRV_LOG(DEBUG, "Secondary handle eth device remove port %d VF port %d",
+		    hv->port_id, port_id);
+
+	/* VF is already locked by primary */
+	dev = &rte_eth_devices[port_id];
+	return rte_eth_dev_release_port(dev);
+}
+
+static int
+netvsc_mp_secondary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
+{
+	struct rte_mp_msg mp_res = { 0 };
+	struct netvsc_mp_param *res = (struct netvsc_mp_param *)mp_res.param;
+	const struct netvsc_mp_param *param =
+		(const struct netvsc_mp_param *)mp_msg->param;
+	struct rte_eth_dev *dev;
+	struct hn_data *hv;
+	int ret = 0;
+
+	if (!rte_eth_dev_is_valid_port(param->port_id)) {
+		PMD_DRV_LOG(ERR, "MP handle port ID %u invalid", param->port_id);
+		return -ENODEV;
+	}
+
+	dev = &rte_eth_devices[param->port_id];
+	hv = dev->data->dev_private;
+
+	mp_init_msg(&mp_res, param->type, param->port_id);
+
+	switch (param->type) {
+	case NETVSC_MP_REQ_VF_REMOVE:
+		/* remove the VF from DPDK and netvsc */
+		res->result = netvsc_secondary_handle_device_remove(hv);
+		ret = rte_mp_reply(&mp_res, peer);
+		break;
+
+	default:
+		PMD_DRV_LOG(ERR, "Port %u unknown primary MP type %u",
+			param->port_id, param->type);
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
+int netvsc_mp_req_VF(struct hn_data *hv, enum netvsc_mp_req_type type)
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
+			rte_memory_order_relaxed) == 0)
+		return 0;
+
+	mp_init_msg(&mp_req, type, hv->port_id);
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
+	int ret;
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
+				0, rte_memory_order_relaxed);
+
+		ret = netvsc_mp_init_primary();
+		if (ret) {
+			rte_memzone_free(netvsc_shared_mz);
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
+		if (ret)
+			break;
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
@@ -1522,10 +1765,14 @@ static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
 	if (ret)
 		return ret;
 
+	ret = netvsc_init_once();
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
@@ -1551,6 +1798,17 @@ static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
 		goto dev_init_failed;
 
 	rte_eth_dev_probing_finish(eth_dev);
+
+	rte_spinlock_lock(&netvsc_shared_data_lock);
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		netvsc_local_data.primary_cnt++;
+	} else {
+		rte_atomic_fetch_add_explicit(&netvsc_shared_data->secondary_cnt,
+				1, rte_memory_order_relaxed);
+		netvsc_local_data.secondary_cnt++;
+	}
+	rte_spinlock_unlock(&netvsc_shared_data_lock);
+
 	return ret;
 
 dev_init_failed:
@@ -1562,6 +1820,9 @@ static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
 vmbus_alloc_failed:
 	rte_dev_event_monitor_stop();
 
+init_once_failed:
+	netvsc_uninit_once();
+
 fail:
 	remove_cache_list();
 	return ret;
@@ -1575,6 +1836,17 @@ static int eth_hn_remove(struct rte_vmbus_device *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+	rte_spinlock_lock(&netvsc_shared_data_lock);
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		netvsc_local_data.primary_cnt--;
+	} else {
+		rte_atomic_fetch_sub_explicit(&netvsc_shared_data->secondary_cnt,
+				1, rte_memory_order_relaxed);
+		netvsc_local_data.secondary_cnt--;
+	}
+	netvsc_uninit_once();
+	rte_spinlock_unlock(&netvsc_shared_data_lock);
+
 	eth_dev = rte_eth_dev_allocated(dev->device.name);
 	if (!eth_dev)
 		return 0; /* port already released */
diff --git a/drivers/net/netvsc/hn_nvs.h b/drivers/net/netvsc/hn_nvs.h
index bf10621927..9127575cd4 100644
--- a/drivers/net/netvsc/hn_nvs.h
+++ b/drivers/net/netvsc/hn_nvs.h
@@ -243,3 +243,8 @@ hn_nvs_send_sglist(struct hn_data *hv, struct vmbus_channel *chan,
 	return rte_vmbus_chan_send_sglist(hn_nvs_get_vmbus_device(hv), chan, sg, sglen, nvs_msg,
 					  nvs_msglen, (uint64_t)sndc, need_sig);
 }
+
+enum netvsc_mp_req_type {
+	NETVSC_MP_REQ_VF_REMOVE = 1,
+};
+int netvsc_mp_req_VF(struct hn_data *hv, enum netvsc_mp_req_type type);
diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
index e4bebda147..d4b4b9de9f 100644
--- a/drivers/net/netvsc/hn_vf.c
+++ b/drivers/net/netvsc/hn_vf.c
@@ -155,6 +155,10 @@ static void hn_remove_delayed(void *args)
 		PMD_DRV_LOG(ERR, "rte_eth_dev_close failed port_id=%u ret=%d",
 			    port_id, ret);
 
+	ret = netvsc_mp_req_VF(hv, NETVSC_MP_REQ_VF_REMOVE);
+	if (ret)
+		PMD_DRV_LOG(ERR, "failed to request secondary VF remove");
+
 	/* Remove the rte device when all its eth devices are removed */
 	all_eth_removed = true;
 	RTE_ETH_FOREACH_DEV_OF(port_id, dev) {
-- 
2.43.0

