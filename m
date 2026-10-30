Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0621606A321
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 04:43:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3398040A6B;
	Fri, 30 Oct 2026 05:43:31 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 6B96440151
 for <dev@dpdk.org>; Fri, 30 Oct 2026 05:43:24 +0100 (CET)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 301661A0091;
 Fri, 30 Oct 2026 05:43:24 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EC2551A00BC;
 Fri, 30 Oct 2026 05:43:23 +0100 (CET)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 27CE9180022D;
 Fri, 30 Oct 2026 12:43:23 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v2 3/4] net/dpaa: support non fmX-macY type of shared Ethernet
 name
Date: Fri, 30 Oct 2026 10:13:17 +0530
Message-Id: <20261030044318.1892998-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261030044318.1892998-1-g.singh@nxp.com>
References: <20261028085517.705621-1-g.singh@nxp.com>
 <20261030044318.1892998-1-g.singh@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Hemant Agrawal <hemant.agrawal@nxp.com>

A shared MAC interface needs the kernel netdev name to read the MTU,
and that name is only the DPDK port name for fmX-macY style netdevs.

Look it up in sysfs under the platform device of the dpa-ethernet node
the port was created from, and fall back to the port name.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 doc/guides/nics/dpaa.rst       |  6 ++-
 drivers/net/dpaa/dpaa_ethdev.c | 68 +++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/dpaa.rst b/doc/guides/nics/dpaa.rst
index 21f54bcd36..2094abf417 100644
--- a/doc/guides/nics/dpaa.rst
+++ b/doc/guides/nics/dpaa.rst
@@ -276,6 +276,11 @@ Refer to the document :doc:`build_and_test` for details.
   and thus disabling hardware based packet handling at driver level,
   e.g. ``dpaa:fm1-mac3,recv_err_pkts=1``.
 
+* For a shared MAC interface the kernel network interface name is looked up
+  in sysfs from the device tree node the port was created from,
+  so a kernel interface that does not follow
+  the ``fmX-macY`` naming style is handled without extra configuration.
+
 ``drv_bh_port``
    Name of the back-half port associated with an offline (O/H) port device.
    It is passed on the offline port device itself, which is named
@@ -306,7 +311,6 @@ control device can be programmed by the application via the experimental
 ``rte_pmd_dpaa_ol_set_lgw_info()`` and ``rte_pmd_dpaa_ol_reset_lgw_info()``
 APIs declared in ``rte_pmd_dpaa_oldev.h``.
 
-
 FMAN Config
 -----------
 
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index fe49c7b961..a821e68807 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -9,12 +9,14 @@
 #include <inttypes.h>
 #include <unistd.h>
 #include <limits.h>
+#include <stdlib.h>
 #include <sched.h>
 #include <signal.h>
 #include <pthread.h>
 #include <sys/types.h>
 #include <sys/syscall.h>
 #include <sys/ioctl.h>
+#include <dirent.h>
 
 #include <eal_export.h>
 #include <rte_string_fns.h>
@@ -57,6 +59,61 @@
 #define DRIVER_RECV_ERR_PKTS      "recv_err_pkts"
 #define RTE_PRIORITY_103 103
 
+#define DPAA_OF_BASE_PATH "/sys/firmware/devicetree/base"
+
+/*
+ * Get the kernel netdev name bound to the same device tree node as this
+ * port, by matching each /sys/class/net/<ifname>/device/of_node against
+ * node_path. Returns 1 on success, 0 if none was found, negative on error.
+ */
+static int
+dpaa_get_kernel_ifname(const char *node_path, char *name, size_t size)
+{
+	char path[PATH_MAX], resolved[PATH_MAX];
+	struct dirent *entry;
+	DIR *dir;
+	int ret;
+
+	if (!node_path || node_path[0] == '\0')
+		return 0;
+
+	dir = opendir("/sys/class/net");
+	if (!dir)
+		return 0;
+
+	ret = 0;
+	while ((entry = readdir(dir)) != NULL) {
+		if (entry->d_name[0] == '.')
+			continue;
+
+		if (snprintf(path, sizeof(path),
+			     "/sys/class/net/%s/device/of_node",
+			     entry->d_name) >= (int)sizeof(path))
+			continue;
+
+		if (realpath(path, resolved) == NULL)
+			continue;
+
+		if (strncmp(resolved, DPAA_OF_BASE_PATH,
+			    strlen(DPAA_OF_BASE_PATH)) != 0)
+			continue;
+
+		if (strcmp(resolved + strlen(DPAA_OF_BASE_PATH),
+			   node_path) != 0)
+			continue;
+
+		if (rte_strscpy(name, entry->d_name, size) < 0) {
+			ret = -ENAMETOOLONG;
+			break;
+		}
+		ret = 1;
+		break;
+	}
+
+	closedir(dir);
+	return ret;
+}
+
 /* Supported Rx offloads */
 static uint64_t dev_rx_offloads_sup =
 		RTE_ETH_RX_OFFLOAD_SCATTER;
@@ -251,6 +308,7 @@ dpaa_eth_dev_configure(struct rte_eth_dev *dev)
 	int speed, duplex;
 	int ret, rx_status, socket_fd;
 	struct ifreq ifr;
+	char sh_if_name[IFNAMSIZ];
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -272,7 +330,15 @@ dpaa_eth_dev_configure(struct rte_eth_dev *dev)
 			DPAA_PMD_ERR("Cannot open IF socket");
 			return -errno;
 		}
-		strlcpy(ifr.ifr_name, dpaa_intf->name, IFNAMSIZ);
+
+		/* The DPDK port name matches the netdev only for fmX-macY. */
+		sh_if_name[0] = '\0';
+		ret = dpaa_get_kernel_ifname(__fif->node_path, sh_if_name,
+					     sizeof(sh_if_name));
+		if (ret <= 0 || sh_if_name[0] == '\0')
+			strlcpy(ifr.ifr_name, dpaa_intf->name, IFNAMSIZ);
+		else
+			strlcpy(ifr.ifr_name, sh_if_name, IFNAMSIZ);
 
 		if (ioctl(socket_fd, SIOCGIFMTU, &ifr) < 0) {
 			DPAA_PMD_ERR("Cannot get interface mtu");
-- 
2.25.1

