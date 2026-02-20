Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F821C5518E
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:10:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B09140655;
	Fri, 20 Feb 2026 11:09:37 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 82579402AA;
 Fri, 20 Feb 2026 02:10:11 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id CB71020B6F00; Thu, 19 Feb 2026 17:10:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB71020B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1771549810;
 bh=5lMW9g4r9FckcOkuGP+tuCjupl9kViCkH0BcoqexPZE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ila0nJ1s2GhAu033M6drWSLvt4DVW7i0sBCigcrH0HaF+30pN2EijYIX9MUcJR7Za
 FeoHuLmjV+FdRxWsd8zEHyWQ6EtF87Sqrjw5m0mS2aDcYj925FlGpLfEvLVgNp2Sv2
 hqJ7RWSsilbKbLX1awxqoJeyUWxkWqf3vOF3E684=
From: longli@linux.microsoft.com
To: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Wei Hu <weh@microsoft.com>, stable@dpdk.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 2/8] net/netvsc: fix race conditions on VF add/remove events
Date: Thu, 19 Feb 2026 17:09:32 -0800
Message-ID: <20260220010938.595319-3-longli@linux.microsoft.com>
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

Netvsc gets notification from VSP on VF add/remove over VMBUS, but the
timing may not match the DPDK sequence of device events triggered from
uevents from kernel.

Remove the retry logic from the code when attach to VF and rely on DPDK
event to attach to VF. With this change, both the notifications from VSP
and the DPDK will attempt a VF attach.

Also implement locking when checking on all VF related fields.

Fixes: a2a23a794b3a ("net/netvsc: support VF device hot add/remove")
Cc: stable@dpdk.org

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/netvsc/hn_ethdev.c |   6 +-
 drivers/net/netvsc/hn_rxtx.c   |  40 +++++------
 drivers/net/netvsc/hn_var.h    |   1 +
 drivers/net/netvsc/hn_vf.c     | 118 ++++++++++++++++-----------------
 4 files changed, 79 insertions(+), 86 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 5d7b410f1b..1dcab189e2 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -678,6 +678,7 @@ static void netvsc_hotplug_retry(void *args)
 
 			free(drv_str);
 
+			hn_vf_add(dev, hv);
 			break;
 		}
 	}
@@ -1418,11 +1419,12 @@ eth_hn_dev_init(struct rte_eth_dev *eth_dev)
 	hv->max_queues = RTE_MIN(rxr_cnt, (unsigned int)max_chan);
 
 	/* If VF was reported but not added, do it now */
+	rte_rwlock_write_lock(&hv->vf_lock);
 	if (hv->vf_ctx.vf_vsp_reported && !hv->vf_ctx.vf_vsc_switched) {
 		PMD_INIT_LOG(DEBUG, "Adding VF device");
-
-		err = hn_vf_add(eth_dev, hv);
+		err = __hn_vf_add(eth_dev, hv);
 	}
+	rte_rwlock_write_unlock(&hv->vf_lock);
 
 	return 0;
 
diff --git a/drivers/net/netvsc/hn_rxtx.c b/drivers/net/netvsc/hn_rxtx.c
index 72dab26ede..0d770d1b25 100644
--- a/drivers/net/netvsc/hn_rxtx.c
+++ b/drivers/net/netvsc/hn_rxtx.c
@@ -1540,20 +1540,18 @@ hn_xmit_pkts(void *ptxq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		hn_process_events(hv, txq->queue_id, 0);
 
 	/* Transmit over VF if present and up */
-	if (hv->vf_ctx.vf_vsc_switched) {
-		rte_rwlock_read_lock(&hv->vf_lock);
-		vf_dev = hn_get_vf_dev(hv);
-		if (hv->vf_ctx.vf_vsc_switched && vf_dev &&
-		    vf_dev->data->dev_started) {
-			void *sub_q = vf_dev->data->tx_queues[queue_id];
-
-			nb_tx = (*vf_dev->tx_pkt_burst)
-					(sub_q, tx_pkts, nb_pkts);
-			rte_rwlock_read_unlock(&hv->vf_lock);
-			return nb_tx;
-		}
+	rte_rwlock_read_lock(&hv->vf_lock);
+	vf_dev = hn_get_vf_dev(hv);
+	if (hv->vf_ctx.vf_vsc_switched && vf_dev &&
+	    vf_dev->data->dev_started) {
+		void *sub_q = vf_dev->data->tx_queues[queue_id];
+
+		nb_tx = (*vf_dev->tx_pkt_burst)
+				(sub_q, tx_pkts, nb_pkts);
 		rte_rwlock_read_unlock(&hv->vf_lock);
+		return nb_tx;
 	}
+	rte_rwlock_read_unlock(&hv->vf_lock);
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		struct rte_mbuf *m = tx_pkts[nb_tx];
@@ -1684,17 +1682,15 @@ hn_recv_pkts(void *prxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 					   (void **)rx_pkts, nb_pkts, NULL);
 
 	/* If VF is available, check that as well */
-	if (hv->vf_ctx.vf_vsc_switched) {
-		rte_rwlock_read_lock(&hv->vf_lock);
-		vf_dev = hn_get_vf_dev(hv);
-		if (hv->vf_ctx.vf_vsc_switched && vf_dev &&
-		    vf_dev->data->dev_started)
-			nb_rcv += hn_recv_vf(vf_dev->data->port_id, rxq,
-					     rx_pkts + nb_rcv,
-					     nb_pkts - nb_rcv);
+	rte_rwlock_read_lock(&hv->vf_lock);
+	vf_dev = hn_get_vf_dev(hv);
+	if (hv->vf_ctx.vf_vsc_switched && vf_dev &&
+	    vf_dev->data->dev_started)
+		nb_rcv += hn_recv_vf(vf_dev->data->port_id, rxq,
+				     rx_pkts + nb_rcv,
+				     nb_pkts - nb_rcv);
+	rte_rwlock_read_unlock(&hv->vf_lock);
 
-		rte_rwlock_read_unlock(&hv->vf_lock);
-	}
 	return nb_rcv;
 }
 
diff --git a/drivers/net/netvsc/hn_var.h b/drivers/net/netvsc/hn_var.h
index 17c1d5d07b..32fe373cb6 100644
--- a/drivers/net/netvsc/hn_var.h
+++ b/drivers/net/netvsc/hn_var.h
@@ -239,6 +239,7 @@ hn_get_vf_dev(const struct hn_data *hv)
 int	hn_vf_info_get(struct hn_data *hv,
 		       struct rte_eth_dev_info *info);
 int	hn_vf_add(struct rte_eth_dev *dev, struct hn_data *hv);
+int	__hn_vf_add(struct rte_eth_dev *dev, struct hn_data *hv);
 int	hn_vf_configure_locked(struct rte_eth_dev *dev,
 			       const struct rte_eth_conf *dev_conf);
 const uint32_t *hn_vf_supported_ptypes(struct rte_eth_dev *dev,
diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
index 0ecfaf54ea..e4bebda147 100644
--- a/drivers/net/netvsc/hn_vf.c
+++ b/drivers/net/netvsc/hn_vf.c
@@ -59,8 +59,8 @@ static int hn_vf_attach(struct rte_eth_dev *dev, struct hn_data *hv)
 	int port, ret;
 
 	if (hv->vf_ctx.vf_attached) {
-		PMD_DRV_LOG(ERR, "VF already attached");
-		return 0;
+		PMD_DRV_LOG(NOTICE, "VF already attached");
+		return -EEXIST;
 	}
 
 	port = hn_vf_match(dev);
@@ -91,10 +91,30 @@ static int hn_vf_attach(struct rte_eth_dev *dev, struct hn_data *hv)
 	PMD_DRV_LOG(DEBUG, "Attach VF device %u", port);
 	hv->vf_ctx.vf_attached = true;
 	hv->vf_ctx.vf_port = port;
+
+	ret = rte_eth_dev_callback_register(hv->vf_ctx.vf_port,
+					    RTE_ETH_EVENT_INTR_RMV,
+					    hn_eth_rmv_event_callback,
+					    hv);
+	if (ret) {
+		/* Rollback state changes on callback registration failure */
+		hv->vf_ctx.vf_attached = false;
+		hv->vf_ctx.vf_port = 0;
+
+		/* Release port ownership */
+		if (rte_eth_dev_owner_unset(port, hv->owner.id) < 0)
+			PMD_DRV_LOG(ERR, "Failed to unset owner for port %d", port);
+
+		PMD_DRV_LOG(ERR,
+			    "Registering callback failed for vf port %d ret %d",
+			    port, ret);
+		return ret;
+	}
+
 	return 0;
 }
 
-static void hn_vf_remove(struct hn_data *hv);
+static void __hn_vf_remove(struct hn_data *hv);
 
 static void hn_remove_delayed(void *args)
 {
@@ -104,12 +124,12 @@ static void hn_remove_delayed(void *args)
 	int ret;
 	bool all_eth_removed;
 
-	/* Tell VSP to switch data path to synthetic */
-	hn_vf_remove(hv);
-
 	PMD_DRV_LOG(NOTICE, "Start to remove port %d", port_id);
 	rte_rwlock_write_lock(&hv->vf_lock);
 
+	/* Tell VSP to switch data path to synthetic */
+	__hn_vf_remove(hv);
+
 	/* Give back ownership */
 	ret = rte_eth_dev_owner_unset(port_id, hv->owner.id);
 	if (ret)
@@ -213,36 +233,20 @@ static int hn_setup_vf_queues(int port, struct rte_eth_dev *dev)
 	return ret;
 }
 
-int hn_vf_add(struct rte_eth_dev *dev, struct hn_data *hv);
-
-static void hn_vf_add_retry(void *args)
-{
-	struct rte_eth_dev *dev = args;
-	struct hn_data *hv = dev->data->dev_private;
-
-	hn_vf_add(dev, hv);
-}
-
 int hn_vf_configure(struct rte_eth_dev *dev,
 		    const struct rte_eth_conf *dev_conf);
 
-/* Add new VF device to synthetic device */
-int hn_vf_add(struct rte_eth_dev *dev, struct hn_data *hv)
+/* Add new VF device to synthetic device, unlocked version */
+int __hn_vf_add(struct rte_eth_dev *dev, struct hn_data *hv)
 {
-	int ret, port;
+	int ret = 0, port;
 
 	if (!hv->vf_ctx.vf_vsp_reported || hv->vf_ctx.vf_vsc_switched)
-		return 0;
-
-	rte_rwlock_write_lock(&hv->vf_lock);
+		goto exit;
 
 	ret = hn_vf_attach(dev, hv);
-	if (ret) {
-		PMD_DRV_LOG(NOTICE,
-			    "RNDIS reports VF but device not found, retrying");
-		rte_eal_alarm_set(1000000, hn_vf_add_retry, dev);
+	if (ret && ret != -EEXIST)
 		goto exit;
-	}
 
 	port = hv->vf_ctx.vf_port;
 
@@ -252,7 +256,7 @@ int hn_vf_add(struct rte_eth_dev *dev, struct hn_data *hv)
 	if (dev->data->dev_started) {
 		if (rte_eth_devices[port].data->dev_started) {
 			PMD_DRV_LOG(ERR, "VF already started on hot add");
-			goto exit;
+			goto switch_data_path;
 		}
 
 		PMD_DRV_LOG(NOTICE, "configuring VF port %d", port);
@@ -287,26 +291,32 @@ int hn_vf_add(struct rte_eth_dev *dev, struct hn_data *hv)
 		hv->vf_ctx.vf_state = vf_started;
 	}
 
+switch_data_path:
 	ret = hn_nvs_set_datapath(hv, NVS_DATAPATH_VF);
 	if (ret == 0)
 		hv->vf_ctx.vf_vsc_switched = true;
 
 exit:
-	rte_rwlock_write_unlock(&hv->vf_lock);
 	return ret;
 }
 
-/* Switch data path to VF device */
-static void hn_vf_remove(struct hn_data *hv)
+/* Add new VF device to synthetic device, locked version */
+int hn_vf_add(struct rte_eth_dev *dev, struct hn_data *hv)
 {
 	int ret;
 
-	if (!hv->vf_ctx.vf_vsc_switched) {
-		PMD_DRV_LOG(ERR, "VF path not active");
-		return;
-	}
-
 	rte_rwlock_write_lock(&hv->vf_lock);
+	ret = __hn_vf_add(dev, hv);
+	rte_rwlock_write_unlock(&hv->vf_lock);
+
+	return ret;
+}
+
+/* Switch data path to VF device, unlocked version */
+static void __hn_vf_remove(struct hn_data *hv)
+{
+	int ret;
+
 	if (!hv->vf_ctx.vf_vsc_switched) {
 		PMD_DRV_LOG(ERR, "VF path not active");
 	} else {
@@ -314,9 +324,9 @@ static void hn_vf_remove(struct hn_data *hv)
 		ret = hn_nvs_set_datapath(hv, NVS_DATAPATH_SYNTHETIC);
 		if (ret)
 			PMD_DRV_LOG(ERR, "Failed to switch to synthetic");
-		hv->vf_ctx.vf_vsc_switched = false;
+		else
+			hv->vf_ctx.vf_vsc_switched = false;
 	}
-	rte_rwlock_write_unlock(&hv->vf_lock);
 }
 
 /* Handle VF association message from host */
@@ -338,14 +348,17 @@ hn_nvs_handle_vfassoc(struct rte_eth_dev *dev,
 		    vf_assoc->allocated ? "add to" : "remove from",
 		    dev->data->port_id);
 
-	hv->vf_ctx.vf_vsp_reported = vf_assoc->allocated;
+	rte_rwlock_write_lock(&hv->vf_lock);
 
+	hv->vf_ctx.vf_vsp_reported = vf_assoc->allocated;
 	if (dev->state == RTE_ETH_DEV_ATTACHED) {
 		if (vf_assoc->allocated)
-			hn_vf_add(dev, hv);
+			__hn_vf_add(dev, hv);
 		else
-			hn_vf_remove(hv);
+			__hn_vf_remove(hv);
 	}
+
+	rte_rwlock_write_unlock(&hv->vf_lock);
 }
 
 static void
@@ -426,29 +439,12 @@ int hn_vf_configure(struct rte_eth_dev *dev,
 	vf_conf.intr_conf.rmv = 1;
 
 	if (hv->vf_ctx.vf_attached) {
-		ret = rte_eth_dev_callback_register(hv->vf_ctx.vf_port,
-						    RTE_ETH_EVENT_INTR_RMV,
-						    hn_eth_rmv_event_callback,
-						    hv);
-		if (ret) {
-			PMD_DRV_LOG(ERR,
-				    "Registering callback failed for vf port %d ret %d",
-				    hv->vf_ctx.vf_port, ret);
-			return ret;
-		}
-
 		ret = rte_eth_dev_configure(hv->vf_ctx.vf_port,
 					    dev->data->nb_rx_queues,
 					    dev->data->nb_tx_queues,
 					    &vf_conf);
 		if (ret) {
 			PMD_DRV_LOG(ERR, "VF configuration failed: %d", ret);
-
-			rte_eth_dev_callback_unregister(hv->vf_ctx.vf_port,
-							RTE_ETH_EVENT_INTR_RMV,
-							hn_eth_rmv_event_callback,
-							hv);
-
 			return ret;
 		}
 
@@ -555,9 +551,7 @@ int hn_vf_close(struct rte_eth_dev *dev)
 	int ret = 0;
 	struct hn_data *hv = dev->data->dev_private;
 
-	rte_eal_alarm_cancel(hn_vf_add_retry, dev);
-
-	rte_rwlock_read_lock(&hv->vf_lock);
+	rte_rwlock_write_lock(&hv->vf_lock);
 	if (hv->vf_ctx.vf_attached) {
 		rte_eth_dev_callback_unregister(hv->vf_ctx.vf_port,
 						RTE_ETH_EVENT_INTR_RMV,
@@ -567,7 +561,7 @@ int hn_vf_close(struct rte_eth_dev *dev)
 		ret = rte_eth_dev_close(hv->vf_ctx.vf_port);
 		hv->vf_ctx.vf_attached = false;
 	}
-	rte_rwlock_read_unlock(&hv->vf_lock);
+	rte_rwlock_write_unlock(&hv->vf_lock);
 
 	return ret;
 }
-- 
2.43.0

