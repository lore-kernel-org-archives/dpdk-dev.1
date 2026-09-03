Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3E8C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 13:57:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07EE342E72;
	Thu,  3 Sep 2026 15:54:41 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id B1CB442E52
 for <dev@dpdk.org>; Thu,  3 Sep 2026 15:54:32 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9685F200480;
 Thu,  3 Sep 2026 15:54:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6133820002E;
 Thu,  3 Sep 2026 15:54:32 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5539B18000B1;
 Thu,  3 Sep 2026 21:54:31 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH 30/45] drivers: inherit dpaa2 rxq config for event queue
Date: Thu,  3 Sep 2026 19:23:38 +0530
Message-ID: <20260903135353.3358303-31-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Jun Yang <jun.yang@nxp.com>

The configuration parameter in event queue attachment should use
flc and cgid configured in rxq setup.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h | 2 +-
 drivers/net/dpaa2/dpaa2_ethdev.c        | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index 12216750a8..f87bf51d09 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2024 NXP
+ *   Copyright 2016-2025 NXP
  *
  */
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 0835296ee2..57c6e8e90b 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2815,11 +2815,12 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 	struct dpaa2_dev_priv *eth_priv = dev->data->dev_private;
 	struct fsl_mc_io *dpni = (struct fsl_mc_io *)dev->process_private;
 	struct dpaa2_queue *dpaa2_ethq = eth_priv->rx_vq[eth_rx_queue_id];
-	uint8_t flow_id = dpaa2_ethq->flow_id;
+	uint8_t flow_id;
 	struct dpni_queue *cfg;
 	uint8_t options, priority;
 	int ret;
 
+	flow_id = dpaa2_ethq->flow_id;
 	cfg = dpaa2_ethq->cfg;
 
 	if (queue_conf->ev.sched_type == RTE_SCHED_TYPE_PARALLEL)
-- 
2.43.0

