Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90AAFF8864
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 08:51:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AADA40664;
	Wed, 29 Apr 2026 10:51:30 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3C8BE4027A;
 Wed, 29 Apr 2026 10:51:29 +0200 (CEST)
Received: from alhe-weh-mana-dpdk-s2.corp.microsoft.com (unknown
 [131.107.1.160])
 by linux.microsoft.com (Postfix) with ESMTPSA id 5122820B716E;
 Wed, 29 Apr 2026 01:51:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5122820B716E
From: Wei Hu <weh@microsoft.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	stable@dpdk.org
Cc: longli@microsoft.com,
	weh@microsoft.com
Subject: [PATCH 2/2] net/netvsc: handle VF recovery events for service reset
Date: Wed, 29 Apr 2026 01:49:55 -0700
Message-Id: <20260429084955.39164-3-weh@microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429084955.39164-1-weh@microsoft.com>
References: <20260429084955.39164-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Register callbacks for RTE_ETH_EVENT_ERR_RECOVERING,
RTE_ETH_EVENT_RECOVERY_SUCCESS, and RTE_ETH_EVENT_RECOVERY_FAILED
events on the VF port to handle MANA service resets.

- On ERR_RECOVERING: switch data path to synthetic but keep the
  VF device attached in DPDK
- On RECOVERY_SUCCESS: switch data path back to VF
- On RECOVERY_FAILED: do full VF removal (same as INTR_RMV)
- Unregister all recovery callbacks during detach, removal, and
  close

This ensures that during a service reset (kernel suspend/resume
without PCI remove), netvsc keeps the VF attached and seamlessly
switches back to it after recovery, without requiring a PCI
hot-add event.

Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: Wei Hu <weh@microsoft.com>
---
 drivers/net/netvsc/hn_vf.c | 106 +++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
index 1fcc65a712..366efb721f 100644
--- a/drivers/net/netvsc/hn_vf.c
+++ b/drivers/net/netvsc/hn_vf.c
@@ -50,6 +50,13 @@ static int hn_vf_match(const struct rte_eth_dev *dev)
 }
 
 
+static int hn_eth_recovering_callback(uint16_t port_id,
+	enum rte_eth_event_type event, void *cb_arg, void *out);
+static int hn_eth_recovery_success_callback(uint16_t port_id,
+	enum rte_eth_event_type event, void *cb_arg, void *out);
+static int hn_eth_recovery_failed_callback(uint16_t port_id,
+	enum rte_eth_event_type event, void *cb_arg, void *out);
+
 /*
  * Attach new PCI VF device and return the port_id
  */
@@ -111,6 +118,17 @@ static int hn_vf_attach(struct rte_eth_dev *dev, struct hn_data *hv)
 		return ret;
 	}
 
+	/* Register recovery event callbacks for service reset handling */
+	rte_eth_dev_callback_register(hv->vf_ctx.vf_port,
+				      RTE_ETH_EVENT_ERR_RECOVERING,
+				      hn_eth_recovering_callback, hv);
+	rte_eth_dev_callback_register(hv->vf_ctx.vf_port,
+				      RTE_ETH_EVENT_RECOVERY_SUCCESS,
+				      hn_eth_recovery_success_callback, hv);
+	rte_eth_dev_callback_register(hv->vf_ctx.vf_port,
+				      RTE_ETH_EVENT_RECOVERY_FAILED,
+				      hn_eth_recovery_failed_callback, hv);
+
 	return 0;
 }
 
@@ -143,6 +161,12 @@ static void hn_remove_delayed(void *args)
 		PMD_DRV_LOG(ERR,
 			    "rte_eth_dev_callback_unregister failed ret=%d",
 			    ret);
+	rte_eth_dev_callback_unregister(port_id, RTE_ETH_EVENT_ERR_RECOVERING,
+					hn_eth_recovering_callback, hv);
+	rte_eth_dev_callback_unregister(port_id, RTE_ETH_EVENT_RECOVERY_SUCCESS,
+					hn_eth_recovery_success_callback, hv);
+	rte_eth_dev_callback_unregister(port_id, RTE_ETH_EVENT_RECOVERY_FAILED,
+					hn_eth_recovery_failed_callback, hv);
 
 	/* Detach and release port_id from system */
 	ret = rte_eth_dev_stop(port_id);
@@ -187,6 +211,70 @@ int hn_eth_rmv_event_callback(uint16_t port_id,
 	return 0;
 }
 
+/*
+ * Handle VF error recovery event from MANA PMD.
+ * Switch data path to synthetic but keep the VF attached.
+ */
+static int
+hn_eth_recovering_callback(uint16_t port_id,
+			   enum rte_eth_event_type event __rte_unused,
+			   void *cb_arg, void *out __rte_unused)
+{
+	struct hn_data *hv = cb_arg;
+
+	PMD_DRV_LOG(NOTICE, "VF port %u recovering from error", port_id);
+
+	rte_rwlock_write_lock(&hv->vf_lock);
+	hn_vf_remove_unlocked(hv);
+	rte_rwlock_write_unlock(&hv->vf_lock);
+
+	return 0;
+}
+
+/*
+ * Handle VF recovery success event from MANA PMD.
+ * Switch data path back to VF.
+ */
+static int
+hn_eth_recovery_success_callback(uint16_t port_id,
+				 enum rte_eth_event_type event __rte_unused,
+				 void *cb_arg, void *out __rte_unused)
+{
+	struct hn_data *hv = cb_arg;
+	int ret;
+
+	PMD_DRV_LOG(NOTICE, "VF port %u recovery succeeded", port_id);
+
+	rte_rwlock_write_lock(&hv->vf_lock);
+	if (hv->vf_ctx.vf_attached && !hv->vf_ctx.vf_vsc_switched) {
+		ret = hn_nvs_set_datapath(hv, NVS_DATAPATH_VF);
+		if (ret)
+			PMD_DRV_LOG(ERR, "Failed to switch to VF after recovery");
+		else
+			hv->vf_ctx.vf_vsc_switched = true;
+	}
+	rte_rwlock_write_unlock(&hv->vf_lock);
+
+	return 0;
+}
+
+/*
+ * Handle VF recovery failure event from MANA PMD.
+ * VF is unusable, do full removal.
+ */
+static int
+hn_eth_recovery_failed_callback(uint16_t port_id,
+				enum rte_eth_event_type event __rte_unused,
+				void *cb_arg, void *out __rte_unused)
+{
+	struct hn_data *hv = cb_arg;
+
+	PMD_DRV_LOG(NOTICE, "VF port %u recovery failed, removing", port_id);
+	rte_eal_alarm_set(1, hn_remove_delayed, hv);
+
+	return 0;
+}
+
 static int hn_setup_vf_queues(int port, struct rte_eth_dev *dev)
 {
 	struct hn_rx_queue *rx_queue;
@@ -247,6 +335,12 @@ static void hn_vf_detach(struct hn_data *hv)
 
 	rte_eth_dev_callback_unregister(port, RTE_ETH_EVENT_INTR_RMV,
 					hn_eth_rmv_event_callback, hv);
+	rte_eth_dev_callback_unregister(port, RTE_ETH_EVENT_ERR_RECOVERING,
+					hn_eth_recovering_callback, hv);
+	rte_eth_dev_callback_unregister(port, RTE_ETH_EVENT_RECOVERY_SUCCESS,
+					hn_eth_recovery_success_callback, hv);
+	rte_eth_dev_callback_unregister(port, RTE_ETH_EVENT_RECOVERY_FAILED,
+					hn_eth_recovery_failed_callback, hv);
 
 	if (rte_eth_dev_owner_unset(port, hv->owner.id) < 0)
 		PMD_DRV_LOG(ERR, "Failed to unset owner for port %d", port);
@@ -630,6 +724,18 @@ int hn_vf_close(struct rte_eth_dev *dev)
 						RTE_ETH_EVENT_INTR_RMV,
 						hn_eth_rmv_event_callback,
 						hv);
+		rte_eth_dev_callback_unregister(hv->vf_ctx.vf_port,
+						RTE_ETH_EVENT_ERR_RECOVERING,
+						hn_eth_recovering_callback,
+						hv);
+		rte_eth_dev_callback_unregister(hv->vf_ctx.vf_port,
+						RTE_ETH_EVENT_RECOVERY_SUCCESS,
+						hn_eth_recovery_success_callback,
+						hv);
+		rte_eth_dev_callback_unregister(hv->vf_ctx.vf_port,
+						RTE_ETH_EVENT_RECOVERY_FAILED,
+						hn_eth_recovery_failed_callback,
+						hv);
 		rte_eal_alarm_cancel(hn_remove_delayed, hv);
 		ret = rte_eth_dev_close(hv->vf_ctx.vf_port);
 		hv->vf_ctx.vf_attached = false;
-- 
2.34.1

