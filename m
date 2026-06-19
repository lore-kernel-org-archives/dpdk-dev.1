Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E713CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 18:45:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0A7140DD8;
	Fri, 19 Jun 2026 20:44:40 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6D4474028F
 for <dev@dpdk.org>; Fri, 19 Jun 2026 20:44:31 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4B3511A0012;
 Fri, 19 Jun 2026 20:44:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1078E1A0025;
 Fri, 19 Jun 2026 20:44:31 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 865D31800071;
 Sat, 20 Jun 2026 02:44:30 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH 09/10] net/enetc: set user configurable priority to TX rings
Date: Sat, 20 Jun 2026 00:14:26 +0530
Message-Id: <20260619184427.522518-10-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619184427.522518-1-g.singh@nxp.com>
References: <20260619184427.522518-1-g.singh@nxp.com>
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

Add devarg 'enetc4_txq_prior' to allow per-queue TX ring priority
configuration. The value is a '|'-separated list of TBMR priority
bits, one per TX queue (e.g. 'enetc4_txq_prior=1|2|3').

Store the parsed priorities in hw->txq_prior and apply them in
enetc4_tx_queue_setup() when enabling the ring.

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/enetc/enetc.h         |  1 +
 drivers/net/enetc/enetc4_ethdev.c | 71 ++++++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 2cdb3c7..99b1e91 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -111,6 +111,7 @@ struct enetc_eth_hw {
 	uint32_t max_tx_queues;
 	uint32_t vsi_timeout; /* VSI-PSI message wait timeout (iterations) */
 	uint32_t vsi_delay;   /* VSI-PSI message wait delay (us) */
+	uint32_t *txq_prior;  /* per-queue TX priority (TBMR priority bits) */
 };
 
 /*
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 154fc09..d54051f 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdbool.h>
+#include <rte_kvargs.h>
 #include <rte_random.h>
 #include <dpaax_iova_table.h>
 
@@ -10,6 +11,65 @@
 #include "enetc_logs.h"
 #include "enetc.h"
 
+#define ENETC4_TXQ_PRIORITIES	"enetc4_txq_prior"
+
+static int
+parse_txq_prior(const char *key __rte_unused, const char *value, void *opaque)
+{
+	struct rte_eth_dev *dev = (struct rte_eth_dev *)opaque;
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	char *input_str = strdup(value);
+	char *str;
+	uint32_t i = 0;
+
+	hw->txq_prior = rte_zmalloc(NULL,
+				    hw->max_tx_queues * sizeof(uint32_t), 0);
+	if (!hw->txq_prior) {
+		free(input_str);
+		return -1;
+	}
+
+	str = strtok(input_str, "|");
+	while (str != NULL && i < hw->max_tx_queues) {
+		hw->txq_prior[i++] = (uint32_t)atoi(str);
+		str = strtok(NULL, "|");
+	}
+
+	free(input_str);
+	return 0;
+}
+
+static int
+enetc4_get_devargs(struct rte_eth_dev *dev, const char *key)
+{
+	struct rte_devargs *devargs = dev->device->devargs;
+	struct rte_kvargs *kvlist;
+
+	if (!devargs)
+		return 0;
+
+	kvlist = rte_kvargs_parse(devargs->args, NULL);
+	if (!kvlist)
+		return 0;
+
+	if (!rte_kvargs_count(kvlist, key)) {
+		rte_kvargs_free(kvlist);
+		return 0;
+	}
+
+	if (!strcmp(key, ENETC4_TXQ_PRIORITIES)) {
+		if (rte_kvargs_process(kvlist, key,
+				       parse_txq_prior, (void *)dev) < 0) {
+			rte_kvargs_free(kvlist);
+			return 0;
+		}
+	}
+
+	rte_kvargs_free(kvlist);
+	return 0;
+}
+
 /* Supported Rx offloads */
 static uint64_t dev_rx_offloads_sup =
 	RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
@@ -310,9 +370,14 @@ enetc4_tx_queue_setup(struct rte_eth_dev *dev,
 	data->tx_queues[queue_idx] = tx_ring;
 	tx_ring->tx_deferred_start = tx_conf->tx_deferred_start;
 	if (!tx_conf->tx_deferred_start) {
+		uint32_t tx_en = ENETC_TBMR_EN;
+
+		/* apply TX queue priority if configured */
+		if (priv->hw.txq_prior)
+			tx_en |= priv->hw.txq_prior[tx_ring->index];
 		/* enable ring */
 		enetc4_txbdr_wr(&priv->hw.hw, tx_ring->index,
-			       ENETC_TBMR, ENETC_TBMR_EN);
+			       ENETC_TBMR, tx_en);
 		dev->data->tx_queue_state[tx_ring->index] =
 			       RTE_ETH_QUEUE_STATE_STARTED;
 	} else {
@@ -1009,6 +1074,8 @@ enetc4_dev_init(struct rte_eth_dev *eth_dev)
 	hw->max_tx_queues = si_cap & ENETC_SICAPR0_BDR_MASK;
 	hw->max_rx_queues = (si_cap >> 16) & ENETC_SICAPR0_BDR_MASK;
 
+	enetc4_get_devargs(eth_dev, ENETC4_TXQ_PRIORITIES);
+
 	ENETC_PMD_DEBUG("Max RX queues = %d Max TX queues = %d",
 			hw->max_rx_queues, hw->max_tx_queues);
 	error = enetc4_mac_init(hw, eth_dev);
@@ -1065,4 +1132,6 @@ static struct rte_pci_driver rte_enetc4_pmd = {
 RTE_PMD_REGISTER_PCI(net_enetc4, rte_enetc4_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_enetc4, pci_id_enetc4_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_enetc4, "* vfio-pci");
+RTE_PMD_REGISTER_PARAM_STRING(net_enetc4,
+			      ENETC4_TXQ_PRIORITIES "=<string>");
 RTE_LOG_REGISTER_DEFAULT(enetc4_logtype_pmd, NOTICE);
-- 
2.25.1

