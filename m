Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FAFCA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 07:26:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B20AE42D27;
	Wed,  7 Oct 2026 09:25:05 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7254D42686
 for <dev@dpdk.org>; Wed,  7 Oct 2026 09:24:49 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5821E200003;
 Wed,  7 Oct 2026 09:24:49 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 23C03200002;
 Wed,  7 Oct 2026 09:24:49 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9EB02180006C;
 Wed,  7 Oct 2026 15:24:48 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v22 20/27] net/dpaa: support fmcless rxq number as devargs
Date: Wed,  7 Oct 2026 12:54:32 +0530
Message-Id: <20261007072439.3135351-21-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261007072439.3135351-1-hemant.agrawal@nxp.com>
References: <20261006092703.2138929-1-hemant.agrawal@nxp.com>
 <20261007072439.3135351-1-hemant.agrawal@nxp.com>
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

From: Jun Yang <jun.yang@nxp.com>

In FMCLESS mode, set the default number of Rx frame queues to the
maximum queue number instead of the core count, because multiple
queues may be processed on the same core. The value can also be
configured per port through the 'drv_fmcless_rxq' device argument.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 doc/guides/nics/dpaa.rst       |  3 +++
 drivers/net/dpaa/dpaa_ethdev.c | 34 +++++++++++++++++++++++++++++++---
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/dpaa.rst b/doc/guides/nics/dpaa.rst
index 2b6bf7608d..d03027d8bb 100644
--- a/doc/guides/nics/dpaa.rst
+++ b/doc/guides/nics/dpaa.rst
@@ -286,6 +286,9 @@ the ``-a`` EAL option (e.g. ``-a dpaa_bus:fm1-mac3,drv_rx_taildrop=64``):
    Configure the Rx / Tx frame queue taildrop congestion threshold. A value
    of ``0`` disables taildrop.
 
+``drv_fmcless_rxq``
+   In FMCLESS mode, override the number of Rx frame queues to create.
+
 FMAN Config
 -----------
 
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 78afe472a8..a367f4512f 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -57,6 +57,7 @@
 #define DRIVER_RECV_ERR_PKTS      "recv_err_pkts"
 #define DRIVER_RX_TAILDROP        "drv_rx_taildrop"
 #define DRIVER_TX_TAILDROP        "drv_tx_taildrop"
+#define DRIVER_FMCLESS_RXQ        "drv_fmcless_rxq"
 #define RTE_PRIORITY_103 103
 
 /* Maximum number of stale frame queues cleaned up per congestion group. */
@@ -2418,8 +2419,34 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 				dpaa_intf->name);
 		}
 	} else {
-		/* FMCLESS mode, load balance to multiple cores.*/
-		num_rx_fqs = rte_lcore_count();
+		/* FMCLESS mode, default queue number is max queues
+		 * because multiple queues may be processed on same core.
+		 */
+		long fmcless_rxq = 0;
+
+		ret = dpaa_get_devargs_int(dev->devargs, DRIVER_FMCLESS_RXQ,
+					   &fmcless_rxq);
+		if (ret < 0) {
+			DPAA_PMD_ERR("Invalid %s value", DRIVER_FMCLESS_RXQ);
+			return ret;
+		}
+		if (ret == 1) {
+			/* Range check before narrowing to int, otherwise a
+			 * value such as 4294967296 would truncate to 0.
+			 */
+			if (fmcless_rxq < 1) {
+				DPAA_PMD_ERR("fmcless rxq number must be >= 1");
+				return -EINVAL;
+			}
+			if (fmcless_rxq > DPAA_MAX_NUM_PCD_QUEUES) {
+				DPAA_PMD_WARN("fmcless rxq number > %d, clamped",
+					DPAA_MAX_NUM_PCD_QUEUES);
+				fmcless_rxq = DPAA_MAX_NUM_PCD_QUEUES;
+			}
+			num_rx_fqs = (int)fmcless_rxq;
+		} else {
+			num_rx_fqs = DPAA_MAX_NUM_PCD_QUEUES;
+		}
 	}
 
 	/* Each device can not have more than DPAA_MAX_NUM_PCD_QUEUES RX
@@ -2932,5 +2959,6 @@ RTE_PMD_REGISTER_DPAA(net_dpaa, rte_dpaa_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(net_dpaa,
 		DRIVER_RECV_ERR_PKTS "=<int> "
 		DRIVER_RX_TAILDROP "=<int> "
-		DRIVER_TX_TAILDROP "=<int>");
+		DRIVER_TX_TAILDROP "=<int> "
+		DRIVER_FMCLESS_RXQ "=<int>");
 RTE_LOG_REGISTER_DEFAULT(dpaa_logtype_pmd, NOTICE);
-- 
2.25.1

