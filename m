Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69108E6816F
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 11:03:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4C3640616;
	Tue, 17 Feb 2026 12:03:29 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id AA164402A7
 for <dev@dpdk.org>; Tue, 17 Feb 2026 12:03:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771326206;
 bh=COP/qHUouWg7vFPqoMOvTJ/EhqNeoCZk6LFXZsQAEiU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EpiRuFmfkJfvB/Nre/j6xCI4t0P7ikdSig+XDgL1559u7TR+TkKD8jURswQ26SCjM
 csnBU/0cAJJAlomajWfK/KSPlosDTyK1K6icZAZv2TD/uUM8Bt8RLQ7s5ttMpdquoi
 GzQ/JPRt7HOoDMYVD0K42d0wuUd/4mj4NSZaYVgg1ybc/FzCqGR6REvrl2ag7QXOX2
 5IMZliPnosv2wxy21iHVBJXfaW5+mi3QzsvGfoYMIbQqGrvn7Wvi6v+mIJ64+nWj7P
 d5hnpy5WdwRoAQoatk9sG3yAlz1IAFoK8Vm/G78nZq4vdK0vz/0i0ao53eMH0ybnRJ
 TnOjtdzyqmFQA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 76866118013F;
 Tue, 17 Feb 2026 12:03:26 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v2 2/6] net/nfb: get correct link speed
Date: Tue, 17 Feb 2026 12:03:20 +0100
Message-ID: <20260217110324.3344310-3-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217110324.3344310-1-spinler@cesnet.cz>
References: <20260206170435.302184-1-spinler@cesnet.cz>
 <20260217110324.3344310-1-spinler@cesnet.cz>
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

Read link speed capabilities and actual link speed
from the MDIO registers.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 doc/guides/rel_notes/release_26_03.rst |  2 +-
 drivers/net/nfb/meson.build            |  1 +
 drivers/net/nfb/nfb.h                  |  7 +++
 drivers/net/nfb/nfb_ethdev.c           | 82 +++++++++++++++++++-------
 drivers/net/nfb/nfb_mdio.c             | 44 ++++++++++++++
 drivers/net/nfb/nfb_mdio.h             | 39 ++++++++++++
 6 files changed, 153 insertions(+), 22 deletions(-)
 create mode 100644 drivers/net/nfb/nfb_mdio.c
 create mode 100644 drivers/net/nfb/nfb_mdio.h

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 7678cf1a49..d408551955 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -64,7 +64,7 @@ New Features
   * The timestamp value has been updated to make it usable.
   * The DPDK port now represents just one Ethernet port instead of all Ethernet ports on the NIC.
   * All ports are used by default, but a subset can be selected using the ``port`` argument.
-  * Report firmware version.
+  * Report firmware version and correct Ethernet link speed.
   * Common CESNET-NDK-based adapters have been added,
     including the FB2CGHH (Silicom Denmark) and XpressSX AGI-FH400G (Reflex CES).
 
diff --git a/drivers/net/nfb/meson.build b/drivers/net/nfb/meson.build
index 9e458dfb4a..b57d1d48fa 100644
--- a/drivers/net/nfb/meson.build
+++ b/drivers/net/nfb/meson.build
@@ -21,6 +21,7 @@ sources = files(
         'nfb_rxmode.c',
         'nfb_stats.c',
         'nfb_tx.c',
+        'nfb_mdio.c',
 )
 
 cflags += no_wvla_cflag
diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index 1d863d5ad7..3b905bbb3b 100644
--- a/drivers/net/nfb/nfb.h
+++ b/drivers/net/nfb/nfb.h
@@ -11,6 +11,7 @@
 #include <nfb/ndp.h>
 #include <netcope/rxmac.h>
 #include <netcope/txmac.h>
+#include <netcope/mdio_if_info.h>
 #include <netcope/info.h>
 
 extern int nfb_logtype;
@@ -50,6 +51,10 @@ extern int nfb_logtype;
 	NFB_ARG_PORT "=<number>" \
 	""
 
+struct eth_node {
+	struct mdio_if_info if_info;    /**< MDIO interface handles */
+};
+
 /*
  * Handles obtained from the libnfb: each process must use own instance.
  * Stored inside dev->process_private.
@@ -57,8 +62,10 @@ extern int nfb_logtype;
 struct pmd_internals {
 	uint16_t         max_rxmac;     /**< Count of valid rxmac items */
 	uint16_t         max_txmac;     /**< Count of valid txmac items */
+	uint16_t         max_eth;       /**< Count of valid eth nodes */
 	struct nc_rxmac  **rxmac;       /**< Array of Rx MAC handles */
 	struct nc_txmac  **txmac;       /**< Array of Tx MAC handles */
+	struct eth_node	 *eth_node;     /**< Array of Eth nodes */
 	struct nfb_device *nfb;
 
 	TAILQ_ENTRY(pmd_internals) eth_dev_list;  /**< Item in list of all devices */
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index b99785cc22..9b173c0f89 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -14,6 +14,8 @@
 #include <netcope/eth.h>
 #include <netcope/rxmac.h>
 #include <netcope/txmac.h>
+#include <netcope/mdio.h>
+#include <netcope/ieee802_3.h>
 
 #include <ethdev_pci.h>
 #include <rte_kvargs.h>
@@ -24,6 +26,8 @@
 #include "nfb_rxmode.h"
 #include "nfb.h"
 
+#include "nfb_mdio.h"
+
 static const char * const VALID_KEYS[] = {
 	NFB_ARG_PORT,
 	NULL
@@ -48,6 +52,18 @@ static struct nfb_pmd_internals_head nfb_eth_dev_list =
 
 static int nfb_eth_dev_uninit(struct rte_eth_dev *dev);
 
+static int
+nfb_mdio_read(void *priv, int prtad, int devad, uint16_t addr)
+{
+	return nc_mdio_read((struct nc_mdio *)priv, prtad, devad, addr);
+}
+
+static int
+nfb_mdio_write(void *priv, int prtad, int devad, uint16_t addr, uint16_t val)
+{
+	return nc_mdio_write((struct nc_mdio *)priv, prtad, devad, addr, val);
+}
+
 /**
  * Default MAC addr
  */
@@ -67,10 +83,17 @@ static int
 nfb_nc_eth_init(struct pmd_internals *intl, struct nfb_ifc_create_params *params)
 {
 	int ret;
-	int i, rxm, txm;
+	int i, rxm, txm, eth;
 	struct nc_ifc_info *ifc = params->ifc_info;
 	struct nc_ifc_map_info *mi = &params->map_info;
 
+	int node, node_cp;
+	const int32_t *prop32;
+	int proplen;
+	const void *fdt;
+
+	fdt = nfb_get_fdt(intl->nfb);
+
 	ret = -ENOMEM;
 	if (ifc->eth_cnt == 0)
 		return 0;
@@ -83,14 +106,19 @@ nfb_nc_eth_init(struct pmd_internals *intl, struct nfb_ifc_create_params *params
 	if (intl->txmac == NULL)
 		goto err_alloc_txmac;
 
+	intl->eth_node = calloc(ifc->eth_cnt, sizeof(*intl->eth_node));
+	if (intl->eth_node == NULL)
+		goto err_alloc_ethnode;
+
 	/* Some eths may not have assigned MAC nodes, hence use separate var for indexing */
 	rxm = 0;
 	txm = 0;
+	eth = 0;
 	for (i = 0; i < mi->eth_cnt; i++) {
 		if (mi->eth[i].ifc != ifc->id)
 			continue;
 
-		if (rxm >= ifc->eth_cnt || txm >= ifc->eth_cnt) {
+		if (rxm >= ifc->eth_cnt || txm >= ifc->eth_cnt || eth >= ifc->eth_cnt) {
 			NFB_LOG(ERR, "MAC mapping inconsistent");
 			ret = -EINVAL;
 			goto err_map_inconsistent;
@@ -103,17 +131,37 @@ nfb_nc_eth_init(struct pmd_internals *intl, struct nfb_ifc_create_params *params
 		intl->txmac[txm] = nc_txmac_open(intl->nfb, mi->eth[i].node_txmac);
 		if (intl->txmac[txm])
 			txm++;
+
+		node = nc_eth_get_pcspma_control_node(fdt, mi->eth[i].node_eth, &node_cp);
+
+		intl->eth_node[eth].if_info.dev = nc_mdio_open(intl->nfb, node, node_cp);
+		if (intl->eth_node[eth].if_info.dev) {
+			intl->eth_node[eth].if_info.prtad = 0;
+			intl->eth_node[eth].if_info.mdio_read = nfb_mdio_read;
+			intl->eth_node[eth].if_info.mdio_write = nfb_mdio_write;
+
+			prop32 = fdt_getprop(fdt, node_cp, "dev", &proplen);
+			if (proplen == sizeof(*prop32))
+				intl->eth_node[eth].if_info.prtad = fdt32_to_cpu(*prop32);
+
+			eth++;
+		}
 	}
 
 	intl->max_rxmac = rxm;
 	intl->max_txmac = txm;
+	intl->max_eth = eth;
 	return 0;
 
 err_map_inconsistent:
+	for (i = 0; i < eth; i++)
+		nc_mdio_close(intl->eth_node[i].if_info.dev);
 	for (i = 0; i < txm; i++)
 		nc_txmac_close(intl->txmac[i]);
 	for (i = 0; i < rxm; i++)
 		nc_rxmac_close(intl->rxmac[i]);
+	free(intl->eth_node);
+err_alloc_ethnode:
 	free(intl->txmac);
 err_alloc_txmac:
 	free(intl->rxmac);
@@ -130,6 +178,8 @@ static void
 nfb_nc_eth_deinit(struct pmd_internals *intl)
 {
 	uint16_t i;
+	for (i = 0; i < intl->max_eth; i++)
+		nc_mdio_close(intl->eth_node[i].if_info.dev);
 	for (i = 0; i < intl->max_txmac; i++)
 		nc_txmac_close(intl->txmac[i]);
 	for (i = 0; i < intl->max_rxmac; i++)
@@ -276,16 +326,22 @@ nfb_eth_dev_info(struct rte_eth_dev *dev,
 	struct rte_eth_dev_info *dev_info)
 {
 	struct pmd_priv *priv = dev->data->dev_private;
+	struct pmd_internals *intl = dev->process_private;
 
 	dev_info->max_mac_addrs = nfb_eth_get_max_mac_address_count(dev);
 
 	dev_info->max_rx_pktlen = (uint32_t)-1;
 	dev_info->max_rx_queues = priv->max_rx_queues;
 	dev_info->max_tx_queues = priv->max_tx_queues;
-	dev_info->speed_capa = RTE_ETH_LINK_SPEED_100G;
+	dev_info->speed_capa = RTE_ETH_LINK_SPEED_FIXED;
 	dev_info->rx_offload_capa =
 		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
+	if (intl->max_eth) {
+		nfb_mdio_cl45_pma_get_speed_capa(&intl->eth_node[0].if_info,
+				&dev_info->speed_capa);
+	}
+
 	return 0;
 }
 
@@ -353,24 +409,8 @@ nfb_eth_link_update(struct rte_eth_dev *dev,
 	link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
 	link.link_autoneg = RTE_ETH_LINK_SPEED_FIXED;
 
-	if (internals->max_rxmac) {
-		nc_rxmac_read_status(internals->rxmac[0], &status);
-
-		switch (status.speed) {
-		case MAC_SPEED_10G:
-			link.link_speed = RTE_ETH_SPEED_NUM_10G;
-			break;
-		case MAC_SPEED_40G:
-			link.link_speed = RTE_ETH_SPEED_NUM_40G;
-			break;
-		case MAC_SPEED_100G:
-			link.link_speed = RTE_ETH_SPEED_NUM_100G;
-			break;
-		default:
-			link.link_speed = RTE_ETH_SPEED_NUM_NONE;
-			break;
-		}
-	}
+	if (internals->max_eth)
+		link.link_speed = ieee802_3_get_pma_speed_value(&internals->eth_node->if_info);
 
 	for (i = 0; i < internals->max_rxmac; ++i) {
 		nc_rxmac_read_status(internals->rxmac[i], &status);
diff --git a/drivers/net/nfb/nfb_mdio.c b/drivers/net/nfb/nfb_mdio.c
new file mode 100644
index 0000000000..a4a827e734
--- /dev/null
+++ b/drivers/net/nfb/nfb_mdio.c
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 CESNET, z.s.p.o.
+ */
+
+#include <eal_export.h>
+#include <rte_ethdev.h>
+
+#include "nfb_mdio.h"
+
+RTE_EXPORT_INTERNAL_SYMBOL(nfb_mdio_cl45_pma_get_speed_capa)
+void
+nfb_mdio_cl45_pma_get_speed_capa(struct mdio_if_info *info, uint32_t *capa)
+{
+	int i;
+	int reg;
+
+	const int speed_ability[NFB_MDIO_WIDTH] = {
+		RTE_ETH_LINK_SPEED_10G,
+		0,
+		0,
+		RTE_ETH_LINK_SPEED_50G,
+		RTE_ETH_LINK_SPEED_1G,
+		RTE_ETH_LINK_SPEED_100M,
+		RTE_ETH_LINK_SPEED_10M,
+		0,
+		RTE_ETH_LINK_SPEED_40G,
+		RTE_ETH_LINK_SPEED_100G,
+		0,
+		RTE_ETH_LINK_SPEED_25G,
+		RTE_ETH_LINK_SPEED_200G,
+		RTE_ETH_LINK_SPEED_2_5G,
+		RTE_ETH_LINK_SPEED_5G,
+		RTE_ETH_LINK_SPEED_400G,
+	};
+
+	reg = nfb_mdio_if_read_pma(info, NFB_MDIO_PMA_SPEED_ABILITY);
+	if (reg < 0)
+		return;
+
+	for (i = 0; i < NFB_MDIO_WIDTH; i++) {
+		if (reg & NFB_MDIO_BIT(i))
+			*capa |= speed_ability[i];
+	}
+}
diff --git a/drivers/net/nfb/nfb_mdio.h b/drivers/net/nfb/nfb_mdio.h
new file mode 100644
index 0000000000..7cafe17dc5
--- /dev/null
+++ b/drivers/net/nfb/nfb_mdio.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 CESNET, z.s.p.o.
+ */
+
+#ifndef _NFB_MDIO_H_
+#define _NFB_MDIO_H_
+
+#include <stdint.h>
+#include <rte_bitops.h>
+#include <netcope/mdio_if_info.h>
+
+
+#define NFB_MDIO_WIDTH (UINT16_WIDTH)
+#define NFB_MDIO_BIT(nr) (UINT16_C(1) << (nr))
+
+#define NFB_MDIO_DEV_PMA 1
+
+#define NFB_MDIO_PMA_CTRL 0
+#define NFB_MDIO_PMA_CTRL_RESET NFB_MDIO_BIT(15)
+
+#define NFB_MDIO_PMA_SPEED_ABILITY 4
+
+#define NFB_MDIO_PMA_RSFEC_CR 200
+#define NFB_MDIO_PMA_RSFEC_CR_ENABLE NFB_MDIO_BIT(2)
+
+static inline int nfb_mdio_if_read_pma(struct mdio_if_info *if_info, uint16_t addr)
+{
+	return if_info->mdio_read(if_info->dev, if_info->prtad, NFB_MDIO_DEV_PMA, addr);
+}
+
+static inline int nfb_mdio_if_write_pma(struct mdio_if_info *if_info, uint16_t addr, uint16_t val)
+{
+	return if_info->mdio_write(if_info->dev, if_info->prtad, NFB_MDIO_DEV_PMA, addr, val);
+}
+
+__rte_internal
+void nfb_mdio_cl45_pma_get_speed_capa(struct mdio_if_info *if_info, uint32_t *capa);
+
+#endif /* _NFB_MDIO_H_ */
-- 
2.53.0

