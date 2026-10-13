Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31634CC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 10:40:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43E5640DDC;
	Tue, 13 Oct 2026 12:38:59 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id A2EE14060B
 for <dev@dpdk.org>; Tue, 13 Oct 2026 12:38:43 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 84AE01A0034;
 Tue, 13 Oct 2026 12:38:43 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4EEFC1A0004;
 Tue, 13 Oct 2026 12:38:43 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C371318000B5;
 Tue, 13 Oct 2026 18:38:42 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v25 18/24] net/dpaa: support fmcless rxq number as devargs
Date: Tue, 13 Oct 2026 16:08:27 +0530
Message-Id: <20261013103833.3822265-19-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261013103833.3822265-1-hemant.agrawal@nxp.com>
References: <20261012080845.2325199-1-hemant.agrawal@nxp.com>
 <20261013103833.3822265-1-hemant.agrawal@nxp.com>
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
A malformed value fails the probe instead of silently using the
default.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 doc/guides/nics/dpaa.rst       | 15 +++++--
 drivers/net/dpaa/dpaa_ethdev.c | 81 ++++++++++++++++++++++++++++++++--
 2 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/doc/guides/nics/dpaa.rst b/doc/guides/nics/dpaa.rst
index c6aab46828..32462a587b 100644
--- a/doc/guides/nics/dpaa.rst
+++ b/doc/guides/nics/dpaa.rst
@@ -272,9 +272,18 @@ Refer to the document :doc:`build_and_test` for details.
       Done
       testpmd>
 
-* Use dev arg option ``recv_err_pkts=1`` to receive all packets including error packets
-  and thus disabling hardware based packet handling at driver level,
-  e.g. ``dpaa:fm1-mac3,recv_err_pkts=1``.
+Device Arguments
+~~~~~~~~~~~~~~~~
+
+The DPAA PMD supports the following per-port device arguments, passed with
+the ``-a`` EAL option (e.g. ``-a dpaa_bus:fm1-mac3,drv_fmcless_rxq=4``):
+
+``recv_err_pkts`` (default disabled)
+   Receive all packets including error packets, disabling hardware based
+   packet handling at driver level. e.g. ``dpaa:fm1-mac3,recv_err_pkts=1``
+
+``drv_fmcless_rxq``
+   In FMCLESS mode, override the number of Rx frame queues to create.
 
 FMAN Config
 -----------
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index f044a0a3b9..b3d214add1 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -55,6 +55,7 @@
 #define CHECK_INTERVAL          100  /* 100ms */
 #define MAX_REPEAT_TIME         90   /* 9s (90 * 100ms) in total */
 #define DRIVER_RECV_ERR_PKTS      "recv_err_pkts"
+#define DRIVER_FMCLESS_RXQ        "drv_fmcless_rxq"
 #define RTE_PRIORITY_103 103
 
 /* Supported Rx offloads */
@@ -2228,6 +2229,53 @@ dpaa_get_devargs(struct rte_devargs *devargs, const char *key)
 	return 1;
 }
 
+static int
+parse_int_devarg_handler(__rte_unused const char *key, const char *value,
+			 void *opaque)
+{
+	char *end;
+	long val;
+
+	errno = 0;
+	val = strtol(value, &end, 0);
+	if (errno != 0 || end == value || *end != '\0')
+		return -EINVAL;
+
+	*(long *)opaque = val;
+	return 0;
+}
+
+/*
+ * Fetch an integer valued device argument.
+ * Returns 1 and stores the parsed value in *val if the key is present and
+ * valid, 0 if the key is absent, and a negative errno on parse error.
+ */
+static int
+dpaa_get_devargs_int(struct rte_devargs *devargs, const char *key, long *val)
+{
+	struct rte_kvargs *kvlist;
+	int ret;
+
+	if (!devargs)
+		return 0;
+
+	kvlist = rte_kvargs_parse(devargs->args, NULL);
+	if (!kvlist)
+		return 0;
+
+	if (!rte_kvargs_count(kvlist, key)) {
+		rte_kvargs_free(kvlist);
+		return 0;
+	}
+
+	ret = rte_kvargs_process(kvlist, key, parse_int_devarg_handler, val);
+	rte_kvargs_free(kvlist);
+	if (ret < 0)
+		return ret;
+
+	return 1;
+}
+
 /* Initialise a network interface */
 static int
 dpaa_dev_init(struct rte_eth_dev *eth_dev)
@@ -2296,8 +2344,34 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
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
@@ -2740,5 +2814,6 @@ static struct rte_dpaa_driver rte_dpaa_pmd = {
 
 RTE_PMD_REGISTER_DPAA(net_dpaa, rte_dpaa_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(net_dpaa,
-		DRIVER_RECV_ERR_PKTS "=<int>");
+		DRIVER_RECV_ERR_PKTS "=<int> "
+		DRIVER_FMCLESS_RXQ "=<int>");
 RTE_LOG_REGISTER_DEFAULT(dpaa_logtype_pmd, NOTICE);
-- 
2.25.1

