Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A89C61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 06:12:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBF6A4025A;
	Mon, 31 Aug 2026 08:12:05 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id BD3D8400D5;
 Mon, 31 Aug 2026 08:12:03 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A926D1A0397;
 Mon, 31 Aug 2026 08:12:03 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 76A401A035A;
 Mon, 31 Aug 2026 08:12:03 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 41CBE18000B1;
 Mon, 31 Aug 2026 14:12:02 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v2] net/dpaa: fix Rx queue shutdown before init
Date: Mon, 31 Aug 2026 11:41:59 +0530
Message-ID: <20260831061159.3668135-1-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827072913.1015508-1-prashant.gupta_3@nxp.com>
References: <20260827072913.1015508-1-prashant.gupta_3@nxp.com>
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

The frame queue shutdown in dpaa_eth_rx_queue_setup() is too late:
the queue has already been created and initialized by dpaa_dev_init(),
so the shutdown forces a live FQ out of service and the queue no
longer receives frames.

Move the shutdown to dpaa_dev_init(), just before dpaa_rx_queue_init(),
where it cleans up a frame queue left over from a previous run as
intended.

Fixes: 0e3c389b9e4f ("bus/dpaa: do proper cleanup of frame queues on shutdown")
Cc: stable@dpdk.org

Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 4dc4d1f10c..b7bc616fed 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -1119,9 +1119,6 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	DPAA_PMD_INFO("Rx queue setup for queue index: %d fq_id (0x%x)",
 			queue_idx, rxq->fqid);
 
-	/* Shutdown FQ before configure */
-	qman_shutdown_fq(rxq->fqid);
-
 	if (!fif->num_profiles) {
 		if (dpaa_intf->bp_info && dpaa_intf->bp_info->bp &&
 			dpaa_intf->bp_info->mp != mp) {
@@ -2355,6 +2352,11 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 
 		vsp_id = dev_vspids[loop];
 
+		/* Clean up a frame queue left behind by a previous run
+		 * before it is initialized.
+		 */
+		qman_shutdown_fq(rxq->fqid);
+
 		if (dpaa_intf->cgr_rx)
 			dpaa_intf->cgr_rx[loop].cgrid = cgrid[loop];
 
-- 
2.43.0

