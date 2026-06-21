Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7EFCD98F0
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 17:29:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5503840698;
	Sun, 21 Jun 2026 19:27:59 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7D1A94064F
 for <dev@dpdk.org>; Sun, 21 Jun 2026 19:27:54 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 632981A0235;
 Sun, 21 Jun 2026 19:27:54 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2A8C01A0230;
 Sun, 21 Jun 2026 19:27:54 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C6657180007B;
 Mon, 22 Jun 2026 01:27:52 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Subject: [PATCH v4 15/19] net/dpaa: report error on using deferred start
Date: Sun, 21 Jun 2026 22:57:27 +0530
Message-Id: <20260621172731.2916346-16-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260621172731.2916346-1-hemant.agrawal@nxp.com>
References: <20260621152228.2777171-1-hemant.agrawal@nxp.com>
 <20260621172731.2916346-1-hemant.agrawal@nxp.com>
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
index 2e3757ca03..83210ff775 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -1174,6 +1174,12 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
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
 
@@ -1480,6 +1486,12 @@ int dpaa_eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
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

