Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD691C5CFEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 14:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADC5F42E6D;
	Thu, 13 Aug 2026 16:42:34 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6151C42E71
 for <dev@dpdk.org>; Thu, 13 Aug 2026 16:42:31 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 485A61A0071;
 Thu, 13 Aug 2026 16:42:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0FEFF1A008B;
 Thu, 13 Aug 2026 16:42:31 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id ACACD18000B1;
 Thu, 13 Aug 2026 22:42:29 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v11 17/25] net/dpaa: support non fmX-macY type of shared
 Ethernet name
Date: Thu, 13 Aug 2026 20:11:57 +0530
Message-Id: <20260813144205.2505031-18-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813144205.2505031-1-hemant.agrawal@nxp.com>
References: <20260813104405.2313474-1-hemant.agrawal@nxp.com>
 <20260813144205.2505031-1-hemant.agrawal@nxp.com>
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

When using a shared interface, the Linux interface name (as shown by
ifconfig) may differ from the fmX-macY style name used by DPDK. Add a
"drv_sh_if_name" device argument to let the application provide the
kernel shared interface name to the DPAA PMD.

	e.g. -a dpaa_bus:fm1-mac3,drv_sh_if_name=eth1

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 doc/guides/nics/dpaa.rst       |  5 +++
 drivers/net/dpaa/dpaa_ethdev.c | 65 ++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/dpaa.rst b/doc/guides/nics/dpaa.rst
index 5858c63cc5..d4cf861d2b 100644
--- a/doc/guides/nics/dpaa.rst
+++ b/doc/guides/nics/dpaa.rst
@@ -292,6 +292,11 @@ the ``-a`` EAL option (e.g. ``-a dpaa_bus:fm1-mac3,drv_rx_taildrop=64``):
 
   In FMCLESS mode, override the number of Rx frame queues to create.
 
+* ``drv_sh_if_name``
+
+  Provide the kernel Linux interface name for a shared MAC interface when it
+  differs from the ``fmX-macY`` style name used by DPDK.
+
 FMAN Config
 -----------
 
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index e58c5c3e43..087de9aeb8 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -58,8 +58,12 @@
 #define DRIVER_RX_TAILDROP        "drv_rx_taildrop"
 #define DRIVER_TX_TAILDROP        "drv_tx_taildrop"
 #define DRIVER_FMCLESS_RXQ        "drv_fmcless_rxq"
+#define DRIVER_SH_IF_NAME         "drv_sh_if_name"
 #define RTE_PRIORITY_103 103
 
+static int dpaa_get_devargs_str(struct rte_devargs *devargs, const char *key,
+				char *val, size_t size);
+
 /* Supported Rx offloads */
 static uint64_t dev_rx_offloads_sup =
 		RTE_ETH_RX_OFFLOAD_SCATTER;
@@ -247,6 +251,7 @@ dpaa_eth_dev_configure(struct rte_eth_dev *dev)
 	int speed, duplex;
 	int ret, rx_status, socket_fd;
 	struct ifreq ifr;
+	char sh_if_name[IFNAMSIZ];
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -268,7 +273,15 @@ dpaa_eth_dev_configure(struct rte_eth_dev *dev)
 			DPAA_PMD_ERR("Cannot open IF socket");
 			return -errno;
 		}
-		strncpy(ifr.ifr_name, dpaa_intf->name, IFNAMSIZ - 1);
+
+		sh_if_name[0] = '\0';
+		ret = dpaa_get_devargs_str(dpaa_dev->device.devargs,
+					   DRIVER_SH_IF_NAME, sh_if_name,
+					   sizeof(sh_if_name));
+		if (ret <= 0 || sh_if_name[0] == '\0')
+			strlcpy(ifr.ifr_name, dpaa_intf->name, IFNAMSIZ);
+		else
+			strlcpy(ifr.ifr_name, sh_if_name, IFNAMSIZ);
 
 		if (ioctl(socket_fd, SIOCGIFMTU, &ifr) < 0) {
 			DPAA_PMD_ERR("Cannot get interface mtu");
@@ -2271,6 +2284,53 @@ dpaa_get_devargs_int(struct rte_devargs *devargs, const char *key, long *val)
 	return 1;
 }
 
+static int
+parse_str_devarg_handler(__rte_unused const char *key, const char *value,
+			 void *opaque)
+{
+	*(const char **)opaque = value;
+	return 0;
+}
+
+/*
+ * Fetch a string valued device argument into a caller-supplied buffer.
+ * Returns 1 and copies the value into val (up to size bytes, NUL-terminated)
+ * if the key is present, 0 if the key is absent, and a negative errno on error.
+ */
+static int
+dpaa_get_devargs_str(struct rte_devargs *devargs, const char *key,
+		     char *val, size_t size)
+{
+	struct rte_kvargs *kvlist;
+	const char *str = NULL;
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
+	ret = rte_kvargs_process(kvlist, key, parse_str_devarg_handler, &str);
+	if (ret < 0 || str == NULL) {
+		rte_kvargs_free(kvlist);
+		return ret < 0 ? ret : 0;
+	}
+
+	ret = rte_strscpy(val, str, size);
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
@@ -2808,5 +2868,6 @@ RTE_PMD_REGISTER_PARAM_STRING(net_dpaa,
 		DRIVER_RECV_ERR_PKTS "=<int>"
 		DRIVER_RX_TAILDROP "=<int>"
 		DRIVER_TX_TAILDROP "=<int>"
-		DRIVER_FMCLESS_RXQ "=<int>");
+		DRIVER_FMCLESS_RXQ "=<int>"
+		DRIVER_SH_IF_NAME "=<string>");
 RTE_LOG_REGISTER_DEFAULT(dpaa_logtype_pmd, NOTICE);
-- 
2.25.1

