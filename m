Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E74606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:47:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5220F406B7;
	Fri, 23 Oct 2026 15:44:36 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 30CEE40E24
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:23 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 161C2200031;
 Fri, 23 Oct 2026 15:44:23 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D632D20003C;
 Fri, 23 Oct 2026 15:44:22 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 79B7A180006C;
 Fri, 23 Oct 2026 21:44:21 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v4-S3 28/65] net/dpaa2: reject Rx queue deferred start
Date: Fri, 23 Oct 2026 19:13:08 +0530
Message-ID: <20261023134346.37727-29-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index cca7aa0891..9002556b91 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1483,6 +1483,13 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
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

