Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD68CCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 10:29:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F078427BB;
	Thu, 16 Oct 2025 12:28:25 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 60FB8411F3
 for <dev@dpdk.org>; Thu, 16 Oct 2025 12:28:12 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 474F21A2711;
 Thu, 16 Oct 2025 12:28:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1303E1A26F1;
 Thu, 16 Oct 2025 12:28:12 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 95DBA180007D;
 Thu, 16 Oct 2025 18:28:11 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 12/15] net/dpaa2: add devargs to drop parse packets in HW
Date: Thu, 16 Oct 2025 15:58:02 +0530
Message-ID: <20251016102805.2453687-13-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
References: <20251014064035.1312896-1-prashant.gupta_3@nxp.com>
 <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
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

This patch add support to allow to drop HW parser error
pkts in DPAA2 hardware

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 doc/guides/nics/dpaa2.rst        |  4 ++++
 drivers/net/dpaa2/dpaa2_ethdev.c | 11 ++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h |  3 +++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 94bf1907df..782220b4cd 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -482,6 +482,10 @@ for details.
   In this mode tx conf queues need to be polled to free the buffers.
   e.g. ``fslmc:dpni.1,drv_tx_conf=1``
 
+* Use dev arg option  ``drv_rx_parse_drop=1`` to configure the system to start
+  dropping the error packets in hardware (parse errors).
+  e.g. ``fslmc:dpni.1,drv_rx_parse_drop=1``
+
 * Use dev arg option  ``drv_error_queue=1`` to enable Packets in Error queue.
   DPAA2 hardware drops the error packet in hardware. This option enables the
   hardware to not drop the error packet and let the driver dump the error
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 56c23e4717..5b72243346 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -34,6 +34,7 @@
 #define DRIVER_LOOPBACK_MODE "drv_loopback"
 #define DRIVER_NO_PREFETCH_MODE "drv_no_prefetch"
 #define DRIVER_TX_CONF "drv_tx_conf"
+#define DRIVER_RX_PARSE_ERR_DROP "drv_rx_parse_drop"
 #define DRIVER_ERROR_QUEUE  "drv_err_queue"
 #define CHECK_INTERVAL         100  /* 100ms */
 #define MAX_REPEAT_TIME        90   /* 9s (90 * 100ms) in total */
@@ -1349,7 +1350,8 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 		err_cfg.errors = DPNI_ERROR_L3CE | DPNI_ERROR_L4CE;
 
 		/* if packet with parse error are not to be dropped */
-		err_cfg.errors |= DPNI_ERROR_PHE | DPNI_ERROR_BLE;
+		if (!(priv->flags & DPAA2_PARSE_ERR_DROP))
+			err_cfg.errors |= DPNI_ERROR_PHE | DPNI_ERROR_BLE;
 
 		err_cfg.error_action = DPNI_ERROR_ACTION_CONTINUE;
 	}
@@ -2909,6 +2911,12 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		DPAA2_PMD_INFO("Enable error queue");
 	}
 
+	/* Packets with parse error to be dropped in hw */
+	if (dpaa2_get_devargs(dev->devargs, DRIVER_RX_PARSE_ERR_DROP)) {
+		priv->flags |= DPAA2_PARSE_ERR_DROP;
+		DPAA2_PMD_INFO("Drop parse error packets in hw");
+	}
+
 	if (getenv("DPAA2_PRINT_RX_PARSER_RESULT"))
 		dpaa2_print_parser_result = 1;
 
@@ -3278,5 +3286,6 @@ RTE_PMD_REGISTER_PARAM_STRING(NET_DPAA2_PMD_DRIVER_NAME,
 		DRIVER_LOOPBACK_MODE "=<int> "
 		DRIVER_NO_PREFETCH_MODE "=<int>"
 		DRIVER_TX_CONF "=<int>"
+		DRIVER_RX_PARSE_ERR_DROP "=<int>"
 		DRIVER_ERROR_QUEUE "=<int>");
 RTE_LOG_REGISTER_DEFAULT(dpaa2_logtype_pmd, NOTICE);
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index f4adb76bb6..b2ab3d539b 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -70,6 +70,9 @@
  */
 #define DPAA2_TX_CGR_OFF	RTE_BIT32(0)
 
+/* Drop packets with parsing error in hw */
+#define DPAA2_PARSE_ERR_DROP	RTE_BIT32(1)
+
 /* Disable RX tail drop, default is enable */
 #define DPAA2_RX_TAILDROP_OFF	RTE_BIT32(2)
 
-- 
2.43.0

