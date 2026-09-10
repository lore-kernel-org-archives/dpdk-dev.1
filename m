Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED58C79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:57:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF57142EE0;
	Thu, 10 Sep 2026 15:53:08 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3349542E90
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:56 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 194F32003F6;
 Thu, 10 Sep 2026 15:52:56 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D82AA20043E;
 Thu, 10 Sep 2026 15:52:55 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C62D418000B7;
 Thu, 10 Sep 2026 21:52:54 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 47/47] net/dpaa2: reject Rx queue deferred start
Date: Thu, 10 Sep 2026 19:21:58 +0530
Message-ID: <20260910135158.2181141-48-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

The driver has no way to hold an Rx queue down while the port is started,
and dpaa2_rxq_info_get() already reports rx_deferred_start as 0. The Tx
side rejects the request; do the same for Rx instead of silently
accepting a configuration that will not be honoured.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 5dcc12b19a..6e16e7a84b 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1424,6 +1424,13 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	DPAA2_PMD_DEBUG("dev =%p, queue =%d, pool = %p, conf =%p",
 			dev, rx_queue_id, mb_pool, rx_conf);
 
+	/* Rx deferred start is not supported */
+	if (rx_conf->rx_deferred_start) {
+		DPAA2_PMD_ERR("%s: Rx deferred start not supported",
+			dev->data->name);
+		return -EINVAL;
+	}
+
 	total_nb_rx_desc += nb_rx_desc;
 	if (total_nb_rx_desc > MAX_NB_RX_DESC_IN_PEB &&
 	    (priv->options & DPNI_OPT_V1_PFDR_IN_PEB)) {
-- 
2.43.0

