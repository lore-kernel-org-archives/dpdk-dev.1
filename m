Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFB4C44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 07:27:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86683402C3;
	Thu, 22 Jan 2026 08:27:35 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 8CA7C400D5
 for <dev@dpdk.org>; Thu, 22 Jan 2026 08:27:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1769066849;
 bh=LsfbJ/PIITrTnf/Jh39YOX5T1gEECoBzPhueOR7ap38=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jBk2UNsLz59SamajsOCocbxOamKRU2oMMiDUcdEXZ2bVQuwliELCs2YjoFCdSPL9U
 Dh0KG2TXGZrxVCpXJELUfApknXzxGqb+Kqk9kqsPhOunK5IKMl0WyPVOzExO7VyFi/
 M98iN9mKaJ9pWrNvZoFgzpvrU2nOvFq6m+Yxv9XFVWBYONyU4vHVmVPLDQfki7eLPm
 KIda/Ja0/6fziuEV8gGRAZf/B7WWv8H90d/pzAN5PV5oITCqkiAYbDWUou2A6xkp6G
 wjbyvgGaipv8Kx+nTf8+P+KRz/8lIxlhPX3rp9niUdyCOfhALyctL9jj9SegFeRGBi
 VzkhkAGA+qlEA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 6F0D7118007E;
 Thu, 22 Jan 2026 08:27:29 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v4 4/8] net/nfb: add device argument "port" to limit used ports
Date: Thu, 22 Jan 2026 08:27:15 +0100
Message-ID: <20260122072719.505185-5-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122072719.505185-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260122072719.505185-1-spinler@cesnet.cz>
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
 drivers/net/nfb/nfb_ethdev.c | 54 +++++++++++++++++++++++++++++++++++-
 drivers/net/nfb/nfb_vdev.c   |  3 +-
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index d0d46f4a38..605ea8e875 100644
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
index 3c009fc1a4..f7c50ea3c4 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -22,6 +22,11 @@
 #include "nfb_rxmode.h"
 #include "nfb.h"
 
+static const char * const VALID_KEYS[] = {
+	NFB_ARG_PORT,
+	NULL
+};
+
 /* The TAILQ entries are used for cleanup of allocated resources
  * in situations, where dev_close is not called.
  */
@@ -664,6 +669,23 @@ nfb_eth_dev_uninit(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int fill_port_mask(const char *key __rte_unused, const char *value, void *opaque)
+{
+	char *end;
+	uint64_t *port_mask = opaque;
+	unsigned long port;
+
+	if (value == NULL || strlen(value) == 0 || !isdigit(*value))
+		return -1;
+
+	port = strtoul(value, &end, 0);
+	if (*end != '\0' || port >= ULONG_WIDTH)
+		return -1;
+
+	*port_mask |= RTE_BIT64(port);
+	return 0;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(nfb_eth_common_probe)
 int
 nfb_eth_common_probe(struct rte_device *device,
@@ -671,7 +693,7 @@ nfb_eth_common_probe(struct rte_device *device,
 		struct nfb_init_params *params, int ep_index)
 {
 	int i;
-	int ret;
+	int ret = 0;
 	int basename_len;
 
 	struct nc_ifc_info *ifc;
@@ -679,6 +701,9 @@ nfb_eth_common_probe(struct rte_device *device,
 	struct rte_eth_dev *eth_dev;
 	struct pmd_internals *p;
 
+	struct rte_kvargs *kvlist;
+	uint64_t port_mask = UINT64_MAX;
+
 	basename_len = strlen(params->name);
 
 	nfb_dev = nfb_open(params->path);
@@ -689,6 +714,27 @@ nfb_eth_common_probe(struct rte_device *device,
 
 	nc_ifc_map_info_create_ordinary(nfb_dev, &params->map_info);
 
+	if (params->args != NULL && strlen(params->args) > 0) {
+		kvlist = rte_kvargs_parse(params->args, VALID_KEYS);
+		if (kvlist == NULL) {
+			NFB_LOG(ERR, "Failed to parse device arguments %s", params->args);
+			return -EINVAL;
+		}
+		if (rte_kvargs_count(kvlist, NFB_ARG_PORT)) {
+			port_mask = 0;
+			if (rte_kvargs_process(kvlist, NFB_ARG_PORT, fill_port_mask,
+					(void *)&port_mask))
+				ret = -1;
+			if (ret || port_mask >= RTE_BIT64(params->map_info.ifc_cnt))
+				port_mask = 0;
+		}
+		rte_kvargs_free(kvlist);
+		if (port_mask == 0) {
+			NFB_LOG(ERR, "Failed to parse device port argument");
+			return -EINVAL;
+		}
+	}
+
 	for (i = 0; i < params->map_info.ifc_cnt; i++) {
 		ifc = &params->map_info.ifc[i];
 		params->ifc_info = ifc;
@@ -698,6 +744,9 @@ nfb_eth_common_probe(struct rte_device *device,
 				(ifc->flags & NC_IFC_INFO_FLAG_ACTIVE) == 0)
 			continue;
 
+		if ((port_mask & RTE_BIT64(i)) == 0)
+			continue;
+
 		snprintf(params->name + basename_len, sizeof(params->name) - basename_len,
 				"_eth%d", params->ifc_info->id);
 
@@ -818,3 +867,6 @@ RTE_PMD_REGISTER_PCI(RTE_NFB_DRIVER_NAME, nfb_eth_driver);
 RTE_PMD_REGISTER_PCI_TABLE(RTE_NFB_DRIVER_NAME, nfb_pci_id_table);
 RTE_PMD_REGISTER_KMOD_DEP(RTE_NFB_DRIVER_NAME, "* nfb");
 RTE_LOG_REGISTER_DEFAULT(nfb_logtype, NOTICE);
+RTE_PMD_REGISTER_PARAM_STRING(RTE_NFB_DRIVER_NAME,
+		NFB_COMMON_ARGS
+		);
diff --git a/drivers/net/nfb/nfb_vdev.c b/drivers/net/nfb/nfb_vdev.c
index c3629bd395..81f9301def 100644
--- a/drivers/net/nfb/nfb_vdev.c
+++ b/drivers/net/nfb/nfb_vdev.c
@@ -98,5 +98,6 @@ static struct rte_vdev_driver vdev_nfb_vdev = {
 RTE_PMD_REGISTER_VDEV(VDEV_NFB_DRIVER, vdev_nfb_vdev);
 RTE_PMD_REGISTER_ALIAS(VDEV_NFB_DRIVER, eth_vdev_nfb);
 RTE_PMD_REGISTER_PARAM_STRING(net_vdev_nfb,
-		VDEV_NFB_ARG_DEV "=<string>"
+		VDEV_NFB_ARG_DEV "=<string> "
+		NFB_COMMON_ARGS
 		);
-- 
2.52.0

