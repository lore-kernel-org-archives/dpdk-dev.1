Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89AFC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 14:10:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03F0642E56;
	Fri,  7 Feb 2025 15:10:19 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id EB39B42E50
 for <dev@dpdk.org>; Fri,  7 Feb 2025 15:10:17 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517CdMOI024114
 for <dev@dpdk.org>; Fri, 7 Feb 2025 06:10:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Q
 GKuuhladziGNcjv8+eYzc0bW1SDbJXI3HmGAn+GNTs=; b=DKZric0F68mAsFC/L
 DrzRXAs3MzVN1gELr7EXvIXxqYrA5Xn3STuYfkJus+uolAOkGkfsDuDPIFpNfFaj
 SXVYJxZ4kFt4SmWFeync4q0JVmTBpUKO4+U4TCwFaLSPbKnuA4ELjg9uKbPBrfIJ
 btFdhzktWkJAgIopozp+ULNcd6BzIFnCuHn73IFNzhBicYVOnyEKnJAkC2GfL0Q+
 4SXnUh+UuQMqWxT0JEsfjjoIuuQKmtk0jDTX55Klip8xAZH1bY5Wbr6Q4GvEgopP
 KErtrKFp9k4lSNpLcyDfF+T6pjttW2Bcz+j6IYLai8f/q7VB5Sh2WJQRC1KWueGG
 3OznA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44njc1g5nh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 07 Feb 2025 06:10:16 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 7 Feb 2025 06:10:16 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 7 Feb 2025 06:10:16 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
 by maili.marvell.com (Postfix) with ESMTP id 9554F3F7061;
 Fri,  7 Feb 2025 06:10:14 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <jerinj@marvell.com>
CC: <pbhagavatula@marvell.com>, Shijith Thotton <sthotton@marvell.com>,
 <dev@dpdk.org>
Subject: [PATCH 2/3] event/cnxk: enable PMD op to burst add queues to Rx
 adapter
Date: Fri, 7 Feb 2025 19:39:09 +0530
Message-ID: <20250207140910.721374-3-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250207140910.721374-1-sthotton@marvell.com>
References: <20250207140910.721374-1-sthotton@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: IoJQwltCcEhoO4dcU1yMKO4gFRdzzm2V
X-Proofpoint-ORIG-GUID: IoJQwltCcEhoO4dcU1yMKO4gFRdzzm2V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_06,2025-02-07_02,2024-11-22_01
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

Implemented PMD support for the eventdev PMD operation to burst add
queues to the Rx adapter.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 drivers/event/cnxk/cn10k_eventdev.c      |  82 ++++++++--
 drivers/event/cnxk/cn20k_eventdev.c      | 195 ++++++++++++++++-------
 drivers/event/cnxk/cn9k_eventdev.c       |  38 ++++-
 drivers/event/cnxk/cnxk_eventdev.h       |   8 +-
 drivers/event/cnxk/cnxk_eventdev_adptr.c | 102 +++++++-----
 5 files changed, 308 insertions(+), 117 deletions(-)

diff --git a/drivers/event/cnxk/cn10k_eventdev.c b/drivers/event/cnxk/cn10k_eventdev.c
index f2e591f547..3832eb7e00 100644
--- a/drivers/event/cnxk/cn10k_eventdev.c
+++ b/drivers/event/cnxk/cn10k_eventdev.c
@@ -685,6 +685,22 @@ cn10k_sso_rx_offload_cb(uint16_t port_id, uint64_t flags)
 	eventdev_fops_update(event_dev);
 }
 
+static int
+cn10k_sso_configure_queue_stash_default(struct cnxk_sso_evdev *dev, uint16_t hwgrp)
+{
+	struct roc_sso_hwgrp_stash stash;
+	int rc;
+
+	stash.hwgrp = hwgrp;
+	stash.stash_offset = CN10K_SSO_DEFAULT_STASH_OFFSET;
+	stash.stash_count = CN10K_SSO_DEFAULT_STASH_LENGTH;
+	rc = roc_sso_hwgrp_stash_config(&dev->sso, &stash, 1);
+	if (rc)
+		plt_warn("failed to configure HWGRP WQE stashing rc = %d", rc);
+
+	return rc;
+}
+
 static int
 cn10k_sso_rx_adapter_queue_add(
 	const struct rte_eventdev *event_dev, const struct rte_eth_dev *eth_dev,
@@ -693,8 +709,8 @@ cn10k_sso_rx_adapter_queue_add(
 {
 	struct cnxk_eth_dev *cnxk_eth_dev = eth_dev->data->dev_private;
 	struct cnxk_sso_evdev *dev = cnxk_sso_pmd_priv(event_dev);
-	struct roc_sso_hwgrp_stash stash;
 	struct cn10k_eth_rxq *rxq;
+	uint16_t nb_rx_queues;
 	void *lookup_mem;
 	int rc;
 
@@ -702,8 +718,42 @@ cn10k_sso_rx_adapter_queue_add(
 	if (rc)
 		return -EINVAL;
 
-	rc = cnxk_sso_rx_adapter_queue_add(event_dev, eth_dev, rx_queue_id,
-					   queue_conf);
+	nb_rx_queues = rx_queue_id == -1 ? 0 : 1;
+	rc = cnxk_sso_rx_adapter_queues_add(event_dev, eth_dev, &rx_queue_id, queue_conf,
+					    nb_rx_queues);
+	if (rc)
+		return -EINVAL;
+
+	cnxk_eth_dev->cnxk_sso_ptp_tstamp_cb = cn10k_sso_tstamp_hdl_update;
+	cnxk_eth_dev->evdev_priv = (struct rte_eventdev *)(uintptr_t)event_dev;
+
+	rxq = eth_dev->data->rx_queues[0];
+	lookup_mem = rxq->lookup_mem;
+	cn10k_sso_set_priv_mem(event_dev, lookup_mem);
+	cn10k_sso_fp_fns_set((struct rte_eventdev *)(uintptr_t)event_dev);
+	if (roc_feature_sso_has_stash() && dev->nb_event_ports > 1)
+		rc = cn10k_sso_configure_queue_stash_default(dev, queue_conf->ev.queue_id);
+
+	return rc;
+}
+static int
+cn10k_sso_rx_adapter_queues_add(const struct rte_eventdev *event_dev,
+				const struct rte_eth_dev *eth_dev, int32_t rx_queue_id[],
+				const struct rte_event_eth_rx_adapter_queue_conf queue_conf[],
+				uint16_t nb_rx_queues)
+{
+	struct cnxk_eth_dev *cnxk_eth_dev = eth_dev->data->dev_private;
+	struct cnxk_sso_evdev *dev = cnxk_sso_pmd_priv(event_dev);
+	struct cn10k_eth_rxq *rxq;
+	void *lookup_mem;
+	int rc, i;
+
+	rc = strncmp(eth_dev->device->driver->name, "net_cn10k", 8);
+	if (rc)
+		return -EINVAL;
+
+	rc = cnxk_sso_rx_adapter_queues_add(event_dev, eth_dev, rx_queue_id, queue_conf,
+					    nb_rx_queues);
 	if (rc)
 		return -EINVAL;
 
@@ -715,15 +765,24 @@ cn10k_sso_rx_adapter_queue_add(
 	cn10k_sso_set_priv_mem(event_dev, lookup_mem);
 	cn10k_sso_fp_fns_set((struct rte_eventdev *)(uintptr_t)event_dev);
 	if (roc_feature_sso_has_stash() && dev->nb_event_ports > 1) {
-		stash.hwgrp = queue_conf->ev.queue_id;
-		stash.stash_offset = CN10K_SSO_DEFAULT_STASH_OFFSET;
-		stash.stash_count = CN10K_SSO_DEFAULT_STASH_LENGTH;
-		rc = roc_sso_hwgrp_stash_config(&dev->sso, &stash, 1);
-		if (rc < 0)
-			plt_warn("failed to configure HWGRP WQE stashing rc = %d", rc);
+		uint16_t hwgrp = dev->sso.max_hwgrp;
+
+		if (nb_rx_queues == 0)
+			rc = cn10k_sso_configure_queue_stash_default(dev,
+								     queue_conf[0].ev.queue_id);
+
+		for (i = 0; i < nb_rx_queues; i++) {
+			if (hwgrp == queue_conf[i].ev.queue_id)
+				continue;
+
+			hwgrp = queue_conf[i].ev.queue_id;
+			rc = cn10k_sso_configure_queue_stash_default(dev, hwgrp);
+			if (rc < 0)
+				break;
+		}
 	}
 
-	return 0;
+	return rc;
 }
 
 static int
@@ -987,8 +1046,6 @@ cn10k_dma_adapter_vchan_del(const struct rte_eventdev *event_dev,
 	return cnxk_dma_adapter_vchan_del(dma_dev_id, vchan_id);
 }
 
-
-
 static struct eventdev_ops cn10k_sso_dev_ops = {
 	.dev_infos_get = cn10k_sso_info_get,
 	.dev_configure = cn10k_sso_dev_configure,
@@ -1010,6 +1067,7 @@ static struct eventdev_ops cn10k_sso_dev_ops = {
 
 	.eth_rx_adapter_caps_get = cn10k_sso_rx_adapter_caps_get,
 	.eth_rx_adapter_queue_add = cn10k_sso_rx_adapter_queue_add,
+	.eth_rx_adapter_queues_add = cn10k_sso_rx_adapter_queues_add,
 	.eth_rx_adapter_queue_del = cn10k_sso_rx_adapter_queue_del,
 	.eth_rx_adapter_start = cnxk_sso_rx_adapter_start,
 	.eth_rx_adapter_stop = cnxk_sso_rx_adapter_stop,
diff --git a/drivers/event/cnxk/cn20k_eventdev.c b/drivers/event/cnxk/cn20k_eventdev.c
index d68700fc05..0688cf97e5 100644
--- a/drivers/event/cnxk/cn20k_eventdev.c
+++ b/drivers/event/cnxk/cn20k_eventdev.c
@@ -717,79 +717,115 @@ cn20k_sso_rx_adapter_vwqe_enable(struct cnxk_sso_evdev *dev, uint16_t port_id, u
 }
 
 static int
-cn20k_rx_adapter_queue_add(const struct rte_eventdev *event_dev, const struct rte_eth_dev *eth_dev,
-			   int32_t rx_queue_id,
-			   const struct rte_event_eth_rx_adapter_queue_conf *queue_conf)
+cn20k_rx_adapter_queue_del(const struct rte_eventdev *event_dev, const struct rte_eth_dev *eth_dev,
+			   int32_t rx_queue_id)
 {
 	struct cnxk_eth_dev *cnxk_eth_dev = eth_dev->data->dev_private;
 	struct cnxk_sso_evdev *dev = cnxk_sso_pmd_priv(event_dev);
-	uint16_t port = eth_dev->data->port_id;
-	struct cnxk_eth_rxq_sp *rxq_sp;
-	int i, rc = 0, agq = 0;
+	struct roc_nix_rq *rxq;
+	int i, rc = 0;
 
+	RTE_SET_USED(event_dev);
 	if (rx_queue_id < 0) {
 		for (i = 0; i < eth_dev->data->nb_rx_queues; i++)
-			rc |= cn20k_rx_adapter_queue_add(event_dev, eth_dev, i, queue_conf);
+			cn20k_rx_adapter_queue_del(event_dev, eth_dev, i);
 	} else {
-		rxq_sp = cnxk_eth_rxq_to_sp(eth_dev->data->rx_queues[rx_queue_id]);
+		rxq = &cnxk_eth_dev->rqs[rx_queue_id];
+		if (rxq->tt == SSO_TT_AGG)
+			roc_sso_hwgrp_agq_free(&dev->sso, rxq->hwgrp, rxq->tag_mask);
+		rc = cnxk_sso_rxq_disable(eth_dev, (uint16_t)rx_queue_id);
+		cnxk_eth_dev->nb_rxq_sso--;
+	}
+
+	if (rc < 0)
+		plt_err("Failed to clear Rx adapter config port=%d, q=%d", eth_dev->data->port_id,
+			rx_queue_id);
+	return rc;
+}
+
+static int
+cn20k_rx_adapter_queues_add(const struct rte_eventdev *event_dev, const struct rte_eth_dev *eth_dev,
+			    int32_t rx_queue_id[],
+			    const struct rte_event_eth_rx_adapter_queue_conf queue_conf[],
+			    uint16_t nb_rx_queues)
+{
+	struct cnxk_eth_dev *cnxk_eth_dev = eth_dev->data->dev_private;
+	struct cnxk_sso_evdev *dev = cnxk_sso_pmd_priv(event_dev);
+	const struct rte_event_eth_rx_adapter_queue_conf *conf;
+	uint64_t old_xae_cnt = dev->adptr_xae_cnt;
+	uint16_t port = eth_dev->data->port_id;
+	struct cnxk_eth_rxq_sp *rxq_sp;
+	uint16_t max_rx_queues;
+	int i, rc = 0, agq = 0;
+	int32_t queue_id;
+
+	max_rx_queues = nb_rx_queues ? nb_rx_queues : eth_dev->data->nb_rx_queues;
+	for (i = 0; i < max_rx_queues; i++) {
+		conf = nb_rx_queues ? &queue_conf[i] : &queue_conf[0];
+		queue_id = nb_rx_queues ? rx_queue_id[i] : i;
+		rxq_sp = cnxk_eth_rxq_to_sp(eth_dev->data->rx_queues[queue_id]);
 		cnxk_sso_updt_xae_cnt(dev, rxq_sp, RTE_EVENT_TYPE_ETHDEV);
+
+		if (conf->rx_queue_flags & RTE_EVENT_ETH_RX_ADAPTER_QUEUE_EVENT_VECTOR)
+			cnxk_sso_updt_xae_cnt(dev, conf->vector_mp, RTE_EVENT_TYPE_ETHDEV_VECTOR);
+	}
+
+	if (dev->adptr_xae_cnt != old_xae_cnt) {
 		rc = cnxk_sso_xae_reconfigure((struct rte_eventdev *)(uintptr_t)event_dev);
-		if (queue_conf->rx_queue_flags & RTE_EVENT_ETH_RX_ADAPTER_QUEUE_EVENT_VECTOR) {
-			cnxk_sso_updt_xae_cnt(dev, queue_conf->vector_mp,
-					      RTE_EVENT_TYPE_ETHDEV_VECTOR);
-			rc = cnxk_sso_xae_reconfigure((struct rte_eventdev *)(uintptr_t)event_dev);
-			if (rc < 0)
-				return rc;
+		if (rc < 0)
+			return rc;
+	}
+
+	for (i = 0; i < max_rx_queues; i++) {
+		conf = nb_rx_queues ? &queue_conf[i] : &queue_conf[0];
+		queue_id = nb_rx_queues ? rx_queue_id[i] : i;
+		if (conf->rx_queue_flags & RTE_EVENT_ETH_RX_ADAPTER_QUEUE_EVENT_VECTOR) {
+			rc = cn20k_sso_rx_adapter_vwqe_enable(dev, port, queue_id, conf);
+			if (rc < 0) {
+				plt_err("Failed to enable VWQE, port=%d, rxq=%d", port, queue_id);
+				goto fail;
+			}
 
-			rc = cn20k_sso_rx_adapter_vwqe_enable(dev, port, rx_queue_id, queue_conf);
-			if (rc < 0)
-				return rc;
 			agq = rc;
 		}
 
-		rc = cn20k_sso_rxq_enable(cnxk_eth_dev, (uint16_t)rx_queue_id, port, queue_conf,
-					  agq);
+		rc = cn20k_sso_rxq_enable(cnxk_eth_dev, (uint16_t)queue_id, port, conf, agq);
+		if (rc < 0) {
+			plt_err("Failed to enable Rx queue, port=%d, rxq=%d", port, queue_id);
+			goto fail;
+		}
 
-		/* Propagate force bp devarg */
-		cnxk_eth_dev->nix.force_rx_aura_bp = dev->force_ena_bp;
-		cnxk_sso_tstamp_cfg(port, eth_dev, dev);
 		cnxk_eth_dev->nb_rxq_sso++;
 	}
 
-	if (rc < 0) {
-		plt_err("Failed to configure Rx adapter port=%d, q=%d", port,
-			queue_conf->ev.queue_id);
-		return rc;
-	}
-
+	/* Propagate force bp devarg */
+	cnxk_eth_dev->nix.force_rx_aura_bp = dev->force_ena_bp;
+	cnxk_sso_tstamp_cfg(port, eth_dev, dev);
 	dev->rx_offloads |= cnxk_eth_dev->rx_offload_flags;
 	return 0;
+
+fail:
+	for (i = cnxk_eth_dev->nb_rxq_sso - 1; i >= 0; i--) {
+		queue_id = nb_rx_queues ? rx_queue_id[i] : i;
+		cn20k_rx_adapter_queue_del(event_dev, eth_dev, queue_id);
+	}
+
+	return rc;
 }
 
 static int
-cn20k_rx_adapter_queue_del(const struct rte_eventdev *event_dev, const struct rte_eth_dev *eth_dev,
-			   int32_t rx_queue_id)
+cn20k_sso_configure_queue_stash_default(struct cnxk_sso_evdev *dev, uint16_t hwgrp)
 {
-	struct cnxk_eth_dev *cnxk_eth_dev = eth_dev->data->dev_private;
-	struct cnxk_sso_evdev *dev = cnxk_sso_pmd_priv(event_dev);
-	struct roc_nix_rq *rxq;
-	int i, rc = 0;
-
-	RTE_SET_USED(event_dev);
-	if (rx_queue_id < 0) {
-		for (i = 0; i < eth_dev->data->nb_rx_queues; i++)
-			cn20k_rx_adapter_queue_del(event_dev, eth_dev, i);
-	} else {
-		rxq = &cnxk_eth_dev->rqs[rx_queue_id];
-		if (rxq->tt == SSO_TT_AGG)
-			roc_sso_hwgrp_agq_free(&dev->sso, rxq->hwgrp, rxq->tag_mask);
-		rc = cnxk_sso_rxq_disable(eth_dev, (uint16_t)rx_queue_id);
-		cnxk_eth_dev->nb_rxq_sso--;
-	}
+	struct roc_sso_hwgrp_stash stash;
+	int rc;
 
+	stash.hwgrp = hwgrp;
+	stash.stash_offset = CN20K_SSO_DEFAULT_STASH_OFFSET;
+	stash.stash_count = CN20K_SSO_DEFAULT_STASH_LENGTH;
+	rc = roc_sso_hwgrp_stash_config(&dev->sso, &stash, 1);
 	if (rc < 0)
-		plt_err("Failed to clear Rx adapter config port=%d, q=%d", eth_dev->data->port_id,
-			rx_queue_id);
+		plt_warn("failed to configure HWGRP WQE stashing rc = %d", rc);
+
 	return rc;
 }
 
@@ -800,8 +836,8 @@ cn20k_sso_rx_adapter_queue_add(const struct rte_eventdev *event_dev,
 {
 	struct cnxk_eth_dev *cnxk_eth_dev = eth_dev->data->dev_private;
 	struct cnxk_sso_evdev *dev = cnxk_sso_pmd_priv(event_dev);
-	struct roc_sso_hwgrp_stash stash;
 	struct cn20k_eth_rxq *rxq;
+	uint16_t nb_rx_queues;
 	void *lookup_mem;
 	int rc;
 
@@ -809,7 +845,42 @@ cn20k_sso_rx_adapter_queue_add(const struct rte_eventdev *event_dev,
 	if (rc)
 		return -EINVAL;
 
-	rc = cn20k_rx_adapter_queue_add(event_dev, eth_dev, rx_queue_id, queue_conf);
+	nb_rx_queues = rx_queue_id == -1 ? 0 : 1;
+	rc = cn20k_rx_adapter_queues_add(event_dev, eth_dev, &rx_queue_id, queue_conf,
+					 nb_rx_queues);
+	if (rc)
+		return -EINVAL;
+
+	cnxk_eth_dev->cnxk_sso_ptp_tstamp_cb = cn20k_sso_tstamp_hdl_update;
+	cnxk_eth_dev->evdev_priv = (struct rte_eventdev *)(uintptr_t)event_dev;
+
+	rxq = eth_dev->data->rx_queues[0];
+	lookup_mem = rxq->lookup_mem;
+	cn20k_sso_set_priv_mem(event_dev, lookup_mem);
+	cn20k_sso_fp_fns_set((struct rte_eventdev *)(uintptr_t)event_dev);
+	if (roc_feature_sso_has_stash() && dev->nb_event_ports > 1)
+		rc = cn20k_sso_configure_queue_stash_default(dev, queue_conf->ev.queue_id);
+
+	return rc;
+}
+
+static int
+cn20k_sso_rx_adapter_queues_add(const struct rte_eventdev *event_dev,
+				const struct rte_eth_dev *eth_dev, int32_t rx_queue_id[],
+				const struct rte_event_eth_rx_adapter_queue_conf queue_conf[],
+				uint16_t nb_rx_queues)
+{
+	struct cnxk_eth_dev *cnxk_eth_dev = eth_dev->data->dev_private;
+	struct cnxk_sso_evdev *dev = cnxk_sso_pmd_priv(event_dev);
+	struct cn20k_eth_rxq *rxq;
+	void *lookup_mem;
+	int rc, i;
+
+	rc = strncmp(eth_dev->device->driver->name, "net_cn20k", 8);
+	if (rc)
+		return -EINVAL;
+
+	rc = cn20k_rx_adapter_queues_add(event_dev, eth_dev, rx_queue_id, queue_conf, nb_rx_queues);
 	if (rc)
 		return -EINVAL;
 
@@ -821,15 +892,24 @@ cn20k_sso_rx_adapter_queue_add(const struct rte_eventdev *event_dev,
 	cn20k_sso_set_priv_mem(event_dev, lookup_mem);
 	cn20k_sso_fp_fns_set((struct rte_eventdev *)(uintptr_t)event_dev);
 	if (roc_feature_sso_has_stash() && dev->nb_event_ports > 1) {
-		stash.hwgrp = queue_conf->ev.queue_id;
-		stash.stash_offset = CN20K_SSO_DEFAULT_STASH_OFFSET;
-		stash.stash_count = CN20K_SSO_DEFAULT_STASH_LENGTH;
-		rc = roc_sso_hwgrp_stash_config(&dev->sso, &stash, 1);
-		if (rc < 0)
-			plt_warn("failed to configure HWGRP WQE stashing rc = %d", rc);
+		uint16_t hwgrp = dev->sso.max_hwgrp;
+
+		if (nb_rx_queues == 0)
+			rc = cn20k_sso_configure_queue_stash_default(dev,
+								     queue_conf[0].ev.queue_id);
+
+		for (i = 0; i < nb_rx_queues; i++) {
+			if (hwgrp == queue_conf[i].ev.queue_id)
+				continue;
+
+			hwgrp = queue_conf[i].ev.queue_id;
+			rc = cn20k_sso_configure_queue_stash_default(dev, hwgrp);
+			if (rc < 0)
+				break;
+		}
 	}
 
-	return 0;
+	return rc;
 }
 
 static int
@@ -985,6 +1065,7 @@ static struct eventdev_ops cn20k_sso_dev_ops = {
 
 	.eth_rx_adapter_caps_get = cn20k_sso_rx_adapter_caps_get,
 	.eth_rx_adapter_queue_add = cn20k_sso_rx_adapter_queue_add,
+	.eth_rx_adapter_queues_add = cn20k_sso_rx_adapter_queues_add,
 	.eth_rx_adapter_queue_del = cn20k_sso_rx_adapter_queue_del,
 	.eth_rx_adapter_start = cnxk_sso_rx_adapter_start,
 	.eth_rx_adapter_stop = cnxk_sso_rx_adapter_stop,
diff --git a/drivers/event/cnxk/cn9k_eventdev.c b/drivers/event/cnxk/cn9k_eventdev.c
index 05e237c005..5f24366770 100644
--- a/drivers/event/cnxk/cn9k_eventdev.c
+++ b/drivers/event/cnxk/cn9k_eventdev.c
@@ -871,6 +871,7 @@ cn9k_sso_rx_adapter_queue_add(
 {
 	struct cnxk_eth_dev *cnxk_eth_dev = eth_dev->data->dev_private;
 	struct cn9k_eth_rxq *rxq;
+	uint16_t nb_rx_queues;
 	void *lookup_mem;
 	int rc;
 
@@ -878,8 +879,40 @@ cn9k_sso_rx_adapter_queue_add(
 	if (rc)
 		return -EINVAL;
 
-	rc = cnxk_sso_rx_adapter_queue_add(event_dev, eth_dev, rx_queue_id,
-					   queue_conf);
+	nb_rx_queues = rx_queue_id == -1 ? 0 : 1;
+	rc = cnxk_sso_rx_adapter_queues_add(event_dev, eth_dev, &rx_queue_id, queue_conf,
+					    nb_rx_queues);
+	if (rc)
+		return -EINVAL;
+
+	cnxk_eth_dev->cnxk_sso_ptp_tstamp_cb = cn9k_sso_tstamp_hdl_update;
+	cnxk_eth_dev->evdev_priv = (struct rte_eventdev *)(uintptr_t)event_dev;
+
+	rxq = eth_dev->data->rx_queues[0];
+	lookup_mem = rxq->lookup_mem;
+	cn9k_sso_set_priv_mem(event_dev, lookup_mem);
+	cn9k_sso_fp_fns_set((struct rte_eventdev *)(uintptr_t)event_dev);
+
+	return 0;
+}
+
+static int
+cn9k_sso_rx_adapter_queues_add(const struct rte_eventdev *event_dev,
+			       const struct rte_eth_dev *eth_dev, int32_t rx_queue_id[],
+			       const struct rte_event_eth_rx_adapter_queue_conf queue_conf[],
+			       uint16_t nb_rx_queues)
+{
+	struct cnxk_eth_dev *cnxk_eth_dev = eth_dev->data->dev_private;
+	struct cn9k_eth_rxq *rxq;
+	void *lookup_mem;
+	int rc;
+
+	rc = strncmp(eth_dev->device->driver->name, "net_cn9k", 8);
+	if (rc)
+		return -EINVAL;
+
+	rc = cnxk_sso_rx_adapter_queues_add(event_dev, eth_dev, rx_queue_id, queue_conf,
+					    nb_rx_queues);
 	if (rc)
 		return -EINVAL;
 
@@ -1131,6 +1164,7 @@ static struct eventdev_ops cn9k_sso_dev_ops = {
 
 	.eth_rx_adapter_caps_get = cn9k_sso_rx_adapter_caps_get,
 	.eth_rx_adapter_queue_add = cn9k_sso_rx_adapter_queue_add,
+	.eth_rx_adapter_queues_add = cn9k_sso_rx_adapter_queues_add,
 	.eth_rx_adapter_queue_del = cn9k_sso_rx_adapter_queue_del,
 	.eth_rx_adapter_start = cnxk_sso_rx_adapter_start,
 	.eth_rx_adapter_stop = cnxk_sso_rx_adapter_stop,
diff --git a/drivers/event/cnxk/cnxk_eventdev.h b/drivers/event/cnxk/cnxk_eventdev.h
index 33b3538753..32991e51dc 100644
--- a/drivers/event/cnxk/cnxk_eventdev.h
+++ b/drivers/event/cnxk/cnxk_eventdev.h
@@ -255,10 +255,10 @@ int cnxk_sso_xstats_reset(struct rte_eventdev *event_dev,
 void cn9k_sso_set_rsrc(void *arg);
 
 /* Common adapter ops */
-int cnxk_sso_rx_adapter_queue_add(
-	const struct rte_eventdev *event_dev, const struct rte_eth_dev *eth_dev,
-	int32_t rx_queue_id,
-	const struct rte_event_eth_rx_adapter_queue_conf *queue_conf);
+int cnxk_sso_rx_adapter_queues_add(const struct rte_eventdev *event_dev,
+				   const struct rte_eth_dev *eth_dev, int32_t rx_queue_id[],
+				   const struct rte_event_eth_rx_adapter_queue_conf queue_conf[],
+				   uint16_t nb_rx_queues);
 int cnxk_sso_rx_adapter_queue_del(const struct rte_eventdev *event_dev,
 				  const struct rte_eth_dev *eth_dev,
 				  int32_t rx_queue_id);
diff --git a/drivers/event/cnxk/cnxk_eventdev_adptr.c b/drivers/event/cnxk/cnxk_eventdev_adptr.c
index 4cf48db74c..80f770ee8d 100644
--- a/drivers/event/cnxk/cnxk_eventdev_adptr.c
+++ b/drivers/event/cnxk/cnxk_eventdev_adptr.c
@@ -220,63 +220,81 @@ cnxk_sso_tstamp_cfg(uint16_t port_id, const struct rte_eth_dev *eth_dev, struct
 }
 
 int
-cnxk_sso_rx_adapter_queue_add(
-	const struct rte_eventdev *event_dev, const struct rte_eth_dev *eth_dev,
-	int32_t rx_queue_id,
-	const struct rte_event_eth_rx_adapter_queue_conf *queue_conf)
+cnxk_sso_rx_adapter_queues_add(const struct rte_eventdev *event_dev,
+			       const struct rte_eth_dev *eth_dev, int32_t rx_queue_id[],
+			       const struct rte_event_eth_rx_adapter_queue_conf queue_conf[],
+			       uint16_t nb_rx_queues)
 {
 	struct cnxk_eth_dev *cnxk_eth_dev = eth_dev->data->dev_private;
 	struct cnxk_sso_evdev *dev = cnxk_sso_pmd_priv(event_dev);
+	const struct rte_event_eth_rx_adapter_queue_conf *conf;
+	uint64_t old_xae_cnt = dev->adptr_xae_cnt;
 	uint16_t port = eth_dev->data->port_id;
 	struct cnxk_eth_rxq_sp *rxq_sp;
-	int i, rc = 0;
+	bool vec_drop_reset = false;
+	uint16_t max_rx_queues;
+	int32_t queue_id;
+	int i, rc;
 
-	if (rx_queue_id < 0) {
-		for (i = 0; i < eth_dev->data->nb_rx_queues; i++)
-			rc |= cnxk_sso_rx_adapter_queue_add(event_dev, eth_dev,
-							    i, queue_conf);
-	} else {
-		rxq_sp = cnxk_eth_rxq_to_sp(
-			eth_dev->data->rx_queues[rx_queue_id]);
+	max_rx_queues = nb_rx_queues ? nb_rx_queues : eth_dev->data->nb_rx_queues;
+	for (i = 0; i < max_rx_queues; i++) {
+		conf = nb_rx_queues ? &queue_conf[i] : &queue_conf[0];
+		queue_id = nb_rx_queues ? rx_queue_id[i] : i;
+
+		rxq_sp = cnxk_eth_rxq_to_sp(eth_dev->data->rx_queues[queue_id]);
 		cnxk_sso_updt_xae_cnt(dev, rxq_sp, RTE_EVENT_TYPE_ETHDEV);
-		rc = cnxk_sso_xae_reconfigure(
-			(struct rte_eventdev *)(uintptr_t)event_dev);
-		rc |= cnxk_sso_rxq_enable(
-			cnxk_eth_dev, (uint16_t)rx_queue_id, port,
-			&queue_conf->ev,
-			!!(queue_conf->rx_queue_flags &
-			   RTE_EVENT_ETH_RX_ADAPTER_QUEUE_FLOW_ID_VALID));
-		if (queue_conf->rx_queue_flags &
-		    RTE_EVENT_ETH_RX_ADAPTER_QUEUE_EVENT_VECTOR) {
-			cnxk_sso_updt_xae_cnt(dev, queue_conf->vector_mp,
-					      RTE_EVENT_TYPE_ETHDEV_VECTOR);
-			rc |= cnxk_sso_xae_reconfigure(
-				(struct rte_eventdev *)(uintptr_t)event_dev);
-			rc |= cnxk_sso_rx_adapter_vwqe_enable(
-				cnxk_eth_dev, port, rx_queue_id,
-				queue_conf->vector_sz,
-				queue_conf->vector_timeout_ns,
-				queue_conf->vector_mp);
-
-			if (cnxk_eth_dev->vec_drop_re_dis)
-				rc |= roc_nix_rx_drop_re_set(&cnxk_eth_dev->nix,
-							     false);
-		}
 
-		/* Propagate force bp devarg */
-		cnxk_eth_dev->nix.force_rx_aura_bp = dev->force_ena_bp;
-		cnxk_sso_tstamp_cfg(eth_dev->data->port_id, eth_dev, dev);
+		if (conf->rx_queue_flags & RTE_EVENT_ETH_RX_ADAPTER_QUEUE_EVENT_VECTOR)
+			cnxk_sso_updt_xae_cnt(dev, conf->vector_mp, RTE_EVENT_TYPE_ETHDEV_VECTOR);
+	}
+
+	if (dev->adptr_xae_cnt != old_xae_cnt) {
+		rc = cnxk_sso_xae_reconfigure((struct rte_eventdev *)(uintptr_t)event_dev);
+		if (rc < 0)
+			return rc;
+	}
+
+	for (i = 0; i < max_rx_queues; i++) {
+		conf = nb_rx_queues ? &queue_conf[i] : &queue_conf[0];
+		queue_id = nb_rx_queues ? rx_queue_id[i] : i;
+
+		rc = cnxk_sso_rxq_enable(
+			cnxk_eth_dev, (uint16_t)queue_id, port, &conf->ev,
+			!!(conf->rx_queue_flags & RTE_EVENT_ETH_RX_ADAPTER_QUEUE_FLOW_ID_VALID));
+		if (rc < 0)
+			goto fail;
+
+		if (conf->rx_queue_flags & RTE_EVENT_ETH_RX_ADAPTER_QUEUE_EVENT_VECTOR) {
+			rc = cnxk_sso_rx_adapter_vwqe_enable(
+				cnxk_eth_dev, port, (uint16_t)queue_id, conf->vector_sz,
+				conf->vector_timeout_ns, conf->vector_mp);
+			if (rc < 0)
+				goto fail;
+
+			vec_drop_reset = true;
+		}
 		cnxk_eth_dev->nb_rxq_sso++;
 	}
 
-	if (rc < 0) {
-		plt_err("Failed to configure Rx adapter port=%d, q=%d", port,
-			queue_conf->ev.queue_id);
-		return rc;
+	if (cnxk_eth_dev->vec_drop_re_dis && vec_drop_reset) {
+		rc = roc_nix_rx_drop_re_set(&cnxk_eth_dev->nix, false);
+		if (rc < 0)
+			goto fail;
 	}
 
+	/* Propagate force bp devarg */
+	cnxk_eth_dev->nix.force_rx_aura_bp = dev->force_ena_bp;
+	cnxk_sso_tstamp_cfg(eth_dev->data->port_id, eth_dev, dev);
 	dev->rx_offloads |= cnxk_eth_dev->rx_offload_flags;
 	return 0;
+
+fail:
+	for (i = cnxk_eth_dev->nb_rxq_sso - 1; i >= 0; i--) {
+		queue_id = nb_rx_queues ? rx_queue_id[i] : i;
+		cnxk_sso_rx_adapter_queue_del(event_dev, eth_dev, queue_id);
+	}
+
+	return rc;
 }
 
 int
-- 
2.25.1

