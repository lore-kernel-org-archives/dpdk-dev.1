Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95BFCD98FA
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:13:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2990C40E4B;
	Thu, 18 Jun 2026 16:12:08 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id D339540E3E;
 Thu, 18 Jun 2026 16:12:05 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BD6541A0021;
 Thu, 18 Jun 2026 16:12:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 874C51A001B;
 Thu, 18 Jun 2026 16:12:05 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 25ED91800071;
 Thu, 18 Jun 2026 22:12:04 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v1 09/17] net/dpaa: fix device remove
Date: Thu, 18 Jun 2026 19:41:43 +0530
Message-Id: <20260618141151.3990283-10-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
References: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

Add a check to avoid closing a device that is already closed,
preventing a double-close condition during device removal.

Fixes: 78ea4b4fcb ("bus/dpaa: improve cleanup")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 424458857e..9a9c5ee817 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -2674,18 +2674,19 @@ static int
 rte_dpaa_remove(struct rte_dpaa_device *dpaa_dev)
 {
 	struct rte_eth_dev *eth_dev;
-	int ret;
+	int ret = 0;
 
 	PMD_INIT_FUNC_TRACE();
 
 	eth_dev = dpaa_dev->eth_dev;
-	dpaa_eth_dev_close(eth_dev);
-	ret = rte_eth_dev_release_port(eth_dev);
+	if (eth_dev->state !=  RTE_ETH_DEV_UNUSED) {
+		dpaa_eth_dev_close(eth_dev);
+		ret = rte_eth_dev_release_port(eth_dev);
+	}
 	dpaa_valid_dev--;
-	if (!dpaa_valid_dev) {
+	if (!dpaa_valid_dev)
 		rte_mempool_free(dpaa_tx_sg_pool);
-		dpaa_finish();
-	}
+
 	return ret;
 }
 
-- 
2.43.0

