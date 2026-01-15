Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C346D44C61
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 15:17:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A146B427E6;
	Thu, 15 Jan 2026 16:17:08 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id C3AE74003C
 for <dev@dpdk.org>; Thu, 15 Jan 2026 16:17:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768490223;
 bh=9KQ1RLO/3XmcloHtRLh15as4pEqMar/fXzpt/lu2vqo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eO0QHft5zhNXF8gcbFoksSXgzaV2c3RaQs7MkoVO9XTAMvMnusaZg97RnOLB0x47D
 6DFAQgWW+aS1S9xIor+1HSsH2ukjMsJihttINVhp3mpRWm1Eh8Ck9JJGjYC7E32ujG
 SQdKxoSCe3nz0gHIO1e/7e/VG8xmvUTQho08CrHYBIqKOUtJ18KZDDrgVY73qKRXly
 DO+g0wU4CkvKcx+4AB1SHoTs7YgqHO72OWPhbTavBbbfXQ4OHJaBYEkdLU0CcOs4Ts
 cLtFbSnuIYvdJVymOkGgi0TldRO698VVqNC9vFQl8lI/8oPb7EC9Q6+C76tumKbffh
 47uLBTC+cfzTA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 9BAE61180088;
 Thu, 15 Jan 2026 16:17:03 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH 4/8] net/nfb: add device argument "port" to limit used ports
Date: Thu, 15 Jan 2026 16:16:52 +0100
Message-ID: <20260115151656.393106-5-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115151656.393106-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
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

NFB devices does not use separate PCI device for each port; one PCI device
contains handles for all ports instead. For some application this approach
can be limiting.

The "port" argument can be used to select only desired ports.
It can be used multiple times. When is not used at all, the driver
selects all ports.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb.h        | 10 ++++++++
 drivers/net/nfb/nfb_ethdev.c | 49 +++++++++++++++++++++++++++++++++++-
 drivers/net/nfb/nfb_vdev.c   |  3 ++-
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index 9c0d1a06f8..86fcc1862c 100644
--- a/drivers/net/nfb/nfb.h
+++ b/drivers/net/nfb/nfb.h
@@ -42,6 +42,16 @@ extern int nfb_logtype;
 
 #define RTE_NFB_DRIVER_NAME net_nfb
 
+/* Device arguments */
+#define NFB_ARG_PORT "port"
+
+#define NFB_COMMON_ARGS \
+	NFB_ARG_PORT"=<number>"
+
+static const char * const VALID_KEYS[] = {
+	NFB_ARG_PORT,
+	NULL
+};
 
 struct pmd_internals {
 	uint16_t         max_rxmac;
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 4a6648059e..7f0303e389 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -659,13 +659,31 @@ nfb_eth_dev_uninit(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int fill_port_mask(const char *key __rte_unused, const char *value, void *opaque)
+{
+	int ret = 0;
+	char *end = NULL;
+	uint64_t *port_mask = opaque;
+	int port;
+
+	port = strtol(value, &end, 16);
+	if ((value[0] == '\0') || (end == NULL) || (*end != '\0'))
+		ret = -1;
+
+	if (ret != 0 || port >= 64 || port < 0)
+		return -1;
+
+	*port_mask |= (1ull << port);
+	return 0;
+}
+
 int
 nfb_eth_common_probe(struct rte_device *device,
 		ethdev_bus_specific_init specific_init, void *specific_device,
 		struct nfb_init_params *params, int ep_index)
 {
 	int i;
-	int ret;
+	int ret = 0;
 	int basename_len;
 
 	struct nc_ifc_info *ifc;
@@ -673,6 +691,9 @@ nfb_eth_common_probe(struct rte_device *device,
 	struct rte_eth_dev *eth_dev;
 	struct pmd_internals *p;
 
+	struct rte_kvargs *kvlist;
+	uint64_t port_mask = 0xFFFFFFFFFFFFFFFFull;
+
 	basename_len = strlen(params->name);
 
 	nfb_dev = nfb_open(params->path);
@@ -683,6 +704,26 @@ nfb_eth_common_probe(struct rte_device *device,
 
 	nc_ifc_map_info_create_ordinary(nfb_dev, &params->map_info);
 
+	if (params->args != NULL && strlen(params->args) > 0) {
+		kvlist = rte_kvargs_parse(params->args, VALID_KEYS);
+		if (kvlist == NULL) {
+			NFB_LOG(ERR, "Failed to parse device arguments %s", params->args);
+			return -EINVAL;
+		}
+		if (rte_kvargs_count(kvlist, NFB_ARG_PORT)) {
+			port_mask = 0;
+			if (rte_kvargs_process(kvlist, NFB_ARG_PORT, fill_port_mask, (void*) &port_mask))
+				ret = -1;
+			if (ret || port_mask >= (1ull << (params->map_info.ifc_cnt)))
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
 		ifc = params->ifc_info = &params->map_info.ifc[i];
 
@@ -691,6 +732,9 @@ nfb_eth_common_probe(struct rte_device *device,
 				(ifc->flags & NC_IFC_INFO_FLAG_ACTIVE) == 0)
 			continue;
 
+		if ((port_mask & (1ull << i)) == 0)
+			continue;
+
 		snprintf(params->name + basename_len, sizeof(params->name) - basename_len,
 				"_eth%d", params->ifc_info->id);
 
@@ -807,3 +851,6 @@ RTE_PMD_REGISTER_PCI(RTE_NFB_DRIVER_NAME, nfb_eth_driver);
 RTE_PMD_REGISTER_PCI_TABLE(RTE_NFB_DRIVER_NAME, nfb_pci_id_table);
 RTE_PMD_REGISTER_KMOD_DEP(RTE_NFB_DRIVER_NAME, "* nfb");
 RTE_LOG_REGISTER_DEFAULT(nfb_logtype, NOTICE);
+RTE_PMD_REGISTER_PARAM_STRING(RTE_NFB_DRIVER_NAME,
+		NFB_COMMON_ARGS
+		);
diff --git a/drivers/net/nfb/nfb_vdev.c b/drivers/net/nfb/nfb_vdev.c
index 0cbb34f00a..f5c8b3edb0 100644
--- a/drivers/net/nfb/nfb_vdev.c
+++ b/drivers/net/nfb/nfb_vdev.c
@@ -92,5 +92,6 @@ static struct rte_vdev_driver vdev_nfb_vdev = {
 RTE_PMD_REGISTER_VDEV(VDEV_NFB_DRIVER, vdev_nfb_vdev);
 RTE_PMD_REGISTER_ALIAS(VDEV_NFB_DRIVER, eth_vdev_nfb);
 RTE_PMD_REGISTER_PARAM_STRING(net_vdev_nfb,
-		VDEV_NFB_ARG_DEV "=<string>"
+		VDEV_NFB_ARG_DEV "=<string> "
+		NFB_COMMON_ARGS
 		);
-- 
2.52.0

