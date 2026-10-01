Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3314CA5FCB
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 11:27:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 685B442F7E;
	Thu,  1 Oct 2026 13:24:54 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2BBC742E55
 for <dev@dpdk.org>; Thu,  1 Oct 2026 13:24:40 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0FB641A0130;
 Thu,  1 Oct 2026 13:24:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CD24A1A0120;
 Thu,  1 Oct 2026 13:24:39 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 511E418000BE;
 Thu,  1 Oct 2026 19:24:39 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v19 18/26] net/dpaa: support Rx/Tx taildrop threshold devarg
Date: Thu,  1 Oct 2026 16:54:22 +0530
Message-Id: <20261001112430.251845-19-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261001112430.251845-1-hemant.agrawal@nxp.com>
References: <20260930062437.3019096-1-hemant.agrawal@nxp.com>
 <20261001112430.251845-1-hemant.agrawal@nxp.com>
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

The Rx frame queue taildrop threshold was fixed at compile time and the
Tx one could only be set through the DPAA_TX_TAILDROP_THRESHOLD
environment variable, which applies to every port in the process.

Add 'drv_rx_taildrop' and 'drv_tx_taildrop' device arguments so both
congestion thresholds can be configured per port, with 0 disabling
taildrop. A value above UINT16_MAX falls back to the default threshold.
The environment variable is still honoured for the Tx threshold when the
devarg is absent, so existing scripts keep working.

Both thresholds are reset to their defaults at the start of
dpaa_dev_init() so that a value configured for one port is not inherited
by the next one probed.

A dpaa_get_devargs_int() helper is added to parse an integer valued
device argument, and the new arguments are advertised through
RTE_PMD_REGISTER_PARAM_STRING() and documented in the DPAA NIC guide.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
Signed-off-by: Sachin Saxena <sachin.saxena@nxp.com>
---
 doc/guides/nics/dpaa.rst       | 16 +++++--
 drivers/net/dpaa/dpaa_ethdev.c | 83 ++++++++++++++++++++++++++++++++--
 2 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/doc/guides/nics/dpaa.rst b/doc/guides/nics/dpaa.rst
index c6aab46828..2b6bf7608d 100644
--- a/doc/guides/nics/dpaa.rst
+++ b/doc/guides/nics/dpaa.rst
@@ -272,9 +272,19 @@ Refer to the document :doc:`build_and_test` for details.
       Done
       testpmd>
 
-* Use dev arg option ``recv_err_pkts=1`` to receive all packets including error packets
-  and thus disabling hardware based packet handling at driver level,
-  e.g. ``dpaa:fm1-mac3,recv_err_pkts=1``.
+Device Arguments
+~~~~~~~~~~~~~~~~~
+
+The DPAA PMD supports the following per-port device arguments, passed with
+the ``-a`` EAL option (e.g. ``-a dpaa_bus:fm1-mac3,drv_rx_taildrop=64``):
+
+``recv_err_pkts`` (default disabled)
+   Receive all packets including error packets, disabling hardware based
+   packet handling at driver level. e.g. ``dpaa:fm1-mac3,recv_err_pkts=1``
+
+``drv_rx_taildrop`` / ``drv_tx_taildrop``
+   Configure the Rx / Tx frame queue taildrop congestion threshold. A value
+   of ``0`` disables taildrop.
 
 FMAN Config
 -----------
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 7391004512..1155c6f9a0 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -55,6 +55,8 @@
 #define CHECK_INTERVAL          100  /* 100ms */
 #define MAX_REPEAT_TIME         90   /* 9s (90 * 100ms) in total */
 #define DRIVER_RECV_ERR_PKTS      "recv_err_pkts"
+#define DRIVER_RX_TAILDROP        "drv_rx_taildrop"
+#define DRIVER_TX_TAILDROP        "drv_tx_taildrop"
 #define RTE_PRIORITY_103 103
 
 /* Maximum number of stale frame queues cleaned up per congestion group. */
@@ -2289,6 +2291,53 @@ dpaa_get_devargs(struct rte_devargs *devargs, const char *key)
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
@@ -2309,6 +2358,7 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 	int8_t dev_vspids[DPAA_MAX_NUM_PCD_QUEUES];
 	int8_t vsp_id = -1;
 	struct rte_device *dev = eth_dev->device;
+	long td_val = 0;
 #ifdef RTE_LIBRTE_DPAA_DEBUG_DRIVER
 	char *penv;
 #endif
@@ -2383,13 +2433,36 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 
 	memset(cgrid, 0, sizeof(cgrid));
 	memset(cgrid_tx, 0, sizeof(cgrid_tx));
+	td_threshold = CGR_RX_PERFQ_THRESH;
+	td_tx_threshold = 0;
+
+	/* If "drv_rx_taildrop" devarg is set, use that value; if 0, it means
+	 * Rx tail drop is disabled.
+	 */
+	if (dpaa_get_devargs_int(dev->devargs, DRIVER_RX_TAILDROP,
+				 &td_val) == 1) {
+		td_threshold = (unsigned int)td_val;
+		DPAA_PMD_DEBUG("Rx tail drop threshold configured: %u",
+			       td_threshold);
+		/* if a very large value is being configured */
+		if (td_threshold > UINT16_MAX)
+			td_threshold = CGR_RX_PERFQ_THRESH;
+	}
 
-	/* if DPAA_TX_TAILDROP_THRESHOLD is set, use that value; if 0, it means
+	/* If "drv_tx_taildrop" devarg is set, use that value; if 0, it means
 	 * Tx tail drop is disabled.
 	 */
-	if (getenv("DPAA_TX_TAILDROP_THRESHOLD")) {
+	if (dpaa_get_devargs_int(dev->devargs, DRIVER_TX_TAILDROP,
+				 &td_val) == 1) {
+		td_tx_threshold = (unsigned int)td_val;
+		DPAA_PMD_DEBUG("Tx tail drop threshold configured: %u",
+			       td_tx_threshold);
+		/* if a very large value is being configured */
+		if (td_tx_threshold > UINT16_MAX)
+			td_tx_threshold = CGR_RX_PERFQ_THRESH;
+	} else if (getenv("DPAA_TX_TAILDROP_THRESHOLD")) {
 		td_tx_threshold = atoi(getenv("DPAA_TX_TAILDROP_THRESHOLD"));
-		DPAA_PMD_DEBUG("Tail drop threshold env configured: %u",
+		DPAA_PMD_DEBUG("Tx tail drop threshold env configured: %u",
 			       td_tx_threshold);
 		/* if a very large value is being configured */
 		if (td_tx_threshold > UINT16_MAX)
@@ -2823,5 +2896,7 @@ static struct rte_dpaa_driver rte_dpaa_pmd = {
 
 RTE_PMD_REGISTER_DPAA(net_dpaa, rte_dpaa_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(net_dpaa,
-		DRIVER_RECV_ERR_PKTS "=<int>");
+		DRIVER_RECV_ERR_PKTS "=<int> "
+		DRIVER_RX_TAILDROP "=<int> "
+		DRIVER_TX_TAILDROP "=<int>");
 RTE_LOG_REGISTER_DEFAULT(dpaa_logtype_pmd, NOTICE);
-- 
2.25.1

