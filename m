Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DF7C8302F
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 11:37:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D1A840698;
	Tue,  1 Jul 2025 13:37:18 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id EB46A40647
 for <dev@dpdk.org>; Tue,  1 Jul 2025 13:37:11 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D18F1200D6C;
 Tue,  1 Jul 2025 13:37:11 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 984022004AC;
 Tue,  1 Jul 2025 13:37:11 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 15F45180007B;
 Tue,  1 Jul 2025 19:37:11 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [v5 7/9] net/dpaa: add devargs for enabling err packets on main queue
Date: Tue,  1 Jul 2025 17:07:05 +0530
Message-Id: <20250701113707.2793004-8-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250701113707.2793004-1-vanshika.shukla@nxp.com>
References: <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250701113707.2793004-1-vanshika.shukla@nxp.com>
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

Currently, error queue is mapped to the Rx queue and enabled by default.
This patch adds the devargs to control the err packets on main queue.
Also, in VSP mode the error queue should be disabled because the error
packets from kernel are diverted to the Rx queue/err queue causing crash.

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 doc/guides/nics/dpaa.rst       |  4 ++++
 drivers/net/dpaa/dpaa_ethdev.c | 29 +++++++++++++++++++++--------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/doc/guides/nics/dpaa.rst b/doc/guides/nics/dpaa.rst
index de3ae96e07..19d7d00da4 100644
--- a/doc/guides/nics/dpaa.rst
+++ b/doc/guides/nics/dpaa.rst
@@ -278,6 +278,10 @@ for details.
 * Use dev arg option ``drv_ieee1588=1`` to enable IEEE 1588 support
   at driver level, e.g. ``dpaa:fm1-mac3,drv_ieee1588=1``.
 
+* Use dev arg option ``recv_err_pkts=1`` to receive all packets including
+  error packets and thus disabling hardware based packet handing
+  at driver level, e.g. ``dpaa:fm1-mac3,recv_err_pkts=1``.
+
 FMAN Config
 -----------
 
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 7d0f830204..62cafb7073 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -52,9 +52,10 @@
 #include <process.h>
 #include <fmlib/fm_ext.h>
 
-#define DRIVER_IEEE1588        "drv_ieee1588"
-#define CHECK_INTERVAL         100  /* 100ms */
-#define MAX_REPEAT_TIME        90   /* 9s (90 * 100ms) in total */
+#define DRIVER_IEEE1588         "drv_ieee1588"
+#define CHECK_INTERVAL          100  /* 100ms */
+#define MAX_REPEAT_TIME         90   /* 9s (90 * 100ms) in total */
+#define DRIVER_RECV_ERR_PKTS      "recv_err_pkts"
 
 /* Supported Rx offloads */
 static uint64_t dev_rx_offloads_sup =
@@ -87,6 +88,8 @@ static int is_global_init;
 static int fmc_q = 1;	/* Indicates the use of static fmc for distribution */
 static int default_q;	/* use default queue - FMC is not executed*/
 int dpaa_ieee_1588;	/* use to indicate if IEEE 1588 is enabled for the driver */
+bool dpaa_enable_recv_err_pkts; /* Enable main queue to receive error packets */
+
 /* At present we only allow up to 4 push mode queues as default - as each of
  * this queue need dedicated portal and we are short of portals.
  */
@@ -1273,10 +1276,12 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		}
 	}
 
-	/* Enable main queue to receive error packets also by default */
+	/* Enable main queue to receive error packets */
 	if (fif->mac_type != fman_offline_internal &&
-	    fif->mac_type != fman_onic)
+			fif->mac_type != fman_onic &&
+			dpaa_enable_recv_err_pkts && !fif->is_shared_mac) {
 		fman_if_set_err_fqid(fif, rxq->fqid);
+	}
 
 	return 0;
 }
@@ -2191,6 +2196,9 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 	if (dpaa_get_devargs(dev->devargs, DRIVER_IEEE1588))
 		dpaa_ieee_1588 = 1;
 
+	if (dpaa_get_devargs(dev->devargs, DRIVER_RECV_ERR_PKTS))
+		dpaa_enable_recv_err_pkts = 1;
+
 	memset((char *)dev_rx_fqids, 0,
 		sizeof(uint32_t) * DPAA_MAX_NUM_PCD_QUEUES);
 
@@ -2418,8 +2426,12 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 	    fman_intf->mac_type != fman_offline_internal &&
 	    fman_intf->mac_type != fman_onic) {
 		/* Configure error packet handling */
-		fman_if_receive_rx_errors(fman_intf,
-					  FM_FD_RX_STATUS_ERR_MASK);
+#ifndef RTE_LIBRTE_DPAA_DEBUG_DRIVER
+			if (dpaa_enable_recv_err_pkts)
+#endif
+				fman_if_receive_rx_errors(fman_intf,
+						FM_FD_RX_STATUS_ERR_MASK);
+
 		/* Disable RX mode */
 		fman_if_disable_rx(fman_intf);
 		/* Disable promiscuous mode */
@@ -2619,5 +2631,6 @@ static struct rte_dpaa_driver rte_dpaa_pmd = {
 
 RTE_PMD_REGISTER_DPAA(net_dpaa, rte_dpaa_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(net_dpaa,
-		DRIVER_IEEE1588 "=<int>");
+		DRIVER_IEEE1588 "=<int>"
+		DRIVER_RECV_ERR_PKTS "=<int>");
 RTE_LOG_REGISTER_DEFAULT(dpaa_logtype_pmd, NOTICE);
-- 
2.25.1

