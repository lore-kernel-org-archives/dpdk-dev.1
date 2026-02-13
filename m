Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2ACEF99C5
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 18:54:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17E964065A;
	Fri, 13 Feb 2026 19:53:37 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 6298B402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 19:53:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771008811;
 bh=Dc+lb1aWDG57oPYnUYt0JfGF8adDEE/A68LNAIRCODI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=f/XhHtpB7sIXw40DV7cHgGMZIdkJQNg8p7gW3GGuOgETkLVr7MgetcwNy358NhTTG
 Gi5+W7sf07h9G/mGY/iXITurh/IKLJ1Ou8YWkCbLcv8DFl+G+XNtFNI+/uSSAJDtvZ
 4WDUTMeSwLK41FgPh/bPUsR3FCtXNS0zffSiBFCDTS1pRga9QeRI50fPcBRvBnQbpy
 udRaaBMSmJhqkFLtnMV6GNETZ5iabY120x1je1FIq18ca5iz3r+A2Pxh1DAdzXBw7P
 gxygq29q7junASL3mJ3t9weR84yWm8XHwAQr548x9qTz2E28l++l9iaspBrbcMpB5E
 ZrOshznJwAUOA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 466BF1180082;
 Fri, 13 Feb 2026 19:53:31 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v8 4/8] net/nfb: add device argument "port" to limit used ports
Date: Fri, 13 Feb 2026 19:53:13 +0100
Message-ID: <20260213185317.1893353-5-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213185317.1893353-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260213185317.1893353-1-spinler@cesnet.cz>
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

From: Martin Spinler <spinler@cesnet.cz>

NFB devices do not use separate PCI device for each port; one PCI device
contains handles for all ports instead. For some application this approach
can be limiting.

The "port" argument can be used to select only desired ports.
It can be used multiple times. When is not used at all, the driver
selects all ports.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb.h        |  7 ++++
 drivers/net/nfb/nfb_ethdev.c | 67 +++++++++++++++++++++++++++++++++---
 drivers/net/nfb/nfb_vdev.c   |  3 +-
 3 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index 3f758da7be..0ff49929c1 100644
--- a/drivers/net/nfb/nfb.h
+++ b/drivers/net/nfb/nfb.h
@@ -42,6 +42,13 @@ extern int nfb_logtype;
 
 #define RTE_NFB_DRIVER_NAME net_nfb
 
+/* Device arguments */
+#define NFB_ARG_PORT "port"
+
+#define NFB_COMMON_ARGS \
+	NFB_ARG_PORT "=<number>" \
+	""
+
 /*
  * Handles obtained from the libnfb: each process must use own instance.
  * Stored inside dev->process_private.
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 5758e22426..6ff343488d 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -4,6 +4,7 @@
  * All rights reserved.
  */
 
+#include <ctype.h>
 #include <sys/queue.h>
 #include <eal_export.h>
 #include <rte_tailq.h>
@@ -22,12 +23,19 @@
 #include "nfb_rxmode.h"
 #include "nfb.h"
 
+static const char * const VALID_KEYS[] = {
+	NFB_ARG_PORT,
+	NULL
+};
+
 struct nfb_ifc_create_params {
 	struct nfb_probe_params *probe_params;
 	struct nc_ifc_map_info map_info;
 	struct nc_ifc_info *ifc_info;
 
 	int basename_len;       /* Cached real length of original probe_params->name */
+	/* Return value of failed nfb_eth_dev_create_for_ifc when rte_kvargs_process is used */
+	int ret;
 };
 
 /* The TAILQ entries are used for cleanup of allocated resources
@@ -738,6 +746,29 @@ nfb_eth_dev_create_for_ifc(struct nfb_ifc_create_params *cp)
 	return ret;
 }
 
+static int nfb_eth_dev_create_for_ifc_by_port(const char *key __rte_unused,
+		const char *value, void *opaque)
+{
+	char *end;
+	unsigned long port;
+	struct nfb_ifc_create_params *ifc_params = opaque;
+
+	if (value == NULL || strlen(value) == 0 || !isdigit(*value))
+		return -EINVAL;
+
+	errno = 0;
+	port = strtoul(value, &end, 10);
+	if (errno != 0 || *end != '\0')
+		return -EINVAL;
+
+	if (port >= LONG_MAX || port >= (unsigned long)ifc_params->map_info.ifc_cnt)
+		return -EINVAL;
+
+	ifc_params->ifc_info = &ifc_params->map_info.ifc[port];
+	ifc_params->ret = nfb_eth_dev_create_for_ifc(ifc_params);
+	return ifc_params->ret;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(nfb_eth_common_probe)
 int
 nfb_eth_common_probe(struct nfb_probe_params *params)
@@ -747,6 +778,7 @@ nfb_eth_common_probe(struct nfb_probe_params *params)
 
 	struct nfb_device *nfb_dev;
 	struct nfb_ifc_create_params ifc_params;
+	struct rte_kvargs *kvlist = NULL;
 
 	/* Open the device handle just for parsing ifc_params.
 	 * A separate handle is used later for each netdev.
@@ -761,16 +793,38 @@ nfb_eth_common_probe(struct nfb_probe_params *params)
 	if (ret)
 		goto err_map_info_create;
 
+	if (params->args != NULL && strlen(params->args) > 0) {
+		kvlist = rte_kvargs_parse(params->args, VALID_KEYS);
+		if (kvlist == NULL) {
+			NFB_LOG(ERR, "Failed to parse device arguments %s", params->args);
+			ret = -EINVAL;
+			goto err_parse_args;
+		}
+	}
+
+	ifc_params.ret = 0;
 	ifc_params.probe_params = params;
 	ifc_params.basename_len = strlen(params->name);
 
-	for (i = 0; i < ifc_params.map_info.ifc_cnt; i++) {
-		ifc_params.ifc_info = &ifc_params.map_info.ifc[i];
-		ret = nfb_eth_dev_create_for_ifc(&ifc_params);
-		if (ret)
+	/* When at least one port argument is specified, create only selected ports */
+	if (kvlist && rte_kvargs_count(kvlist, NFB_ARG_PORT)) {
+		ret = rte_kvargs_process(kvlist, NFB_ARG_PORT,
+				nfb_eth_dev_create_for_ifc_by_port, (void *)&ifc_params);
+		if (ret) {
+			ret = ifc_params.ret;
 			goto err_dev_create;
+		}
+	} else {
+		for (i = 0; i < ifc_params.map_info.ifc_cnt; i++) {
+			ifc_params.ifc_info = &ifc_params.map_info.ifc[i];
+			ret = nfb_eth_dev_create_for_ifc(&ifc_params);
+			if (ret)
+				goto err_dev_create;
+		}
 	}
 
+	rte_kvargs_free(kvlist);
+
 	nc_map_info_destroy(&ifc_params.map_info);
 	nfb_close(nfb_dev);
 
@@ -778,6 +832,8 @@ nfb_eth_common_probe(struct nfb_probe_params *params)
 
 err_dev_create:
 	nfb_eth_common_remove(params->device);
+	rte_kvargs_free(kvlist);
+err_parse_args:
 	nc_map_info_destroy(&ifc_params.map_info);
 err_map_info_create:
 	nfb_close(nfb_dev);
@@ -884,3 +940,6 @@ RTE_PMD_REGISTER_PCI(RTE_NFB_DRIVER_NAME, nfb_eth_driver);
 RTE_PMD_REGISTER_PCI_TABLE(RTE_NFB_DRIVER_NAME, nfb_pci_id_table);
 RTE_PMD_REGISTER_KMOD_DEP(RTE_NFB_DRIVER_NAME, "* nfb");
 RTE_LOG_REGISTER_DEFAULT(nfb_logtype, NOTICE);
+RTE_PMD_REGISTER_PARAM_STRING(RTE_NFB_DRIVER_NAME,
+		NFB_COMMON_ARGS
+		);
diff --git a/drivers/net/nfb/nfb_vdev.c b/drivers/net/nfb/nfb_vdev.c
index b79f7ac416..57f10d2068 100644
--- a/drivers/net/nfb/nfb_vdev.c
+++ b/drivers/net/nfb/nfb_vdev.c
@@ -102,5 +102,6 @@ static struct rte_vdev_driver vdev_nfb_vdev = {
 RTE_PMD_REGISTER_VDEV(VDEV_NFB_DRIVER, vdev_nfb_vdev);
 RTE_PMD_REGISTER_ALIAS(VDEV_NFB_DRIVER, eth_vdev_nfb);
 RTE_PMD_REGISTER_PARAM_STRING(net_vdev_nfb,
-		VDEV_NFB_ARG_DEV "=<string>"
+		VDEV_NFB_ARG_DEV "=<string> "
+		NFB_COMMON_ARGS
 		);
-- 
2.53.0

