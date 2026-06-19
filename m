Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7090BCD98F2
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 12:30:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5E8840E2D;
	Fri, 19 Jun 2026 14:29:47 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id C316240E49
 for <dev@dpdk.org>; Fri, 19 Jun 2026 14:29:43 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A8B3F1A025D;
 Fri, 19 Jun 2026 14:29:43 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 722D91A0257;
 Fri, 19 Jun 2026 14:29:43 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0BF58180007B;
 Fri, 19 Jun 2026 20:29:41 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Subject: [PATCH 11/18] net/dpaa: remove redundant FQ shutdown from
 rx_queue_setup
Date: Fri, 19 Jun 2026 17:59:11 +0530
Message-Id: <20260619122922.3774666-15-hemant.agrawal@nxp.com>
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

Remove the redundant qman_shutdown_fq() call from dpaa_eth_rx_queue_setup().
The FQ is shut down during device stop, so calling it again at queue setup
time is unnecessary and may interfere with a clean queue initialization.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index b427b1df13..3b66fbe18a 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -1157,9 +1157,6 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	DPAA_PMD_INFO("Rx queue setup for queue index: %d fq_id (0x%x)",
 			queue_idx, rxq->fqid);
 
-	/* Shutdown FQ before configure */
-	qman_shutdown_fq(rxq->fqid);
-
 	if (!fif->num_profiles) {
 		if (dpaa_intf->bp_info && dpaa_intf->bp_info->bp &&
 			dpaa_intf->bp_info->mp != mp) {
-- 
2.25.1

