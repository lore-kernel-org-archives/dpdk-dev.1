Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89518FD375F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 13:58:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37902402F2;
	Wed, 25 Feb 2026 14:58:32 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id A0BB3402AA;
 Wed, 25 Feb 2026 03:02:53 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 1D3CF20B6F02; Tue, 24 Feb 2026 18:02:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1D3CF20B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1771984973;
 bh=tRwbg53btlr+4MYkPkoFE6/DWkiLsj6X558/jyX6uBo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pU7Mri0CEMda6ljA/fp2+tXOlG3N1wBSpzMmmeYmZUwqAgiuUVDKNMjXKMzsvfEia
 wQLtgcMmWM+YXQI8QXn/Czux9aLnG8b5RUxjP+ZahJ9GbP56CuEOFSBqW2bpb3ZcX9
 Djq02iRRgBVdjfh0MsvsKQe9sMJy9y4ub9R1xhz0=
From: longli@linux.microsoft.com
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v3 1/7] net/netvsc: fix race conditions on VF add/remove events
Date: Tue, 24 Feb 2026 18:02:33 -0800
Message-ID: <20260225020246.890306-2-longli@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260225020246.890306-1-longli@linux.microsoft.com>
References: <20260225020246.890306-1-longli@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:58:29 +0100
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
v3:
- No changes from v2 (was patch 2 in v2)

v2:
- Rename __hn_vf_add/__hn_vf_remove to hn_vf_add_unlocked/
  hn_vf_remove_unlocked to avoid C-reserved double-underscore
  prefix (C99 7.1.3)
- Add hn_vf_detach() cleanup helper to reverse hn_vf_attach()
  when VF configure/start fails, preventing half-attached VF state
- Unconditionally clear vf_vsc_switched on VF remove since the VF
  is being removed regardless of hn_nvs_set_datapath() result
---
 drivers/net/netvsc/hn_ethdev.c |   6 +-
 drivers/net/netvsc/hn_rxtx.c   |  40 +++++-----
 drivers/net/netvsc/hn_var.h    |   1 +
 drivers/net/netvsc/hn_vf.c     | 140 ++++++++++++++++++---------------
 4 files changed, 100 insertions(+), 87 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 6584819f4f..6068c225fd 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -672,6 +672,7 @@ static void netvsc_hotplug_retry(void *args)
 
 			free(drv_str);
 
+			hn_vf_add(dev, hv);
 			break;
 		}
 	}
@@ -1412,11 +1413,12 @@ eth_hn_dev_init(struct rte_eth_dev *eth_dev)
 	hv->max_queues = RTE_MIN(rxr_cnt, (unsigned int)max_chan);
 
 	/* If VF was reported but not added, do it now */
+	rte_rwlock_write_lock(&hv->vf_lock);
 	if (hv->vf_ctx.vf_vsp_reported && !hv->vf_ctx.vf_vsc_switched) {
 		PMD_INIT_LOG(DEBUG, "Adding VF device");
-
-		err = hn_vf_add(eth_dev, hv);
+		err = hn_vf_add_unlocked(eth_dev, hv);
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
index 17c1d5d07b..ef55dee28e 100644
--- a/drivers/net/netvsc/hn_var.h
+++ b/drivers/net/netvsc/hn_var.h
@@ -239,6 +239,7 @@ hn_get_vf_dev(const struct hn_data *hv)
 int	hn_vf_info_get(struct hn_data *hv,
 		       struct rte_eth_dev_info *info);
 int	hn_vf_add(struct rte_eth_dev *dev, struct hn_data *hv);
+int	hn_vf_add_unlocked(struct rte_eth_dev *dev, struct hn_data *hv);
 int	hn_vf_configure_locked(struct rte_eth_dev *dev,
 			       const struct rte_eth_conf *dev_conf);
 const uint32_t *hn_vf_supported_ptypes(struct rte_eth_dev *dev,
diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
index 0ecfaf54ea..64c89130f5 100644
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
+static void hn_vf_remove_unlocked(struct hn_data *hv);
 
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
+	hn_vf_remove_unlocked(hv);
+
 	/* Give back ownership */
 	ret = rte_eth_dev_owner_unset(port_id, hv->owner.id);
 	if (ret)
@@ -213,36 +233,35 @@ static int hn_setup_vf_queues(int port, struct rte_eth_dev *dev)
 	return ret;
 }
 
-int hn_vf_add(struct rte_eth_dev *dev, struct hn_data *hv);
+int hn_vf_configure(struct rte_eth_dev *dev,
+		    const struct rte_eth_conf *dev_conf);
 
-static void hn_vf_add_retry(void *args)
+/* Undo hn_vf_attach() on configure/start failure */
+static void hn_vf_detach(struct hn_data *hv)
 {
-	struct rte_eth_dev *dev = args;
-	struct hn_data *hv = dev->data->dev_private;
+	uint16_t port = hv->vf_ctx.vf_port;
 
-	hn_vf_add(dev, hv);
-}
+	rte_eth_dev_callback_unregister(port, RTE_ETH_EVENT_INTR_RMV,
+					hn_eth_rmv_event_callback, hv);
 
-int hn_vf_configure(struct rte_eth_dev *dev,
-		    const struct rte_eth_conf *dev_conf);
+	if (rte_eth_dev_owner_unset(port, hv->owner.id) < 0)
+		PMD_DRV_LOG(ERR, "Failed to unset owner for port %d", port);
 
-/* Add new VF device to synthetic device */
-int hn_vf_add(struct rte_eth_dev *dev, struct hn_data *hv)
+	hv->vf_ctx.vf_attached = false;
+	hv->vf_ctx.vf_port = 0;
+}
+
+/* Add new VF device to synthetic device, unlocked version */
+int hn_vf_add_unlocked(struct rte_eth_dev *dev, struct hn_data *hv)
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
 
@@ -252,7 +271,7 @@ int hn_vf_add(struct rte_eth_dev *dev, struct hn_data *hv)
 	if (dev->data->dev_started) {
 		if (rte_eth_devices[port].data->dev_started) {
 			PMD_DRV_LOG(ERR, "VF already started on hot add");
-			goto exit;
+			goto switch_data_path;
 		}
 
 		PMD_DRV_LOG(NOTICE, "configuring VF port %d", port);
@@ -260,7 +279,7 @@ int hn_vf_add(struct rte_eth_dev *dev, struct hn_data *hv)
 		if (ret) {
 			PMD_DRV_LOG(ERR, "Failed to configure VF port %d",
 				    port);
-			goto exit;
+			goto detach;
 		}
 
 		ret = hn_setup_vf_queues(port, dev);
@@ -268,13 +287,13 @@ int hn_vf_add(struct rte_eth_dev *dev, struct hn_data *hv)
 			PMD_DRV_LOG(ERR,
 				    "Failed to configure VF queues port %d",
 				    port);
-			goto exit;
+			goto detach;
 		}
 
 		ret = rte_eth_dev_set_mtu(port, dev->data->mtu);
 		if (ret) {
 			PMD_DRV_LOG(ERR, "Failed to set VF MTU");
-			goto exit;
+			goto detach;
 		}
 
 		PMD_DRV_LOG(NOTICE, "Starting VF port %d", port);
@@ -282,31 +301,41 @@ int hn_vf_add(struct rte_eth_dev *dev, struct hn_data *hv)
 		if (ret) {
 			PMD_DRV_LOG(ERR, "rte_eth_dev_start failed ret=%d",
 				    ret);
-			goto exit;
+			goto detach;
 		}
 		hv->vf_ctx.vf_state = vf_started;
 	}
 
+switch_data_path:
 	ret = hn_nvs_set_datapath(hv, NVS_DATAPATH_VF);
 	if (ret == 0)
 		hv->vf_ctx.vf_vsc_switched = true;
 
 exit:
-	rte_rwlock_write_unlock(&hv->vf_lock);
+	return ret;
+
+detach:
+	hn_vf_detach(hv);
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
+	ret = hn_vf_add_unlocked(dev, hv);
+	rte_rwlock_write_unlock(&hv->vf_lock);
+
+	return ret;
+}
+
+/* Switch data path to synthetic, unlocked version */
+static void hn_vf_remove_unlocked(struct hn_data *hv)
+{
+	int ret;
+
 	if (!hv->vf_ctx.vf_vsc_switched) {
 		PMD_DRV_LOG(ERR, "VF path not active");
 	} else {
@@ -314,9 +343,10 @@ static void hn_vf_remove(struct hn_data *hv)
 		ret = hn_nvs_set_datapath(hv, NVS_DATAPATH_SYNTHETIC);
 		if (ret)
 			PMD_DRV_LOG(ERR, "Failed to switch to synthetic");
+
+		/* Clear switched flag regardless — VF is being removed */
 		hv->vf_ctx.vf_vsc_switched = false;
 	}
-	rte_rwlock_write_unlock(&hv->vf_lock);
 }
 
 /* Handle VF association message from host */
@@ -338,14 +368,17 @@ hn_nvs_handle_vfassoc(struct rte_eth_dev *dev,
 		    vf_assoc->allocated ? "add to" : "remove from",
 		    dev->data->port_id);
 
-	hv->vf_ctx.vf_vsp_reported = vf_assoc->allocated;
+	rte_rwlock_write_lock(&hv->vf_lock);
 
+	hv->vf_ctx.vf_vsp_reported = vf_assoc->allocated;
 	if (dev->state == RTE_ETH_DEV_ATTACHED) {
 		if (vf_assoc->allocated)
-			hn_vf_add(dev, hv);
+			hn_vf_add_unlocked(dev, hv);
 		else
-			hn_vf_remove(hv);
+			hn_vf_remove_unlocked(hv);
 	}
+
+	rte_rwlock_write_unlock(&hv->vf_lock);
 }
 
 static void
@@ -426,29 +459,12 @@ int hn_vf_configure(struct rte_eth_dev *dev,
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
 
@@ -555,9 +571,7 @@ int hn_vf_close(struct rte_eth_dev *dev)
 	int ret = 0;
 	struct hn_data *hv = dev->data->dev_private;
 
-	rte_eal_alarm_cancel(hn_vf_add_retry, dev);
-
-	rte_rwlock_read_lock(&hv->vf_lock);
+	rte_rwlock_write_lock(&hv->vf_lock);
 	if (hv->vf_ctx.vf_attached) {
 		rte_eth_dev_callback_unregister(hv->vf_ctx.vf_port,
 						RTE_ETH_EVENT_INTR_RMV,
@@ -567,7 +581,7 @@ int hn_vf_close(struct rte_eth_dev *dev)
 		ret = rte_eth_dev_close(hv->vf_ctx.vf_port);
 		hv->vf_ctx.vf_attached = false;
 	}
-	rte_rwlock_read_unlock(&hv->vf_lock);
+	rte_rwlock_write_unlock(&hv->vf_lock);
 
 	return ret;
 }
-- 
2.43.0

