Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8093AE95395
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 12:32:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DCF14067A;
	Wed,  4 Feb 2026 13:32:08 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id DCCE6402DE
 for <dev@dpdk.org>; Wed,  4 Feb 2026 13:32:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770208322;
 bh=PgYaHx0hJvaXeJHcp3kzNbsNr5f8A9ljGEoeQS0fQlU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=E9EcxxlWzJkSWD5oEhKhkMCna1vFVDGwnA8zQ9tgZ68dL/gssQC++0eVdJqzMdLY1
 WNAb8w1peq6L8y2D4yi/wWdk+vVPXsoDBWSFcxZWBFYmDJtfrNjYOVJJXuekwY7v+V
 3Iyy3WHrO9kk4rmvFqmjwxOpi7xivPJbJhOVY8CIosS3OI2mSLRSl9Qeqkc+yM0HAb
 GDxKyL96CCVPjGQxGlhMv0kQDLMZdVOZXWVAw+u/zUPpGKzr+s0ZrcSAJ+GLlDv/ut
 nFYJ1tGjNzUdPP9ztUIS3q7RtYdHjxHzS6fo7OiENfnhWls1Z/MjQWm4xS5XChcqWe
 yQtUqUi2YiAkg==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id B4C241180072;
 Wed,  4 Feb 2026 13:32:02 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v7 4/8] net/nfb: add device argument "port" to limit used ports
Date: Wed,  4 Feb 2026 13:31:33 +0100
Message-ID: <20260204123137.123171-5-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204123137.123171-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260204123137.123171-1-spinler@cesnet.cz>
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
 drivers/net/nfb/nfb.h        |  7 +++++
 drivers/net/nfb/nfb_ethdev.c | 55 ++++++++++++++++++++++++++++++++++--
 drivers/net/nfb/nfb_vdev.c   |  3 +-
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index a1134d7786..10d74eb49c 100644
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
index 77a1488731..09a18362f5 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -4,6 +4,7 @@
  * All rights reserved.
  */
 
+#include <ctype.h>
 #include <sys/queue.h>
 #include <eal_export.h>
 #include <rte_tailq.h>
@@ -22,6 +23,11 @@
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
@@ -713,6 +719,24 @@ nfb_eth_dev_create_for_ifc(struct nfb_ifc_create_params *cp)
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
+	port = strtoul(value, &end, 0);
+	if (*end != '\0' || port >= (unsigned long)ifc_params->map_info.ifc_cnt)
+		return -EINVAL;
+
+	ifc_params->ifc_info = &ifc_params->map_info.ifc[port];
+	return nfb_eth_dev_create_for_ifc(ifc_params);
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(nfb_eth_common_probe)
 int
 nfb_eth_common_probe(struct nfb_probe_params *params)
@@ -722,6 +746,7 @@ nfb_eth_common_probe(struct nfb_probe_params *params)
 
 	struct nfb_device *nfb_dev;
 	struct nfb_ifc_create_params ifc_params;
+	struct rte_kvargs *kvlist = NULL;
 
 	nfb_dev = nfb_open(params->path);
 	if (nfb_dev == NULL) {
@@ -733,16 +758,35 @@ nfb_eth_common_probe(struct nfb_probe_params *params)
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
 	ifc_params.probe_params = params;
 	ifc_params.basename_len = strlen(params->name);
 
-	for (i = 0; i < ifc_params.map_info.ifc_cnt; i++) {
-		ifc_params.ifc_info = &ifc_params.map_info.ifc[i];
-		ret = nfb_eth_dev_create_for_ifc(&ifc_params);
+	/* When at least one port argument is specified, create only selected ports */
+	if (kvlist && rte_kvargs_count(kvlist, NFB_ARG_PORT)) {
+		ret = rte_kvargs_process(kvlist, NFB_ARG_PORT,
+				nfb_eth_dev_create_for_ifc_by_port, (void *)&ifc_params);
 		if (ret)
 			goto err_dev_create;
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
 
@@ -750,6 +794,8 @@ nfb_eth_common_probe(struct nfb_probe_params *params)
 
 err_dev_create:
 	nfb_eth_common_remove(params->device);
+	rte_kvargs_free(kvlist);
+err_parse_args:
 	nc_map_info_destroy(&ifc_params.map_info);
 err_map_info_create:
 	nfb_close(nfb_dev);
@@ -858,3 +904,6 @@ RTE_PMD_REGISTER_PCI(RTE_NFB_DRIVER_NAME, nfb_eth_driver);
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

