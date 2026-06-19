Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A804CD98F2
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 12:31:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDD5C40F16;
	Fri, 19 Jun 2026 14:29:54 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 65D0140EAB
 for <dev@dpdk.org>; Fri, 19 Jun 2026 14:29:50 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 49C8120024A;
 Fri, 19 Jun 2026 14:29:50 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 13C8E200238;
 Fri, 19 Jun 2026 14:29:50 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A6E541800086;
 Fri, 19 Jun 2026 20:29:48 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Subject: [PATCH 15/18] net/dpaa: report error on using deferred start
Date: Fri, 19 Jun 2026 17:59:17 +0530
Message-Id: <20260619122922.3774666-21-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619122922.3774666-1-hemant.agrawal@nxp.com>
References: <20260619122922.3774666-1-hemant.agrawal@nxp.com>
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

This patch add support to report on error
for rx and tx deferred start config

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index a223703421..c884d7e5e4 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -1171,6 +1171,12 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	rxq->nb_desc = UINT16_MAX;
 	rxq->offloads = rx_conf->offloads;
 
+	/* Rx deferred start is not supported */
+	if (rx_conf->rx_deferred_start) {
+		DPAA_PMD_ERR("%p:Rx deferred start not supported", (void *)dev);
+		return -EINVAL;
+	}
+
 	DPAA_PMD_INFO("Rx queue setup for queue index: %d fq_id (0x%x)",
 			queue_idx, rxq->fqid);
 
@@ -1477,6 +1483,12 @@ int dpaa_eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->nb_desc = UINT16_MAX;
 	txq->offloads = tx_conf->offloads;
 
+	/* Tx deferred start is not supported */
+	if (tx_conf->tx_deferred_start) {
+		DPAA_PMD_ERR("%p:Tx deferred start not supported", (void *)dev);
+		return -EINVAL;
+	}
+
 	if (queue_idx >= dev->data->nb_tx_queues) {
 		rte_errno = EOVERFLOW;
 		DPAA_PMD_ERR("%p: queue index out of range (%u >= %u)",
-- 
2.25.1

