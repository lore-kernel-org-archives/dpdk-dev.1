Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEDB606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 08:52:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C4A940611;
	Wed, 28 Oct 2026 09:52:01 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 68D74400D7
 for <dev@dpdk.org>; Wed, 28 Oct 2026 09:51:57 +0100 (CET)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3039520000A;
 Wed, 28 Oct 2026 09:51:57 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F0912200002;
 Wed, 28 Oct 2026 09:51:56 +0100 (CET)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3667D1800068;
 Wed, 28 Oct 2026 16:51:56 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH 2/3] net/dpaa: support non fmX-macY type of shared Ethernet
 name
Date: Wed, 28 Oct 2026 14:21:53 +0530
Message-Id: <20261028085154.699656-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261028085154.699656-1-g.singh@nxp.com>
References: <20261028085154.699656-1-g.singh@nxp.com>
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
 doc/guides/nics/dpaa.rst       |  5 +++
 drivers/net/dpaa/dpaa_ethdev.c | 59 +++++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/dpaa.rst b/doc/guides/nics/dpaa.rst
index 667b8c113d..14a14feb3c 100644
--- a/doc/guides/nics/dpaa.rst
+++ b/doc/guides/nics/dpaa.rst
@@ -303,6 +303,11 @@ is passed through the EAL bus arguments. The bus name is ``dpaa_bus``:
    silently drops that port.
 
 
+* For a shared MAC interface the kernel network interface name is looked up
+  in sysfs from the device tree node the port was created from,
+  so a kernel interface that does not follow
+  the ``fmX-macY`` naming style is handled without extra configuration.
+
 FMAN Config
 -----------
 
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index fe49c7b961..456e3df995 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -15,6 +15,7 @@
 #include <sys/types.h>
 #include <sys/syscall.h>
 #include <sys/ioctl.h>
+#include <dirent.h>
 
 #include <eal_export.h>
 #include <rte_string_fns.h>
@@ -57,6 +58,53 @@
 #define DRIVER_RECV_ERR_PKTS      "recv_err_pkts"
 #define RTE_PRIORITY_103 103
 
+/*
+ * Get the name of the kernel netdev bound to the same device tree node as
+ * this port. Returns 1 on success, 0 if none was found, negative on error.
+ */
+static int
+dpaa_get_kernel_ifname(const char *node_path, char *name, size_t size)
+{
+	char path[PATH_MAX];
+	const char *node;
+	struct dirent *entry;
+	DIR *dir;
+	int ret;
+
+	if (!node_path || node_path[0] == '\0')
+		return 0;
+
+	/* Platform device name is the last node of the DTS path. */
+	node = strrchr(node_path, '/');
+	node = node ? node + 1 : node_path;
+	if (node[0] == '\0')
+		return 0;
+
+	ret = snprintf(path, sizeof(path),
+		       "/sys/bus/platform/devices/%s/net", node);
+	if (ret < 0 || (size_t)ret >= sizeof(path))
+		return -ENAMETOOLONG;
+
+	dir = opendir(path);
+	if (!dir)
+		return 0;
+
+	ret = 0;
+	while ((entry = readdir(dir)) != NULL) {
+		if (entry->d_name[0] == '.')
+			continue;
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
@@ -251,6 +299,7 @@ dpaa_eth_dev_configure(struct rte_eth_dev *dev)
 	int speed, duplex;
 	int ret, rx_status, socket_fd;
 	struct ifreq ifr;
+	char sh_if_name[IFNAMSIZ];
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -272,7 +321,15 @@ dpaa_eth_dev_configure(struct rte_eth_dev *dev)
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

