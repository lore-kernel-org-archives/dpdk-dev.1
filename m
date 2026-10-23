Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF78606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:46:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05EB940E40;
	Fri, 23 Oct 2026 15:44:26 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id C85E440E0C
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:16 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A7B4E1A0043;
 Fri, 23 Oct 2026 15:44:16 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4691C1A0021;
 Fri, 23 Oct 2026 15:44:16 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DCA7C18000B5;
 Fri, 23 Oct 2026 21:44:14 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 22/65] net/dpaa2: reimplement RSS distribution via
 rte_flow
Date: Fri, 23 Oct 2026 19:13:02 +0530
Message-ID: <20261023134346.37727-23-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
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

From: Jun Yang <jun.yang@nxp.com>

Prefer the stable rte_flow API over driver-private, experimental
entry points for RSS setup, and retire the private helpers that
duplicated what rte_flow already does. The goal is that user code
configures DPAA2 RSS the same way it configures any other PMD, with
no reliance on experimental or vendor-specific interfaces.

Delete drivers/net/dpaa2/base/dpaa2_hw_dpni.c and drop it from
meson.build. The helpers it hosted (dpaa2_setup_flow_dist,
dpaa2_setup_flow_dist_size, dpaa2_remove_flow_dist,
dpaa2_distset_to_dpkg_profile_cfg, dpaa2_attach_bp_list,
rte_pmd_dpaa2_set_custom_hash) are either reimplemented in
dpaa2_ethdev.c or fully superseded by rte_flow.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 doc/guides/rel_notes/release_26_11.rst |   8 +
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c | 544 -------------------------
 drivers/net/dpaa2/dpaa2_ethdev.c       | 297 +++++++++++---
 drivers/net/dpaa2/dpaa2_ethdev.h       |  21 -
 drivers/net/dpaa2/meson.build          |   1 -
 drivers/net/dpaa2/rte_pmd_dpaa2.h      |  84 ++--
 6 files changed, 311 insertions(+), 644 deletions(-)
 delete mode 100644 drivers/net/dpaa2/base/dpaa2_hw_dpni.c

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 70266464d2..9f9008f51b 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -228,6 +228,14 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* net/dpaa2: The exported function ``rte_pmd_dpaa2_set_custom_hash()`` is no
+  longer provided as a stable ABI symbol. A ``static inline`` helper of the
+  same name is still available in the DPAA2 public header, but it is now
+  implemented purely on top of the standard ``rte_flow`` API and no longer
+  depends on any DPAA2-specific internals. The inline helper is provided only
+  as a reference for users; applications should prefer calling the
+  ``rte_flow`` API directly.
+
 * eal: Improved pointer arithmetic macros.
 
   * ``RTE_PTR_ADD``, ``RTE_PTR_SUB``, ``RTE_PTR_ALIGN``, ``RTE_PTR_ALIGN_CEIL``,
diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
deleted file mode 100644
index 5f4268f0d7..0000000000
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ /dev/null
@@ -1,544 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- *
- *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2021,2023-2025 NXP
- *
- */
-
-#include <time.h>
-#include <net/if.h>
-
-#include <eal_export.h>
-#include <rte_mbuf.h>
-#include <ethdev_driver.h>
-#include <rte_malloc.h>
-#include <rte_memcpy.h>
-#include <rte_string_fns.h>
-#include <rte_cycles.h>
-#include <rte_kvargs.h>
-#include <dev_driver.h>
-
-#include <dpaa2_pmd_logs.h>
-#include <dpaa2_hw_pvt.h>
-#include <dpaa2_hw_mempool.h>
-
-#include "../dpaa2_ethdev.h"
-
-int
-dpaa2_distset_to_dpkg_profile_cfg(
-		uint64_t req_dist_set,
-		struct dpkg_profile_cfg *kg_cfg);
-
-RTE_EXPORT_SYMBOL(rte_pmd_dpaa2_set_custom_hash)
-int
-rte_pmd_dpaa2_set_custom_hash(uint16_t port_id,
-	uint16_t offset, uint8_t size)
-{
-	struct rte_eth_dev *eth_dev = &rte_eth_devices[port_id];
-	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
-	struct fsl_mc_io *dpni = priv->hw;
-	struct dpni_rx_tc_dist_cfg tc_cfg;
-	struct dpkg_profile_cfg kg_cfg;
-	void *p_params;
-	int ret, tc_index = 0;
-
-	if (!rte_eth_dev_is_valid_port(port_id)) {
-		DPAA2_PMD_WARN("Invalid port id %u", port_id);
-		return -EINVAL;
-	}
-
-	if (strcmp(eth_dev->device->driver->name,
-			RTE_STR(NET_DPAA2_PMD_DRIVER_NAME))) {
-		DPAA2_PMD_WARN("Not a valid dpaa2 port");
-		return -EINVAL;
-	}
-
-	p_params = rte_zmalloc(NULL,
-		DIST_PARAM_IOVA_SIZE, RTE_CACHE_LINE_SIZE);
-	if (!p_params) {
-		DPAA2_PMD_ERR("Unable to allocate flow-dist parameters");
-		return -ENOMEM;
-	}
-
-	memset(&kg_cfg, 0, sizeof(struct dpkg_profile_cfg));
-	kg_cfg.extracts[0].type = DPKG_EXTRACT_FROM_DATA;
-	kg_cfg.extracts[0].extract.from_data.offset = offset;
-	kg_cfg.extracts[0].extract.from_data.size = size;
-	kg_cfg.extracts[0].num_of_byte_masks = 0;
-	kg_cfg.num_extracts = 1;
-
-	ret = dpkg_prepare_key_cfg(&kg_cfg, p_params);
-	if (ret) {
-		DPAA2_PMD_ERR("Unable to prepare extract parameters");
-		rte_free(p_params);
-		return ret;
-	}
-
-	memset(&tc_cfg, 0, sizeof(struct dpni_rx_tc_dist_cfg));
-	tc_cfg.key_cfg_iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(p_params,
-		DIST_PARAM_IOVA_SIZE);
-	if (tc_cfg.key_cfg_iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for key cfg(%p)",
-			__func__, p_params);
-		rte_free(p_params);
-		return -ENOBUFS;
-	}
-
-	tc_cfg.dist_size = eth_dev->data->nb_rx_queues;
-	tc_cfg.dist_mode = DPNI_DIST_MODE_HASH;
-
-	ret = dpni_set_rx_tc_dist(dpni, CMD_PRI_LOW, priv->token, tc_index,
-			&tc_cfg);
-	rte_free(p_params);
-	if (ret) {
-		DPAA2_PMD_ERR("Set RX TC dist failed(err=%d)", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-int
-dpaa2_setup_flow_dist(struct rte_eth_dev *eth_dev,
-	uint64_t req_dist_set, int tc_index)
-{
-	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
-	int tc_dist_queues;
-
-	/* TC distribution size is set with dist_queues or
-	 * (nb_rx_queues - tc_index*dist_queues) in order of TC priority index.
-	 */
-	tc_dist_queues = eth_dev->data->nb_rx_queues -
-		tc_index * priv->dist_queues;
-	if (tc_dist_queues <= 0) {
-		DPAA2_PMD_INFO("No distribution on TC%d", tc_index);
-		return 0;
-	}
-
-	if (tc_dist_queues > priv->dist_queues)
-		tc_dist_queues = priv->dist_queues;
-
-	return dpaa2_setup_flow_dist_size(eth_dev, req_dist_set,
-					   tc_index, tc_dist_queues);
-}
-
-int
-dpaa2_setup_flow_dist_size(struct rte_eth_dev *eth_dev,
-	uint64_t req_dist_set, int tc_index, uint16_t dist_size)
-{
-	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
-	struct fsl_mc_io *dpni = eth_dev->process_private;
-	struct dpni_rx_dist_cfg tc_cfg;
-	struct dpkg_profile_cfg kg_cfg;
-	void *p_params;
-	int ret;
-
-	if (dist_size == 0)
-		return 0;
-
-	p_params = rte_malloc(NULL,
-		DIST_PARAM_IOVA_SIZE, RTE_CACHE_LINE_SIZE);
-	if (!p_params) {
-		DPAA2_PMD_ERR("Unable to allocate flow-dist parameters");
-		return -ENOMEM;
-	}
-
-	memset(p_params, 0, DIST_PARAM_IOVA_SIZE);
-	memset(&tc_cfg, 0, sizeof(struct dpni_rx_dist_cfg));
-
-	ret = dpaa2_distset_to_dpkg_profile_cfg(req_dist_set, &kg_cfg);
-	if (ret) {
-		DPAA2_PMD_ERR("Given RSS Hash (%" PRIx64 ") not supported",
-			      req_dist_set);
-		rte_free(p_params);
-		return ret;
-	}
-
-	tc_cfg.key_cfg_iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(p_params,
-		DIST_PARAM_IOVA_SIZE);
-	if (tc_cfg.key_cfg_iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for key cfg(%p)",
-			__func__, p_params);
-		rte_free(p_params);
-		return -ENOBUFS;
-	}
-
-	tc_cfg.dist_size = dist_size;
-	tc_cfg.enable = true;
-	tc_cfg.tc = tc_index;
-
-	ret = dpkg_prepare_key_cfg(&kg_cfg, p_params);
-	if (ret) {
-		DPAA2_PMD_ERR("Unable to prepare extract parameters");
-		rte_free(p_params);
-		return ret;
-	}
-
-	ret = dpni_set_rx_hash_dist(dpni, CMD_PRI_LOW, priv->token, &tc_cfg);
-	rte_free(p_params);
-	if (ret) {
-		DPAA2_PMD_ERR("RX Hash dist for failed(err=%d)", ret);
-		return ret;
-	}
-
-	if (tc_index < MAX_TCS)
-		priv->dist_size_cur[tc_index] = dist_size;
-
-	return 0;
-}
-
-int
-dpaa2_remove_flow_dist(struct rte_eth_dev *eth_dev,
-	uint8_t tc_index)
-{
-	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
-	struct fsl_mc_io *dpni = priv->hw;
-	struct dpni_rx_dist_cfg tc_cfg;
-	struct dpkg_profile_cfg kg_cfg;
-	void *p_params;
-	int ret;
-
-	p_params = rte_malloc(NULL,
-		DIST_PARAM_IOVA_SIZE, RTE_CACHE_LINE_SIZE);
-	if (!p_params) {
-		DPAA2_PMD_ERR("Unable to allocate flow-dist parameters");
-		return -ENOMEM;
-	}
-
-	memset(&tc_cfg, 0, sizeof(struct dpni_rx_dist_cfg));
-	tc_cfg.dist_size = 0;
-	tc_cfg.key_cfg_iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(p_params,
-		DIST_PARAM_IOVA_SIZE);
-	if (tc_cfg.key_cfg_iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for key cfg(%p)",
-			__func__, p_params);
-		rte_free(p_params);
-		return -ENOBUFS;
-	}
-
-	tc_cfg.enable = true;
-	tc_cfg.tc = tc_index;
-
-	memset(p_params, 0, DIST_PARAM_IOVA_SIZE);
-	kg_cfg.num_extracts = 0;
-	ret = dpkg_prepare_key_cfg(&kg_cfg, p_params);
-	if (ret) {
-		DPAA2_PMD_ERR("Unable to prepare extract parameters");
-		rte_free(p_params);
-		return ret;
-	}
-
-	ret = dpni_set_rx_hash_dist(dpni, CMD_PRI_LOW, priv->token,
-			&tc_cfg);
-	rte_free(p_params);
-	if (ret)
-		DPAA2_PMD_ERR("RX hash dist failed(err=%d)", ret);
-	return ret;
-}
-
-int
-dpaa2_distset_to_dpkg_profile_cfg(
-		uint64_t req_dist_set,
-		struct dpkg_profile_cfg *kg_cfg)
-{
-	uint32_t loop = 0, i = 0;
-	uint64_t dist_field = 0;
-	int l2_configured = 0, l3_configured = 0;
-	int l4_configured = 0;
-	int mpls_configured = 0;
-	int vlan_configured = 0;
-	int esp_configured = 0;
-	int ah_configured = 0;
-	int pppoe_configured = 0;
-
-	memset(kg_cfg, 0, sizeof(struct dpkg_profile_cfg));
-	while (req_dist_set) {
-		if (req_dist_set % 2 != 0) {
-			dist_field = 1ULL << loop;
-			switch (dist_field) {
-			case RTE_ETH_RSS_L2_PAYLOAD:
-			case RTE_ETH_RSS_ETH:
-				if (l2_configured)
-					break;
-				l2_configured = 1;
-
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_ETH;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_ETH_TYPE;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-				break;
-
-			case RTE_ETH_RSS_PPPOE:
-				if (pppoe_configured)
-					break;
-				pppoe_configured = 1;
-
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_PPPOE;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_PPPOE_SID;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-				break;
-
-			case RTE_ETH_RSS_ESP:
-				if (esp_configured)
-					break;
-				esp_configured = 1;
-
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_IPSEC_ESP;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_IPSEC_ESP_SPI;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-				break;
-
-			case RTE_ETH_RSS_AH:
-				if (ah_configured)
-					break;
-				ah_configured = 1;
-
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_IPSEC_AH;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_IPSEC_AH_SPI;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-				break;
-
-			case RTE_ETH_RSS_C_VLAN:
-			case RTE_ETH_RSS_S_VLAN:
-				if (vlan_configured)
-					break;
-				vlan_configured = 1;
-
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_VLAN;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_VLAN_TCI;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-				break;
-
-			case RTE_ETH_RSS_MPLS:
-
-				if (mpls_configured)
-					break;
-				mpls_configured = 1;
-
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_MPLS;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_MPLS_MPLSL_1;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_MPLS;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_MPLS_MPLSL_2;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_MPLS;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_MPLS_MPLSL_N;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-				break;
-
-			case RTE_ETH_RSS_IPV4:
-			case RTE_ETH_RSS_FRAG_IPV4:
-			case RTE_ETH_RSS_NONFRAG_IPV4_OTHER:
-			case RTE_ETH_RSS_IPV6:
-			case RTE_ETH_RSS_FRAG_IPV6:
-			case RTE_ETH_RSS_NONFRAG_IPV6_OTHER:
-			case RTE_ETH_RSS_IPV6_EX: {
-				static const uint32_t ip_fields[] = {
-					NH_FLD_IP_SRC, NH_FLD_IP_DST,
-					NH_FLD_IP_PROTO };
-				static const uint8_t ip_hdr_index[] = {
-					0, (uint8_t)LAST_HDR_INDEX };
-				unsigned int f, h;
-
-				if (l3_configured)
-					break;
-				l3_configured = 1;
-
-				/* Hash on the outer IP (index 0) and the innermost
-				 * IP instance. A plain frame has a single IP header,
-				 * so only the outer extract resolves; a tunnelled
-				 * frame resolves both and is also spread on its inner
-				 * IP.
-				 */
-				for (h = 0; h < RTE_DIM(ip_hdr_index); h++)
-					for (f = 0; f < RTE_DIM(ip_fields); f++) {
-						kg_cfg->extracts[i].extract.from_hdr.prot =
-							NET_PROT_IP;
-						kg_cfg->extracts[i].extract.from_hdr.hdr_index =
-							ip_hdr_index[h];
-						kg_cfg->extracts[i].extract.from_hdr.field =
-							ip_fields[f];
-						kg_cfg->extracts[i].type =
-							DPKG_EXTRACT_FROM_HDR;
-						kg_cfg->extracts[i].extract.from_hdr.type =
-							DPKG_FULL_FIELD;
-						i++;
-					}
-				break;
-			}
-
-			case RTE_ETH_RSS_NONFRAG_IPV4_TCP:
-			case RTE_ETH_RSS_NONFRAG_IPV6_TCP:
-			case RTE_ETH_RSS_NONFRAG_IPV4_UDP:
-			case RTE_ETH_RSS_NONFRAG_IPV6_UDP:
-			case RTE_ETH_RSS_IPV6_TCP_EX:
-			case RTE_ETH_RSS_IPV6_UDP_EX:
-			case RTE_ETH_RSS_NONFRAG_IPV4_SCTP:
-			case RTE_ETH_RSS_NONFRAG_IPV6_SCTP:
-
-				if (l4_configured)
-					break;
-				l4_configured = 1;
-
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_TCP;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_TCP_PORT_SRC;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_TCP;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_TCP_PORT_DST;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-				break;
-
-			default:
-				DPAA2_PMD_WARN(
-				      "unsupported flow dist option 0x%" PRIx64,
-					     dist_field);
-				return -EINVAL;
-			}
-		}
-		req_dist_set = req_dist_set >> 1;
-		loop++;
-	}
-	kg_cfg->num_extracts = i;
-	return 0;
-}
-
-int
-dpaa2_attach_bp_list(struct dpaa2_dev_priv *priv,
-	struct fsl_mc_io *dpni, void *blist)
-{
-	/* Function to attach a DPNI with a buffer pool list. Buffer pool list
-	 * handle is passed in blist.
-	 */
-	int32_t retcode;
-	struct dpni_pools_cfg bpool_cfg;
-	struct dpaa2_bp_list *bp_list = (struct dpaa2_bp_list *)blist;
-	struct dpni_buffer_layout layout;
-	int tot_size;
-
-	/* ... rx buffer layout .
-	 * Check alignment for buffer layouts first
-	 */
-
-	/* ... rx buffer layout ... */
-	if (priv->tx_conf_type == DPAA2_TX_DYNAMIC_CONF) {
-		int out_min_hdr_room, in_min_hdr_room;
-		/** Additional headroom layout for IPSec with TX configure
-		 * dynamic enabled.
-		 */
-		in_min_hdr_room = DPAA2_RX_MIN_FD_OFFSET +
-			DPAA2_SEC_SIMPLE_FD_IB_MIN;
-		out_min_hdr_room = DPAA2_DYN_TX_MIN_FD_OFFSET +
-			DPAA2_SEC_SIMPLE_FD_OB_MIN;
-		tot_size = RTE_MAX(in_min_hdr_room, out_min_hdr_room);
-		if (tot_size < RTE_PKTMBUF_HEADROOM)
-			tot_size = RTE_PKTMBUF_HEADROOM;
-	} else {
-		tot_size = RTE_PKTMBUF_HEADROOM;
-	}
-	tot_size = RTE_ALIGN_CEIL(tot_size, DPAA2_PACKET_LAYOUT_ALIGN);
-
-	memset(&layout, 0, sizeof(struct dpni_buffer_layout));
-	layout.options = DPNI_BUF_LAYOUT_OPT_DATA_HEAD_ROOM |
-			 DPNI_BUF_LAYOUT_OPT_FRAME_STATUS |
-			 DPNI_BUF_LAYOUT_OPT_PARSER_RESULT |
-			 DPNI_BUF_LAYOUT_OPT_DATA_ALIGN |
-			 DPNI_BUF_LAYOUT_OPT_TIMESTAMP |
-			 DPNI_BUF_LAYOUT_OPT_PRIVATE_DATA_SIZE;
-
-	layout.pass_timestamp = true;
-	layout.pass_frame_status = 1;
-	layout.private_data_size = DPAA2_FD_PTA_SIZE;
-	layout.pass_parser_result = 1;
-	layout.data_align = DPAA2_PACKET_LAYOUT_ALIGN;
-	layout.data_head_room = tot_size - DPAA2_FD_PTA_SIZE -
-				DPAA2_MBUF_HW_ANNOTATION;
-	retcode = dpni_set_buffer_layout(dpni, CMD_PRI_LOW, priv->token,
-					 DPNI_QUEUE_RX, &layout);
-	if (retcode) {
-		DPAA2_PMD_ERR("Error configuring buffer pool Rx layout (%d)",
-			     retcode);
-		return retcode;
-	}
-
-	/*Attach buffer pool to the network interface as described by the user*/
-	memset(&bpool_cfg, 0, sizeof(struct dpni_pools_cfg));
-	bpool_cfg.num_dpbp = 1;
-	bpool_cfg.pools[0].dpbp_id = bp_list->buf_pool.dpbp_node->dpbp_id;
-	bpool_cfg.pools[0].backup_pool = 0;
-	bpool_cfg.pools[0].buffer_size = RTE_ALIGN_CEIL(bp_list->buf_pool.size,
-						DPAA2_PACKET_LAYOUT_ALIGN);
-	bpool_cfg.pools[0].priority_mask = 0;
-
-	retcode = dpni_set_pools(dpni, CMD_PRI_LOW, priv->token, &bpool_cfg);
-	if (retcode != 0) {
-		DPAA2_PMD_ERR("Error configuring buffer pool on interface."
-			      " bpid = %d error code = %d",
-			      bpool_cfg.pools[0].dpbp_id, retcode);
-		return retcode;
-	}
-
-	priv->bp_list = bp_list;
-	return 0;
-}
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 9ad4494ab0..0de8e5c627 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -160,7 +160,7 @@ static int total_nb_rx_desc;
  */
 #define DPAA2_RETA_SIZE		64
 
-/* Values of dist_size accepted by the DPNI 'dpni_set_rx_hash_dist' MC command.
+/* Values of dist_size accepted by the DPNI HW requirement.
  * Source: fsl_dpni.h, "struct dpni_rx_dist_cfg::dist_size" documentation.
  * Used by dpaa2_dev_rss_reta_update() to validate user-requested patterns.
  */
@@ -172,11 +172,34 @@ static const uint16_t dpaa2_dist_size_allowed[] = {
 static bool
 dpaa2_dist_size_is_supported(uint16_t n)
 {
-	size_t i;
+	size_t i, offset = 0;
+	char print_buf[1024];
+	int ret;
+
+	ret = snprintf(print_buf, sizeof(print_buf),
+		"dist_size %u not supported by HW. Allowed: ", n);
+	if (ret > 0 && (size_t)ret < sizeof(print_buf))
+		offset = (size_t)ret;
+
 	for (i = 0; i < RTE_DIM(dpaa2_dist_size_allowed); i++) {
 		if (dpaa2_dist_size_allowed[i] == n)
 			return true;
+
+		/* Keep scanning the table even once the message buffer is
+		 * full so a valid size is still matched; just stop appending.
+		 */
+		if (offset >= sizeof(print_buf) - 1)
+			continue;
+
+		ret = snprintf(&print_buf[offset], sizeof(print_buf) - offset,
+			"%s%u", (i > 0) ? ", " : "", dpaa2_dist_size_allowed[i]);
+		if (ret > 0)
+			offset += (size_t)ret;
+		if (offset >= sizeof(print_buf))
+			offset = sizeof(print_buf) - 1;
 	}
+	DPAA2_PMD_ERR("%s", print_buf);
+
 	return false;
 }
 
@@ -442,6 +465,189 @@ static int dpaa2_dev_set_link_up(struct rte_eth_dev *dev);
 static int dpaa2_dev_set_link_down(struct rte_eth_dev *dev);
 static int dpaa2_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu);
 
+static int
+dpaa2_setup_flow_dist(struct rte_eth_dev *eth_dev,
+	uint64_t req_dist_set, int tc_index)
+{
+	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
+	int tc_dist_queues;
+	struct rte_flow_attr attr;
+	struct rte_flow_action_rss action_rss;
+	struct rte_flow_action actions[2];
+	struct rte_flow *rss_flow;
+
+	/*TC distribution size is set with dist_queues or
+	 * nb_rx_queues % dist_queues in order of TC priority index.
+	 * Calculating dist size for this tc_index:-
+	 */
+	tc_dist_queues = eth_dev->data->nb_rx_queues -
+		tc_index * priv->dist_queues;
+	if (tc_dist_queues <= 0) {
+		DPAA2_PMD_DEBUG("No distribution on TC%d", tc_index);
+		return 0;
+	}
+
+	if (tc_dist_queues > priv->dist_queues)
+		tc_dist_queues = priv->dist_queues;
+
+	memset(&attr, 0, sizeof(attr));
+	action_rss.func = RTE_ETH_HASH_FUNCTION_DEFAULT;
+	action_rss.level = 0;
+	action_rss.types = req_dist_set;
+	action_rss.key_len = 0;
+	action_rss.key = NULL;
+	action_rss.queue = NULL;
+	action_rss.queue_num = tc_dist_queues;
+
+	actions[0].type = RTE_FLOW_ACTION_TYPE_RSS;
+	actions[0].conf = &action_rss;
+	actions[1].type = RTE_FLOW_ACTION_TYPE_END;
+	attr.group = tc_index;
+	attr.ingress = 1;
+	rss_flow = rte_flow_create(eth_dev->data->port_id, &attr, NULL, actions, NULL);
+	if (!rss_flow) {
+		DPAA2_PMD_WARN("%s: Set RSS flow dist on tc%d failed",
+			__func__, tc_index);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int
+dpaa2_remove_flow_rss_dist(struct rte_eth_dev *eth_dev,
+	uint8_t tc_index)
+{
+	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	int ret;
+
+	tbl_profile = &priv->flow_profile.tc_profile[tc_index];
+	if (!tbl_profile->rss_flow) {
+		DPAA2_PMD_WARN("%s'TC[%d] is not RSS distributed",
+			eth_dev->data->name, tc_index);
+		return 0;
+	}
+	ret = rte_flow_destroy(eth_dev->data->port_id, tbl_profile->rss_flow, NULL);
+	if (ret)
+		return ret;
+	tbl_profile->rss_flow = NULL;
+
+	return 0;
+}
+
+static int
+dpaa2_update_flow_rss_dist(struct rte_eth_dev *eth_dev,
+	uint64_t req_dist_set, int tc_index, uint16_t dist_size)
+{
+	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	struct rte_flow_action_rss action_rss;
+	struct rte_flow_action actions[2];
+	int ret;
+
+	tbl_profile = &priv->flow_profile.tc_profile[tc_index];
+	if (!tbl_profile->rss_flow) {
+		DPAA2_PMD_WARN("%s'TC[%d] is not RSS distributed",
+			eth_dev->data->name, tc_index);
+		return 0;
+	}
+	action_rss.func = RTE_ETH_HASH_FUNCTION_DEFAULT;
+	action_rss.level = 0;
+	action_rss.types = req_dist_set;
+	action_rss.key_len = 0;
+	action_rss.queue_num = dist_size;
+	action_rss.key = NULL;
+	action_rss.queue = NULL;
+	actions[0].type = RTE_FLOW_ACTION_TYPE_RSS;
+	actions[0].conf = &action_rss;
+	actions[1].type = RTE_FLOW_ACTION_TYPE_END;
+	ret = rte_flow_actions_update(eth_dev->data->port_id, tbl_profile->rss_flow,
+		actions, NULL);
+	if (!ret)
+		tbl_profile->tc_cfg.dist_size = dist_size;
+
+	return ret;
+}
+
+static int
+dpaa2_attach_bp_list(struct dpaa2_dev_priv *priv,
+	struct fsl_mc_io *dpni, void *blist)
+{
+	/* Function to attach a DPNI with a buffer pool list. Buffer pool list
+	 * handle is passed in blist.
+	 */
+	int32_t retcode;
+	struct dpni_pools_cfg bpool_cfg;
+	struct dpaa2_bp_list *bp_list = blist;
+	struct dpni_buffer_layout layout;
+	int tot_size, out_min_hdr_room, in_min_hdr_room;
+
+	/* ... rx buffer layout .
+	 * Check alignment for buffer layouts first
+	 */
+
+	/* ... rx buffer layout ... */
+	if (priv->tx_conf_type == DPAA2_TX_DYNAMIC_CONF) {
+		/** Additional headroom layout for IPSec with TX configure
+		 * dynamic enabled.
+		 */
+		in_min_hdr_room = DPAA2_RX_MIN_FD_OFFSET +
+			DPAA2_SEC_SIMPLE_FD_IB_MIN;
+		out_min_hdr_room = DPAA2_DYN_TX_MIN_FD_OFFSET +
+			DPAA2_SEC_SIMPLE_FD_OB_MIN;
+		tot_size = RTE_MAX(in_min_hdr_room, out_min_hdr_room);
+		if (tot_size < RTE_PKTMBUF_HEADROOM)
+			tot_size = RTE_PKTMBUF_HEADROOM;
+	} else {
+		tot_size = RTE_PKTMBUF_HEADROOM;
+	}
+	tot_size = RTE_ALIGN_CEIL(tot_size, DPAA2_PACKET_LAYOUT_ALIGN);
+
+	memset(&layout, 0, sizeof(struct dpni_buffer_layout));
+	layout.options = DPNI_BUF_LAYOUT_OPT_DATA_HEAD_ROOM |
+		DPNI_BUF_LAYOUT_OPT_FRAME_STATUS |
+		DPNI_BUF_LAYOUT_OPT_PARSER_RESULT |
+		DPNI_BUF_LAYOUT_OPT_DATA_ALIGN |
+		DPNI_BUF_LAYOUT_OPT_TIMESTAMP |
+		DPNI_BUF_LAYOUT_OPT_PRIVATE_DATA_SIZE;
+
+	layout.pass_timestamp = true;
+	layout.pass_frame_status = 1;
+	layout.private_data_size = DPAA2_FD_PTA_SIZE;
+	layout.pass_parser_result = 1;
+	layout.data_align = DPAA2_PACKET_LAYOUT_ALIGN;
+	layout.data_head_room = tot_size - DPAA2_FD_PTA_SIZE -
+		DPAA2_MBUF_HW_ANNOTATION;
+	retcode = dpni_set_buffer_layout(dpni, CMD_PRI_LOW, priv->token,
+			DPNI_QUEUE_RX, &layout);
+	if (retcode) {
+		DPAA2_PMD_ERR("Error configuring buffer pool Rx layout (%d)",
+			retcode);
+		return retcode;
+	}
+
+	/*Attach buffer pool to the network interface as described by the user*/
+	memset(&bpool_cfg, 0, sizeof(struct dpni_pools_cfg));
+	bpool_cfg.num_dpbp = 1;
+	bpool_cfg.pools[0].dpbp_id = bp_list->buf_pool.dpbp_node->dpbp_id;
+	bpool_cfg.pools[0].backup_pool = 0;
+	bpool_cfg.pools[0].buffer_size = RTE_ALIGN_CEIL(bp_list->buf_pool.size,
+				DPAA2_PACKET_LAYOUT_ALIGN);
+	bpool_cfg.pools[0].priority_mask = 0;
+
+	retcode = dpni_set_pools(dpni, CMD_PRI_LOW, priv->token, &bpool_cfg);
+	if (retcode) {
+		DPAA2_PMD_ERR("Error(%d) configuring bp(id=%d) on %s.",
+			retcode, bpool_cfg.pools[0].dpbp_id,
+			priv->eth_dev->data->name);
+		return retcode;
+	}
+
+	priv->bp_list = bp_list;
+	return 0;
+}
+
 static int
 dpaa2_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 {
@@ -667,8 +873,8 @@ dpaa2_dev_info_get(struct rte_eth_dev *dev,
 	/* DPAA2 has no software-visible indirection table: incoming packets are
 	 * dispatched to FQs via 'queue_id = hash % dist_size'. We expose the
 	 * standard RETA API as an emulation that only accepts uniform patterns
-	 * 'reta[i] = i % N' and translates them into a dpni_set_rx_hash_dist
-	 * command with dist_size=N. See dpaa2_dev_rss_reta_update().
+	 * 'reta[i] = i % N' and translates them into a DPNI HW command with
+	 * dist_size=N. See dpaa2_dev_rss_reta_update().
 	 */
 	dev_info->reta_size = DPAA2_RETA_SIZE;
 	dev_info->hash_key_size = 0;
@@ -2777,7 +2983,7 @@ dpaa2_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 
 static int
 dpaa2_dev_rss_hash_update(struct rte_eth_dev *dev,
-			  struct rte_eth_rss_conf *rss_conf)
+	struct rte_eth_rss_conf *rss_conf)
 {
 	struct rte_eth_dev_data *data = dev->data;
 	struct dpaa2_dev_priv *priv = data->dev_private;
@@ -2788,21 +2994,20 @@ dpaa2_dev_rss_hash_update(struct rte_eth_dev *dev,
 
 	if (rss_conf->rss_hf) {
 		for (tc_index = 0; tc_index < priv->num_rx_tc; tc_index++) {
-			ret = dpaa2_setup_flow_dist(dev, rss_conf->rss_hf,
-				tc_index);
+			ret = dpaa2_update_flow_rss_dist(dev, rss_conf->rss_hf,
+				tc_index, priv->dist_queues);
 			if (ret) {
-				DPAA2_PMD_ERR("Unable to set flow dist on tc%d",
-					tc_index);
+				DPAA2_PMD_ERR("Failed(%d) to set RSS flow on tc.%d",
+					ret, tc_index);
 				return ret;
 			}
 		}
 	} else {
 		for (tc_index = 0; tc_index < priv->num_rx_tc; tc_index++) {
-			ret = dpaa2_remove_flow_dist(dev, tc_index);
+			ret = dpaa2_remove_flow_rss_dist(dev, tc_index);
 			if (ret) {
-				DPAA2_PMD_ERR(
-					"Unable to remove flow dist on tc%d",
-					tc_index);
+				DPAA2_PMD_ERR("Failed(%d) to remove RSS flow on tc.%d",
+					ret, tc_index);
 				return ret;
 			}
 		}
@@ -2813,21 +3018,17 @@ dpaa2_dev_rss_hash_update(struct rte_eth_dev *dev,
 
 static int
 dpaa2_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
-			    struct rte_eth_rss_conf *rss_conf)
+	struct rte_eth_rss_conf *rss_conf)
 {
 	struct rte_eth_dev_data *data = dev->data;
-	struct rte_eth_conf *eth_conf = &data->dev_conf;
 
 	/* dpaa2 does not support rss_key, so length should be 0*/
 	rss_conf->rss_key_len = 0;
-	rss_conf->rss_hf = eth_conf->rx_adv_conf.rss_conf.rss_hf;
+	rss_conf->rss_hf = data->dev_conf.rx_adv_conf.rss_conf.rss_hf;
 	return 0;
 }
 
-/* Emulation of the standard DPDK RETA API on top of DPAA2's
- * dpni_set_rx_hash_dist MC command.
- *
- * DPAA2 hardware dispatches incoming frames using 'queue_id = hash % dist_size'
+/* DPAA2 hardware dispatches incoming frames using 'queue_id = hash % dist_size'
  * (no software-visible indirection table). To expose the standard
  * rte_eth_dev_rss_reta_update() interface, we accept ONLY uniform patterns of
  * the form 'reta[i] = i % N' where N is in the HW-allowed dist_size list. Any
@@ -2841,20 +3042,18 @@ dpaa2_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
  */
 static int
 dpaa2_dev_rss_reta_update(struct rte_eth_dev *dev,
-			  struct rte_eth_rss_reta_entry64 *reta_conf,
-			  uint16_t reta_size)
+	struct rte_eth_rss_reta_entry64 *reta_conf, uint16_t reta_size)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	struct rte_eth_conf *eth_conf = &dev->data->dev_conf;
-	uint16_t i, max_q = 0, n;
+	uint64_t req_dist_set = dev->data->dev_conf.rx_adv_conf.rss_conf.rss_hf;
+	uint16_t i, max_q = 0, n, grp, pos, q, expected;
 	int tc_index, ret;
 	bool any_set = false;
 
 	PMD_INIT_FUNC_TRACE();
 
 	if (reta_size != DPAA2_RETA_SIZE) {
-		DPAA2_PMD_ERR("Invalid reta_size %u (expected %u)",
-			      reta_size, DPAA2_RETA_SIZE);
+		DPAA2_PMD_ERR("Invalid reta_size %u (expected %u)", reta_size, DPAA2_RETA_SIZE);
 		return -EINVAL;
 	}
 
@@ -2864,7 +3063,7 @@ dpaa2_dev_rss_reta_update(struct rte_eth_dev *dev,
 	for (i = 0; i < reta_size / RTE_ETH_RETA_GROUP_SIZE; i++) {
 		if (reta_conf[i].mask != UINT64_MAX) {
 			DPAA2_PMD_ERR("partial RETA update not supported; set all %u entries",
-				      DPAA2_RETA_SIZE);
+				DPAA2_RETA_SIZE);
 			return -ENOTSUP;
 		}
 	}
@@ -2873,9 +3072,8 @@ dpaa2_dev_rss_reta_update(struct rte_eth_dev *dev,
 	 * one slot to be selected via the per-group mask.
 	 */
 	for (i = 0; i < reta_size; i++) {
-		uint16_t grp = i / RTE_ETH_RETA_GROUP_SIZE;
-		uint16_t pos = i % RTE_ETH_RETA_GROUP_SIZE;
-		uint16_t q;
+		grp = i / RTE_ETH_RETA_GROUP_SIZE;
+		pos = i % RTE_ETH_RETA_GROUP_SIZE;
 
 		if (!(reta_conf[grp].mask & (1ULL << pos)))
 			continue;
@@ -2902,10 +3100,9 @@ dpaa2_dev_rss_reta_update(struct rte_eth_dev *dev,
 	 * slot the user has selected. dpaa2 HW cannot honor any other layout.
 	 */
 	for (i = 0; i < reta_size; i++) {
-		uint16_t grp = i / RTE_ETH_RETA_GROUP_SIZE;
-		uint16_t pos = i % RTE_ETH_RETA_GROUP_SIZE;
-		uint16_t expected = i % n;
-		uint16_t q;
+		grp = i / RTE_ETH_RETA_GROUP_SIZE;
+		pos = i % RTE_ETH_RETA_GROUP_SIZE;
+		expected = i % n;
 
 		if (!(reta_conf[grp].mask & (1ULL << pos)))
 			continue;
@@ -2921,18 +3118,12 @@ dpaa2_dev_rss_reta_update(struct rte_eth_dev *dev,
 		}
 	}
 
-	if (!dpaa2_dist_size_is_supported(n)) {
-		DPAA2_PMD_ERR("dist_size %u not supported by HW. Allowed: "
-			"1,2,3,4,6,7,8,12,14,16,24,28,32,48,56,64,...",
-			n);
+	if (!dpaa2_dist_size_is_supported(n))
 		return -ENOTSUP;
-	}
 
 	/* Apply on every configured RX TC, matching rss_hash_update behavior. */
 	for (tc_index = 0; tc_index < priv->num_rx_tc; tc_index++) {
-		ret = dpaa2_setup_flow_dist_size(dev,
-				eth_conf->rx_adv_conf.rss_conf.rss_hf,
-				tc_index, n);
+		ret = dpaa2_update_flow_rss_dist(dev, req_dist_set, tc_index, n);
 		if (ret) {
 			DPAA2_PMD_ERR("Failed to apply dist_size=%u on tc%d (err=%d)",
 				n, tc_index, ret);
@@ -2941,46 +3132,44 @@ dpaa2_dev_rss_reta_update(struct rte_eth_dev *dev,
 	}
 
 	DPAA2_PMD_DEBUG("RETA updated: dist_size now %u on %u TC(s)",
-			n, priv->num_rx_tc);
+		n, priv->num_rx_tc);
 	return 0;
 }
 
 /* Synthesizes a RETA snapshot from the currently-active dist_size on TC 0.
  * Since DPAA2 always uses uniform 'hash mod N' distribution, the returned
- * RETA is reta[i] = i % dist_size_cur[0].
+ * RETA is reta[i] = i % flow_profile.tc_profile[0].tc_cfg.dist_size.
  */
 static int
 dpaa2_dev_rss_reta_query(struct rte_eth_dev *dev,
-			 struct rte_eth_rss_reta_entry64 *reta_conf,
-			 uint16_t reta_size)
+	struct rte_eth_rss_reta_entry64 *reta_conf, uint16_t reta_size)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	uint16_t i, n;
+	uint16_t i, n, grp, pos;
 
 	PMD_INIT_FUNC_TRACE();
 
 	if (reta_size != DPAA2_RETA_SIZE) {
 		DPAA2_PMD_ERR("Invalid reta_size %u (expected %u)",
-			      reta_size, DPAA2_RETA_SIZE);
+			reta_size, DPAA2_RETA_SIZE);
 		return -EINVAL;
 	}
 
 	/* Use the cached dist_size on TC 0 (representative). Fall back to the
 	 * default (nb_rx_queues clamped to dist_queues) when never programmed.
 	 */
-	n = priv->dist_size_cur[0];
-	if (n == 0) {
+	n = priv->flow_profile.tc_profile[0].tc_cfg.dist_size;
+	if (!n) {
 		n = priv->dist_queues;
 		if (n > dev->data->nb_rx_queues)
 			n = dev->data->nb_rx_queues;
 	}
-	if (n == 0)
+	if (!n)
 		return -EINVAL;
 
 	for (i = 0; i < reta_size; i++) {
-		uint16_t grp = i / RTE_ETH_RETA_GROUP_SIZE;
-		uint16_t pos = i % RTE_ETH_RETA_GROUP_SIZE;
-
+		grp = i / RTE_ETH_RETA_GROUP_SIZE;
+		pos = i % RTE_ETH_RETA_GROUP_SIZE;
 		if (reta_conf[grp].mask & (1ULL << pos))
 			reta_conf[grp].reta[pos] = i % n;
 	}
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index e3fb3f8920..7a65f5e383 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -395,12 +395,6 @@ struct dpaa2_dev_priv {
 	/** RXQs in same TC share same cgid.*/
 	uint8_t cgid_in_use[MAX_TCS];
 
-	/* Current hash distribution size per RX TC, written by
-	 * dpaa2_setup_flow_dist_size() and read by reta_query / reta_update.
-	 * Zero means "use default" (= nb_rx_queues clamped to dist_queues).
-	 */
-	uint16_t dist_size_cur[MAX_TCS];
-
 	uint16_t dpni_ver_major;
 	uint16_t dpni_ver_minor;
 	uint32_t speed_capa;
@@ -876,21 +870,6 @@ dpaa2_dpkg_insert_extract(struct dpkg_profile_cfg *kg_cfg,
 	kg_cfg->num_extracts++;
 }
 
-int dpaa2_distset_to_dpkg_profile_cfg(uint64_t req_dist_set,
-				      struct dpkg_profile_cfg *kg_cfg);
-
-int dpaa2_setup_flow_dist(struct rte_eth_dev *eth_dev,
-		uint64_t req_dist_set, int tc_index);
-
-int dpaa2_setup_flow_dist_size(struct rte_eth_dev *eth_dev,
-		uint64_t req_dist_set, int tc_index, uint16_t dist_size);
-
-int dpaa2_remove_flow_dist(struct rte_eth_dev *eth_dev,
-			   uint8_t tc_index);
-
-int dpaa2_attach_bp_list(struct dpaa2_dev_priv *priv,
-	struct fsl_mc_io *dpni, void *blist);
-
 __rte_internal
 int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 		int eth_rx_queue_id,
diff --git a/drivers/net/dpaa2/meson.build b/drivers/net/dpaa2/meson.build
index b821f7bfad..affcaf8d3a 100644
--- a/drivers/net/dpaa2/meson.build
+++ b/drivers/net/dpaa2/meson.build
@@ -8,7 +8,6 @@ endif
 
 deps += ['mempool_dpaa2']
 sources = files(
-        'base/dpaa2_hw_dpni.c',
         'base/dpaa2_tlu_hash.c',
         'dpaa2_tm.c',
         'dpaa2_mux.c',
diff --git a/drivers/net/dpaa2/rte_pmd_dpaa2.h b/drivers/net/dpaa2/rte_pmd_dpaa2.h
index f8718db0dc..e8e21e28cc 100644
--- a/drivers/net/dpaa2/rte_pmd_dpaa2.h
+++ b/drivers/net/dpaa2/rte_pmd_dpaa2.h
@@ -13,6 +13,7 @@
 
 #include <rte_compat.h>
 #include <rte_flow.h>
+#include <ethdev_driver.h>
 
 /**
  * LX series support only.
@@ -84,30 +85,6 @@ __rte_experimental
 int
 rte_pmd_dpaa2_mux_rx_frame_len(uint32_t dpdmux_id, uint16_t max_rx_frame_len);
 
-/**
- * Create a custom hash key on basis of offset of start of packet and size.
- * for e.g. if we need GRE packets (non-vlan and without any extra headers)
- * to be hashed on basis of inner IP header, we will provide offset as:
- * 14 (eth) + 20 (IP) + 4 (GRE) + 12 (Inner Src offset) = 50 and size
- * as 8 bytes.
- *
- * @param port_id
- *    The port identifier of the Ethernet device.
- * @param offset
- *    Offset from the start of packet which needs to be included to
- *    calculate hash
- * @param size
- *    Size of the hash input key
- *
- * @return
- *   - 0 if successful.
- *   - Negative in case of failure.
- */
-int
-rte_pmd_dpaa2_set_custom_hash(uint16_t port_id,
-			      uint16_t offset,
-			      uint8_t size);
-
 /**
  * @warning
  * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
@@ -207,4 +184,63 @@ int
 rte_dpaa2_flow_group_set_miss_actions(uint16_t port_id,
 	uint32_t group_id, uint32_t type, const struct rte_flow_group_attr *attr,
 	const struct rte_flow_action actions[], struct rte_flow_error *error);
+
+__rte_experimental
+static inline int
+rte_pmd_dpaa2_set_custom_hash(uint16_t port_id,
+	uint16_t offset, uint8_t size)
+{
+	struct rte_flow *rss_flow;
+	struct rte_eth_dev *dev;
+	struct rte_flow_item_raw raw_spec;
+	struct rte_flow_item_raw raw_mask;
+	struct rte_flow_attr attr;
+	struct rte_flow_action_rss rss;
+	struct rte_flow_item pattern[2];
+	struct rte_flow_action action[2];
+	int ret;
+
+	if (!rte_pmd_dpaa2_dev_is_dpaa2(port_id))
+		return -EINVAL;
+
+	dev = &rte_eth_devices[port_id];
+
+	memset(&attr, 0, sizeof(attr));
+	memset(&raw_spec, 0, sizeof(raw_spec));
+	memset(&raw_mask, 0, sizeof(raw_mask));
+
+	raw_spec.relative = 0;
+	raw_spec.search = 0;
+	raw_spec.offset = offset;
+	raw_spec.limit = 0;
+	raw_spec.length = size;
+
+	raw_mask.offset = 0xffff;
+	raw_mask.length = 0xffff;
+	pattern[0].type = RTE_FLOW_ITEM_TYPE_RAW;
+	pattern[0].spec = &raw_spec;
+	pattern[0].mask = &raw_mask;
+	pattern[1].type = RTE_FLOW_ITEM_TYPE_END;
+
+	memset(&rss, 0, sizeof(rss));
+	rss.func = RTE_ETH_HASH_FUNCTION_DEFAULT;
+	/** Assume single TC only, will rework later.*/
+	rss.queue_num = dev->data->nb_rx_queues;
+
+	attr.ingress = 1;
+
+	action[0].type = RTE_FLOW_ACTION_TYPE_RSS;
+	action[0].conf = &rss;
+	action[1].type = RTE_FLOW_ACTION_TYPE_END;
+
+	ret = rte_flow_validate(port_id, &attr, pattern, action, NULL);
+	if (ret)
+		return ret;
+
+	rss_flow = rte_flow_create(port_id, &attr, pattern, action, NULL);
+	if (!rss_flow)
+		return -EINVAL;
+
+	return 0;
+}
 #endif /* _RTE_PMD_DPAA2_H */
-- 
2.43.0

