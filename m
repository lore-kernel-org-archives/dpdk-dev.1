Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7EAFD45E3
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 19:50:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0586440279;
	Wed, 25 Feb 2026 20:50:55 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 83D84400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 20:50:53 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 065DA20B6F02; Wed, 25 Feb 2026 11:50:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 065DA20B6F02
From: Long Li <longli@microsoft.com>
To: Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: [PATCH] net/netvsc: support runtime queue count reconfiguration
Date: Wed, 25 Feb 2026 11:50:40 -0800
Message-ID: <20260225195040.945067-1-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
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

Add support for changing the number of RX/TX queues at runtime
via port stop/configure/start. When the queue count changes,
perform a full NVS/RNDIS teardown and reinit to allocate fresh
VMBus subchannels matching the new queue count, then reconfigure
RSS indirection table accordingly.

Key changes:
- hn_dev_configure: detect queue count changes and perform full
  NVS session reinit with subchannel teardown/recreation
- hn_dev_stop: drain pending TX completions (up to 1s) to prevent
  stale completions from corrupting queue state after reconfig
- eth_hn_dev_uninit: close subchannels before primary channel to
  prevent resource leaks on device removal
- hn_vf_tx/rx_queue_release: null VF queue pointers after release
  to prevent use-after-free when the ethdev framework releases
  excess queues during VF reconfiguration

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/netvsc/hn_ethdev.c | 151 ++++++++++++++++++++++++++++++++-
 drivers/net/netvsc/hn_vf.c     |   8 +-
 2 files changed, 154 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 6584819f4f..a0bb37a66c 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -745,6 +745,9 @@ netvsc_hotadd_callback(const char *device_name, enum rte_dev_event_type type,
 	}
 }
 
+static void hn_detach(struct hn_data *hv);
+static int hn_attach(struct hn_data *hv, unsigned int mtu);
+
 static int hn_dev_configure(struct rte_eth_dev *dev)
 {
 	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
@@ -754,6 +757,7 @@ static int hn_dev_configure(struct rte_eth_dev *dev)
 	struct hn_data *hv = dev->data->dev_private;
 	uint64_t unsupported;
 	int i, err, subchan;
+	uint32_t old_subchans = 0;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -778,6 +782,7 @@ static int hn_dev_configure(struct rte_eth_dev *dev)
 
 	hv->vlan_strip = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
 
+	/* Configure RNDIS offload regardless of queue count change */
 	err = hn_rndis_conf_offload(hv, txmode->offloads,
 				    rxmode->offloads);
 	if (err) {
@@ -786,28 +791,93 @@ static int hn_dev_configure(struct rte_eth_dev *dev)
 		return err;
 	}
 
+	/* If queue count unchanged, skip subchannel teardown/reinit */
+	if (RTE_MAX(dev->data->nb_rx_queues,
+		    dev->data->nb_tx_queues) == hv->num_queues)
+		goto skip_reinit;
+
 	hv->num_queues = RTE_MAX(dev->data->nb_rx_queues,
 				 dev->data->nb_tx_queues);
 
+	/* Close all existing subchannels */
+	for (i = 1; i < HN_MAX_CHANNELS; i++) {
+		if (hv->channels[i] != NULL) {
+			rte_vmbus_chan_close(hv->channels[i]);
+			hv->channels[i] = NULL;
+			old_subchans++;
+		}
+	}
+
+	/*
+	 * If subchannels existed, do a full NVS/RNDIS teardown
+	 * and vmbus re-init to ensure a clean NVS session.
+	 * Cannot re-send NVS subchannel request on the same
+	 * session without invalidating the data path.
+	 */
+	if (old_subchans > 0) {
+		PMD_DRV_LOG(NOTICE,
+			    "reinit NVS (had %u subchannels)",
+			    old_subchans);
+
+		hn_detach(hv);
+
+		rte_vmbus_chan_close(hv->channels[0]);
+		rte_free(hv->channels[0]);
+		hv->channels[0] = NULL;
+
+		rte_vmbus_unmap_device(hv->vmbus);
+		err = rte_vmbus_map_device(hv->vmbus);
+		if (err) {
+			PMD_DRV_LOG(ERR,
+				    "Could not re-map vmbus device!");
+			goto reinit_failed;
+		}
+
+		hv->rxbuf_res = hv->vmbus->resource[HV_RECV_BUF_MAP];
+		hv->chim_res  = hv->vmbus->resource[HV_SEND_BUF_MAP];
+
+		err = rte_vmbus_chan_open(hv->vmbus, &hv->channels[0]);
+		if (err) {
+			PMD_DRV_LOG(ERR,
+				    "Could not re-open vmbus channel!");
+			goto reinit_failed;
+		}
+
+		rte_vmbus_set_latency(hv->vmbus, hv->channels[0],
+				      hv->latency);
+
+		err = hn_attach(hv, dev->data->mtu);
+		if (err) {
+			rte_vmbus_chan_close(hv->channels[0]);
+			rte_free(hv->channels[0]);
+			hv->channels[0] = NULL;
+			PMD_DRV_LOG(ERR,
+				    "NVS reinit failed: %d", err);
+			goto reinit_failed;
+		}
+	}
+
 	for (i = 0; i < NDIS_HASH_INDCNT; i++)
 		hv->rss_ind[i] = i % dev->data->nb_rx_queues;
 
 	hn_rss_hash_init(hv, rss_conf);
 
 	subchan = hv->num_queues - 1;
+
+	/* Allocate fresh subchannels and configure RSS */
 	if (subchan > 0) {
 		err = hn_subchan_configure(hv, subchan);
 		if (err) {
 			PMD_DRV_LOG(NOTICE,
 				    "subchannel configuration failed");
-			return err;
+			goto subchan_cleanup;
 		}
 
 		err = hn_rndis_conf_rss(hv, NDIS_RSS_FLAG_DISABLE);
 		if (err) {
 			PMD_DRV_LOG(NOTICE,
 				"rss disable failed");
-			return err;
+			goto subchan_cleanup;
 		}
 
 		if (rss_conf->rss_hf != 0) {
@@ -815,12 +885,53 @@ static int hn_dev_configure(struct rte_eth_dev *dev)
 			if (err) {
 				PMD_DRV_LOG(NOTICE,
 					    "initial RSS config failed");
-				return err;
+				goto subchan_cleanup;
 			}
 		}
 	}
 
+skip_reinit:
 	return hn_vf_configure_locked(dev, dev_conf);
+
+subchan_cleanup:
+	for (i = 1; i < HN_MAX_CHANNELS; i++) {
+		if (hv->channels[i] != NULL) {
+			rte_vmbus_chan_close(hv->channels[i]);
+			hv->channels[i] = NULL;
+		}
+	}
+	hv->num_queues = 1;
+	return err;
+
+reinit_failed:
+	/* Device is in a broken state after failed reinit.
+	 * Try to re-establish minimal connectivity.
+	 */
+	PMD_DRV_LOG(ERR,
+		    "reinit failed (err %d), attempting recovery", err);
+	if (hv->channels[0] == NULL) {
+		if (rte_vmbus_chan_open(hv->vmbus, &hv->channels[0]) == 0) {
+			if (hn_attach(hv, dev->data->mtu) == 0) {
+				hv->num_queues = 1;
+				PMD_DRV_LOG(NOTICE,
+					    "recovery successful on primary channel");
+			} else {
+				rte_vmbus_chan_close(hv->channels[0]);
+				rte_free(hv->channels[0]);
+				hv->channels[0] = NULL;
+				hv->num_queues = 0;
+				PMD_DRV_LOG(ERR,
+					    "recovery failed, device unusable");
+			}
+		} else {
+			hv->num_queues = 0;
+			PMD_DRV_LOG(ERR,
+				    "recovery failed, device unusable");
+		}
+	} else {
+		hv->num_queues = 1;
+	}
+	return err;
 }
 
 static int hn_dev_stats_get(struct rte_eth_dev *dev,
@@ -1067,6 +1178,7 @@ hn_dev_stop(struct rte_eth_dev *dev)
 {
 	struct hn_data *hv = dev->data->dev_private;
 	int i, ret;
+	unsigned int retry;
 
 	PMD_INIT_FUNC_TRACE();
 	dev->data->dev_started = 0;
@@ -1075,6 +1187,29 @@ hn_dev_stop(struct rte_eth_dev *dev)
 	hn_rndis_set_rxfilter(hv, 0);
 	ret = hn_vf_stop(dev);
 
+	/*
+	 * Drain pending TX completions to prevent stale completions
+	 * from corrupting queue state after port reconfiguration.
+	 */
+	for (retry = 0; retry < 100; retry++) {
+		uint32_t pending = 0;
+
+		for (i = 0; i < hv->num_queues; i++) {
+			struct hn_tx_queue *txq = dev->data->tx_queues[i];
+
+			if (txq == NULL)
+				continue;
+			hn_process_events(hv, i, 0);
+			pending += rte_mempool_in_use_count(txq->txdesc_pool);
+		}
+		if (pending == 0)
+			break;
+		rte_delay_ms(10);
+	}
+	if (retry >= 100)
+		PMD_DRV_LOG(WARNING,
+			    "Failed to drain all TX completions");
+
 	for (i = 0; i < hv->num_queues; i++) {
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
@@ -1433,6 +1568,7 @@ eth_hn_dev_uninit(struct rte_eth_dev *eth_dev)
 {
 	struct hn_data *hv = eth_dev->data->dev_private;
 	int ret, ret_stop;
+	int i;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -1444,6 +1580,15 @@ eth_hn_dev_uninit(struct rte_eth_dev *eth_dev)
 
 	hn_detach(hv);
 	hn_chim_uninit(eth_dev);
+
+	/* Close any subchannels before closing the primary channel */
+	for (i = 1; i < HN_MAX_CHANNELS; i++) {
+		if (hv->channels[i] != NULL) {
+			rte_vmbus_chan_close(hv->channels[i]);
+			hv->channels[i] = NULL;
+		}
+	}
+
 	rte_vmbus_chan_close(hv->channels[0]);
 	rte_free(hv->primary);
 	ret = rte_eth_dev_owner_delete(hv->owner.id);
diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
index 0ecfaf54ea..756241e58d 100644
--- a/drivers/net/netvsc/hn_vf.c
+++ b/drivers/net/netvsc/hn_vf.c
@@ -639,8 +639,10 @@ void hn_vf_tx_queue_release(struct hn_data *hv, uint16_t queue_id)
 
 	rte_rwlock_read_lock(&hv->vf_lock);
 	vf_dev = hn_get_vf_dev(hv);
-	if (vf_dev && vf_dev->dev_ops->tx_queue_release)
+	if (vf_dev && vf_dev->dev_ops->tx_queue_release) {
 		(*vf_dev->dev_ops->tx_queue_release)(vf_dev, queue_id);
+		vf_dev->data->tx_queues[queue_id] = NULL;
+	}
 
 	rte_rwlock_read_unlock(&hv->vf_lock);
 }
@@ -671,8 +673,10 @@ void hn_vf_rx_queue_release(struct hn_data *hv, uint16_t queue_id)
 
 	rte_rwlock_read_lock(&hv->vf_lock);
 	vf_dev = hn_get_vf_dev(hv);
-	if (vf_dev && vf_dev->dev_ops->rx_queue_release)
+	if (vf_dev && vf_dev->dev_ops->rx_queue_release) {
 		(*vf_dev->dev_ops->rx_queue_release)(vf_dev, queue_id);
+		vf_dev->data->rx_queues[queue_id] = NULL;
+	}
 	rte_rwlock_read_unlock(&hv->vf_lock);
 }
 
-- 
2.43.0

