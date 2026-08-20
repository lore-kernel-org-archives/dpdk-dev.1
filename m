Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1613AC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:43:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F543406FF;
	Thu, 20 Aug 2026 16:43:23 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 68E174069F;
 Thu, 20 Aug 2026 16:43:19 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3E08E2001CB;
 Thu, 20 Aug 2026 16:43:19 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 087532001BD;
 Thu, 20 Aug 2026 16:43:19 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D125918000BF;
 Thu, 20 Aug 2026 22:43:17 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v14 02/23] net/dpaa: fix free port resources on close
Date: Thu, 20 Aug 2026 20:12:51 +0530
Message-Id: <20260820144312.3922316-3-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260820144312.3922316-1-hemant.agrawal@nxp.com>
References: <20260819105004.2272880-1-hemant.agrawal@nxp.com>
 <20260820144312.3922316-1-hemant.agrawal@nxp.com>
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

dpaa_intf->tx_conf_queues is allocated unconditionally for every port
in dpaa_dev_init():

	dpaa_intf->tx_conf_queues = rte_zmalloc(NULL, sizeof(struct qman_fq) *
		MAX_DPAA_CORES, MAX_CACHELINE);

but it is never released. It is a driver private allocation, so
rte_eth_dev_release_port() does not free it either. The memory is
therefore leaked on every device close and on every probe failure that
happens after the allocation.

dpaa_eth_dev_close() returned early for offline (O/H) and ONIC ports,
before the common cleanup that frees the queue and congestion-group
memory allocated at probe. Added support to clean that path as well.

Fixes: 58e0420f72f8 ("net/dpaa: support Tx confirmation to enable PTP")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 77730f16e3..00ab436ad1 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -537,7 +537,7 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 
 	if (fif->mac_type == fman_offline_internal ||
 	    fif->mac_type == fman_onic)
-		return 0;
+		goto clean_1;
 
 	/* Reset link to autoneg */
 	if (link->link_status && !link->link_autoneg) {
@@ -562,7 +562,7 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 				dev->data->name, ret);
 		}
 	}
-
+clean_1:
 	/* release configuration memory */
 	rte_free(dpaa_intf->fc_conf);
 
@@ -624,6 +624,9 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
+	rte_free(dpaa_intf->tx_conf_queues);
+	dpaa_intf->tx_conf_queues = NULL;
+
 	return ret;
 }
 
@@ -2497,6 +2500,8 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 	return 0;
 
 free_tx:
+	rte_free(dpaa_intf->tx_conf_queues);
+	dpaa_intf->tx_conf_queues = NULL;
 	rte_free(dpaa_intf->tx_queues);
 	dpaa_intf->tx_queues = NULL;
 	dpaa_intf->nb_tx_queues = 0;
-- 
2.25.1

