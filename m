Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D457BCD98F6
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 06:09:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD1CA406B6;
	Fri, 19 Jun 2026 08:09:30 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 46B624064A;
 Fri, 19 Jun 2026 08:09:26 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 269CF1A0214;
 Fri, 19 Jun 2026 08:09:26 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E49CF1A0203;
 Fri, 19 Jun 2026 08:09:25 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AED3B180007B;
 Fri, 19 Jun 2026 14:09:24 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v2 04/18] net/dpaa: fix modify cgr to use index
Date: Fri, 19 Jun 2026 11:39:02 +0530
Message-Id: <20260619060916.485258-5-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619060916.485258-1-hemant.agrawal@nxp.com>
References: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
 <20260619060916.485258-1-hemant.agrawal@nxp.com>
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

In dpaa_modify_cgr(), the code was always using the pointer to
the first CGR element instead of indexing by the queue index.
Fix it to use the correct CGR entry by index.

Fixes: 62f53995caaf ("net/dpaa: add frame count based tail drop with CGR")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 9f976d179b..424458857e 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -1304,7 +1304,7 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		rxq->nb_desc = nb_desc;
 		/* Enable tail drop with cgr on this queue */
 		qm_cgr_cs_thres_set64(&cgr_opts.cgr.cs_thres, nb_desc, 0);
-		ret = qman_modify_cgr(dpaa_intf->cgr_rx, 0, &cgr_opts);
+		ret = qman_modify_cgr(&dpaa_intf->cgr_rx[queue_idx], 0, &cgr_opts);
 		if (ret) {
 			DPAA_PMD_WARN(
 				"rx taildrop modify fail on fqid %d (ret=%d)",
-- 
2.43.0

