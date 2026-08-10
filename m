Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB74C5AD7B
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 10:12:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6C1040671;
	Mon, 10 Aug 2026 12:12:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id E0AD5402E8;
 Mon, 10 Aug 2026 12:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786356770; x=1817892770;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=U3/Rvu2u/ZpN5FesC8r8Ab+5hjkw7z09cDfimPGFae8=;
 b=TYVa2Jv5MYUVMM/u7Lv5sCI2ZFNq5OOsF+VNDM3edo7+pozCfBlXlG8r
 jNn7/cydzvORV2ow1H0vGM/JKq7Wc4h82q6l3Ezrg96HUf+vO1RnU9A2F
 PT5+3vCrIRjYLn1cyfMgPOdfH5oHPgo6jHz7gNVEJi9DYBD/s90hhHNgc
 Z5JfaV6txycJTo0d7gkwsF013P+a0bXTMTCmMkgJHTkwx3DKLLvsVEvaS
 K1UwQc8a+Z55yLZR4PuizNRSn7DNdFL8OLFk1zrgXx49e2RfNdXTcv9eb
 ZaXz0kaX4ewrYp+AVLYoTZXzph7SAQeHd3zkJEgeQaxQRmFkQxEh9NS0f w==;
X-CSE-ConnectionGUID: dQPwBJ3zS7myKu39udK/vg==
X-CSE-MsgGUID: mYf1iA/ERk+v0VfR7LF8ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86893668"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="86893668"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 03:12:49 -0700
X-CSE-ConnectionGUID: Ml5fenntSkqm+O4WDGMSEg==
X-CSE-MsgGUID: KihAye98T3Wk5J5bGgT2tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="301227635"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa001.jf.intel.com with ESMTP; 10 Aug 2026 03:12:47 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com, mtahhan@redhat.com, stephen@networkplumber.org,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH] net/af_xdp: fix default device plugin path
Date: Mon, 10 Aug 2026 10:11:58 +0000
Message-Id: <20260810101158.1011356-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When use_cni=1 or use_pinned_map=1 is passed without an explicit
dp_path, the PMD builds the path to the AF_XDP device plugin
endpoint itself.
That default was hardcoded to /tmp/afxdp_dp/<if_name>/.

A unix domain socket and a pinned map are runtime state.
Current Linux file hierarchy conventions place these below
the runtime directory, not below world writable /tmp.
DPDK already exposes such a location through
rte_eal_get_runtime_dir().

The location cannot simply be moved as it is a contract
duplicated in the AF_XDP Device Plugin for Kubernetes,
which creates the socket and mounts it into the pod at
the /tmp path the PMD expects.
Changing only the PMD would break every existing deployment.

This patch fixes the default so that the endpoint is looked
up below the EAL runtime directory first, and fall back to
/tmp/afxdp_dp only when nothing is found there, a warning
is logged whenever that fallback is taken.
Existing plugin deployments keep working unchanged, while
a deployment, that places the endpoint in the runtime
directory, no longer has to pass dp_path.
An explicit dp_path still overrides both.

The <if_name> component is kept in both layouts. It is what
keeps the endpoints of several interfaces distinct when more
than one UDS server is mounted in a single pod.

The runtime directory prefix makes the built path longer,
so reject a dp_path that does not fit the sun_path field
of struct sockaddr_un instead of letting strlcpy()
silently truncate it.

The interface name check is moved ahead of the path
construction, as the default path is now built from it.

Bugzilla ID: 1973
Fixes: 9c1323736cf9 ("net/af_xdp: fix multi-interface support for k8s")
Fixes: 8a324b1c6464 ("net/af_xdp: support AF_XDP device plugin pinned maps")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 doc/guides/howto/af_xdp_dp.rst      | 24 ++++++++-
 doc/guides/nics/af_xdp.rst          | 26 ++++++++--
 drivers/net/af_xdp/rte_eth_af_xdp.c | 76 ++++++++++++++++++++++++++---
 3 files changed, 114 insertions(+), 12 deletions(-)

diff --git a/doc/guides/howto/af_xdp_dp.rst b/doc/guides/howto/af_xdp_dp.rst
index c194ead250..e9eeace749 100644
--- a/doc/guides/howto/af_xdp_dp.rst
+++ b/doc/guides/howto/af_xdp_dp.rst
@@ -68,7 +68,25 @@ arguments to explicitly tell the AF_XDP PMD where to find either:
 2. The pinned xskmap to use when creating AF_XDP sockets.
 
 If this argument is not passed alongside the ``use_cni`` or ``use_pinned_map`` arguments
-then the AF_XDP PMD configures it internally to the `AF_XDP Device Plugin for Kubernetes`_.
+then the AF_XDP PMD builds the path itself.
+It looks for ``afxdp_dp/<if_name>/afxdp.sock``
+(or ``afxdp_dp/<if_name>/xsks_map``) below the EAL runtime directory,
+which is where runtime state such as sockets belongs.
+When no such entry exists, the PMD falls back to the same file
+below ``/tmp/afxdp_dp``, the location used by the
+`AF_XDP Device Plugin for Kubernetes`_.
+
+.. note::
+
+   The ``/tmp/afxdp_dp`` fallback exists only for compatibility with
+   deployments of the `AF_XDP Device Plugin for Kubernetes`_
+   that mount the endpoint there.
+   New deployments should place the socket or pinned map
+   below the EAL runtime directory,
+   or point at it explicitly with ``dp_path``.
+   The ``<if_name>`` component of the path must be kept in either location:
+   it is what distinguishes the endpoints
+   when several interfaces are mounted in a single pod.
 
 .. note::
 
@@ -339,4 +357,6 @@ Run dpdk-testpmd with the AF_XDP Device Plugin + CNI
 .. note::
 
    If the ``dp_path`` parameter isn't explicitly set with ``use_cni`` or ``use_pinned_map``
-   the AF_XDP PMD will set the parameter values to the `AF_XDP Device Plugin for Kubernetes`_ defaults.
+   the AF_XDP PMD looks for the endpoint below the EAL runtime directory first,
+   and only then below the ``/tmp/afxdp_dp`` location
+   used by the `AF_XDP Device Plugin for Kubernetes`_.
diff --git a/doc/guides/nics/af_xdp.rst b/doc/guides/nics/af_xdp.rst
index c455b4c066..94583dbb62 100644
--- a/doc/guides/nics/af_xdp.rst
+++ b/doc/guides/nics/af_xdp.rst
@@ -199,18 +199,36 @@ to explicitly tell the AF_XDP PMD where to find either:
 1. The UDS to interact with the AF_XDP Device Plugin. OR
 2. The pinned xskmap to use when creating AF_XDP sockets.
 
-If this argument is not passed alongside the ``use_cni`` or ``use_pinned_map`` arguments then
-the AF_XDP PMD configures it internally to the `AF_XDP Device Plugin for Kubernetes`_.
+If this argument is not passed alongside the ``use_cni`` or ``use_pinned_map`` arguments,
+the AF_XDP PMD builds the path itself.
+It looks for ``afxdp_dp/<<interface name>>/afxdp.sock``
+(or ``afxdp_dp/<<interface name>>/xsks_map``) below the EAL runtime directory,
+which is where runtime state such as sockets belongs.
+When no such entry exists, the PMD falls back to the same file
+below ``/tmp/afxdp_dp``, the location used by the
+`AF_XDP Device Plugin for Kubernetes`_.
 
 .. _AF_XDP Device Plugin for Kubernetes: https://github.com/redhat-et/afxdp-plugins-for-kubernetes
 
+.. note::
+
+   The ``/tmp/afxdp_dp`` fallback exists only for compatibility with
+   deployments of the `AF_XDP Device Plugin for Kubernetes`_
+   that mount the endpoint there.
+   New deployments should place the socket or pinned map
+   below the EAL runtime directory,
+   or point at it explicitly with ``dp_path``.
+   The interface name component of the path must be kept in either location:
+   it is what distinguishes the endpoints
+   when several interfaces are mounted in a single pod.
+
 .. code-block:: console
 
-   --vdev=net_af_xdp0,use_cni=1,dp_path="/tmp/afxdp_dp/<<interface name>>/afxdp.sock"
+   --vdev=net_af_xdp0,use_cni=1,dp_path="/var/run/dpdk/rte/afxdp_dp/<<interface name>>/afxdp.sock"
 
 .. code-block:: console
 
-   --vdev=net_af_xdp0,use_pinned_map=1,dp_path="/tmp/afxdp_dp/<<interface name>>/xsks_map"
+   --vdev=net_af_xdp0,use_pinned_map=1,dp_path="/var/run/dpdk/rte/afxdp_dp/<<interface name>>/xsks_map"
 
 Limitations
 -----------
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 2cdb533276..a7b9cc2cdf 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -83,7 +83,9 @@ RTE_LOG_REGISTER_DEFAULT(af_xdp_logtype, NOTICE);
 
 #define ETH_AF_XDP_MP_KEY "afxdp_mp_send_fds"
 
-#define DP_BASE_PATH			"/tmp/afxdp_dp"
+/* Directory holding the per interface device plugin endpoints. */
+#define DP_DIR_NAME			"afxdp_dp"
+#define DP_LEGACY_BASE_PATH		"/tmp/" DP_DIR_NAME
 #define DP_UDS_SOCK             "afxdp.sock"
 #define DP_XSK_MAP				"xsks_map"
 #define MAX_LONG_OPT_SZ			64
@@ -1438,6 +1440,11 @@ init_uds_sock(struct sockaddr_un *server, const char *dp_path)
 {
 	int sock;
 
+	if (strnlen(dp_path, PATH_MAX) >= sizeof(server->sun_path)) {
+		AF_XDP_LOG_LINE(ERR, "Device plugin socket path '%s' is too long", dp_path);
+		return -1;
+	}
+
 	sock = socket(AF_UNIX, SOCK_SEQPACKET, 0);
 	if (sock < 0) {
 		AF_XDP_LOG_LINE(ERR, "Failed to opening stream socket");
@@ -2459,6 +2466,48 @@ afxdp_mp_send_fds(const struct rte_mp_msg *request, const void *peer)
 	return 0;
 }
 
+/*
+ * Build the default device plugin path for an interface.
+ *
+ * Unix domain sockets and pinned maps are runtime state, so the runtime
+ * directory is preferred over the world writable /tmp. The AF_XDP Device
+ * Plugin for Kubernetes still creates and mounts these endpoints below
+ * DP_LEGACY_BASE_PATH, so that location is used when the runtime directory
+ * holds no entry for the interface.
+ *
+ * The interface name is always part of the path: it keeps the endpoints of
+ * several interfaces distinct when more than one is mounted in a single pod.
+ */
+static int
+get_dflt_dp_path(char *dp_path, size_t size, const char *if_name,
+		 const char *entry)
+{
+	int ret;
+
+	ret = snprintf(dp_path, size, "%s/%s/%s/%s", rte_eal_get_runtime_dir(),
+		       DP_DIR_NAME, if_name, entry);
+	if (ret < 0 || (size_t)ret >= size)
+		goto too_long;
+
+	if (access(dp_path, F_OK) == 0)
+		return 0;
+
+	ret = snprintf(dp_path, size, "%s/%s/%s", DP_LEGACY_BASE_PATH, if_name,
+		       entry);
+	if (ret < 0 || (size_t)ret >= size)
+		goto too_long;
+
+	AF_XDP_LOG_LINE(WARNING,
+		"No '%s' entry for %s below '%s', falling back to '%s'",
+		entry, if_name, rte_eal_get_runtime_dir(), DP_LEGACY_BASE_PATH);
+
+	return 0;
+
+too_long:
+	AF_XDP_LOG_LINE(ERR, "Device plugin path for %s is too long", if_name);
+	return -ENAMETOOLONG;
+}
+
 static int
 rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 {
@@ -2522,6 +2571,11 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 		return -EINVAL;
 	}
 
+	if (strlen(if_name) == 0) {
+		AF_XDP_LOG_LINE(ERR, "Network interface must be specified");
+		return -EINVAL;
+	}
+
 	if (use_cni && use_pinned_map) {
 		AF_XDP_LOG_LINE(ERR, "When '%s' parameter is used, '%s' parameter is not valid",
 			ETH_AF_XDP_USE_CNI_ARG, ETH_AF_XDP_USE_PINNED_MAP_ARG);
@@ -2543,13 +2597,17 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 	}
 
 	if (use_cni && !strnlen(dp_path, PATH_MAX)) {
-		snprintf(dp_path, sizeof(dp_path), "%s/%s/%s", DP_BASE_PATH, if_name, DP_UDS_SOCK);
+		ret = get_dflt_dp_path(dp_path, sizeof(dp_path), if_name, DP_UDS_SOCK);
+		if (ret < 0)
+			return ret;
 		AF_XDP_LOG_LINE(INFO, "'%s' parameter not provided, setting value to '%s'",
 			ETH_AF_XDP_DP_PATH_ARG, dp_path);
 	}
 
 	if (use_pinned_map && !strnlen(dp_path, PATH_MAX)) {
-		snprintf(dp_path, sizeof(dp_path), "%s/%s/%s", DP_BASE_PATH, if_name, DP_XSK_MAP);
+		ret = get_dflt_dp_path(dp_path, sizeof(dp_path), if_name, DP_XSK_MAP);
+		if (ret < 0)
+			return ret;
 		AF_XDP_LOG_LINE(INFO, "'%s' parameter not provided, setting value to '%s'",
 			ETH_AF_XDP_DP_PATH_ARG, dp_path);
 	}
@@ -2561,9 +2619,15 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 		return -EINVAL;
 	}
 
-	if (strlen(if_name) == 0) {
-		AF_XDP_LOG_LINE(ERR, "Network interface must be specified");
-		return -EINVAL;
+	/*
+	 * The socket address is copied into sun_path which is much shorter than
+	 * PATH_MAX, reject an oversized path instead of silently truncating it.
+	 */
+	if (use_cni && strnlen(dp_path, PATH_MAX) >=
+		       RTE_SIZEOF_FIELD(struct sockaddr_un, sun_path)) {
+		AF_XDP_LOG_LINE(ERR, "'%s' value '%s' is too long for a unix socket address",
+				ETH_AF_XDP_DP_PATH_ARG, dp_path);
+		return -ENAMETOOLONG;
 	}
 
 	/* get numa node id from net sysfs */
-- 
2.34.1

