Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E465EC624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 13:58:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27FF742E94;
	Thu,  3 Sep 2026 15:54:51 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 3DCAD42E73
 for <dev@dpdk.org>; Thu,  3 Sep 2026 15:54:42 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E6DCD1A0054;
 Thu,  3 Sep 2026 15:54:41 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A9C7A1A0035;
 Thu,  3 Sep 2026 15:54:40 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 281BA180006C;
 Thu,  3 Sep 2026 21:54:39 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH 37/45] net/dpaa2: rework flow engine
Date: Thu,  3 Sep 2026 19:23:45 +0530
Message-ID: <20260903135353.3358303-38-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

Rework the dpaa2 flow engine so that flow rules are programmed through
the updated QoS and flow steering (FS) table interface.

The distribution helpers in base/dpaa2_hw_dpni.c are removed and folded
into the ethdev and flow code, which removes a layer of indirection and
keeps the key extraction, RSS distribution and QoS/FS entry programming
together in one place.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c |  546 --
 drivers/net/dpaa2/dpaa2_ethdev.c       |  457 +-
 drivers/net/dpaa2/dpaa2_ethdev.h       |  478 +-
 drivers/net/dpaa2/dpaa2_flow.c         | 6906 ++++++++++++++----------
 drivers/net/dpaa2/meson.build          |    3 +-
 5 files changed, 4719 insertions(+), 3671 deletions(-)
 delete mode 100644 drivers/net/dpaa2/base/dpaa2_hw_dpni.c

diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
deleted file mode 100644
index fee96b3529..0000000000
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ /dev/null
@@ -1,546 +0,0 @@
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
-			case RTE_ETH_RSS_IPV6_EX:
-
-				if (l3_configured)
-					break;
-				l3_configured = 1;
-
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_IP;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_IP_SRC;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_IP;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_IP_DST;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_IP;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_IP_PROTO;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-			break;
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
-	if (priv->flags & DPAA2_TX_PREFETCH_DYNAMIC_CONF) {
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
index 1836226706..a7c9bb678e 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -73,8 +73,6 @@ static uint64_t dev_tx_offloads_sup =
 static uint64_t dev_tx_offloads_nodis =
 		RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
-bool dpaa2_print_parser_result;
-
 /* Rx descriptor limit when DPNI loads PFDRs in PEB */
 #define MAX_NB_RX_DESC_IN_PEB	11264
 static int total_nb_rx_desc;
@@ -85,27 +83,6 @@ static int total_nb_rx_desc;
  * patterns are inspected by dpaa2_dev_rss_reta_update().
  */
 #define DPAA2_RETA_SIZE		64
-
-/* Values of dist_size accepted by the DPNI 'dpni_set_rx_hash_dist' MC command.
- * Source: fsl_dpni.h, "struct dpni_rx_dist_cfg::dist_size" documentation.
- * Used by dpaa2_dev_rss_reta_update() to validate user-requested patterns.
- */
-static const uint16_t dpaa2_dist_size_allowed[] = {
-	1, 2, 3, 4, 6, 7, 8, 12, 14, 16, 24, 28, 32, 48, 56, 64,
-	96, 112, 128, 192, 224, 256, 384, 448, 512, 768, 896, 1024,
-};
-
-static bool
-dpaa2_dist_size_is_supported(uint16_t n)
-{
-	size_t i;
-	for (i = 0; i < RTE_DIM(dpaa2_dist_size_allowed); i++) {
-		if (dpaa2_dist_size_allowed[i] == n)
-			return true;
-	}
-	return false;
-}
-
 int dpaa2_valid_dev;
 struct rte_mempool *dpaa2_tx_sg_pool;
 
@@ -396,6 +373,197 @@ static int dpaa2_dev_link_update(struct rte_eth_dev *dev,
 static int dpaa2_dev_set_link_up(struct rte_eth_dev *dev);
 static int dpaa2_dev_set_link_down(struct rte_eth_dev *dev);
 static int dpaa2_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu);
+static int
+dpaa2_setup_table_miss_action(struct rte_eth_dev *eth_dev,
+	uint8_t tc_index)
+{
+	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
+	struct rte_flow_group_attr attr;
+	struct rte_flow_action actions[2];
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.ingress = 1;
+	if (tc_index < priv->num_rx_tc) {
+		tbl_profile = &priv->flow_profile.tc_profile[tc_index];
+		if (tbl_profile->default_drop) {
+			actions[0].type = RTE_FLOW_ACTION_TYPE_DROP;
+		} else if (tbl_profile->default_queue.index >= eth_dev->data->nb_rx_queues) {
+			DPAA2_PMD_DEBUG("%s-tc%d-default-rxq(%d) >= max rxq(%d), Force to drop.",
+				eth_dev->data->name, tc_index, tbl_profile->default_queue.index,
+				eth_dev->data->nb_rx_queues);
+			tbl_profile->default_drop = true;
+			actions[0].type = RTE_FLOW_ACTION_TYPE_DROP;
+		} else {
+			actions[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
+			actions[0].conf = &tbl_profile->default_queue;
+		}
+	} else {
+		tbl_profile = &priv->flow_profile.qos_profile;
+		if (tbl_profile->default_drop) {
+			actions[0].type = RTE_FLOW_ACTION_TYPE_DROP;
+		} else if (tbl_profile->default_jump.group >= priv->num_rx_tc) {
+			DPAA2_PMD_DEBUG("%s-default-tc(%d) >= max tc(%d), Force to drop.",
+				eth_dev->data->name, tbl_profile->default_jump.group,
+				priv->num_rx_tc);
+			tbl_profile->default_drop = true;
+			actions[0].type = RTE_FLOW_ACTION_TYPE_DROP;
+		} else {
+			actions[0].type = RTE_FLOW_ACTION_TYPE_JUMP;
+			actions[0].conf = &tbl_profile->default_jump;
+		}
+	}
+	actions[1].type = RTE_FLOW_ACTION_TYPE_END;
+
+	return rte_flow_group_set_miss_actions(eth_dev->data->port_id,
+			tc_index, &attr, actions, NULL);
+}
+
+static int
+dpaa2_setup_flow_rss_dist(struct rte_eth_dev *eth_dev,
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
+dpaa2_setup_flow_dcb_dist(struct rte_eth_dev *eth_dev,
+	uint8_t prio, uint8_t tc)
+{
+	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
+	struct rte_flow_attr attr;
+	struct rte_flow_action actions[2];
+	struct rte_flow_item_vlan vlan_item;
+	struct rte_flow_item_vlan vlan_mask;
+	struct rte_flow_item items[2];
+	struct rte_flow_action_jump action_jump;
+	struct rte_flow *qos_flow;
+
+	memset(&attr, 0, sizeof(struct rte_flow_attr));
+	attr.ingress = 1;
+
+	attr.group = priv->num_rx_tc;
+	attr.priority = prio;
+	memset(&vlan_item, 0, sizeof(struct rte_flow_item_vlan));
+	memset(&vlan_mask, 0, sizeof(struct rte_flow_item_vlan));
+	vlan_item.hdr.vlan_tci = rte_cpu_to_be_16(RTE_VLAN_TCI_MAKE(0, prio, 0));
+	vlan_mask.hdr.vlan_tci = rte_cpu_to_be_16(RTE_VLAN_PRI_MASK);
+	items[0].spec = &vlan_item;
+	items[0].mask = &vlan_mask;
+	items[0].type = RTE_FLOW_ITEM_TYPE_VLAN;
+	items[1].type = RTE_FLOW_ITEM_TYPE_END;
+
+	actions[0].type = RTE_FLOW_ACTION_TYPE_JUMP;
+	action_jump.group = tc;
+	actions[0].conf = &action_jump;
+	actions[1].type = RTE_FLOW_ACTION_TYPE_END;
+
+	qos_flow = rte_flow_create(eth_dev->data->port_id,
+		&attr, items, actions, NULL);
+	if (!qos_flow) {
+		DPAA2_PMD_WARN("Failed to direct vlan with prio(%d) to tc%d", prio, tc);
+		return -EIO;
+	}
+	priv->dcb_flow[prio] = qos_flow;
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
+	if (!tbl_profile->rss_flow || !tbl_profile->is_rss) {
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
+	uint64_t req_dist_set, int tc_index)
+{
+	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	struct rte_flow_action_rss action_rss;
+	struct rte_flow_action actions[2];
+	int ret;
+
+	tbl_profile = &priv->flow_profile.tc_profile[tc_index];
+	if (!tbl_profile->rss_flow || !tbl_profile->is_rss) {
+		DPAA2_PMD_WARN("%s'TC[%d] is not RSS distributed",
+			eth_dev->data->name, tc_index);
+		return 0;
+	}
+	action_rss.func = RTE_ETH_HASH_FUNCTION_DEFAULT;
+	action_rss.level = 0;
+	action_rss.types = req_dist_set;
+	action_rss.key_len = 0;
+	action_rss.queue_num = tbl_profile->tc_cfg.dist_size;
+	action_rss.key = NULL;
+	action_rss.queue = NULL;
+	actions[0].type = RTE_FLOW_ACTION_TYPE_RSS;
+	actions[0].conf = &action_rss;
+	actions[1].type = RTE_FLOW_ACTION_TYPE_END;
+	ret = rte_flow_actions_update(eth_dev->data->port_id, tbl_profile->rss_flow,
+		actions, NULL);
+
+	return ret;
+}
 
 static int
 dpaa2_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
@@ -613,7 +781,7 @@ dpaa2_dev_info_get(struct rte_eth_dev *dev,
 					dev_rx_offloads_nodis;
 	dev_info->tx_offload_capa = dev_tx_offloads_sup |
 					dev_tx_offloads_nodis;
-	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
+	dev_info->dev_capa = 0;
 
 	dev_info->max_hash_mac_addrs = 0;
 	dev_info->max_vfs = 0;
@@ -883,6 +1051,28 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 	}
 }
 
+static int
+dpaa2_dev_dcb_info(struct rte_eth_dev *dev,
+	struct rte_eth_dcb_info *dcb_info)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	int i;
+
+	if (!priv->nb_dcb_tcs)
+		return -ENOTSUP;
+
+	memset(dcb_info, 0, sizeof(struct rte_eth_dcb_info));
+	dcb_info->nb_tcs = priv->nb_dcb_tcs;
+	rte_memcpy(dcb_info->prio_tc, priv->prio_dcb_tc,
+		sizeof(uint8_t) * RTE_ETH_DCB_NUM_USER_PRIORITIES);
+	for (i = 0; i < dcb_info->nb_tcs; i++) {
+		dcb_info->tc_queue.tc_rxq[0][i].base = priv->dist_queues * i;
+		dcb_info->tc_queue.tc_rxq[0][i].nb_queue = priv->dist_queues;
+	}
+
+	return 0;
+}
+
 static int
 dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 {
@@ -895,8 +1085,12 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 	int rx_l4_csum_offload = false;
 	int tx_l3_csum_offload = false;
 	int tx_l4_csum_offload = false;
-	int ret, tc_index;
-	uint32_t max_rx_pktlen;
+	int ret, tc_index, nb_tcs;
+	uint32_t max_rx_pktlen, base;
+	struct rte_eth_rss_conf *rss_conf;
+	struct rte_eth_dcb_rx_conf *dcb_rx_conf;
+	struct rte_dpaa2_default_action_conf *def_act_conf;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -942,15 +1136,64 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 		return -1;
 	}
 
-	if (eth_conf->rxmode.mq_mode == RTE_ETH_MQ_RX_RSS) {
+	rss_conf = &eth_conf->rx_adv_conf.rss_conf;
+	dcb_rx_conf = &eth_conf->rx_adv_conf.dcb_rx_conf;
+	def_act_conf = eth_conf->rxmode.reserved_ptrs[0];
+
+	for (tc_index = 0; tc_index < priv->num_rx_tc; tc_index++) {
+		tbl_profile = &priv->flow_profile.tc_profile[tc_index];
+		base = priv->dist_queues * tc_index;
+		if (def_act_conf && tc_index < def_act_conf->max_tc) {
+			if (def_act_conf->default_flows[tc_index] >= priv->dist_queues) {
+				tbl_profile->default_drop = true;
+			} else {
+				tbl_profile->default_drop = false;
+				tbl_profile->default_queue.index = base +
+					def_act_conf->default_flows[tc_index];
+			}
+		}
+		if (priv->fs_entries) {
+			ret = dpaa2_setup_table_miss_action(dev, tc_index);
+			if (ret) {
+				DPAA2_PMD_ERR("Error(%d) to set miss action of %s-tc%d table",
+					ret, dev->data->name, tc_index);
+			}
+		}
+	}
+	if (def_act_conf) {
+		tbl_profile = &priv->flow_profile.qos_profile;
+		if (def_act_conf->default_tc >= priv->num_rx_tc) {
+			tbl_profile->default_drop = true;
+		} else {
+			tbl_profile->default_drop = false;
+			tbl_profile->default_jump.group = def_act_conf->default_tc;
+		}
+	}
+	ret = dpaa2_setup_table_miss_action(dev, priv->num_rx_tc);
+	if (ret) {
+		DPAA2_PMD_ERR("Error(%d) to set miss action of %s-QoS table",
+			ret, dev->data->name);
+	}
+
+	if (eth_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_RSS) {
 		for (tc_index = 0; tc_index < priv->num_rx_tc; tc_index++) {
-			ret = dpaa2_setup_flow_dist(dev,
-					eth_conf->rx_adv_conf.rss_conf.rss_hf,
-					tc_index);
+			ret = dpaa2_setup_flow_rss_dist(dev, rss_conf->rss_hf, tc_index);
 			if (ret) {
-				DPAA2_PMD_ERR(
-					"Unable to set flow distribution on tc%d."
-					"Check queue config", tc_index);
+				DPAA2_PMD_ERR("RSS dist on tc%d err(%d)", tc_index, ret);
+				return ret;
+			}
+		}
+	}
+
+	if ((eth_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_DCB) && priv->qos_entries) {
+		nb_tcs = dcb_rx_conf->nb_tcs;
+		for (tc_index = 0; tc_index < nb_tcs; tc_index++) {
+			if (tc_index >= priv->num_rx_tc)
+				break;
+			ret = dpaa2_setup_flow_dcb_dist(dev, dcb_rx_conf->dcb_tc[tc_index],
+				tc_index);
+			if (ret) {
+				DPAA2_PMD_ERR("DCB direct to tc%d err(%d)", tc_index, ret);
 				return ret;
 			}
 		}
@@ -1097,7 +1340,6 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	struct dpni_taildrop taildrop;
 	uint8_t qopt = 0;
 	uint16_t flow_id;
-	uint32_t bpid;
 	int ret;
 
 	PMD_INIT_FUNC_TRACE();
@@ -1116,18 +1358,6 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			       nb_rx_desc);
 	}
 
-	if (!priv->bp_list || priv->bp_list->mp != mb_pool) {
-		if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
-			ret = rte_dpaa2_bpid_info_init(mb_pool);
-			if (ret)
-				return ret;
-		}
-		bpid = mempool_to_bpid(mb_pool);
-		ret = dpaa2_attach_bp_list(priv, dpni,
-				rte_dpaa2_bpid_info[bpid].bp_list);
-		if (ret)
-			return ret;
-	}
 	dpaa2_q = priv->rx_vq[rx_queue_id];
 	if (dpaa2_q->fqid != DPAA2_INVALID_FQ_ID) {
 		DPAA2_PMD_WARN("%s: RXQ[%d] has been setup",
@@ -1797,6 +2027,7 @@ dpaa2_dev_close(struct rte_eth_dev *dev)
 	struct fsl_mc_io *dpni = dev->process_private;
 	int i, ret;
 	struct rte_eth_link link;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -1809,7 +2040,9 @@ dpaa2_dev_close(struct rte_eth_dev *dev)
 	}
 
 	dpaa2_tm_deinit(dev);
-	dpaa2_flow_clean(dev);
+	dpaa2_flow_clean(dev, MAX_TCS);
+	/** No matter dcb flows are created or not, they are destroyed in flow clean.*/
+	memset(priv->dcb_flow, 0, sizeof(void *) * RTE_ETH_DCB_NUM_USER_PRIORITIES);
 	/* Clean the device first */
 	ret = dpni_reset(dpni, CMD_PRI_LOW, priv->token);
 	if (ret) {
@@ -1843,10 +2076,16 @@ dpaa2_dev_close(struct rte_eth_dev *dev)
 	dev->process_private = NULL;
 	rte_free(dpni);
 
-	for (i = 0; i < MAX_TCS; i++)
-		rte_free(priv->extract.tc_extract_param[i]);
-
-	rte_free(priv->extract.qos_extract_param);
+	for (i = 0; i < (MAX_TCS + 1); i++) {
+		if (i < MAX_TCS)
+			tbl_profile = &priv->flow_profile.tc_profile[i];
+		else
+			tbl_profile = &priv->flow_profile.qos_profile;
+		rte_free(tbl_profile->extract_param);
+		tbl_profile->extract_param = NULL;
+		rte_free(tbl_profile->entry_map);
+		tbl_profile->entry_map = NULL;
+	}
 
 	rte_free(priv->cnt_idx_dma_mem);
 	rte_free(priv->cnt_values_dma_mem);
@@ -2746,25 +2985,25 @@ dpaa2_dev_rss_hash_update(struct rte_eth_dev *dev,
 
 	if (rss_conf->rss_hf) {
 		for (tc_index = 0; tc_index < priv->num_rx_tc; tc_index++) {
-			ret = dpaa2_setup_flow_dist(dev, rss_conf->rss_hf,
+			ret = dpaa2_update_flow_rss_dist(dev, rss_conf->rss_hf,
 				tc_index);
-			if (ret) {
-				DPAA2_PMD_ERR("Unable to set flow dist on tc%d",
-					tc_index);
-				return ret;
-			}
+			if (ret)
+				break;
 		}
 	} else {
 		for (tc_index = 0; tc_index < priv->num_rx_tc; tc_index++) {
-			ret = dpaa2_remove_flow_dist(dev, tc_index);
-			if (ret) {
-				DPAA2_PMD_ERR(
-					"Unable to remove flow dist on tc%d",
-					tc_index);
-				return ret;
-			}
+			ret = dpaa2_remove_flow_rss_dist(dev, tc_index);
+			if (ret)
+				break;
 		}
 	}
+	if (ret) {
+		DPAA2_PMD_ERR("%s: %s flow dist on tc%d err(%d)",
+			data->name, rss_conf->rss_hf ? "set" : "remove",
+			tc_index, ret);
+
+		return ret;
+	}
 	eth_conf->rx_adv_conf.rss_conf.rss_hf = rss_conf->rss_hf;
 	return 0;
 }
@@ -2879,23 +3118,34 @@ dpaa2_dev_rss_reta_update(struct rte_eth_dev *dev,
 		}
 	}
 
-	if (!dpaa2_dist_size_is_supported(n)) {
-		DPAA2_PMD_ERR("dist_size %u not supported by HW. Allowed: "
-			"1,2,3,4,6,7,8,12,14,16,24,28,32,48,56,64,...",
-			n);
+	/* The requested distribution size cannot exceed the number of
+	 * distribution queues provisioned per TC. Any HW-specific limitation
+	 * on the exact value is enforced later by the rte_flow update.
+	 */
+	if (n > priv->dist_queues) {
+		DPAA2_PMD_ERR("dist_size %u exceeds max distribution queues %u",
+			n, priv->dist_queues);
 		return -ENOTSUP;
 	}
 
-	/* Apply on every configured RX TC, matching rss_hash_update behavior. */
+	/* Apply on every configured RX TC, matching rss_hash_update behavior.
+	 * Program the new dist_size into each TC's RSS flow profile and push
+	 * it to the live flow via rte_flow_actions_update().
+	 */
 	for (tc_index = 0; tc_index < priv->num_rx_tc; tc_index++) {
-		ret = dpaa2_setup_flow_dist_size(dev,
+		struct dpaa2_flow_tbl_profile *tbl_profile =
+			&priv->flow_profile.tc_profile[tc_index];
+
+		tbl_profile->tc_cfg.dist_size = n;
+		ret = dpaa2_update_flow_rss_dist(dev,
 				eth_conf->rx_adv_conf.rss_conf.rss_hf,
-				tc_index, n);
+				tc_index);
 		if (ret) {
 			DPAA2_PMD_ERR("Failed to apply dist_size=%u on tc%d (err=%d)",
 				n, tc_index, ret);
 			return ret;
 		}
+		priv->dist_size_cur[tc_index] = n;
 	}
 
 	DPAA2_PMD_DEBUG("RETA updated: dist_size now %u on %u TC(s)",
@@ -3453,7 +3703,8 @@ static struct eth_dev_ops dpaa2_ethdev_ops = {
 	.timesync_adjust_time = dpaa2_timesync_adjust_time,
 	.timesync_read_rx_timestamp = dpaa2_timesync_read_rx_timestamp,
 	.timesync_read_tx_timestamp = dpaa2_timesync_read_tx_timestamp,
-	.mtr_ops_get	      = dpaa2_mtr_ops_get,
+	.mtr_ops_get = dpaa2_mtr_ops_get,
+	.get_dcb_info = dpaa2_dev_dcb_info
 };
 
 /* Populate the mac address from physically available (u-boot/firmware) and/or
@@ -3570,7 +3821,9 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	struct dpni_attr attr;
 	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
 	struct dpni_buffer_layout layout;
-	int ret, hw_id, i;
+	int ret, hw_id, i, entry_num;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	uint64_t iova;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -3668,8 +3921,6 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	priv->dist_queues = attr.num_queues;
 	priv->num_channels = attr.num_channels;
 	priv->channel_inuse = 0;
-	priv->default_flow = RTE_MIN(priv->fs_entries,
-		priv->dist_queues) - 1;
 	rte_spinlock_init(&priv->lpbk_qp_lock);
 
 	/* only if the custom CG is enabled */
@@ -3830,27 +4081,51 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	eth_dev->tx_pkt_burst = dpaa2_dev_tx;
 
 	/* Init fields w.r.t. classification */
-	memset(&priv->extract.qos_key_extract, 0,
-		sizeof(struct dpaa2_key_extract));
-	priv->extract.qos_extract_param = rte_zmalloc(NULL,
-		DPAA2_EXTRACT_PARAM_MAX_SIZE,
-		RTE_CACHE_LINE_SIZE);
-	if (!priv->extract.qos_extract_param) {
-		DPAA2_PMD_ERR("Memory alloc failed");
-		goto init_err;
-	}
-
-	for (i = 0; i < MAX_TCS; i++) {
-		memset(&priv->extract.tc_key_extract[i], 0,
-			sizeof(struct dpaa2_key_extract));
-		priv->extract.tc_extract_param[i] = rte_zmalloc(NULL,
+	for (i = 0; i < (MAX_TCS + 1); i++) {
+		if (i < MAX_TCS) {
+			tbl_profile = &priv->flow_profile.tc_profile[i];
+			entry_num = priv->fs_entries;
+		} else {
+			tbl_profile = &priv->flow_profile.qos_profile;
+			entry_num = priv->qos_entries;
+		}
+		memset(tbl_profile, 0, sizeof(struct dpaa2_flow_tbl_profile));
+		tbl_profile->extract_param = rte_zmalloc(NULL,
 			DPAA2_EXTRACT_PARAM_MAX_SIZE,
 			RTE_CACHE_LINE_SIZE);
-		if (!priv->extract.tc_extract_param[i]) {
-			DPAA2_PMD_ERR("Memory alloc failed");
+		if (!tbl_profile->extract_param)
 			goto init_err;
+		iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(tbl_profile->extract_param,
+			DPAA2_EXTRACT_PARAM_MAX_SIZE);
+		tbl_profile->default_drop = false;
+		if (i < MAX_TCS) {
+			tbl_profile->tc_cfg.dist_size = priv->dist_queues;
+			tbl_profile->tc_cfg.key_cfg_iova = iova;
+			tbl_profile->tc_cfg.tc = i;
+			/** First flow of TC as default flow, otherwise, may be dropped.*/
+			tbl_profile->default_queue.index = priv->dist_queues * i;
+		} else {
+			tbl_profile->qos_cfg.key_cfg_iova = iova;
+			tbl_profile->qos_cfg.keep_entries = true;
+			/** First TC as default TC, otherwise, may be dropped.*/
+			tbl_profile->default_jump.group = 0;
 		}
+		if (!entry_num)
+			continue;
+
+		tbl_profile->entry_map = rte_zmalloc(NULL, entry_num / 8 + 1, 0);
+		if (!tbl_profile->entry_map)
+			goto init_err;
+	}
+
+	for (i = 0; i < priv->num_rx_tc; i++) {
+		if (i >= RTE_ETH_DCB_NUM_USER_PRIORITIES)
+			break;
+		if (i >= priv->qos_entries)
+			break;
+		priv->prio_dcb_tc[i] = i;
 	}
+	priv->nb_dcb_tcs = i;
 
 	ret = dpni_set_max_frame_length(dpni_dev, CMD_PRI_LOW, priv->token,
 					RTE_ETHER_MAX_LEN - RTE_ETHER_CRC_LEN
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 523c420c51..5659abcd51 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2015-2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2025 NXP
+ *   Copyright 2016-2026 NXP
  *
  */
 
@@ -12,6 +12,7 @@
 #include <rte_compat.h>
 #include <rte_event_eth_rx_adapter.h>
 #include <rte_pmd_dpaa2.h>
+#include <rte_string_fns.h>
 
 #include <bus_fslmc_driver.h>
 #include <dpaa2_hw_pvt.h>
@@ -24,6 +25,13 @@
 #include "base/dpaa2_hw_dpni_annot.h"
 #include "dpaa2_parser_decode.h"
 
+#define DPAA2_FLOW_FRM_REPLICATION_ACTION_MC_REV RTE_FSL_MC_REV(10, 39, 106)
+#define DPAA2_FS_FLOW_HW_ACTION_UPDATE_MC_REV RTE_FSL_MC_REV(10, 39, 106)
+#define DPAA2_QOS_FLOW_HW_ACTION_UPDATE_MC_REV RTE_FSL_MC_REV(10, 39, 109)
+#define DPAA2_POLICER_SET_V2_MC_REV RTE_FSL_MC_REV(10, 39, 109)
+#define DPAA2_POLICER_NOT_RESET_COUNTER_MC_REV DPAA2_POLICER_SET_V2_MC_REV
+#define DPAA2_QOS_FLOW_TABLE_MISS_FLOW_ACTION_MC_REV RTE_FSL_MC_REV(10, 39, 109)
+#define DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV RTE_FSL_MC_REV(10, 39, 109)
 
 #define DPAA2_MIN_RX_BUF_SIZE 512
 #define DPAA2_MAX_RX_PKT_LEN  10240 /*WRIOP support*/
@@ -35,6 +43,10 @@
 #define MAX_DPNI		8
 #define DPAA2_MAX_CHANNELS	16
 
+#define DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv) \
+	container_of((((struct dpaa2_dev_priv *)priv)->eth_dev->device), \
+	struct rte_dpaa2_device, device)
+
 #define DPAA2_EXTRACT_PARAM_MAX_SIZE \
 	RTE_ALIGN(sizeof(struct dpni_ext_set_rx_tc_dist), 256)
 
@@ -254,125 +266,9 @@ struct dpaa2_dyn_rx_protocol_pos {
 #define DPAA2_FS_FLC_FLOW_OFFSET \
 	(DPAA2_FS_FLC_TC_OFFSET + DPAA2_FS_FLC_TC_BIT_SIZE)
 
-#define DPAA2_FAPR_SIZE \
-	(sizeof(struct dpaa2_annot_hdr) - \
-	offsetof(struct dpaa2_annot_hdr, word3))
-
-#define DPAA2_PR_NXTHDR_OFFSET 0
-
-#define DPAA2_FAFE_PSR_OFFSET 2
-#define DPAA2_FAFE_PSR_SIZE 2
-
-#define DPAA2_FAF_PSR_OFFSET 4
-#define DPAA2_FAF_PSR_SIZE 12
-
-#define DPAA2_FAF_TOTAL_SIZE \
-	(DPAA2_FAFE_PSR_SIZE + DPAA2_FAF_PSR_SIZE)
-
-/* Just most popular Frame attribute flags (FAF) here.*/
-enum dpaa2_rx_faf_offset {
-	/* Set by SP start*/
-	FAFE_VXLAN_IN_VLAN_FRAM = 0,
-	FAFE_VXLAN_IN_IPV4_FRAM = 1,
-	FAFE_VXLAN_IN_IPV6_FRAM = 2,
-	FAFE_VXLAN_IN_UDP_FRAM = 3,
-	FAFE_VXLAN_IN_TCP_FRAM = 4,
-
-	FAFE_ECPRI_FRAM = 7,
-	/* Set by SP end*/
-
-	FAF_GTP_PRIMED_FRAM = 1 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_PTP_FRAM = 3 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_VXLAN_FRAM = 4 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_ETH_FRAM = 10 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_LLC_SNAP_FRAM = 18 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_VLAN_FRAM = 21 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_PPPOE_PPP_FRAM = 25 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_MPLS_FRAM = 27 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_ARP_FRAM = 30 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_IPV4_FRAM = 34 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_IPV6_FRAM = 42 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_IP_FRAM = 48 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_IP_FRAG_FRAM = 50 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_ICMP_FRAM = 57 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_IGMP_FRAM = 58 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_GRE_FRAM = 65 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_UDP_FRAM = 70 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_TCP_FRAM = 72 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_IPSEC_FRAM = 77 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_IPSEC_ESP_FRAM = 78 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_IPSEC_AH_FRAM = 79 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_SCTP_FRAM = 81 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_DCCP_FRAM = 83 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_GTP_FRAM = 87 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_ESP_FRAM = 89 + DPAA2_FAFE_PSR_SIZE * 8,
-};
-
-enum dpaa2_ecpri_fafe_type {
-	ECPRI_FAFE_TYPE_0 = (8 - FAFE_ECPRI_FRAM),
-	ECPRI_FAFE_TYPE_1 = (8 - FAFE_ECPRI_FRAM) | (1 << 1),
-	ECPRI_FAFE_TYPE_2 = (8 - FAFE_ECPRI_FRAM) | (2 << 1),
-	ECPRI_FAFE_TYPE_3 = (8 - FAFE_ECPRI_FRAM) | (3 << 1),
-	ECPRI_FAFE_TYPE_4 = (8 - FAFE_ECPRI_FRAM) | (4 << 1),
-	ECPRI_FAFE_TYPE_5 = (8 - FAFE_ECPRI_FRAM) | (5 << 1),
-	ECPRI_FAFE_TYPE_6 = (8 - FAFE_ECPRI_FRAM) | (6 << 1),
-	ECPRI_FAFE_TYPE_7 = (8 - FAFE_ECPRI_FRAM) | (7 << 1)
-};
-
-#define DPAA2_PR_ETH_OFF_OFFSET 19
-#define DPAA2_PR_TCI_OFF_OFFSET 21
-#define DPAA2_PR_LAST_ETYPE_OFFSET 23
-#define DPAA2_PR_L3_OFF_OFFSET 27
-#define DPAA2_PR_L4_OFF_OFFSET 30
-#define DPAA2_PR_L5_OFF_OFFSET 31
-#define DPAA2_PR_NXTHDR_OFF_OFFSET 34
-
 #define DPAA2_ECPRI_MAX_EXTRACT_NB 8
 
-struct ipv4_sd_addr_extract_rule {
-	uint32_t ipv4_src;
-	uint32_t ipv4_dst;
-};
-
-struct ipv6_sd_addr_extract_rule {
-	uint8_t ipv6_src[NH_FLD_IPV6_ADDR_SIZE];
-	uint8_t ipv6_dst[NH_FLD_IPV6_ADDR_SIZE];
-};
-
-struct ipv4_ds_addr_extract_rule {
-	uint32_t ipv4_dst;
-	uint32_t ipv4_src;
-};
-
-struct ipv6_ds_addr_extract_rule {
-	uint8_t ipv6_dst[NH_FLD_IPV6_ADDR_SIZE];
-	uint8_t ipv6_src[NH_FLD_IPV6_ADDR_SIZE];
-};
-
-union ip_addr_extract_rule {
-	struct ipv4_sd_addr_extract_rule ipv4_sd_addr;
-	struct ipv6_sd_addr_extract_rule ipv6_sd_addr;
-	struct ipv4_ds_addr_extract_rule ipv4_ds_addr;
-	struct ipv6_ds_addr_extract_rule ipv6_ds_addr;
-};
-
-union ip_src_addr_extract_rule {
-	uint32_t ipv4_src;
-	uint8_t ipv6_src[NH_FLD_IPV6_ADDR_SIZE];
-};
-
-union ip_dst_addr_extract_rule {
-	uint32_t ipv4_dst;
-	uint8_t ipv6_dst[NH_FLD_IPV6_ADDR_SIZE];
-};
-
-enum ip_addr_extract_type {
-	IP_NONE_ADDR_EXTRACT,
-	IP_SRC_EXTRACT,
-	IP_DST_EXTRACT,
-	IP_SRC_DST_EXTRACT,
-	IP_DST_SRC_EXTRACT
-};
+#define DPAA2_IBTH_MAX_EXTRACT_NB 4
 
 enum key_prot_type {
 	/* HW extracts from standard protocol fields*/
@@ -389,9 +285,9 @@ struct key_prot_field {
 	uint32_t key_field;
 };
 
-struct dpaa2_raw_region {
-	uint8_t raw_start;
-	uint8_t raw_size;
+struct dpaa2_ip_addr_extract {
+	uint32_t field;
+	uint8_t max_size;
 };
 
 struct dpaa2_key_profile {
@@ -399,35 +295,52 @@ struct dpaa2_key_profile {
 	uint8_t key_offset[DPKG_MAX_NUM_OF_EXTRACTS];
 	uint8_t key_size[DPKG_MAX_NUM_OF_EXTRACTS];
 
-	enum ip_addr_extract_type ip_addr_type;
-	uint8_t ip_addr_extract_pos;
-	uint8_t ip_addr_extract_off;
-
-	uint8_t raw_extract_pos;
-	uint8_t raw_extract_off;
-	uint8_t raw_extract_num;
+	struct dpaa2_ip_addr_extract ip_addr_extracts[2];
 
-	uint8_t l4_src_port_present;
-	uint8_t l4_src_port_pos;
-	uint8_t l4_src_port_offset;
-	uint8_t l4_dst_port_present;
-	uint8_t l4_dst_port_pos;
-	uint8_t l4_dst_port_offset;
+	uint8_t l4_sp_present;
+	uint8_t l4_sp_extract_idx;
+	uint8_t l4_sp_key_offset;
+	uint8_t l4_dp_present;
+	uint8_t l4_dp_extract_idx;
+	uint8_t l4_dp_key_offset;
 	struct key_prot_field prot_field[DPKG_MAX_NUM_OF_EXTRACTS];
 	uint16_t key_max_size;
-	struct dpaa2_raw_region raw_region;
 };
 
-struct dpaa2_key_extract {
+struct dpaa2_flow_tbl_profile {
 	struct dpkg_profile_cfg dpkg;
 	struct dpaa2_key_profile key_profile;
+	uint8_t *extract_param;
+	int entry_num;
+	uint8_t *entry_map;
+	int enabled;
+	int is_rss;
+	void *rss_flow;
+	union {
+		struct dpni_qos_tbl_cfg qos_cfg;
+		struct dpni_rx_dist_cfg tc_cfg;
+	};
+	int default_drop;
+	union {
+		struct rte_flow_action_jump default_jump;
+		struct rte_flow_action_queue default_queue;
+	};
 };
 
-struct extract_s {
-	struct dpaa2_key_extract qos_key_extract;
-	struct dpaa2_key_extract tc_key_extract[MAX_TCS];
-	uint8_t *qos_extract_param;
-	uint8_t *tc_extract_param[MAX_TCS];
+struct dpaa2_flow_profile {
+	struct dpaa2_flow_tbl_profile qos_profile;
+	struct dpaa2_flow_tbl_profile tc_profile[MAX_TCS];
+	/** Meter per TC.*/
+	struct dpaa2_dev_meter_profile *tc_mtr_profile[MAX_TCS];
+	void *mtr_flow[MAX_TCS];
+	void *mempool[MAX_TCS];
+	uint8_t bp_idx[MAX_TCS];
+};
+
+struct rte_dpaa2_default_action_conf {
+	uint8_t default_tc;
+	uint8_t max_tc;
+	uint16_t default_flows[];
 };
 
 struct dpaa2_dev_meter_profile {
@@ -491,15 +404,12 @@ struct dpaa2_dev_priv {
 	/** RXQs in same TC share same cgid.*/
 	uint8_t cgid_in_use[MAX_TCS];
 	rte_spinlock_t meter_lock;
-	/* Lowest priority FS flow id to receive flow steering miss frames. */
-	uint16_t default_flow;
 
 	/* Current hash distribution size per RX TC, written by
 	 * dpaa2_setup_flow_dist_size() and read by reta_query / reta_update.
 	 * Zero means "use default" (= nb_rx_queues clamped to dist_queues).
 	 */
 	uint16_t dist_size_cur[MAX_TCS];
-
 	uint16_t dpni_ver_major;
 	uint16_t dpni_ver_minor;
 	uint32_t speed_capa;
@@ -508,7 +418,10 @@ struct dpaa2_dev_priv {
 	uint16_t ep_object_id;                 /**< Endpoint DPAA2 Object ID */
 	char ep_name[RTE_DEV_NAME_MAX_LEN];
 
-	struct extract_s extract;
+	struct dpaa2_flow_profile flow_profile;
+	uint8_t nb_dcb_tcs;
+	uint8_t prio_dcb_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES];
+	void *dcb_flow[RTE_ETH_DCB_NUM_USER_PRIORITIES];
 
 	uint16_t ss_offset;
 	uint64_t ss_iova;
@@ -528,6 +441,7 @@ struct dpaa2_dev_priv {
 	struct rte_eth_dev *eth_dev; /**< Pointer back to holding ethdev */
 	rte_spinlock_t lpbk_qp_lock;
 
+	bool enable_bp_flow_ctrl;
 	bool sp_protocol;
 	uint8_t channel_inuse;
 	/* Rx-interrupt mode latched at the first dev_configure */
@@ -549,7 +463,7 @@ struct dpaa2_dev_priv {
 
 	struct rte_mempool *tx_sg_pool;
 
-	struct dpaa2_dev_flow *curr;
+	struct dpaa2_generic_flow *cur_flow;
 	LIST_HEAD(, dpaa2_dev_flow) flows;
 	LIST_HEAD(, dpaa2_dev_meter_profile) profiles;
 	LIST_HEAD(, dpaa2_dev_meter_policy) policies;
@@ -569,6 +483,8 @@ static inline int dpaa2_dev_cmp_dpni_ver(struct dpaa2_dev_priv *priv,
 	return priv->dpni_ver_major - ver_major;
 }
 
+#define DPAA2_FLOW_DUMP dpaa2_dump_print
+
 static inline void
 dpaa2_dev_rx_print_parser_result(struct dpaa2_dev_priv *priv,
 	const struct qbman_fd *fd, const struct rte_mbuf *m)
@@ -619,21 +535,269 @@ dpaa2_timestamp_debug(struct dpaa2_dev_priv *priv,
 		prefix, timestamp, (int64_t)ts.tv_sec, (int64_t)ts.tv_nsec);
 }
 
-int dpaa2_distset_to_dpkg_profile_cfg(uint64_t req_dist_set,
-				      struct dpkg_profile_cfg *kg_cfg);
+static inline void
+dpaa2_prot_field_string(uint32_t prot, uint32_t field,
+	char *string, size_t size)
+{
+	if (prot == NET_PROT_ETH) {
+		strlcpy(string, "eth", size);
+		if (field == NH_FLD_ETH_DA)
+			strlcat(string, ".dst", size);
+		else if (field == NH_FLD_ETH_SA)
+			strlcat(string, ".src", size);
+		else if (field == NH_FLD_ETH_TYPE)
+			strlcat(string, ".type", size);
+		else
+			strlcat(string, ".unknown field", size);
+	} else if (prot == NET_PROT_VLAN) {
+		strlcpy(string, "vlan", size);
+		if (field == NH_FLD_VLAN_TCI)
+			strlcat(string, ".tci", size);
+		else
+			strlcat(string, ".unknown field", size);
+	} else if (prot == NET_PROT_IP) {
+		strlcpy(string, "ip", size);
+		if (field == NH_FLD_IP_SRC)
+			strlcat(string, ".src", size);
+		else if (field == NH_FLD_IP_DST)
+			strlcat(string, ".dst", size);
+		else if (field == NH_FLD_IP_PROTO)
+			strlcat(string, ".proto", size);
+		else
+			strlcat(string, ".unknown field", size);
+	} else if (prot == NET_PROT_TCP) {
+		strlcpy(string, "tcp", size);
+		if (field == NH_FLD_TCP_PORT_SRC)
+			strlcat(string, ".src", size);
+		else if (field == NH_FLD_TCP_PORT_DST)
+			strlcat(string, ".dst", size);
+		else
+			strlcat(string, ".unknown field", size);
+	} else if (prot == NET_PROT_UDP) {
+		strlcpy(string, "udp", size);
+		if (field == NH_FLD_UDP_PORT_SRC)
+			strlcat(string, ".src", size);
+		else if (field == NH_FLD_UDP_PORT_DST)
+			strlcat(string, ".dst", size);
+		else
+			strlcat(string, ".unknown field", size);
+	} else if (prot == NET_PROT_ICMP) {
+		strlcpy(string, "icmp", size);
+		if (field == NH_FLD_ICMP_TYPE)
+			strlcat(string, ".type", size);
+		else if (field == NH_FLD_ICMP_CODE)
+			strlcat(string, ".code", size);
+		else
+			strlcat(string, ".unknown field", size);
+	} else if (prot == NET_PROT_SCTP) {
+		strlcpy(string, "sctp", size);
+		if (field == NH_FLD_SCTP_PORT_SRC)
+			strlcat(string, ".src", size);
+		else if (field == NH_FLD_SCTP_PORT_DST)
+			strlcat(string, ".dst", size);
+		else
+			strlcat(string, ".unknown field", size);
+	} else if (prot == NET_PROT_GRE) {
+		strlcpy(string, "gre", size);
+		if (field == NH_FLD_GRE_TYPE)
+			strlcat(string, ".type", size);
+		else
+			strlcat(string, ".unknown field", size);
+	} else if (prot == NET_PROT_GTP) {
+		strlcpy(string, "gtp", size);
+		if (field == NH_FLD_GTP_TEID)
+			strlcat(string, ".teid", size);
+		else
+			strlcat(string, ".unknown field", size);
+	} else if (prot == NET_PROT_IPSEC_ESP) {
+		strlcpy(string, "esp", size);
+		if (field == NH_FLD_IPSEC_ESP_SPI)
+			strlcat(string, ".spi", size);
+		else if (field == NH_FLD_IPSEC_ESP_SEQUENCE_NUM)
+			strlcat(string, ".seq", size);
+		else
+			strlcat(string, ".unknown field", size);
+	} else {
+		snprintf(string, size, "unknown protocol(%d)", prot);
+	}
+}
+
+static inline void
+dpaa2_dump_dpkg(const struct dpkg_profile_cfg *dpkg)
+{
+	int idx;
+	char string[32];
+	const struct dpkg_extract *extract;
+	enum dpkg_extract_type type;
+	enum net_prot prot;
+	uint32_t field;
+
+	for (idx = 0; idx < dpkg->num_extracts; idx++) {
+		extract = &dpkg->extracts[idx];
+		type = extract->type;
+		if (type == DPKG_EXTRACT_FROM_HDR) {
+			prot = extract->extract.from_hdr.prot;
+			field = extract->extract.from_hdr.field;
+			dpaa2_prot_field_string(prot, field, string, sizeof(string));
+		} else if (type == DPKG_EXTRACT_FROM_DATA) {
+			snprintf(string, sizeof(string), "raw offset/len: %d/%d",
+				extract->extract.from_data.offset,
+				extract->extract.from_data.size);
+		} else if (type == DPKG_EXTRACT_FROM_PARSE) {
+			snprintf(string, sizeof(string), "parse offset/len: %d/%d",
+				extract->extract.from_parse.offset,
+				extract->extract.from_parse.size);
+		}
+		DPAA2_FLOW_DUMP("%s", string);
+		if ((idx + 1) < dpkg->num_extracts)
+			DPAA2_FLOW_DUMP(" / ");
+		else
+			DPAA2_FLOW_DUMP("\r\n\n");
+	}
+}
+
+static inline int
+dpaa2_extract_prev_ip_addr_pos(const struct dpaa2_key_profile *profile)
+{
+	int idx = -ENXIO;
+
+	if (!profile->num)
+		return -ENXIO;
+
+	for (idx = profile->num - 1; idx >= 0; idx--) {
+		if (!(profile->prot_field[idx].type == DPAA2_NET_PROT_KEY &&
+			profile->prot_field[idx].prot == NET_PROT_IP &&
+			(profile->prot_field[idx].key_field == NH_FLD_IP_SRC ||
+			profile->prot_field[idx].key_field == NH_FLD_IP_DST)))
+			break;
+	}
+
+	if (idx >= 0)
+		return idx;
+	return -ENXIO;
+}
+
+static inline int
+dpaa2_extract_ip_addr_add(uint32_t field,
+	struct dpaa2_key_profile *key_profile, uint8_t size,
+	int *update, int *pos)
+{
+	struct dpaa2_ip_addr_extract *ip_addr_extracts;
+	uint8_t i = 0;
+	uint16_t max_size_save = key_profile->key_max_size;
+	char log_buf[128];
+
+	if (field != NH_FLD_IP_SRC && field != NH_FLD_IP_DST)
+		return -EINVAL;
+
+	max_size_save -= key_profile->ip_addr_extracts[0].max_size;
+	max_size_save -= key_profile->ip_addr_extracts[1].max_size;
+	ip_addr_extracts = key_profile->ip_addr_extracts;
+	while (i < 2) {
+		if (ip_addr_extracts[i].field == field) {
+			if (size > ip_addr_extracts[i].max_size)
+				ip_addr_extracts[i].max_size = size;
+			break;
+		}
+		if (!ip_addr_extracts[i].field) {
+			ip_addr_extracts[i].field = field;
+			ip_addr_extracts[i].max_size = size;
+			if (update)
+				*update = 1;
+			break;
+		}
+		i++;
+	}
+	if (i > 1) {
+		snprintf(log_buf, sizeof(log_buf),
+			"field[0](%d)/size[0](%d)/field[1](%d)/size[1](%d)",
+			ip_addr_extracts[0].field,
+			ip_addr_extracts[0].max_size,
+			ip_addr_extracts[1].field,
+			ip_addr_extracts[1].max_size);
+		DPAA2_FLOW_DUMP("Invalid IP address extracts:%s\n",
+			log_buf);
+		return -EINVAL;
+	}
+
+	if (pos)
+		*pos = i;
+
+	max_size_save += key_profile->ip_addr_extracts[0].max_size;
+	max_size_save += key_profile->ip_addr_extracts[1].max_size;
+	key_profile->key_max_size = max_size_save;
+
+	return 0;
+}
+
+static inline uint8_t
+dpaa2_profile_insert_no_ipaddr_extract(struct dpaa2_key_profile *profile,
+	uint8_t size, uint8_t *poffset, int *ppos,
+	const struct key_prot_field *prot)
+{
+	uint8_t idx, ip_addr_num = 0, offset;
+
+	if (profile->ip_addr_extracts[0].field &&
+		profile->ip_addr_extracts[1].field) {
+		idx = profile->num - 2;
+		ip_addr_num = 2;
+	} else if (profile->ip_addr_extracts[0].field) {
+		idx = profile->num - 1;
+		ip_addr_num = 1;
+	} else {
+		idx = profile->num;
+	}
 
-int dpaa2_setup_flow_dist(struct rte_eth_dev *eth_dev,
-		uint64_t req_dist_set, int tc_index);
+	if (idx > 0)
+		offset = profile->key_offset[idx - 1] + profile->key_size[idx - 1];
+	else
+		offset = 0;
 
-int dpaa2_setup_flow_dist_size(struct rte_eth_dev *eth_dev,
-		uint64_t req_dist_set, int tc_index, uint16_t dist_size);
+	if (idx > 0) {
+		profile->key_offset[idx] =
+			profile->key_offset[idx - 1] + profile->key_size[idx - 1];
+	} else {
+		profile->key_offset[idx] = 0;
+	}
+	if (ppos)
+		*ppos = profile->key_offset[idx];
+	profile->key_size[idx] = size;
+	profile->key_max_size += size;
+	profile->num++;
+
+	if (ip_addr_num > 0) {
+		memmove(&profile->prot_field[idx + 1],
+			&profile->prot_field[idx],
+			sizeof(struct key_prot_field) * ip_addr_num);
+	}
+	if (poffset)
+		*poffset = offset;
 
-int dpaa2_remove_flow_dist(struct rte_eth_dev *eth_dev,
-			   uint8_t tc_index);
+	if (prot) {
+		rte_memcpy(&profile->prot_field[idx], prot,
+			sizeof(struct key_prot_field));
+	}
 
-int dpaa2_attach_bp_list(struct dpaa2_dev_priv *priv,
-	struct fsl_mc_io *dpni, void *blist);
+	return idx;
+}
+
+static inline void
+dpaa2_dpkg_insert_extract(struct dpkg_profile_cfg *kg_cfg,
+	int idx, const struct dpkg_extract *extract)
+{
+	int i;
 
+	if (idx != kg_cfg->num_extracts) {
+		/* Not the last extract index, must have IP address extract.*/
+		for (i = kg_cfg->num_extracts - 1; i >= idx; i--) {
+			rte_memcpy(&kg_cfg->extracts[i + 1],
+				&kg_cfg->extracts[i], sizeof(struct dpkg_extract));
+		}
+	}
+
+	rte_memcpy(&kg_cfg->extracts[idx], extract, sizeof(struct dpkg_extract));
+	kg_cfg->num_extracts++;
+}
 __rte_internal
 int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 		int eth_rx_queue_id,
@@ -678,7 +842,7 @@ uint16_t dpaa2_dev_tx_multi_txq_ordered(void **queue,
 		struct rte_mbuf **bufs, uint16_t nb_pkts);
 
 void dpaa2_dev_free_eqresp_buf(uint16_t eqresp_ci, struct dpaa2_queue *dpaa2_q);
-void dpaa2_flow_clean(struct rte_eth_dev *dev);
+void dpaa2_flow_clean(struct rte_eth_dev *dev, uint8_t tc_id);
 uint16_t dpaa2_dev_tx_conf(void *txq, int drain);
 
 void
diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index c616857e98..8456b3b80d 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2022 NXP
+ * Copyright 2018-2026 NXP
  */
 
 #include <sys/queue.h>
@@ -16,6 +16,7 @@
 #include <rte_flow_driver.h>
 #include <rte_tailq.h>
 
+#include <eal_export.h>
 #include <fsl_dpni.h>
 #include <fsl_dpkg.h>
 
@@ -23,7 +24,28 @@
 #include <dpaa2_pmd_logs.h>
 #include "dpaa2_parser_decode.h"
 
-static char *dpaa2_flow_control_log;
+#ifndef RTE_DPAA2_ONE_LEVEL_GROUP_FLOW
+#define RTE_DPAA2_ONE_LEVEL_GROUP_FLOW 0
+#endif
+#ifndef RTE_DPAA2_QOS_GROUP_FLOW
+#define RTE_DPAA2_QOS_GROUP_FLOW 1
+#endif
+#ifndef RTE_DPAA2_FS_GROUP_FLOW
+#define RTE_DPAA2_FS_GROUP_FLOW 2
+#endif
+
+#ifndef RTE_DPAA2_FLOW_GROUP_TYPE_GET
+#define RTE_DPAA2_FLOW_GROUP_TYPE_GET(group) \
+	((void)(group), RTE_DPAA2_ONE_LEVEL_GROUP_FLOW)
+#endif
+
+#ifndef RTE_DPAA2_FLOW_GROUP_ID_GET
+#define RTE_DPAA2_FLOW_GROUP_ID_GET(group) (group)
+#endif
+
+static bool dpaa2_flow_control_log;
+
+#define DPAA2_FLOW_QOS_GROUP_ID 0xff
 
 /* Default size of a key */
 #define DPNI_DEFAULT_KEY_SIZE 24
@@ -34,31 +56,61 @@ enum dpaa2_flow_entry_size {
 };
 
 enum dpaa2_flow_dist_type {
-	DPAA2_FLOW_QOS_TYPE = 1 << 0,
-	DPAA2_FLOW_FS_TYPE = 1 << 1
+	DPAA2_FLOW_NULL_TYPE,
+	DPAA2_FLOW_QOS_TYPE,
+	DPAA2_FLOW_FS_TYPE
 };
 
 #define DPAA2_FLOW_RAW_OFFSET_FIELD_SHIFT	16
 #define DPAA2_FLOW_MAX_KEY_SIZE			16
-#define DPAA2_PROT_FIELD_STRING_SIZE		16
+
 #define VXLAN_HF_VNI 0x08
+#define DPAA2_MAX_ACTION_PER_FLOW_NUM 4
 
-struct dpaa2_dev_flow {
-	LIST_ENTRY(dpaa2_dev_flow) next;
-	struct dpni_rule_cfg qos_rule;
-	uint8_t *qos_key_addr;
-	uint8_t *qos_mask_addr;
-	uint16_t qos_rule_size;
-	struct dpni_rule_cfg fs_rule;
-	uint8_t qos_real_key_size;
-	uint8_t fs_real_key_size;
-	uint8_t *fs_key_addr;
-	uint8_t *fs_mask_addr;
-	uint16_t fs_rule_size;
-	uint8_t tc_id; /** Traffic Class ID. */
-	uint8_t tc_index; /** index within this Traffic Class. */
+struct dpaa2_dev_flow_qos_action {
+	enum rte_flow_action_type action_jump_type;
+	struct rte_flow_action_jump action_jump_cfg;
+};
+
+struct dpaa2_dev_flow_fs_action {
 	enum rte_flow_action_type action_type;
 	struct dpni_fs_action_cfg fs_action_cfg;
+	char dst_name[DPNI_FS_REDIR_MAX_NUM][RTE_ETH_NAME_MAX_LEN];
+};
+
+union dpaa2_dev_flow_action {
+	struct dpaa2_dev_flow_qos_action qos_action;
+	struct dpaa2_dev_flow_fs_action fs_action;
+};
+
+struct dpaa2_generic_flow {
+	struct dpni_rule_cfg rule_cfg;
+	uint8_t *key_addr;
+	uint8_t *mask_addr;
+	uint16_t rule_size;
+	uint16_t entry_index;
+	/** This flow has IPv4 or IPv6 extracts.*/
+	enum net_prot ip_key;
+	/** This flow has IPv4 or IPv6 source extract.*/
+	enum net_prot ip_src;
+	/** This flow has IPv4 or IPv6 destination extract.*/
+	enum net_prot ip_dst;
+	struct dpaa2_dev_priv *priv;
+	union {
+		uint8_t tc_id; /** For FS flow only.*/
+		uint8_t flow_id; /** For QoS flow with direct_queue.*/
+	};
+	union dpaa2_dev_flow_action flow_action;
+	int is_rss;
+	int direct_queue;
+};
+
+struct dpaa2_dev_flow {
+	LIST_ENTRY(dpaa2_dev_flow) next;
+	struct dpaa2_generic_flow *qos_flow;
+	struct dpaa2_generic_flow *fs_flow;
+	struct dpaa2_dev_priv *priv;
+	int is_meter_flow;
 };
 
 struct rte_dpaa2_flow_item {
@@ -81,20 +133,18 @@ enum rte_flow_item_type dpaa2_hp_supported_pattern_type[] = {
 	RTE_FLOW_ITEM_TYPE_GTP,
 	RTE_FLOW_ITEM_TYPE_ESP,
 	RTE_FLOW_ITEM_TYPE_AH,
-	RTE_FLOW_ITEM_TYPE_MPLS,
-	RTE_FLOW_ITEM_TYPE_PPPOES,
-	RTE_FLOW_ITEM_TYPE_RAW
+	RTE_FLOW_ITEM_TYPE_RAW,
+	/** Hardware parser supports vlan protocol only.*/
+	RTE_FLOW_ITEM_TYPE_VXLAN
 };
 
 static const
 enum rte_flow_item_type dpaa2_sp_supported_pattern_type[] = {
-	RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ECPRI
+	RTE_FLOW_ITEM_TYPE_ECPRI,
+	RTE_FLOW_ITEM_TYPE_GENEVE
 };
 
-static const
-enum rte_flow_action_type dpaa2_supported_action_type[] = {
-	RTE_FLOW_ACTION_TYPE_END,
+static const enum rte_flow_action_type dpaa2_supported_fs_action_type[] = {
 	RTE_FLOW_ACTION_TYPE_QUEUE,
 	RTE_FLOW_ACTION_TYPE_PORT_ID,
 	RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT,
@@ -102,27 +152,63 @@ enum rte_flow_action_type dpaa2_supported_action_type[] = {
 	RTE_FLOW_ACTION_TYPE_DROP
 };
 
+static const enum rte_flow_action_type dpaa2_supported_qos_action_type[] = {
+	RTE_FLOW_ACTION_TYPE_QUEUE,
+	RTE_FLOW_ACTION_TYPE_JUMP,
+	RTE_FLOW_ACTION_TYPE_DROP
+};
+
+static const enum rte_flow_action_type dpaa2_supported_meter_action_type[] = {
+	RTE_FLOW_ACTION_TYPE_METER_MARK,
+	RTE_FLOW_ACTION_TYPE_METER
+};
+
+#define DPAA2_FLOW_HDR_HEX_DUMP_SIZE \
+	(RTE_MAX(sizeof(struct rte_flow_item_eth), \
+	RTE_MAX(sizeof(struct rte_flow_item_vlan), \
+	RTE_MAX(sizeof(struct rte_flow_item_ipv4), \
+	RTE_MAX(sizeof(struct rte_flow_item_ipv6), \
+	RTE_MAX(sizeof(struct rte_flow_item_icmp), \
+	RTE_MAX(sizeof(struct rte_flow_item_udp), \
+	RTE_MAX(sizeof(struct rte_flow_item_tcp), \
+	RTE_MAX(sizeof(struct rte_flow_item_sctp), \
+	RTE_MAX(sizeof(struct rte_flow_item_gre), \
+	RTE_MAX(sizeof(struct rte_flow_item_ah), \
+	RTE_MAX(sizeof(struct rte_flow_item_esp), \
+	RTE_MAX(sizeof(struct rte_flow_item_vxlan), \
+	RTE_MAX(sizeof(struct rte_flow_item_ecpri), \
+	sizeof(struct rte_flow_item_gtp)))))))))))))) * 10)
+
+
 #ifndef __cplusplus
 static const struct rte_flow_item_eth dpaa2_flow_item_eth_mask = {
-	.hdr.dst_addr.addr_bytes = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
-	.hdr.src_addr.addr_bytes = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
-	.hdr.ether_type = RTE_BE16(0xffff),
+	.dst.addr_bytes = "\xff\xff\xff\xff\xff\xff",
+	.src.addr_bytes = "\xff\xff\xff\xff\xff\xff",
+	.type = RTE_BE16(0xffff),
 };
 
 static const struct rte_flow_item_vlan dpaa2_flow_item_vlan_mask = {
-	.hdr.vlan_tci = RTE_BE16(0xffff),
+	.tci = RTE_BE16(0xffff),
 };
 
 static const struct rte_flow_item_ipv4 dpaa2_flow_item_ipv4_mask = {
 	.hdr.src_addr = RTE_BE32(0xffffffff),
 	.hdr.dst_addr = RTE_BE32(0xffffffff),
 	.hdr.next_proto_id = 0xff,
+	.hdr.packet_id = 0xffff,
+	.hdr.fragment_offset = 0xffff,
 };
 
 static const struct rte_flow_item_ipv6 dpaa2_flow_item_ipv6_mask = {
 	.hdr = {
-		.src_addr = RTE_IPV6_MASK_FULL,
-		.dst_addr = RTE_IPV6_MASK_FULL,
+		.src_addr = {
+			"\xff\xff\xff\xff\xff\xff\xff\xff"
+			"\xff\xff\xff\xff\xff\xff\xff\xff"
+		},
+		.dst_addr = {
+			"\xff\xff\xff\xff\xff\xff\xff\xff"
+			"\xff\xff\xff\xff\xff\xff\xff\xff"
+		},
 		.proto = 0xff
 	},
 };
@@ -170,7 +256,12 @@ static const struct rte_flow_item_gre dpaa2_flow_item_gre_mask = {
 
 static const struct rte_flow_item_vxlan dpaa2_flow_item_vxlan_mask = {
 	.flags = 0xff,
-	.vni = { 0xff, 0xff, 0xff },
+	.vni = "\xff\xff\xff",
+};
+
+static const struct rte_flow_item_geneve dpaa2_flow_item_geneve_mask = {
+	.protocol = RTE_BE16(0xffff),
+	.vni = "\xff\xff\xff",
 };
 
 static const struct rte_flow_item_ecpri dpaa2_flow_item_ecpri_mask = {
@@ -184,253 +275,182 @@ static const struct rte_flow_item_gtp dpaa2_flow_item_gtp_mask = {
 	.teid = RTE_BE32(0xffffffff),
 };
 
-static const struct rte_flow_item_mpls dpaa2_flow_item_mpls_mask = {
-	.label_tc_s = { 0xff, 0xff, 0xff },
-};
-
-static const struct rte_flow_item_pppoe dpaa2_flow_item_pppoe_mask = {
-	.session_id = RTE_BE16(0xffff),
-};
-
 #endif
 
+static inline uint8_t
+dpaa2_flow_entry_map_get(const uint8_t *entry_map,
+	uint16_t index)
+{
+	uint16_t byte_pos = index / 8;
+	uint16_t bit_pos = index % 8;
 
-#define DPAA2_FLOW_DUMP printf
+	return entry_map[byte_pos] & (1 << bit_pos);
+}
 
 static inline void
-dpaa2_prot_field_string(uint32_t prot, uint32_t field,
-	char *string)
+dpaa2_flow_entry_map_set(uint8_t *entry_map,
+	uint16_t index, int set)
 {
-	if (!dpaa2_flow_control_log)
-		return;
+	uint16_t byte_pos = index / 8;
+	uint16_t bit_pos = index % 8;
 
-	if (prot == NET_PROT_ETH) {
-		strcpy(string, "eth");
-		if (field == NH_FLD_ETH_DA)
-			strcat(string, ".dst");
-		else if (field == NH_FLD_ETH_SA)
-			strcat(string, ".src");
-		else if (field == NH_FLD_ETH_TYPE)
-			strcat(string, ".type");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_VLAN) {
-		strcpy(string, "vlan");
-		if (field == NH_FLD_VLAN_TCI)
-			strcat(string, ".tci");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_IP) {
-		strcpy(string, "ip");
-		if (field == NH_FLD_IP_SRC)
-			strcat(string, ".src");
-		else if (field == NH_FLD_IP_DST)
-			strcat(string, ".dst");
-		else if (field == NH_FLD_IP_PROTO)
-			strcat(string, ".proto");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_TCP) {
-		strcpy(string, "tcp");
-		if (field == NH_FLD_TCP_PORT_SRC)
-			strcat(string, ".src");
-		else if (field == NH_FLD_TCP_PORT_DST)
-			strcat(string, ".dst");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_UDP) {
-		strcpy(string, "udp");
-		if (field == NH_FLD_UDP_PORT_SRC)
-			strcat(string, ".src");
-		else if (field == NH_FLD_UDP_PORT_DST)
-			strcat(string, ".dst");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_ICMP) {
-		strcpy(string, "icmp");
-		if (field == NH_FLD_ICMP_TYPE)
-			strcat(string, ".type");
-		else if (field == NH_FLD_ICMP_CODE)
-			strcat(string, ".code");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_SCTP) {
-		strcpy(string, "sctp");
-		if (field == NH_FLD_SCTP_PORT_SRC)
-			strcat(string, ".src");
-		else if (field == NH_FLD_SCTP_PORT_DST)
-			strcat(string, ".dst");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_GRE) {
-		strcpy(string, "gre");
-		if (field == NH_FLD_GRE_TYPE)
-			strcat(string, ".type");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_GTP) {
-		rte_strscpy(string, "gtp", DPAA2_PROT_FIELD_STRING_SIZE);
-		if (field == NH_FLD_GTP_TEID)
-			strcat(string, ".teid");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_IPSEC_ESP) {
-		rte_strscpy(string, "esp", DPAA2_PROT_FIELD_STRING_SIZE);
-		if (field == NH_FLD_IPSEC_ESP_SPI)
-			strcat(string, ".spi");
-		else if (field == NH_FLD_IPSEC_ESP_SEQUENCE_NUM)
-			strcat(string, ".seq");
-		else
-			strcat(string, ".unknown field");
-	} else {
-		sprintf(string, "unknown protocol(%d)", prot);
-	}
+	if (set)
+		entry_map[byte_pos] |= (1 << bit_pos);
+	else
+		entry_map[byte_pos] &= ~(((uint8_t)1) << bit_pos);
 }
 
 static inline void
-dpaa2_flow_qos_extracts_log(const struct dpaa2_dev_priv *priv)
+dpaa2_flow_extracts_log(const struct dpaa2_dev_priv *priv,
+	const char *prefix, uint8_t tc_id)
 {
-	int idx;
-	char string[32];
-	const struct dpkg_profile_cfg *dpkg =
-		&priv->extract.qos_key_extract.dpkg;
-	const struct dpkg_extract *extract;
-	enum dpkg_extract_type type;
-	enum net_prot prot;
-	uint32_t field;
+	char string[1024];
+	const struct dpaa2_flow_tbl_profile *tbl_profile;
+	int offset = 0;
 
 	if (!dpaa2_flow_control_log)
 		return;
 
-	DPAA2_FLOW_DUMP("QoS table: %d extracts\r\n",
-		dpkg->num_extracts);
-	for (idx = 0; idx < dpkg->num_extracts; idx++) {
-		extract = &dpkg->extracts[idx];
-		type = extract->type;
-		if (type == DPKG_EXTRACT_FROM_HDR) {
-			prot = extract->extract.from_hdr.prot;
-			field = extract->extract.from_hdr.field;
-			dpaa2_prot_field_string(prot, field,
-				string);
-		} else if (type == DPKG_EXTRACT_FROM_DATA) {
-			sprintf(string, "raw offset/len: %d/%d",
-				extract->extract.from_data.offset,
-				extract->extract.from_data.size);
-		} else if (type == DPKG_EXTRACT_FROM_PARSE) {
-			sprintf(string, "parse offset/len: %d/%d",
-				extract->extract.from_parse.offset,
-				extract->extract.from_parse.size);
-		}
-		DPAA2_FLOW_DUMP("%s", string);
-		if ((idx + 1) < dpkg->num_extracts)
-			DPAA2_FLOW_DUMP(" / ");
-	}
-	DPAA2_FLOW_DUMP("\r\n");
+	offset += sprintf(&string[offset],
+		"%s's", priv->eth_dev->data->name);
+	if (tc_id >= MAX_TCS) {
+		tbl_profile = &priv->flow_profile.qos_profile;
+		offset += sprintf(&string[offset], " QoS");
+	} else {
+		tbl_profile = &priv->flow_profile.tc_profile[tc_id];
+		offset += sprintf(&string[offset], " FS[%d]", tc_id);
+	}
+	offset += sprintf(&string[offset],
+		" table: %d extracts/%d entries\n",
+		tbl_profile->dpkg.num_extracts, tbl_profile->entry_num);
+	DPAA2_FLOW_DUMP("\n%s %s", prefix, string);
+	dpaa2_dump_dpkg(&tbl_profile->dpkg);
 }
 
 static inline void
-dpaa2_flow_fs_extracts_log(const struct dpaa2_dev_priv *priv,
-	int tc_id)
+dpaa2_flow_qos_entry_log(const char *log_info,
+	const struct dpaa2_generic_flow *flow)
 {
 	int idx;
-	char string[32];
-	const struct dpkg_profile_cfg *dpkg =
-		&priv->extract.tc_key_extract[tc_id].dpkg;
-	const struct dpkg_extract *extract;
-	enum dpkg_extract_type type;
-	enum net_prot prot;
-	uint32_t field;
+	struct rte_eth_dev *dev = flow->priv->eth_dev;
 
 	if (!dpaa2_flow_control_log)
 		return;
 
-	DPAA2_FLOW_DUMP("FS table: %d extracts in TC[%d]\r\n",
-		dpkg->num_extracts, tc_id);
-	for (idx = 0; idx < dpkg->num_extracts; idx++) {
-		extract = &dpkg->extracts[idx];
-		type = extract->type;
-		if (type == DPKG_EXTRACT_FROM_HDR) {
-			prot = extract->extract.from_hdr.prot;
-			field = extract->extract.from_hdr.field;
-			dpaa2_prot_field_string(prot, field,
-				string);
-		} else if (type == DPKG_EXTRACT_FROM_DATA) {
-			sprintf(string, "raw offset/len: %d/%d",
-				extract->extract.from_data.offset,
-				extract->extract.from_data.size);
-		} else if (type == DPKG_EXTRACT_FROM_PARSE) {
-			sprintf(string, "parse offset/len: %d/%d",
-				extract->extract.from_parse.offset,
-				extract->extract.from_parse.size);
-		}
-		DPAA2_FLOW_DUMP("%s", string);
-		if ((idx + 1) < dpkg->num_extracts)
-			DPAA2_FLOW_DUMP(" / ");
-	}
-	DPAA2_FLOW_DUMP("\r\n");
+	DPAA2_FLOW_DUMP("%s: %s QoS entry[%d](size %d/%d) to select TC[%d]\n",
+		dev->data->name, log_info, flow->entry_index, flow->rule_size,
+		flow->rule_cfg.key_size,
+		flow->flow_action.qos_action.action_jump_cfg.group);
+
+	DPAA2_FLOW_DUMP("key:\r\n");
+	for (idx = 0; idx < flow->rule_size; idx++)
+		DPAA2_FLOW_DUMP("%02x ", flow->key_addr[idx]);
+
+	DPAA2_FLOW_DUMP("\r\nmask:\r\n");
+	for (idx = 0; idx < flow->rule_size; idx++)
+		DPAA2_FLOW_DUMP("%02x ", flow->mask_addr[idx]);
+	DPAA2_FLOW_DUMP("\r\n\n");
 }
 
 static inline void
-dpaa2_flow_qos_entry_log(const char *log_info,
-	const struct dpaa2_dev_flow *flow, int qos_index)
+dpaa2_flow_fs_entry_log(const char *log_info,
+	const struct dpaa2_generic_flow *flow)
 {
 	int idx;
-	uint8_t *key, *mask;
+	struct rte_eth_dev *dev = flow->priv->eth_dev;
+	const struct dpaa2_dev_flow_fs_action *fs_action;
 
 	if (!dpaa2_flow_control_log)
 		return;
 
-	if (qos_index >= 0) {
-		DPAA2_FLOW_DUMP("%s QoS entry[%d](size %d/%d) for TC[%d]\r\n",
-			log_info, qos_index, flow->qos_rule_size,
-			flow->qos_rule.key_size,
-			flow->tc_id);
-	} else {
-		DPAA2_FLOW_DUMP("%s QoS entry(size %d/%d) for TC[%d]\r\n",
-			log_info, flow->qos_rule_size,
-			flow->qos_rule.key_size,
-			flow->tc_id);
-	}
+	DPAA2_FLOW_DUMP("%s: %s FS[%d]/entry[%d](size %d/%d)\r\n",
+		dev->data->name, log_info, flow->tc_id,
+		flow->entry_index, flow->rule_size,
+		flow->rule_cfg.key_size);
 
-	key = flow->qos_key_addr;
-	mask = flow->qos_mask_addr;
+	fs_action = &flow->flow_action.fs_action;
 
 	DPAA2_FLOW_DUMP("key:\r\n");
-	for (idx = 0; idx < flow->qos_rule_size; idx++)
-		DPAA2_FLOW_DUMP("%02x ", key[idx]);
+	for (idx = 0; idx < flow->rule_size; idx++)
+		DPAA2_FLOW_DUMP("%02x ", flow->key_addr[idx]);
 
 	DPAA2_FLOW_DUMP("\r\nmask:\r\n");
-	for (idx = 0; idx < flow->qos_rule_size; idx++)
-		DPAA2_FLOW_DUMP("%02x ", mask[idx]);
-	DPAA2_FLOW_DUMP("\r\n");
+	for (idx = 0; idx < flow->rule_size; idx++)
+		DPAA2_FLOW_DUMP("%02x ", flow->mask_addr[idx]);
+	DPAA2_FLOW_DUMP("\r\nAction: ");
+	if (fs_action->action_type == RTE_FLOW_ACTION_TYPE_QUEUE) {
+		DPAA2_FLOW_DUMP("Receive to flow%d\r\n\n",
+			fs_action->fs_action_cfg.flow_id);
+	} else if (fs_action->action_type == RTE_FLOW_ACTION_TYPE_PORT_ID ||
+		fs_action->action_type == RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT) {
+		DPAA2_FLOW_DUMP("Re-direct to port(s): ");
+		for (idx = 0; idx < fs_action->fs_action_cfg.num_tokens; idx++) {
+			DPAA2_FLOW_DUMP("%s", fs_action->dst_name[idx]);
+			if ((idx + 1) < fs_action->fs_action_cfg.num_tokens)
+				DPAA2_FLOW_DUMP(", ");
+		}
+		DPAA2_FLOW_DUMP("\r\n");
+	} else if (fs_action->action_type == RTE_FLOW_ACTION_TYPE_DROP) {
+		DPAA2_FLOW_DUMP("Drop\r\n\n");
+	} else {
+		DPAA2_FLOW_DUMP("Un-supported action type(%d)\r\n\n",
+			fs_action->action_type);
+	}
 }
 
 static inline void
-dpaa2_flow_fs_entry_log(const char *log_info,
-	const struct dpaa2_dev_flow *flow)
+dpaa2_dump_extract_map(const struct dpaa2_dev_priv *priv,
+	const char *prefix, enum dpaa2_flow_dist_type dist_type,
+	uint8_t group)
 {
-	int idx;
-	uint8_t *key, *mask;
+	int idx, offset = 0;
+	char string[2048];
+	const struct dpaa2_flow_tbl_profile *tbl_profile;
 
 	if (!dpaa2_flow_control_log)
 		return;
 
-	DPAA2_FLOW_DUMP("%s FS/TC entry[%d](size %d/%d) of TC[%d]\r\n",
-		log_info, flow->tc_index,
-		flow->fs_rule_size, flow->fs_rule.key_size,
-		flow->tc_id);
+	DPAA2_FLOW_DUMP("%s: %s\n", priv->eth_dev->data->name, prefix);
 
-	key = flow->fs_key_addr;
-	mask = flow->fs_mask_addr;
+	if (dist_type == DPAA2_FLOW_QOS_TYPE) {
+		tbl_profile = &priv->flow_profile.qos_profile;
+		offset += sprintf(&string[offset], "QoS entry map:");
+		if (!tbl_profile->entry_num) {
+			offset += sprintf(&string[offset], " empty\n");
+			goto qos_dump_end;
+		} else {
+			offset += sprintf(&string[offset], "\n");
+		}
+		for (idx = 0; idx < priv->qos_entries; idx++) {
+			offset += sprintf(&string[offset], "%d ",
+				dpaa2_flow_entry_map_get(tbl_profile->entry_map, idx) ?
+					1 : 0);
+			if (!((idx + 1) % 16) || (idx + 1) == priv->qos_entries)
+				offset += sprintf(&string[offset], "\n");
+		}
 
-	DPAA2_FLOW_DUMP("key:\r\n");
-	for (idx = 0; idx < flow->fs_rule_size; idx++)
-		DPAA2_FLOW_DUMP("%02x ", key[idx]);
+qos_dump_end:
+		DPAA2_FLOW_DUMP("%s\n", string);
 
-	DPAA2_FLOW_DUMP("\r\nmask:\r\n");
-	for (idx = 0; idx < flow->fs_rule_size; idx++)
-		DPAA2_FLOW_DUMP("%02x ", mask[idx]);
-	DPAA2_FLOW_DUMP("\r\n");
+		return;
+	}
+
+	tbl_profile = &priv->flow_profile.tc_profile[group];
+	if (!tbl_profile->entry_num) {
+		DPAA2_FLOW_DUMP("FS[%d] table is empty\n\n", group);
+		return;
+	}
+
+	offset = sprintf(&string[offset],
+		"FS[%d] %d entries:\n", group, tbl_profile->entry_num);
+	for (idx = 0; idx < priv->fs_entries; idx++) {
+		offset += sprintf(&string[offset], "%d ",
+			dpaa2_flow_entry_map_get(tbl_profile->entry_map, idx) ?
+			1 : 0);
+		if (!((idx + 1) % 16) || (idx + 1) == priv->fs_entries)
+			offset += sprintf(&string[offset], "\n");
+	}
+	DPAA2_FLOW_DUMP("%s\n", string);
 }
 
 static int
@@ -487,272 +507,481 @@ dpaa2_flow_l4_dst_port_extract(enum net_prot prot,
 	return false;
 }
 
+static int
+dpaa2_flow_rss_conf_to_item(uint64_t req_dist_set,
+	struct rte_flow_item *items, uint8_t *spec_buf,
+	uint32_t buf_max)
+{
+	uint32_t i = 0, offset = 0;
+	uint64_t l2_mask, vlan_mask, ipv4_mask, ipv6_mask;
+	uint64_t dist_supported, udp_mask, tcp_mask, sctp_mask;
+	struct rte_flow_item_eth *eth = NULL;
+	struct rte_flow_item_pppoe *pppoe = NULL;
+	struct rte_flow_item_esp *esp = NULL;
+	struct rte_flow_item_ah *ah = NULL;
+	struct rte_flow_item_vlan *vlan = NULL;
+	struct rte_flow_item_mpls *mpls = NULL;
+	struct rte_flow_item_gtp *gtpu = NULL;
+	struct rte_flow_item_udp *udp = NULL;
+	struct rte_flow_item_tcp *tcp = NULL;
+	struct rte_flow_item_sctp *sctp = NULL;
+	struct rte_flow_item_ipv4 *ipv4 = NULL;
+
+	l2_mask = RTE_ETH_RSS_L2_PAYLOAD | RTE_ETH_RSS_ETH;
+	vlan_mask = RTE_ETH_RSS_C_VLAN | RTE_ETH_RSS_S_VLAN;
+	ipv4_mask = RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4 |
+		RTE_ETH_RSS_NONFRAG_IPV4_OTHER;
+	ipv6_mask = RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6 |
+		RTE_ETH_RSS_IPV6_EX | RTE_ETH_RSS_NONFRAG_IPV6_OTHER;
+	udp_mask = RTE_ETH_RSS_NONFRAG_IPV4_UDP |
+		RTE_ETH_RSS_NONFRAG_IPV6_UDP |
+		RTE_ETH_RSS_IPV6_UDP_EX;
+	tcp_mask = RTE_ETH_RSS_NONFRAG_IPV4_TCP |
+		RTE_ETH_RSS_NONFRAG_IPV6_TCP |
+		RTE_ETH_RSS_IPV6_TCP_EX;
+	sctp_mask = RTE_ETH_RSS_NONFRAG_IPV4_SCTP |
+		RTE_ETH_RSS_NONFRAG_IPV6_SCTP;
+	dist_supported = l2_mask | vlan_mask | ipv4_mask |
+		ipv6_mask | udp_mask | tcp_mask | sctp_mask |
+		RTE_ETH_RSS_GTPU | RTE_ETH_RSS_PPPOE |
+		RTE_ETH_RSS_ESP | RTE_ETH_RSS_AH | RTE_ETH_RSS_MPLS;
+	if (~dist_supported & req_dist_set) {
+		DPAA2_PMD_ERR("%s: Unsupported dist type:0x%" PRIx64,
+			__func__, (~dist_supported) & req_dist_set);
+		return -ENOTSUP;
+	}
+
+	if (req_dist_set & l2_mask) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_ETH;
+		eth = (void *)(spec_buf + offset);
+		memset(eth, 0, sizeof(struct rte_flow_item_eth));
+		memset(eth->dst.addr_bytes, 0xff, RTE_ETHER_ADDR_LEN);
+		memset(eth->src.addr_bytes, 0xff, RTE_ETHER_ADDR_LEN);
+		eth->type = RTE_BE16(0xffff);
+		items[i].spec = eth;
+		items[i].mask = eth;
+		i++;
+		offset += sizeof(struct rte_flow_item_eth);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & RTE_ETH_RSS_PPPOE) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_PPPOES;
+		pppoe = (void *)(spec_buf + offset);
+		memset(pppoe, 0, sizeof(struct rte_flow_item_pppoe));
+		pppoe->session_id = RTE_BE16(0xffff);
+		items[i].spec = pppoe;
+		items[i].mask = pppoe;
+		i++;
+		offset += sizeof(struct rte_flow_item_pppoe);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & RTE_ETH_RSS_ESP) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_ESP;
+		esp = (void *)(spec_buf + offset);
+		memset(esp, 0, sizeof(struct rte_flow_item_esp));
+		esp->hdr.spi = RTE_BE32(0xffffffff);
+		items[i].spec = esp;
+		items[i].mask = esp;
+		i++;
+		offset += sizeof(struct rte_flow_item_esp);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & RTE_ETH_RSS_AH) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_AH;
+		ah = (void *)(spec_buf + offset);
+		memset(ah, 0, sizeof(struct rte_flow_item_ah));
+		ah->spi = RTE_BE32(0xffffffff);
+		items[i].spec = ah;
+		items[i].mask = ah;
+		i++;
+		offset += sizeof(struct rte_flow_item_ah);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & vlan_mask) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_VLAN;
+		vlan = (void *)(spec_buf + offset);
+		memset(vlan, 0, sizeof(struct rte_flow_item_vlan));
+		vlan->tci = RTE_BE16(0xffff);
+		items[i].spec = vlan;
+		items[i].mask = vlan;
+		i++;
+		offset += sizeof(struct rte_flow_item_vlan);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & RTE_ETH_RSS_MPLS) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_MPLS;
+		mpls = (void *)(spec_buf + offset);
+		memset(mpls, 0, sizeof(struct rte_flow_item_mpls));
+		memset(mpls->label_tc_s, 0xff, 3);
+		items[i].spec = mpls;
+		items[i].mask = mpls;
+		i++;
+		offset += sizeof(struct rte_flow_item_mpls);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & RTE_ETH_RSS_GTPU) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_GTPU;
+		gtpu = (void *)(spec_buf + offset);
+		memset(gtpu, 0, sizeof(struct rte_flow_item_gtp));
+		gtpu->teid = RTE_BE32(0xffffffff);
+		items[i].spec = gtpu;
+		items[i].mask = gtpu;
+		i++;
+		offset += sizeof(struct rte_flow_item_gtp);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & udp_mask) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_UDP;
+		udp = (void *)(spec_buf + offset);
+		memset(udp, 0, sizeof(struct rte_flow_item_udp));
+		udp->hdr.src_port = RTE_BE16(0xffff);
+		udp->hdr.dst_port = RTE_BE16(0xffff);
+		items[i].spec = udp;
+		items[i].mask = udp;
+		i++;
+		offset += sizeof(struct rte_flow_item_udp);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & tcp_mask) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_TCP;
+		tcp = (void *)(spec_buf + offset);
+		memset(tcp, 0, sizeof(struct rte_flow_item_tcp));
+		tcp->hdr.src_port = RTE_BE16(0xffff);
+		tcp->hdr.dst_port = RTE_BE16(0xffff);
+		items[i].spec = tcp;
+		items[i].mask = tcp;
+		i++;
+		offset += sizeof(struct rte_flow_item_tcp);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & sctp_mask) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_SCTP;
+		sctp = (void *)(spec_buf + offset);
+		memset(sctp, 0, sizeof(struct rte_flow_item_sctp));
+		sctp->hdr.src_port = RTE_BE16(0xffff);
+		sctp->hdr.dst_port = RTE_BE16(0xffff);
+		items[i].spec = sctp;
+		items[i].mask = sctp;
+		i++;
+		offset += sizeof(struct rte_flow_item_sctp);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & ipv4_mask) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_IPV4;
+		ipv4 = (void *)(spec_buf + offset);
+		memset(ipv4, 0, sizeof(struct rte_flow_item_ipv4));
+		ipv4->hdr.src_addr = RTE_BE32(0xffffffff);
+		ipv4->hdr.dst_addr = RTE_BE32(0xffffffff);
+		ipv4->hdr.next_proto_id = 0xff;
+		items[i].spec = ipv4;
+		items[i].mask = ipv4;
+		i++;
+		offset += sizeof(struct rte_flow_item_ipv4);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	items[i].type = RTE_FLOW_ITEM_TYPE_END;
+
+	return i;
+}
+
 static int
 dpaa2_flow_add_qos_rule(struct dpaa2_dev_priv *priv,
-	struct dpaa2_dev_flow *flow)
+	struct dpaa2_generic_flow *flow)
 {
-	uint16_t qos_index;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 	int ret;
 	struct fsl_mc_io *dpni = priv->hw;
+	uint8_t flags = DPNI_QOS_OPT_SET_TC_ONLY, flow_id = 0;
 
-	if (priv->num_rx_tc <= 1 &&
-		flow->action_type != RTE_FLOW_ACTION_TYPE_RSS) {
-		DPAA2_PMD_WARN("No QoS Table for FS");
+	if (flow->entry_index >= priv->qos_entries) {
+		DPAA2_PMD_ERR("QoS table full(%d >= %d)",
+			flow->entry_index, priv->qos_entries);
+		return -EINVAL;
+	}
+	tbl_profile = &priv->flow_profile.qos_profile;
+	if (dpaa2_flow_entry_map_get(tbl_profile->entry_map,
+		flow->entry_index)) {
+		DPAA2_PMD_ERR("QoS entry[%d] has been occupied",
+			flow->entry_index);
 		return -EINVAL;
 	}
 
-	/* QoS entry added is only effective for multiple TCs.*/
-	qos_index = flow->tc_id * priv->fs_entries + flow->tc_index;
-	if (qos_index >= priv->qos_entries) {
-		DPAA2_PMD_ERR("QoS table full(%d >= %d)",
-			qos_index, priv->qos_entries);
+	if (flow->flow_action.qos_action.action_jump_type !=
+		RTE_FLOW_ACTION_TYPE_JUMP) {
+		DPAA2_PMD_ERR("QoS entry[%d]'jump action not set(%d)",
+			flow->entry_index,
+			flow->flow_action.qos_action.action_jump_type);
+		return -EINVAL;
+	}
+	if (flow->flow_action.qos_action.action_jump_cfg.group >=
+		priv->num_rx_tc) {
+		DPAA2_PMD_ERR("QoS entry[%d]'dest table ID(%d) >= max(%d)",
+			flow->entry_index,
+			flow->flow_action.qos_action.action_jump_cfg.group,
+			priv->num_rx_tc);
 		return -EINVAL;
 	}
 
-	dpaa2_flow_qos_entry_log("Start add", flow, qos_index);
+	dpaa2_flow_qos_entry_log("Add", flow);
 
+	if (flow->direct_queue) {
+		flags |= DPNI_QOS_OPT_SET_FLOW_ID;
+		flow_id = flow->flow_id;
+	}
 	ret = dpni_add_qos_entry(dpni, CMD_PRI_LOW,
-			priv->token, &flow->qos_rule,
-			flow->tc_id, qos_index,
-			0, 0);
+			priv->token, &flow->rule_cfg,
+			flow->flow_action.qos_action.action_jump_cfg.group,
+			flow->entry_index, flags, flow_id);
 	if (ret < 0) {
 		DPAA2_PMD_ERR("Add entry(%d) to table(%d) failed",
-			qos_index, flow->tc_id);
+			flow->entry_index,
+			flow->flow_action.qos_action.action_jump_cfg.group);
 		return ret;
 	}
+	dpaa2_flow_entry_map_set(tbl_profile->entry_map, flow->entry_index, 1);
+	tbl_profile->entry_num++;
 
 	return 0;
 }
 
 static int
 dpaa2_flow_add_fs_rule(struct dpaa2_dev_priv *priv,
-	struct dpaa2_dev_flow *flow)
+	struct dpaa2_generic_flow *flow)
 {
+	struct rte_dpaa2_device *dpaa2_dev;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 	int ret;
 	struct fsl_mc_io *dpni = priv->hw;
 
-	if (flow->tc_index >= priv->fs_entries) {
-		DPAA2_PMD_ERR("FS table full(%d >= %d)",
-			flow->tc_index, priv->fs_entries);
+	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
+
+	tbl_profile = &priv->flow_profile.tc_profile[flow->tc_id];
+	if (dpaa2_flow_entry_map_get(tbl_profile->entry_map,
+		flow->entry_index)) {
+		DPAA2_PMD_ERR("FS[%d].entry[%d] has been occupied",
+			flow->tc_id, flow->entry_index);
 		return -EINVAL;
 	}
 
-	dpaa2_flow_fs_entry_log("Start add", flow);
+	dpaa2_flow_fs_entry_log("Add", flow);
 
-	ret = dpni_add_fs_entry(dpni, CMD_PRI_LOW,
-			priv->token, flow->tc_id,
-			flow->tc_index, &flow->fs_rule,
-			&flow->fs_action_cfg);
+	if (dpaa2_dev->bus_info->mc_rev >= DPAA2_FLOW_FRM_REPLICATION_ACTION_MC_REV) {
+		ret = dpni_add_fs_entry(dpni, CMD_PRI_LOW,
+			priv->token, flow->tc_id, flow->entry_index,
+			&flow->rule_cfg, &flow->flow_action.fs_action.fs_action_cfg);
+	} else {
+		ret = dpni_add_fs_entry_legacy(dpni, CMD_PRI_LOW,
+			priv->token, flow->tc_id, flow->entry_index,
+			&flow->rule_cfg, &flow->flow_action.fs_action.fs_action_cfg);
+	}
 	if (ret < 0) {
 		DPAA2_PMD_ERR("Add rule(%d) to FS table(%d) failed",
-			flow->tc_index, flow->tc_id);
+			flow->entry_index, flow->tc_id);
 		return ret;
 	}
 
+	dpaa2_flow_entry_map_set(tbl_profile->entry_map, flow->entry_index, 1);
+	tbl_profile->entry_num++;
+
 	return 0;
 }
 
 static int
-dpaa2_flow_rule_insert_hole(struct dpaa2_dev_flow *flow,
-	int offset, int size,
-	enum dpaa2_flow_dist_type dist_type)
+dpaa2_flow_update_qos_rule_action(struct dpaa2_dev_priv *priv,
+	struct dpaa2_generic_flow *flow)
 {
-	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-		if (offset < flow->qos_rule_size) {
-			memmove(flow->qos_key_addr + offset + size,
-					flow->qos_key_addr + offset,
-					flow->qos_rule_size - offset);
-			memset(flow->qos_key_addr + offset,
-					0, size);
-
-			memmove(flow->qos_mask_addr + offset + size,
-					flow->qos_mask_addr + offset,
-					flow->qos_rule_size - offset);
-			memset(flow->qos_mask_addr + offset,
-					0, size);
-			flow->qos_rule_size += size;
-		} else {
-			flow->qos_rule_size = offset + size;
-		}
+	int ret;
+	struct fsl_mc_io *dpni = priv->hw;
+	uint8_t flags = DPNI_QOS_OPT_UPDATE_IF_EXISTS, flow_id = 0;
+
+	dpaa2_flow_qos_entry_log("Update action", flow);
+
+	if (flow->direct_queue) {
+		flags |= DPNI_QOS_OPT_SET_FLOW_ID;
+		flow_id = flow->flow_id;
 	}
 
-	if (dist_type & DPAA2_FLOW_FS_TYPE) {
-		if (offset < flow->fs_rule_size) {
-			memmove(flow->fs_key_addr + offset + size,
-					flow->fs_key_addr + offset,
-					flow->fs_rule_size - offset);
-			memset(flow->fs_key_addr + offset,
-					0, size);
-
-			memmove(flow->fs_mask_addr + offset + size,
-					flow->fs_mask_addr + offset,
-					flow->fs_rule_size - offset);
-			memset(flow->fs_mask_addr + offset,
-					0, size);
-			flow->fs_rule_size += size;
-		} else {
-			flow->fs_rule_size = offset + size;
-		}
+	/** This option doesn't support legacy operation.*/
+	ret = dpni_add_qos_entry(dpni, CMD_PRI_LOW,
+			priv->token, &flow->rule_cfg,
+			flow->flow_action.qos_action.action_jump_cfg.group,
+			flow->entry_index,
+			flags, flow_id);
+	if (ret < 0) {
+		DPAA2_PMD_ERR("Update rule(%d) in QOS table failed(%d)",
+			flow->entry_index, ret);
+		return ret;
 	}
 
 	return 0;
 }
 
 static int
-dpaa2_flow_rule_add_all(struct dpaa2_dev_priv *priv,
-	enum dpaa2_flow_dist_type dist_type,
-	uint16_t entry_size, uint8_t tc_id)
+dpaa2_flow_update_fs_rule_action(struct dpaa2_dev_priv *priv,
+	struct dpaa2_generic_flow *flow)
 {
-	struct dpaa2_dev_flow *curr = LIST_FIRST(&priv->flows);
 	int ret;
+	struct fsl_mc_io *dpni = priv->hw;
+	struct dpni_fs_action_cfg *cfg;
 
-	while (curr) {
-		if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-			if (priv->num_rx_tc > 1 ||
-				curr->action_type ==
-				RTE_FLOW_ACTION_TYPE_RSS) {
-				curr->qos_rule.key_size = entry_size;
-				ret = dpaa2_flow_add_qos_rule(priv, curr);
-				if (ret)
-					return ret;
-			}
-		}
-		if (dist_type & DPAA2_FLOW_FS_TYPE &&
-			curr->tc_id == tc_id) {
-			curr->fs_rule.key_size = entry_size;
-			ret = dpaa2_flow_add_fs_rule(priv, curr);
-			if (ret)
-				return ret;
-		}
-		curr = LIST_NEXT(curr, next);
+	dpaa2_flow_fs_entry_log("Update action", flow);
+
+	cfg = &flow->flow_action.fs_action.fs_action_cfg;
+	cfg->options |= DPNI_FS_OPT_UPDATE_IF_EXISTS;
+	/** This option doesn't support legacy operation.*/
+	ret = dpni_add_fs_entry(dpni, CMD_PRI_LOW,
+		priv->token, flow->tc_id, flow->entry_index,
+		&flow->rule_cfg, cfg);
+	if (ret < 0) {
+		DPAA2_PMD_ERR("Update rule(%d) in FS table(%d) failed",
+			flow->entry_index, flow->tc_id);
+		return ret;
 	}
 
 	return 0;
 }
 
 static int
-dpaa2_flow_qos_rule_insert_hole(struct dpaa2_dev_priv *priv,
+_dpaa2_flow_rule_insert_hole(struct dpaa2_generic_flow *flow,
 	int offset, int size)
 {
-	struct dpaa2_dev_flow *curr;
-	int ret;
-
-	curr = priv->curr;
-	if (!curr) {
-		DPAA2_PMD_ERR("Current qos flow insert hole failed.");
-		return -EINVAL;
+	if (offset < flow->rule_size) {
+		memmove(flow->key_addr + offset + size,
+			flow->key_addr + offset,
+			flow->rule_size - offset);
+		memset(flow->key_addr + offset, 0, size);
+
+		memmove(flow->mask_addr + offset + size,
+			flow->mask_addr + offset,
+			flow->rule_size - offset);
+		memset(flow->mask_addr + offset, 0, size);
+		flow->rule_size += size;
 	} else {
-		ret = dpaa2_flow_rule_insert_hole(curr, offset, size,
-				DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-	}
-
-	curr = LIST_FIRST(&priv->flows);
-	while (curr) {
-		ret = dpaa2_flow_rule_insert_hole(curr, offset, size,
-				DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-		curr = LIST_NEXT(curr, next);
+		flow->rule_size = offset + size;
 	}
 
 	return 0;
 }
 
 static int
-dpaa2_flow_fs_rule_insert_hole(struct dpaa2_dev_priv *priv,
-	int offset, int size, int tc_id)
+dpaa2_flow_rule_add_all(struct dpaa2_dev_priv *priv,
+	enum dpaa2_flow_dist_type dist_type,
+	uint16_t entry_size, uint8_t tc_id)
 {
-	struct dpaa2_dev_flow *curr;
+	struct dpaa2_dev_flow *curr = LIST_FIRST(&priv->flows);
+	struct dpaa2_generic_flow *qos_flow;
+	struct dpaa2_generic_flow *fs_flow;
 	int ret;
 
-	curr = priv->curr;
-	if (!curr || curr->tc_id != tc_id) {
-		DPAA2_PMD_ERR("Current flow insert hole failed.");
-		return -EINVAL;
-	} else {
-		ret = dpaa2_flow_rule_insert_hole(curr, offset, size,
-				DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-	}
-
-	curr = LIST_FIRST(&priv->flows);
-
 	while (curr) {
-		if (curr->tc_id != tc_id) {
-			curr = LIST_NEXT(curr, next);
-			continue;
+		qos_flow = curr->qos_flow;
+		fs_flow = curr->fs_flow;
+		if (qos_flow && dist_type == DPAA2_FLOW_QOS_TYPE) {
+			qos_flow->rule_cfg.key_size = entry_size;
+			ret = dpaa2_flow_add_qos_rule(priv, qos_flow);
+			if (ret)
+				return ret;
+		} else if (dist_type == DPAA2_FLOW_FS_TYPE &&
+			fs_flow && fs_flow->tc_id == tc_id) {
+			fs_flow->rule_cfg.key_size = entry_size;
+			ret = dpaa2_flow_add_fs_rule(priv, fs_flow);
+			if (ret)
+				return ret;
 		}
-		ret = dpaa2_flow_rule_insert_hole(curr, offset, size,
-				DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
 		curr = LIST_NEXT(curr, next);
 	}
 
 	return 0;
 }
 
+static void
+dpaa2_flow_rule_insert_hole(struct dpaa2_dev_priv *priv,
+	int offset, int size, int tc_id,
+	enum dpaa2_flow_dist_type dist_type)
+{
+	struct dpaa2_dev_flow *flow;
+	struct dpaa2_generic_flow *curr;
+
+	curr = priv->cur_flow;
+	if (curr)
+		_dpaa2_flow_rule_insert_hole(curr, offset, size);
+
+	flow = LIST_FIRST(&priv->flows);
+	while (flow) {
+		if (dist_type == DPAA2_FLOW_QOS_TYPE)
+			curr = flow->qos_flow;
+		else
+			curr = flow->fs_flow;
+		flow = LIST_NEXT(flow, next);
+		if (!curr)
+			continue;
+		if (dist_type == DPAA2_FLOW_FS_TYPE &&
+			curr->tc_id != tc_id)
+			continue;
+		if (curr->ip_src || curr->ip_dst)
+			_dpaa2_flow_rule_insert_hole(curr, offset, size);
+	}
+}
+
 static int
 dpaa2_flow_faf_advance(struct dpaa2_dev_priv *priv,
 	int faf_byte, enum dpaa2_flow_dist_type dist_type, int tc_id,
 	int *insert_offset)
 {
-	int offset, ret;
 	struct dpaa2_key_profile *key_profile;
-	int num, pos;
+	uint8_t idx, offset = 0xff;
+	struct key_prot_field prot = {0};
 
 	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_profile = &priv->extract.qos_key_extract.key_profile;
+		key_profile = &priv->flow_profile.qos_profile.key_profile;
 	else
-		key_profile = &priv->extract.tc_key_extract[tc_id].key_profile;
-
-	num = key_profile->num;
+		key_profile = &priv->flow_profile.tc_profile[tc_id].key_profile;
 
-	if (num >= DPKG_MAX_NUM_OF_EXTRACTS) {
+	if (key_profile->num >= DPKG_MAX_NUM_OF_EXTRACTS) {
 		DPAA2_PMD_ERR("Number of extracts overflows");
 		return -EINVAL;
 	}
 
-	if (key_profile->ip_addr_type != IP_NONE_ADDR_EXTRACT) {
-		offset = key_profile->ip_addr_extract_off;
-		pos = key_profile->ip_addr_extract_pos;
-		key_profile->ip_addr_extract_pos++;
-		key_profile->ip_addr_extract_off++;
-		if (dist_type == DPAA2_FLOW_QOS_TYPE) {
-			ret = dpaa2_flow_qos_rule_insert_hole(priv,
-					offset, 1);
-		} else {
-			ret = dpaa2_flow_fs_rule_insert_hole(priv,
-				offset, 1, tc_id);
-		}
-		if (ret)
-			return ret;
-	} else {
-		pos = num;
-	}
-
-	if (pos > 0) {
-		key_profile->key_offset[pos] =
-			key_profile->key_offset[pos - 1] +
-			key_profile->key_size[pos - 1];
-	} else {
-		key_profile->key_offset[pos] = 0;
-	}
-
-	key_profile->key_size[pos] = 1;
-	key_profile->prot_field[pos].type = DPAA2_FAF_KEY;
-	key_profile->prot_field[pos].key_field = faf_byte;
-	key_profile->num++;
+	prot.type = DPAA2_FAF_KEY;
+	prot.key_field = faf_byte;
+	idx = dpaa2_profile_insert_no_ipaddr_extract(key_profile,
+		1, &offset, insert_offset, &prot);
+	dpaa2_flow_rule_insert_hole(priv, offset, 1, tc_id, dist_type);
 
-	if (insert_offset)
-		*insert_offset = key_profile->key_offset[pos];
-
-	key_profile->key_max_size++;
-
-	return pos;
+	return idx;
 }
 
 static int
@@ -761,60 +990,27 @@ dpaa2_flow_pr_advance(struct dpaa2_dev_priv *priv,
 	enum dpaa2_flow_dist_type dist_type, int tc_id,
 	int *insert_offset)
 {
-	int offset, ret;
 	struct dpaa2_key_profile *key_profile;
-	int num, pos;
+	uint8_t idx, offset = 0xff;
+	struct key_prot_field prot = {0};
 
 	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_profile = &priv->extract.qos_key_extract.key_profile;
+		key_profile = &priv->flow_profile.qos_profile.key_profile;
 	else
-		key_profile = &priv->extract.tc_key_extract[tc_id].key_profile;
-
-	num = key_profile->num;
+		key_profile = &priv->flow_profile.tc_profile[tc_id].key_profile;
 
-	if (num >= DPKG_MAX_NUM_OF_EXTRACTS) {
+	if (key_profile->num >= DPKG_MAX_NUM_OF_EXTRACTS) {
 		DPAA2_PMD_ERR("Number of extracts overflows");
 		return -EINVAL;
 	}
 
-	if (key_profile->ip_addr_type != IP_NONE_ADDR_EXTRACT) {
-		offset = key_profile->ip_addr_extract_off;
-		pos = key_profile->ip_addr_extract_pos;
-		key_profile->ip_addr_extract_pos++;
-		key_profile->ip_addr_extract_off += pr_size;
-		if (dist_type == DPAA2_FLOW_QOS_TYPE) {
-			ret = dpaa2_flow_qos_rule_insert_hole(priv,
-					offset, pr_size);
-		} else {
-			ret = dpaa2_flow_fs_rule_insert_hole(priv,
-				offset, pr_size, tc_id);
-		}
-		if (ret)
-			return ret;
-	} else {
-		pos = num;
-	}
-
-	if (pos > 0) {
-		key_profile->key_offset[pos] =
-			key_profile->key_offset[pos - 1] +
-			key_profile->key_size[pos - 1];
-	} else {
-		key_profile->key_offset[pos] = 0;
-	}
-
-	key_profile->key_size[pos] = pr_size;
-	key_profile->prot_field[pos].type = DPAA2_PR_KEY;
-	key_profile->prot_field[pos].key_field =
-		(pr_offset << 16) | pr_size;
-	key_profile->num++;
-
-	if (insert_offset)
-		*insert_offset = key_profile->key_offset[pos];
+	prot.type = DPAA2_PR_KEY;
+	prot.key_field = (pr_offset << 16) | pr_size;
+	idx = dpaa2_profile_insert_no_ipaddr_extract(key_profile,
+		pr_size, &offset, insert_offset, &prot);
+	dpaa2_flow_rule_insert_hole(priv, offset, pr_size, tc_id, dist_type);
 
-	key_profile->key_max_size += pr_size;
-
-	return pos;
+	return idx;
 }
 
 /* Move IPv4/IPv6 addresses to fill new extract previous IP address.
@@ -829,9 +1025,9 @@ dpaa2_flow_key_profile_advance(enum net_prot prot,
 	enum dpaa2_flow_dist_type dist_type, int tc_id,
 	int *insert_offset)
 {
-	int offset, ret;
 	struct dpaa2_key_profile *key_profile;
-	int num, pos;
+	uint8_t idx, offset = 0xff;
+	struct key_prot_field prot_field;
 
 	if (dpaa2_flow_ip_address_extract(prot, field)) {
 		DPAA2_PMD_ERR("%s only for none IP address extract",
@@ -840,66 +1036,35 @@ dpaa2_flow_key_profile_advance(enum net_prot prot,
 	}
 
 	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_profile = &priv->extract.qos_key_extract.key_profile;
+		key_profile = &priv->flow_profile.qos_profile.key_profile;
 	else
-		key_profile = &priv->extract.tc_key_extract[tc_id].key_profile;
-
-	num = key_profile->num;
+		key_profile = &priv->flow_profile.tc_profile[tc_id].key_profile;
 
-	if (num >= DPKG_MAX_NUM_OF_EXTRACTS) {
+	if (key_profile->num >= DPKG_MAX_NUM_OF_EXTRACTS) {
 		DPAA2_PMD_ERR("Number of extracts overflows");
 		return -EINVAL;
 	}
 
-	if (key_profile->ip_addr_type != IP_NONE_ADDR_EXTRACT) {
-		offset = key_profile->ip_addr_extract_off;
-		pos = key_profile->ip_addr_extract_pos;
-		key_profile->ip_addr_extract_pos++;
-		key_profile->ip_addr_extract_off += field_size;
-		if (dist_type == DPAA2_FLOW_QOS_TYPE) {
-			ret = dpaa2_flow_qos_rule_insert_hole(priv,
-					offset, field_size);
-		} else {
-			ret = dpaa2_flow_fs_rule_insert_hole(priv,
-				offset, field_size, tc_id);
-		}
-		if (ret)
-			return ret;
-	} else {
-		pos = num;
-	}
-
-	if (pos > 0) {
-		key_profile->key_offset[pos] =
-			key_profile->key_offset[pos - 1] +
-			key_profile->key_size[pos - 1];
-	} else {
-		key_profile->key_offset[pos] = 0;
-	}
-
-	key_profile->key_size[pos] = field_size;
-	key_profile->prot_field[pos].type = DPAA2_NET_PROT_KEY;
-	key_profile->prot_field[pos].prot = prot;
-	key_profile->prot_field[pos].key_field = field;
-	key_profile->num++;
-
-	if (insert_offset)
-		*insert_offset = key_profile->key_offset[pos];
+	prot_field.type = DPAA2_NET_PROT_KEY;
+	prot_field.prot = prot;
+	prot_field.key_field = field;
+	idx = dpaa2_profile_insert_no_ipaddr_extract(key_profile,
+		field_size, &offset, insert_offset, &prot_field);
+	dpaa2_flow_rule_insert_hole(priv, offset, field_size, tc_id, dist_type);
 
 	if (dpaa2_flow_l4_src_port_extract(prot, field)) {
-		key_profile->l4_src_port_present = 1;
-		key_profile->l4_src_port_pos = pos;
-		key_profile->l4_src_port_offset =
-			key_profile->key_offset[pos];
+		key_profile->l4_sp_present = 1;
+		key_profile->l4_sp_extract_idx = idx;
+		key_profile->l4_sp_key_offset =
+			key_profile->key_offset[idx];
 	} else if (dpaa2_flow_l4_dst_port_extract(prot, field)) {
-		key_profile->l4_dst_port_present = 1;
-		key_profile->l4_dst_port_pos = pos;
-		key_profile->l4_dst_port_offset =
-			key_profile->key_offset[pos];
+		key_profile->l4_dp_present = 1;
+		key_profile->l4_dp_extract_idx = idx;
+		key_profile->l4_dp_key_offset =
+			key_profile->key_offset[idx];
 	}
-	key_profile->key_max_size += field_size;
 
-	return pos;
+	return idx;
 }
 
 static int
@@ -908,44 +1073,34 @@ dpaa2_flow_faf_add_hdr(int faf_byte,
 	enum dpaa2_flow_dist_type dist_type, int tc_id,
 	int *insert_offset)
 {
-	int pos, i, offset;
-	struct dpaa2_key_extract *key_extract;
+	int extract_idx;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 	struct dpkg_profile_cfg *dpkg;
-	struct dpkg_extract *extracts;
+	struct dpkg_extract extract;
 
 	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_extract = &priv->extract.qos_key_extract;
+		tbl_profile = &priv->flow_profile.qos_profile;
 	else
-		key_extract = &priv->extract.tc_key_extract[tc_id];
+		tbl_profile = &priv->flow_profile.tc_profile[tc_id];
 
-	dpkg = &key_extract->dpkg;
-	extracts = dpkg->extracts;
+	dpkg = &tbl_profile->dpkg;
 
 	if (dpkg->num_extracts >= DPKG_MAX_NUM_OF_EXTRACTS) {
 		DPAA2_PMD_ERR("Number of extracts overflows");
 		return -EINVAL;
 	}
 
-	pos = dpaa2_flow_faf_advance(priv,
+	extract_idx = dpaa2_flow_faf_advance(priv,
 			faf_byte, dist_type, tc_id,
 			insert_offset);
-	if (pos < 0)
-		return pos;
-
-	if (pos != dpkg->num_extracts) {
-		/* Not the last pos, must have IP address extract.*/
-		for (i = dpkg->num_extracts - 1; i >= pos; i--) {
-			extracts[i + 1] = extracts[i];
-		}
-	}
-
-	offset = DPAA2_FAFE_PSR_OFFSET + faf_byte;
-
-	extracts[pos].type = DPKG_EXTRACT_FROM_PARSE;
-	extracts[pos].extract.from_parse.offset = offset;
-	extracts[pos].extract.from_parse.size = 1;
+	if (extract_idx < 0)
+		return extract_idx;
 
-	dpkg->num_extracts++;
+	memset(&extract, 0, sizeof(extract));
+	extract.type = DPKG_EXTRACT_FROM_PARSE;
+	extract.extract.from_parse.offset = faf_byte;
+	extract.extract.from_parse.size = 1;
+	dpaa2_dpkg_insert_extract(dpkg, extract_idx, &extract);
 
 	return 0;
 }
@@ -956,48 +1111,40 @@ dpaa2_flow_pr_add_hdr(uint32_t pr_offset,
 	enum dpaa2_flow_dist_type dist_type, int tc_id,
 	int *insert_offset)
 {
-	int pos, i;
-	struct dpaa2_key_extract *key_extract;
+	int extract_idx;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 	struct dpkg_profile_cfg *dpkg;
-	struct dpkg_extract *extracts;
+	struct dpkg_extract extract;
 
-	if ((pr_offset + pr_size) > DPAA2_FAPR_SIZE) {
+	if ((pr_offset + pr_size) > DPAA2_PSR_RESULT_SIZE) {
 		DPAA2_PMD_ERR("PR extracts(%d:%d) overflow",
 			pr_offset, pr_size);
 		return -EINVAL;
 	}
 
 	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_extract = &priv->extract.qos_key_extract;
+		tbl_profile = &priv->flow_profile.qos_profile;
 	else
-		key_extract = &priv->extract.tc_key_extract[tc_id];
+		tbl_profile = &priv->flow_profile.tc_profile[tc_id];
 
-	dpkg = &key_extract->dpkg;
-	extracts = dpkg->extracts;
+	dpkg = &tbl_profile->dpkg;
 
 	if (dpkg->num_extracts >= DPKG_MAX_NUM_OF_EXTRACTS) {
 		DPAA2_PMD_ERR("Number of extracts overflows");
 		return -EINVAL;
 	}
 
-	pos = dpaa2_flow_pr_advance(priv,
+	extract_idx = dpaa2_flow_pr_advance(priv,
 			pr_offset, pr_size, dist_type, tc_id,
 			insert_offset);
-	if (pos < 0)
-		return pos;
+	if (extract_idx < 0)
+		return extract_idx;
 
-	if (pos != dpkg->num_extracts) {
-		/* Not the last pos, must have IP address extract.*/
-		for (i = dpkg->num_extracts - 1; i >= pos; i--) {
-			extracts[i + 1] = extracts[i];
-		}
-	}
-
-	extracts[pos].type = DPKG_EXTRACT_FROM_PARSE;
-	extracts[pos].extract.from_parse.offset = pr_offset;
-	extracts[pos].extract.from_parse.size = pr_size;
-
-	dpkg->num_extracts++;
+	memset(&extract, 0, sizeof(extract));
+	extract.type = DPKG_EXTRACT_FROM_PARSE;
+	extract.extract.from_parse.offset = pr_offset;
+	extract.extract.from_parse.size = pr_size;
+	dpaa2_dpkg_insert_extract(dpkg, extract_idx, &extract);
 
 	return 0;
 }
@@ -1009,18 +1156,17 @@ dpaa2_flow_extract_add_hdr(enum net_prot prot,
 	enum dpaa2_flow_dist_type dist_type, int tc_id,
 	int *insert_offset)
 {
-	int pos, i;
-	struct dpaa2_key_extract *key_extract;
+	int extract_idx;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 	struct dpkg_profile_cfg *dpkg;
-	struct dpkg_extract *extracts;
+	struct dpkg_extract extract;
 
 	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_extract = &priv->extract.qos_key_extract;
+		tbl_profile = &priv->flow_profile.qos_profile;
 	else
-		key_extract = &priv->extract.tc_key_extract[tc_id];
+		tbl_profile = &priv->flow_profile.tc_profile[tc_id];
 
-	dpkg = &key_extract->dpkg;
-	extracts = dpkg->extracts;
+	dpkg = &tbl_profile->dpkg;
 
 	if (dpaa2_flow_ip_address_extract(prot, field)) {
 		DPAA2_PMD_ERR("%s only for none IP address extract",
@@ -1033,52 +1179,86 @@ dpaa2_flow_extract_add_hdr(enum net_prot prot,
 		return -EINVAL;
 	}
 
-	pos = dpaa2_flow_key_profile_advance(prot,
+	extract_idx = dpaa2_flow_key_profile_advance(prot,
 			field, field_size, priv,
 			dist_type, tc_id,
 			insert_offset);
-	if (pos < 0)
-		return pos;
+	if (extract_idx < 0)
+		return extract_idx;
 
-	if (pos != dpkg->num_extracts) {
-		/* Not the last pos, must have IP address extract.*/
-		for (i = dpkg->num_extracts - 1; i >= pos; i--) {
-			extracts[i + 1] = extracts[i];
-		}
+	memset(&extract, 0, sizeof(extract));
+	extract.type = DPKG_EXTRACT_FROM_HDR;
+	extract.extract.from_hdr.prot = prot;
+	extract.extract.from_hdr.type = DPKG_FULL_FIELD;
+	extract.extract.from_hdr.field = field;
+	dpaa2_dpkg_insert_extract(dpkg, extract_idx, &extract);
+
+	return 0;
+}
+
+static inline int
+dpaa2_flow_extract_search(struct dpaa2_key_profile *key_profile,
+	enum key_prot_type type, enum net_prot prot, uint32_t key_field)
+{
+	int extract_idx;
+	struct key_prot_field *prot_field;
+
+	if (dpaa2_flow_ip_address_extract(prot, key_field)) {
+		DPAA2_PMD_ERR("%s only for none IP address extract",
+			__func__);
+		return -EINVAL;
 	}
 
-	extracts[pos].type = DPKG_EXTRACT_FROM_HDR;
-	extracts[pos].extract.from_hdr.prot = prot;
-	extracts[pos].extract.from_hdr.type = DPKG_FULL_FIELD;
-	extracts[pos].extract.from_hdr.field = field;
+	prot_field = key_profile->prot_field;
+	for (extract_idx = 0; extract_idx < key_profile->num; extract_idx++) {
+		if (type == DPAA2_NET_PROT_KEY &&
+			prot_field[extract_idx].prot == prot &&
+			prot_field[extract_idx].key_field == key_field &&
+			prot_field[extract_idx].type == type)
+			return extract_idx;
+		else if (type == DPAA2_FAF_KEY &&
+			prot_field[extract_idx].key_field == key_field &&
+			prot_field[extract_idx].type == type)
+			return extract_idx;
+		else if (type == DPAA2_PR_KEY &&
+			prot_field[extract_idx].key_field == key_field &&
+			prot_field[extract_idx].type == type)
+			return extract_idx;
+	}
 
-	dpkg->num_extracts++;
+	if (type == DPAA2_NET_PROT_KEY &&
+		dpaa2_flow_l4_src_port_extract(prot, key_field)) {
+		if (key_profile->l4_sp_present)
+			return key_profile->l4_sp_extract_idx;
+	} else if (type == DPAA2_NET_PROT_KEY &&
+		dpaa2_flow_l4_dst_port_extract(prot, key_field)) {
+		if (key_profile->l4_dp_present)
+			return key_profile->l4_dp_extract_idx;
+	}
 
-	return 0;
+	return -ENXIO;
 }
 
 static int
-dpaa2_flow_extract_new_raw(struct dpaa2_dev_priv *priv,
+_dpaa2_flow_extract_add_raw(struct dpaa2_dev_priv *priv,
 	int offset, int size,
 	enum dpaa2_flow_dist_type dist_type, int tc_id)
 {
-	struct dpaa2_key_extract *key_extract;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 	struct dpkg_profile_cfg *dpkg;
 	struct dpaa2_key_profile *key_profile;
-	int last_extract_size, index, pos, item_size;
+	int last_extract_size, index, raw_idx, item_size;
 	uint8_t num_extracts;
 	uint32_t field;
+	int ret;
 
 	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_extract = &priv->extract.qos_key_extract;
+		tbl_profile = &priv->flow_profile.qos_profile;
 	else
-		key_extract = &priv->extract.tc_key_extract[tc_id];
+		tbl_profile = &priv->flow_profile.tc_profile[tc_id];
 
-	dpkg = &key_extract->dpkg;
-	key_profile = &key_extract->key_profile;
-
-	key_profile->raw_region.raw_start = 0;
-	key_profile->raw_region.raw_size = 0;
+	dpkg = &tbl_profile->dpkg;
+	key_profile = &tbl_profile->key_profile;
 
 	last_extract_size = (size % DPAA2_FLOW_MAX_KEY_SIZE);
 	num_extracts = (size / DPAA2_FLOW_MAX_KEY_SIZE);
@@ -1087,6 +1267,13 @@ dpaa2_flow_extract_new_raw(struct dpaa2_dev_priv *priv,
 	else
 		last_extract_size = DPAA2_FLOW_MAX_KEY_SIZE;
 
+	if ((key_profile->num + num_extracts) >
+		DPKG_MAX_NUM_OF_EXTRACTS) {
+		DPAA2_PMD_ERR("%s Failed to expand raw extracts",
+			__func__);
+		return -EINVAL;
+	}
+
 	for (index = 0; index < num_extracts; index++) {
 		if (index == num_extracts - 1)
 			item_size = last_extract_size;
@@ -1095,25 +1282,22 @@ dpaa2_flow_extract_new_raw(struct dpaa2_dev_priv *priv,
 		field = offset << DPAA2_FLOW_RAW_OFFSET_FIELD_SHIFT;
 		field |= item_size;
 
-		pos = dpaa2_flow_key_profile_advance(NET_PROT_PAYLOAD,
+		ret = dpaa2_flow_extract_search(key_profile,
+			DPAA2_NET_PROT_KEY, NET_PROT_PAYLOAD, field);
+		if (ret >= 0) {
+			offset += item_size;
+			continue;
+		}
+
+		raw_idx = dpaa2_flow_key_profile_advance(NET_PROT_PAYLOAD,
 				field, item_size, priv, dist_type,
 				tc_id, NULL);
-		if (pos < 0)
-			return pos;
-
-		dpkg->extracts[pos].type = DPKG_EXTRACT_FROM_DATA;
-		dpkg->extracts[pos].extract.from_data.size = item_size;
-		dpkg->extracts[pos].extract.from_data.offset = offset;
-
-		if (index == 0) {
-			key_profile->raw_extract_pos = pos;
-			key_profile->raw_extract_off =
-				key_profile->key_offset[pos];
-			key_profile->raw_region.raw_start = offset;
-		}
-		key_profile->raw_extract_num++;
-		key_profile->raw_region.raw_size +=
-			key_profile->key_size[pos];
+		if (raw_idx < 0)
+			return raw_idx;
+
+		dpkg->extracts[raw_idx].type = DPKG_EXTRACT_FROM_DATA;
+		dpkg->extracts[raw_idx].extract.from_data.size = item_size;
+		dpkg->extracts[raw_idx].extract.from_data.offset = offset;
 
 		offset += item_size;
 		dpkg->num_extracts++;
@@ -1127,247 +1311,16 @@ dpaa2_flow_extract_add_raw(struct dpaa2_dev_priv *priv,
 	int offset, int size, enum dpaa2_flow_dist_type dist_type,
 	int tc_id, int *recfg)
 {
-	struct dpaa2_key_profile *key_profile;
-	struct dpaa2_raw_region *raw_region;
-	int end = offset + size, ret = 0, extract_extended, sz_extend;
-	int start_cmp, end_cmp, new_size, index, pos, end_pos;
-	int last_extract_size, item_size, num_extracts, bk_num = 0;
-	struct dpkg_extract extract_bk[DPKG_MAX_NUM_OF_EXTRACTS];
-	uint8_t key_offset_bk[DPKG_MAX_NUM_OF_EXTRACTS];
-	uint8_t key_size_bk[DPKG_MAX_NUM_OF_EXTRACTS];
-	struct key_prot_field prot_field_bk[DPKG_MAX_NUM_OF_EXTRACTS];
-	struct dpaa2_raw_region raw_hole;
-	struct dpkg_profile_cfg *dpkg;
-	enum net_prot prot;
-	uint32_t field;
-
-	if (dist_type == DPAA2_FLOW_QOS_TYPE) {
-		key_profile = &priv->extract.qos_key_extract.key_profile;
-		dpkg = &priv->extract.qos_key_extract.dpkg;
-	} else {
-		key_profile = &priv->extract.tc_key_extract[tc_id].key_profile;
-		dpkg = &priv->extract.tc_key_extract[tc_id].dpkg;
-	}
+	int ret;
 
-	raw_region = &key_profile->raw_region;
-	if (!raw_region->raw_size) {
-		/* New RAW region*/
-		ret = dpaa2_flow_extract_new_raw(priv, offset, size,
+	ret = _dpaa2_flow_extract_add_raw(priv, offset, size,
 			dist_type, tc_id);
-		if (!ret && recfg)
-			(*recfg) |= dist_type;
-
-		return ret;
-	}
-	start_cmp = raw_region->raw_start;
-	end_cmp = raw_region->raw_start + raw_region->raw_size;
-
-	if (offset >= start_cmp && end <= end_cmp)
-		return 0;
-
-	sz_extend = 0;
-	new_size = raw_region->raw_size;
-	if (offset < start_cmp) {
-		sz_extend += start_cmp - offset;
-		new_size += (start_cmp - offset);
-	}
-	if (end > end_cmp) {
-		sz_extend += end - end_cmp;
-		new_size += (end - end_cmp);
-	}
-
-	last_extract_size = (new_size % DPAA2_FLOW_MAX_KEY_SIZE);
-	num_extracts = (new_size / DPAA2_FLOW_MAX_KEY_SIZE);
-	if (last_extract_size)
-		num_extracts++;
-	else
-		last_extract_size = DPAA2_FLOW_MAX_KEY_SIZE;
-
-	if ((key_profile->num + num_extracts -
-		key_profile->raw_extract_num) >=
-		DPKG_MAX_NUM_OF_EXTRACTS) {
-		DPAA2_PMD_ERR("%s Failed to expand raw extracts",
-			__func__);
-		return -EINVAL;
-	}
-
-	if (offset < start_cmp) {
-		raw_hole.raw_start = key_profile->raw_extract_off;
-		raw_hole.raw_size = start_cmp - offset;
-		raw_region->raw_start = offset;
-		raw_region->raw_size += start_cmp - offset;
-
-		if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-			ret = dpaa2_flow_qos_rule_insert_hole(priv,
-					raw_hole.raw_start,
-					raw_hole.raw_size);
-			if (ret)
-				return ret;
-		}
-		if (dist_type & DPAA2_FLOW_FS_TYPE) {
-			ret = dpaa2_flow_fs_rule_insert_hole(priv,
-					raw_hole.raw_start,
-					raw_hole.raw_size, tc_id);
-			if (ret)
-				return ret;
-		}
-	}
-
-	if (end > end_cmp) {
-		raw_hole.raw_start =
-			key_profile->raw_extract_off +
-			raw_region->raw_size;
-		raw_hole.raw_size = end - end_cmp;
-		raw_region->raw_size += end - end_cmp;
-
-		if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-			ret = dpaa2_flow_qos_rule_insert_hole(priv,
-					raw_hole.raw_start,
-					raw_hole.raw_size);
-			if (ret)
-				return ret;
-		}
-		if (dist_type & DPAA2_FLOW_FS_TYPE) {
-			ret = dpaa2_flow_fs_rule_insert_hole(priv,
-					raw_hole.raw_start,
-					raw_hole.raw_size, tc_id);
-			if (ret)
-				return ret;
-		}
-	}
-
-	end_pos = key_profile->raw_extract_pos +
-		key_profile->raw_extract_num;
-	if (key_profile->num > end_pos) {
-		bk_num = key_profile->num - end_pos;
-		memcpy(extract_bk, &dpkg->extracts[end_pos],
-			bk_num * sizeof(struct dpkg_extract));
-		memcpy(key_offset_bk, &key_profile->key_offset[end_pos],
-			bk_num * sizeof(uint8_t));
-		memcpy(key_size_bk, &key_profile->key_size[end_pos],
-			bk_num * sizeof(uint8_t));
-		memcpy(prot_field_bk, &key_profile->prot_field[end_pos],
-			bk_num * sizeof(struct key_prot_field));
-
-		for (index = 0; index < bk_num; index++) {
-			key_offset_bk[index] += sz_extend;
-			prot = prot_field_bk[index].prot;
-			field = prot_field_bk[index].key_field;
-			if (dpaa2_flow_l4_src_port_extract(prot,
-				field)) {
-				key_profile->l4_src_port_present = 1;
-				key_profile->l4_src_port_pos = end_pos + index;
-				key_profile->l4_src_port_offset =
-					key_offset_bk[index];
-			} else if (dpaa2_flow_l4_dst_port_extract(prot,
-				field)) {
-				key_profile->l4_dst_port_present = 1;
-				key_profile->l4_dst_port_pos = end_pos + index;
-				key_profile->l4_dst_port_offset =
-					key_offset_bk[index];
-			}
-		}
-	}
-
-	pos = key_profile->raw_extract_pos;
-
-	for (index = 0; index < num_extracts; index++) {
-		if (index == num_extracts - 1)
-			item_size = last_extract_size;
-		else
-			item_size = DPAA2_FLOW_MAX_KEY_SIZE;
-		field = offset << DPAA2_FLOW_RAW_OFFSET_FIELD_SHIFT;
-		field |= item_size;
-
-		if (pos > 0) {
-			key_profile->key_offset[pos] =
-				key_profile->key_offset[pos - 1] +
-				key_profile->key_size[pos - 1];
-		} else {
-			key_profile->key_offset[pos] = 0;
-		}
-		key_profile->key_size[pos] = item_size;
-		key_profile->prot_field[pos].type = DPAA2_NET_PROT_KEY;
-		key_profile->prot_field[pos].prot = NET_PROT_PAYLOAD;
-		key_profile->prot_field[pos].key_field = field;
-
-		dpkg->extracts[pos].type = DPKG_EXTRACT_FROM_DATA;
-		dpkg->extracts[pos].extract.from_data.size = item_size;
-		dpkg->extracts[pos].extract.from_data.offset = offset;
-		offset += item_size;
-		pos++;
-	}
-
-	if (bk_num) {
-		memcpy(&dpkg->extracts[pos], extract_bk,
-			bk_num * sizeof(struct dpkg_extract));
-		memcpy(&key_profile->key_offset[end_pos],
-			key_offset_bk, bk_num * sizeof(uint8_t));
-		memcpy(&key_profile->key_size[end_pos],
-			key_size_bk, bk_num * sizeof(uint8_t));
-		memcpy(&key_profile->prot_field[end_pos],
-			prot_field_bk, bk_num * sizeof(struct key_prot_field));
-	}
-
-	extract_extended = num_extracts - key_profile->raw_extract_num;
-	if (key_profile->ip_addr_type != IP_NONE_ADDR_EXTRACT) {
-		key_profile->ip_addr_extract_pos += extract_extended;
-		key_profile->ip_addr_extract_off += sz_extend;
-	}
-	key_profile->raw_extract_num = num_extracts;
-	key_profile->num += extract_extended;
-	key_profile->key_max_size += sz_extend;
-
-	dpkg->num_extracts += extract_extended;
 	if (!ret && recfg)
-		(*recfg) |= dist_type;
+		(*recfg) |= true;
 
 	return ret;
 }
 
-static inline int
-dpaa2_flow_extract_search(struct dpaa2_key_profile *key_profile,
-	enum key_prot_type type, enum net_prot prot, uint32_t key_field)
-{
-	int pos;
-	struct key_prot_field *prot_field;
-
-	if (dpaa2_flow_ip_address_extract(prot, key_field)) {
-		DPAA2_PMD_ERR("%s only for none IP address extract",
-			__func__);
-		return -EINVAL;
-	}
-
-	prot_field = key_profile->prot_field;
-	for (pos = 0; pos < key_profile->num; pos++) {
-		if (type == DPAA2_NET_PROT_KEY &&
-			prot_field[pos].prot == prot &&
-			prot_field[pos].key_field == key_field &&
-			prot_field[pos].type == type)
-			return pos;
-		else if (type == DPAA2_FAF_KEY &&
-			prot_field[pos].key_field == key_field &&
-			prot_field[pos].type == type)
-			return pos;
-		else if (type == DPAA2_PR_KEY &&
-			prot_field[pos].key_field == key_field &&
-			prot_field[pos].type == type)
-			return pos;
-	}
-
-	if (type == DPAA2_NET_PROT_KEY &&
-		dpaa2_flow_l4_src_port_extract(prot, key_field)) {
-		if (key_profile->l4_src_port_present)
-			return key_profile->l4_src_port_pos;
-	} else if (type == DPAA2_NET_PROT_KEY &&
-		dpaa2_flow_l4_dst_port_extract(prot, key_field)) {
-		if (key_profile->l4_dst_port_present)
-			return key_profile->l4_dst_port_pos;
-	}
-
-	return -ENXIO;
-}
-
 static inline int
 dpaa2_flow_extract_key_offset(struct dpaa2_key_profile *key_profile,
 	enum key_prot_type type, enum net_prot prot, uint32_t key_field)
@@ -1383,71 +1336,45 @@ dpaa2_flow_extract_key_offset(struct dpaa2_key_profile *key_profile,
 
 static int
 dpaa2_flow_faf_add_rule(struct dpaa2_dev_priv *priv,
-	struct dpaa2_dev_flow *flow,
-	enum dpaa2_rx_faf_offset faf_bit_off,
-	int group,
-	enum dpaa2_flow_dist_type dist_type)
+	struct dpaa2_generic_flow *flow, uint32_t faf_bit_off,
+	int group, enum dpaa2_flow_dist_type dist_type)
 {
 	int offset;
 	uint8_t *key_addr;
 	uint8_t *mask_addr;
-	struct dpaa2_key_extract *key_extract;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 	struct dpaa2_key_profile *key_profile;
 	uint8_t faf_byte = faf_bit_off / 8;
 	uint8_t faf_bit_in_byte = faf_bit_off % 8;
 
 	faf_bit_in_byte = 7 - faf_bit_in_byte;
-
-	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-		key_extract = &priv->extract.qos_key_extract;
-		key_profile = &key_extract->key_profile;
-
-		offset = dpaa2_flow_extract_key_offset(key_profile,
-				DPAA2_FAF_KEY, NET_PROT_NONE, faf_byte);
-		if (offset < 0) {
-			DPAA2_PMD_ERR("%s QoS key extract failed", __func__);
-			return -EINVAL;
-		}
-		key_addr = flow->qos_key_addr + offset;
-		mask_addr = flow->qos_mask_addr + offset;
-
-		if (!(*key_addr) &&
-			key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT &&
-			offset >= flow->qos_rule_size)
-			flow->qos_rule_size = offset + sizeof(uint8_t);
-
-		*key_addr |=  (1 << faf_bit_in_byte);
-		*mask_addr |=  (1 << faf_bit_in_byte);
+	if (dist_type == DPAA2_FLOW_QOS_TYPE)
+		tbl_profile = &priv->flow_profile.qos_profile;
+	else
+		tbl_profile = &priv->flow_profile.tc_profile[group];
+	key_profile = &tbl_profile->key_profile;
+	offset = dpaa2_flow_extract_key_offset(key_profile,
+			DPAA2_FAF_KEY, NET_PROT_NONE, faf_byte);
+	if (offset < 0) {
+		DPAA2_PMD_ERR("%s QoS key extract failed", __func__);
+		return -EINVAL;
 	}
+	key_addr = flow->key_addr + offset;
+	mask_addr = flow->mask_addr + offset;
 
-	if (dist_type & DPAA2_FLOW_FS_TYPE) {
-		key_extract = &priv->extract.tc_key_extract[group];
-		key_profile = &key_extract->key_profile;
-
-		offset = dpaa2_flow_extract_key_offset(key_profile,
-				DPAA2_FAF_KEY, NET_PROT_NONE, faf_byte);
-		if (offset < 0) {
-			DPAA2_PMD_ERR("%s TC[%d] key extract failed",
-				__func__, group);
-			return -EINVAL;
-		}
-		key_addr = flow->fs_key_addr + offset;
-		mask_addr = flow->fs_mask_addr + offset;
-
-		if (!(*key_addr) &&
-			key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT &&
-			offset >= flow->fs_rule_size)
-			flow->fs_rule_size = offset + sizeof(uint8_t);
+	if (!(*key_addr) &&
+		!(flow->ip_src || flow->ip_dst) &&
+		offset >= flow->rule_size)
+		flow->rule_size = offset + sizeof(uint8_t);
 
-		*key_addr |=  (1 << faf_bit_in_byte);
-		*mask_addr |=  (1 << faf_bit_in_byte);
-	}
+	*key_addr |=  (1 << faf_bit_in_byte);
+	*mask_addr |=  (1 << faf_bit_in_byte);
 
 	return 0;
 }
 
 static inline int
-dpaa2_flow_pr_rule_data_set(struct dpaa2_dev_flow *flow,
+dpaa2_flow_pr_rule_data_set(struct dpaa2_generic_flow *flow,
 	struct dpaa2_key_profile *key_profile,
 	uint32_t pr_offset, uint32_t pr_size,
 	const void *key, const void *mask,
@@ -1467,39 +1394,20 @@ dpaa2_flow_pr_rule_data_set(struct dpaa2_dev_flow *flow,
 	sprintf(offset_info, "offset(%d)", offset);
 	sprintf(size_info, "size(%d)", pr_size);
 
-	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-		sprintf(rule_size_info, "qos rule size(%d)",
-			flow->qos_rule_size);
-		memcpy((flow->qos_key_addr + offset), key, pr_size);
-		memcpy((flow->qos_mask_addr + offset), mask, pr_size);
-		if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT) {
-			if (offset >= flow->qos_rule_size) {
-				flow->qos_rule_size = offset + pr_size;
-			} else if ((offset + pr_size) > flow->qos_rule_size) {
-				DPAA2_PMD_ERR("%s < %s, but %s + %s > %s",
-					offset_info, rule_size_info,
-					offset_info, size_info,
-					rule_size_info);
-				return -EINVAL;
-			}
-		}
-	}
-
-	if (dist_type & DPAA2_FLOW_FS_TYPE) {
-		sprintf(rule_size_info, "fs rule size(%d)",
-			flow->fs_rule_size);
-		memcpy((flow->fs_key_addr + offset), key, pr_size);
-		memcpy((flow->fs_mask_addr + offset), mask, pr_size);
-		if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT) {
-			if (offset >= flow->fs_rule_size) {
-				flow->fs_rule_size = offset + pr_size;
-			} else if ((offset + pr_size) > flow->fs_rule_size) {
-				DPAA2_PMD_ERR("%s < %s, but %s + %s > %s",
-					offset_info, rule_size_info,
-					offset_info, size_info,
-					rule_size_info);
-				return -EINVAL;
-			}
+	sprintf(rule_size_info, "%s rule size(%d)",
+		dist_type == DPAA2_FLOW_QOS_TYPE ?
+		"QoS" : "FS", flow->rule_size);
+	memcpy((flow->key_addr + offset), key, pr_size);
+	memcpy((flow->mask_addr + offset), mask, pr_size);
+	if (!(flow->ip_src || flow->ip_dst)) {
+		if (offset >= flow->rule_size) {
+			flow->rule_size = offset + pr_size;
+		} else if ((offset + pr_size) > flow->rule_size) {
+			DPAA2_PMD_ERR("%s < %s, but %s + %s > %s",
+			offset_info, rule_size_info,
+			offset_info, size_info,
+			rule_size_info);
+			return -EINVAL;
 		}
 	}
 
@@ -1507,13 +1415,13 @@ dpaa2_flow_pr_rule_data_set(struct dpaa2_dev_flow *flow,
 }
 
 static inline int
-dpaa2_flow_hdr_rule_data_set(struct dpaa2_dev_flow *flow,
+dpaa2_flow_hdr_rule_data_set(struct dpaa2_generic_flow *flow,
 	struct dpaa2_key_profile *key_profile,
 	enum net_prot prot, uint32_t field, int size,
 	const void *key, const void *mask,
 	enum dpaa2_flow_dist_type dist_type)
 {
-	int offset;
+	int offset, i;
 	char offset_info[64], size_info[64], rule_size_info[64];
 
 	if (dpaa2_flow_ip_address_extract(prot, field)) {
@@ -1532,37 +1440,22 @@ dpaa2_flow_hdr_rule_data_set(struct dpaa2_dev_flow *flow,
 	sprintf(offset_info, "offset(%d)", offset);
 	sprintf(size_info, "size(%d)", size);
 
-	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-		sprintf(rule_size_info, "qos rule size(%d)",
-			flow->qos_rule_size);
-		memcpy((flow->qos_key_addr + offset), key, size);
-		memcpy((flow->qos_mask_addr + offset), mask, size);
-		if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT) {
-			if (offset >= flow->qos_rule_size) {
-				flow->qos_rule_size = offset + size;
-			} else if ((offset + size) > flow->qos_rule_size) {
-				DPAA2_PMD_ERR("%s: %s < %s, but %s + %s > %s",
-					__func__, offset_info, rule_size_info,
-					offset_info, size_info, rule_size_info);
-				return -EINVAL;
-			}
-		}
-	}
+	sprintf(rule_size_info, "%s rule size(%d)",
+		dist_type == DPAA2_FLOW_QOS_TYPE ? "QoS" : "FS",
+		flow->rule_size);
 
-	if (dist_type & DPAA2_FLOW_FS_TYPE) {
-		sprintf(rule_size_info, "fs rule size(%d)",
-			flow->fs_rule_size);
-		memcpy((flow->fs_key_addr + offset), key, size);
-		memcpy((flow->fs_mask_addr + offset), mask, size);
-		if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT) {
-			if (offset >= flow->fs_rule_size) {
-				flow->fs_rule_size = offset + size;
-			} else if ((offset + size) > flow->fs_rule_size) {
-				DPAA2_PMD_ERR("%s: %s < %s, but %s + %s > %s",
-					__func__, offset_info, rule_size_info,
-					offset_info, size_info, rule_size_info);
-				return -EINVAL;
-			}
+	for (i = 0; i < size; i++) {
+		*(flow->key_addr + offset + i) |= *((const uint8_t *)key + i);
+		*(flow->mask_addr + offset + i) |= *((const uint8_t *)mask + i);
+	}
+	if (!(flow->ip_src || flow->ip_dst)) {
+		if (offset >= flow->rule_size) {
+			flow->rule_size = offset + size;
+		} else if ((offset + size) > flow->rule_size) {
+			DPAA2_PMD_ERR("%s: %s < %s, but %s + %s > %s",
+				__func__, offset_info, rule_size_info,
+				offset_info, size_info, rule_size_info);
+			return -EINVAL;
 		}
 	}
 
@@ -1570,7 +1463,7 @@ dpaa2_flow_hdr_rule_data_set(struct dpaa2_dev_flow *flow,
 }
 
 static inline int
-dpaa2_flow_raw_rule_data_set(struct dpaa2_dev_flow *flow,
+dpaa2_flow_raw_rule_data_set(struct dpaa2_generic_flow *flow,
 	struct dpaa2_key_profile *key_profile,
 	uint32_t extract_offset, int size,
 	const void *key, const void *mask,
@@ -1593,34 +1486,19 @@ dpaa2_flow_raw_rule_data_set(struct dpaa2_dev_flow *flow,
 	sprintf(offset_info, "offset(%d)", offset);
 	sprintf(size_info, "size(%d)", size);
 
-	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-		sprintf(rule_size_info, "qos rule size(%d)",
-			flow->qos_rule_size);
-		memcpy((flow->qos_key_addr + offset), key, size);
-		memcpy((flow->qos_mask_addr + offset), mask, size);
-		if (offset >= flow->qos_rule_size) {
-			flow->qos_rule_size = offset + size;
-		} else if ((offset + size) > flow->qos_rule_size) {
-			DPAA2_PMD_ERR("%s: %s < %s, but %s + %s > %s",
-				__func__, offset_info, rule_size_info,
-				offset_info, size_info, rule_size_info);
-			return -EINVAL;
-		}
-	}
-
-	if (dist_type & DPAA2_FLOW_FS_TYPE) {
-		sprintf(rule_size_info, "fs rule size(%d)",
-			flow->fs_rule_size);
-		memcpy((flow->fs_key_addr + offset), key, size);
-		memcpy((flow->fs_mask_addr + offset), mask, size);
-		if (offset >= flow->fs_rule_size) {
-			flow->fs_rule_size = offset + size;
-		} else if ((offset + size) > flow->fs_rule_size) {
-			DPAA2_PMD_ERR("%s: %s < %s, but %s + %s > %s",
-				__func__, offset_info, rule_size_info,
-				offset_info, size_info, rule_size_info);
-			return -EINVAL;
-		}
+	sprintf(rule_size_info, "%s rule size(%d)",
+		dist_type == DPAA2_FLOW_QOS_TYPE ?
+		"QoS" : "FS", flow->rule_size);
+
+	memcpy((flow->key_addr + offset), key, size);
+	memcpy((flow->mask_addr + offset), mask, size);
+	if (offset >= flow->rule_size) {
+		flow->rule_size = offset + size;
+	} else if ((offset + size) > flow->rule_size) {
+		DPAA2_PMD_ERR("%s: %s < %s, but %s + %s > %s",
+			__func__, offset_info, rule_size_info,
+			offset_info, size_info, rule_size_info);
+		return -EINVAL;
 	}
 
 	return 0;
@@ -1691,13 +1569,9 @@ dpaa2_flow_extract_support(const uint8_t *mask_src,
 		mask_support = (const char *)&dpaa2_flow_item_gtp_mask;
 		size = sizeof(struct rte_flow_item_gtp);
 		break;
-	case RTE_FLOW_ITEM_TYPE_MPLS:
-		mask_support = (const char *)&dpaa2_flow_item_mpls_mask;
-		size = sizeof(struct rte_flow_item_mpls);
-		break;
-	case RTE_FLOW_ITEM_TYPE_PPPOES:
-		mask_support = (const char *)&dpaa2_flow_item_pppoe_mask;
-		size = sizeof(struct rte_flow_item_pppoe);
+	case RTE_FLOW_ITEM_TYPE_GENEVE:
+		mask_support = (const char *)&dpaa2_flow_item_geneve_mask;
+		size = sizeof(struct rte_flow_item_geneve);
 		break;
 	default:
 		return -EINVAL;
@@ -1716,19 +1590,17 @@ dpaa2_flow_extract_support(const uint8_t *mask_src,
 
 static int
 dpaa2_flow_identify_by_faf(struct dpaa2_dev_priv *priv,
-	struct dpaa2_dev_flow *flow,
-	enum dpaa2_rx_faf_offset faf_off,
-	enum dpaa2_flow_dist_type dist_type,
-	int group, int *recfg)
+	struct dpaa2_generic_flow *flow, uint32_t faf_bit_off,
+	enum dpaa2_flow_dist_type dist_type, int group, int *recfg)
 {
-	int ret, index, local_cfg = 0;
-	struct dpaa2_key_extract *extract;
+	int ret, index, local_cfg = false;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 	struct dpaa2_key_profile *key_profile;
-	uint8_t faf_byte = faf_off / 8;
+	uint8_t faf_byte = faf_bit_off / 8;
 
-	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-		extract = &priv->extract.qos_key_extract;
-		key_profile = &extract->key_profile;
+	if (dist_type == DPAA2_FLOW_QOS_TYPE) {
+		tbl_profile = &priv->flow_profile.qos_profile;
+		key_profile = &tbl_profile->key_profile;
 
 		index = dpaa2_flow_extract_search(key_profile,
 				DPAA2_FAF_KEY, NET_PROT_NONE, faf_byte);
@@ -1741,20 +1613,18 @@ dpaa2_flow_identify_by_faf(struct dpaa2_dev_priv *priv,
 
 				return -EINVAL;
 			}
-			local_cfg |= DPAA2_FLOW_QOS_TYPE;
+			local_cfg = true;
 		}
 
-		ret = dpaa2_flow_faf_add_rule(priv, flow, faf_off, group,
+		ret = dpaa2_flow_faf_add_rule(priv, flow, faf_bit_off, group,
 				DPAA2_FLOW_QOS_TYPE);
 		if (ret) {
 			DPAA2_PMD_ERR("QoS faf rule set failed");
-			return -EINVAL;
+			return ret;
 		}
-	}
-
-	if (dist_type & DPAA2_FLOW_FS_TYPE) {
-		extract = &priv->extract.tc_key_extract[group];
-		key_profile = &extract->key_profile;
+	} else if (dist_type == DPAA2_FLOW_FS_TYPE) {
+		tbl_profile = &priv->flow_profile.tc_profile[group];
+		key_profile = &tbl_profile->key_profile;
 
 		index = dpaa2_flow_extract_search(key_profile,
 				DPAA2_FAF_KEY, NET_PROT_NONE, faf_byte);
@@ -1768,10 +1638,10 @@ dpaa2_flow_identify_by_faf(struct dpaa2_dev_priv *priv,
 
 				return -EINVAL;
 			}
-			local_cfg |= DPAA2_FLOW_FS_TYPE;
+			local_cfg = true;
 		}
 
-		ret = dpaa2_flow_faf_add_rule(priv, flow, faf_off, group,
+		ret = dpaa2_flow_faf_add_rule(priv, flow, faf_bit_off, group,
 				DPAA2_FLOW_FS_TYPE);
 		if (ret) {
 			DPAA2_PMD_ERR("FS[%d] faf rule set failed",
@@ -1781,29 +1651,29 @@ dpaa2_flow_identify_by_faf(struct dpaa2_dev_priv *priv,
 	}
 
 	if (recfg)
-		*recfg |= local_cfg;
+		(*recfg) |= local_cfg;
 
 	return 0;
 }
 
 static int
-dpaa2_flow_add_pr_extract_rule(struct dpaa2_dev_flow *flow,
+dpaa2_flow_add_pr_extract_rule(struct dpaa2_generic_flow *flow,
 	uint32_t pr_offset, uint32_t pr_size,
 	const void *key, const void *mask,
 	struct dpaa2_dev_priv *priv, int tc_id, int *recfg,
 	enum dpaa2_flow_dist_type dist_type)
 {
-	int index, ret, local_cfg = 0;
-	struct dpaa2_key_extract *key_extract;
+	int index, ret, local_cfg = false;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 	struct dpaa2_key_profile *key_profile;
 	uint32_t pr_field = pr_offset << 16 | pr_size;
 
 	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_extract = &priv->extract.qos_key_extract;
+		tbl_profile = &priv->flow_profile.qos_profile;
 	else
-		key_extract = &priv->extract.tc_key_extract[tc_id];
+		tbl_profile = &priv->flow_profile.tc_profile[tc_id];
 
-	key_profile = &key_extract->key_profile;
+	key_profile = &tbl_profile->key_profile;
 
 	index = dpaa2_flow_extract_search(key_profile,
 			DPAA2_PR_KEY, NET_PROT_NONE, pr_field);
@@ -1817,7 +1687,7 @@ dpaa2_flow_add_pr_extract_rule(struct dpaa2_dev_flow *flow,
 
 			return ret;
 		}
-		local_cfg |= dist_type;
+		local_cfg = true;
 	}
 
 	ret = dpaa2_flow_pr_rule_data_set(flow, key_profile,
@@ -1830,31 +1700,31 @@ dpaa2_flow_add_pr_extract_rule(struct dpaa2_dev_flow *flow,
 	}
 
 	if (recfg)
-		*recfg |= local_cfg;
+		(*recfg) |= local_cfg;
 
 	return 0;
 }
 
 static int
-dpaa2_flow_add_hdr_extract_rule(struct dpaa2_dev_flow *flow,
+dpaa2_flow_add_hdr_extract_rule(struct dpaa2_generic_flow *flow,
 	enum net_prot prot, uint32_t field,
 	const void *key, const void *mask, int size,
 	struct dpaa2_dev_priv *priv, int tc_id, int *recfg,
 	enum dpaa2_flow_dist_type dist_type)
 {
-	int index, ret, local_cfg = 0;
-	struct dpaa2_key_extract *key_extract;
+	int index, ret, local_cfg = false;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 	struct dpaa2_key_profile *key_profile;
 
 	if (dpaa2_flow_ip_address_extract(prot, field))
 		return -EINVAL;
 
 	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_extract = &priv->extract.qos_key_extract;
+		tbl_profile = &priv->flow_profile.qos_profile;
 	else
-		key_extract = &priv->extract.tc_key_extract[tc_id];
+		tbl_profile = &priv->flow_profile.tc_profile[tc_id];
 
-	key_profile = &key_extract->key_profile;
+	key_profile = &tbl_profile->key_profile;
 
 	index = dpaa2_flow_extract_search(key_profile,
 			DPAA2_NET_PROT_KEY, prot, field);
@@ -1868,7 +1738,7 @@ dpaa2_flow_add_hdr_extract_rule(struct dpaa2_dev_flow *flow,
 
 			return ret;
 		}
-		local_cfg |= dist_type;
+		local_cfg = true;
 	}
 
 	ret = dpaa2_flow_hdr_rule_data_set(flow, key_profile,
@@ -1881,44 +1751,57 @@ dpaa2_flow_add_hdr_extract_rule(struct dpaa2_dev_flow *flow,
 	}
 
 	if (recfg)
-		*recfg |= local_cfg;
+		(*recfg) |= local_cfg;
 
 	return 0;
 }
 
 static int
-dpaa2_flow_add_ipaddr_extract_rule(struct dpaa2_dev_flow *flow,
+dpaa2_flow_add_ipaddr_extract_rule(struct dpaa2_generic_flow *flow,
 	enum net_prot prot, uint32_t field,
 	const void *key, const void *mask, int size,
 	struct dpaa2_dev_priv *priv, int tc_id, int *recfg,
 	enum dpaa2_flow_dist_type dist_type)
 {
-	int local_cfg = 0, num, ipaddr_extract_len = 0;
-	struct dpaa2_key_extract *key_extract;
+	int local_cfg = false, update = 0, ret, pos = 0;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 	struct dpaa2_key_profile *key_profile;
 	struct dpkg_profile_cfg *dpkg;
-	uint8_t *key_addr, *mask_addr;
-	union ip_addr_extract_rule *ip_addr_data;
-	union ip_addr_extract_rule *ip_addr_mask;
-	enum net_prot orig_prot;
-	uint32_t orig_field;
-
-	if (prot != NET_PROT_IPV4 && prot != NET_PROT_IPV6)
-		return -EINVAL;
+	uint8_t *key_addr, *mask_addr, num;
+	uint8_t ip_addr_offset = 0;
 
-	if (prot == NET_PROT_IPV4 && field != NH_FLD_IPV4_SRC_IP &&
-		field != NH_FLD_IPV4_DST_IP) {
+	if (prot != NET_PROT_IPV4 && prot != NET_PROT_IPV6) {
+		DPAA2_PMD_ERR("%s: Invalid protocol(%d)",
+			__func__, prot);
 		return -EINVAL;
 	}
 
-	if (prot == NET_PROT_IPV6 && field != NH_FLD_IPV6_SRC_IP &&
-		field != NH_FLD_IPV6_DST_IP) {
-		return -EINVAL;
+	if (prot == NET_PROT_IPV4) {
+		if (field != NH_FLD_IPV4_SRC_IP &&
+			field != NH_FLD_IPV4_DST_IP) {
+			DPAA2_PMD_ERR("%s: Invalid ipv4 filed(%d)",
+				__func__, field);
+			return -EINVAL;
+		}
+		if (size != sizeof(rte_be32_t)) {
+			DPAA2_PMD_ERR("%s: Invalid ipv4 address size(%d)",
+				__func__, size);
+			return -EINVAL;
+		}
+	} else {
+		if (field != NH_FLD_IPV6_SRC_IP &&
+			field != NH_FLD_IPV6_DST_IP) {
+			DPAA2_PMD_ERR("%s: Invalid ipv6 filed(%d)",
+				__func__, field);
+			return -EINVAL;
+		}
+		if (size != NH_FLD_IPV6_ADDR_SIZE) {
+			DPAA2_PMD_ERR("%s: Invalid ipv6 address size(%d)",
+				__func__, size);
+			return -EINVAL;
+		}
 	}
 
-	orig_prot = prot;
-	orig_field = field;
-
 	if (prot == NET_PROT_IPV4 &&
 		field == NH_FLD_IPV4_SRC_IP) {
 		prot = NET_PROT_IP;
@@ -1941,182 +1824,111 @@ dpaa2_flow_add_ipaddr_extract_rule(struct dpaa2_dev_flow *flow,
 		return -EINVAL;
 	}
 
-	if (dist_type == DPAA2_FLOW_QOS_TYPE) {
-		key_extract = &priv->extract.qos_key_extract;
-		key_profile = &key_extract->key_profile;
-		dpkg = &key_extract->dpkg;
-		num = key_profile->num;
-		key_addr = flow->qos_key_addr;
-		mask_addr = flow->qos_mask_addr;
-	} else {
-		key_extract = &priv->extract.tc_key_extract[tc_id];
-		key_profile = &key_extract->key_profile;
-		dpkg = &key_extract->dpkg;
-		num = key_profile->num;
-		key_addr = flow->fs_key_addr;
-		mask_addr = flow->fs_mask_addr;
-	}
+	if (dist_type == DPAA2_FLOW_QOS_TYPE)
+		tbl_profile = &priv->flow_profile.qos_profile;
+	else
+		tbl_profile = &priv->flow_profile.tc_profile[tc_id];
+
+	key_profile = &tbl_profile->key_profile;
+	dpkg = &tbl_profile->dpkg;
+	num = key_profile->num;
+	key_addr = flow->key_addr;
+	mask_addr = flow->mask_addr;
 
 	if (num >= DPKG_MAX_NUM_OF_EXTRACTS) {
 		DPAA2_PMD_ERR("Number of extracts overflows");
 		return -EINVAL;
 	}
 
-	if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT) {
-		if (field == NH_FLD_IP_SRC)
-			key_profile->ip_addr_type = IP_SRC_EXTRACT;
-		else
-			key_profile->ip_addr_type = IP_DST_EXTRACT;
-		ipaddr_extract_len = size;
-
-		key_profile->ip_addr_extract_pos = num;
-		if (num > 0) {
-			key_profile->ip_addr_extract_off =
-				key_profile->key_offset[num - 1] +
-				key_profile->key_size[num - 1];
-		} else {
-			key_profile->ip_addr_extract_off = 0;
-		}
-		key_profile->key_max_size += NH_FLD_IPV6_ADDR_SIZE;
-	} else if (key_profile->ip_addr_type == IP_SRC_EXTRACT) {
-		if (field == NH_FLD_IP_SRC) {
-			ipaddr_extract_len = size;
-			goto rule_configure;
-		}
-		key_profile->ip_addr_type = IP_SRC_DST_EXTRACT;
-		ipaddr_extract_len = size * 2;
-		key_profile->key_max_size += NH_FLD_IPV6_ADDR_SIZE;
-	} else if (key_profile->ip_addr_type == IP_DST_EXTRACT) {
-		if (field == NH_FLD_IP_DST) {
-			ipaddr_extract_len = size;
-			goto rule_configure;
-		}
-		key_profile->ip_addr_type = IP_DST_SRC_EXTRACT;
-		ipaddr_extract_len = size * 2;
-		key_profile->key_max_size += NH_FLD_IPV6_ADDR_SIZE;
+	pos = dpaa2_extract_prev_ip_addr_pos(key_profile);
+	if (pos >= 0) {
+		ip_addr_offset = key_profile->key_offset[pos] +
+			key_profile->key_size[pos];
 	}
-	key_profile->num++;
-	key_profile->prot_field[num].type = DPAA2_NET_PROT_KEY;
 
-	dpkg->extracts[num].extract.from_hdr.prot = prot;
-	dpkg->extracts[num].extract.from_hdr.field = field;
-	dpkg->extracts[num].extract.from_hdr.type = DPKG_FULL_FIELD;
-	dpkg->num_extracts++;
+	ret = dpaa2_extract_ip_addr_add(field,
+		key_profile, size, &update, &pos);
+	if (ret) {
+		DPAA2_PMD_ERR("Add IP address extract failed(%d)", ret);
+		return ret;
+	}
+	if (pos > 1) {
+		DPAA2_PMD_ERR("Invalid IP address extract position(%d)", pos);
+		return -EINVAL;
+	}
+	if (update) {
+		key_profile->num++;
+		key_profile->prot_field[num].type = DPAA2_NET_PROT_KEY;
+		key_profile->prot_field[num].prot = prot;
+		key_profile->prot_field[num].key_field = field;
 
-	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		local_cfg = DPAA2_FLOW_QOS_TYPE;
-	else
-		local_cfg = DPAA2_FLOW_FS_TYPE;
-
-rule_configure:
-	key_addr += key_profile->ip_addr_extract_off;
-	ip_addr_data = (union ip_addr_extract_rule *)key_addr;
-	mask_addr += key_profile->ip_addr_extract_off;
-	ip_addr_mask = (union ip_addr_extract_rule *)mask_addr;
-
-	if (orig_prot == NET_PROT_IPV4 &&
-		orig_field == NH_FLD_IPV4_SRC_IP) {
-		if (key_profile->ip_addr_type == IP_SRC_EXTRACT ||
-			key_profile->ip_addr_type == IP_SRC_DST_EXTRACT) {
-			memcpy(&ip_addr_data->ipv4_sd_addr.ipv4_src,
-				key, size);
-			memcpy(&ip_addr_mask->ipv4_sd_addr.ipv4_src,
-				mask, size);
-		} else {
-			memcpy(&ip_addr_data->ipv4_ds_addr.ipv4_src,
-				key, size);
-			memcpy(&ip_addr_mask->ipv4_ds_addr.ipv4_src,
-				mask, size);
-		}
-	} else if (orig_prot == NET_PROT_IPV4 &&
-		orig_field == NH_FLD_IPV4_DST_IP) {
-		if (key_profile->ip_addr_type == IP_DST_EXTRACT ||
-			key_profile->ip_addr_type == IP_DST_SRC_EXTRACT) {
-			memcpy(&ip_addr_data->ipv4_ds_addr.ipv4_dst,
-				key, size);
-			memcpy(&ip_addr_mask->ipv4_ds_addr.ipv4_dst,
-				mask, size);
-		} else {
-			memcpy(&ip_addr_data->ipv4_sd_addr.ipv4_dst,
-				key, size);
-			memcpy(&ip_addr_mask->ipv4_sd_addr.ipv4_dst,
-				mask, size);
-		}
-	} else if (orig_prot == NET_PROT_IPV6 &&
-		orig_field == NH_FLD_IPV6_SRC_IP) {
-		if (key_profile->ip_addr_type == IP_SRC_EXTRACT ||
-			key_profile->ip_addr_type == IP_SRC_DST_EXTRACT) {
-			memcpy(ip_addr_data->ipv6_sd_addr.ipv6_src,
-				key, size);
-			memcpy(ip_addr_mask->ipv6_sd_addr.ipv6_src,
-				mask, size);
-		} else {
-			memcpy(ip_addr_data->ipv6_ds_addr.ipv6_src,
-				key, size);
-			memcpy(ip_addr_mask->ipv6_ds_addr.ipv6_src,
-				mask, size);
-		}
-	} else if (orig_prot == NET_PROT_IPV6 &&
-		orig_field == NH_FLD_IPV6_DST_IP) {
-		if (key_profile->ip_addr_type == IP_DST_EXTRACT ||
-			key_profile->ip_addr_type == IP_DST_SRC_EXTRACT) {
-			memcpy(ip_addr_data->ipv6_ds_addr.ipv6_dst,
-				key, size);
-			memcpy(ip_addr_mask->ipv6_ds_addr.ipv6_dst,
-				mask, size);
-		} else {
-			memcpy(ip_addr_data->ipv6_sd_addr.ipv6_dst,
-				key, size);
-			memcpy(ip_addr_mask->ipv6_sd_addr.ipv6_dst,
-				mask, size);
-		}
+		dpkg->extracts[num].type = DPKG_EXTRACT_FROM_HDR;
+		dpkg->extracts[num].extract.from_hdr.prot = prot;
+		dpkg->extracts[num].extract.from_hdr.field = field;
+		dpkg->extracts[num].extract.from_hdr.type = DPKG_FULL_FIELD;
+		dpkg->num_extracts++;
+
+		local_cfg = true;
 	}
 
-	if (dist_type == DPAA2_FLOW_QOS_TYPE) {
-		flow->qos_rule_size =
-			key_profile->ip_addr_extract_off + ipaddr_extract_len;
+	key_addr += ip_addr_offset;
+	mask_addr += ip_addr_offset;
+
+	if (pos == 0) {
+		rte_memcpy(key_addr, key, size);
+		rte_memcpy(mask_addr, mask, size);
 	} else {
-		flow->fs_rule_size =
-			key_profile->ip_addr_extract_off + ipaddr_extract_len;
+		rte_memcpy(key_addr + size, key, size);
+		rte_memcpy(mask_addr + size, mask, size);
 	}
 
+	flow->rule_size = ip_addr_offset + size * (pos + 1);
+
 	if (recfg)
-		*recfg |= local_cfg;
+		(*recfg) |= local_cfg;
 
 	return 0;
 }
 
+static void dpaa2_flow_hdr_hexdump(char *dump_buf,
+	const uint8_t *hdr, uint32_t size)
+{
+	uint32_t i;
+
+	for (i = 0; i < size; i++)
+		sprintf(&dump_buf[i], "%02x ", hdr[i]);
+}
+
 static int
-dpaa2_configure_flow_tunnel_eth(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_tunnel_eth_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
-	const struct rte_flow_item *pattern,
-	int *device_configured)
+	const struct rte_flow_item *pattern, int *extract_cfg,
+	enum dpaa2_flow_dist_type dist_type)
 {
-	int ret, local_cfg = 0;
+	int ret, local_cfg = false;
 	uint32_t group;
 	const struct rte_flow_item_eth *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_priv *priv = flow->priv;
 	const char zero_cmp[RTE_ETHER_ADDR_LEN] = {0};
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
+
+	if (!pattern->spec)
+		return 0;
 
 	group = attr->group;
 
 	/* Parse pattern list to get the matching parameters */
 	spec = pattern->spec;
 	mask = pattern->mask ?
-			pattern->mask : &dpaa2_flow_item_eth_mask;
-
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
-	if (!spec)
-		return 0;
+		pattern->mask : &dpaa2_flow_item_eth_mask;
 
 	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
 		RTE_FLOW_ITEM_TYPE_ETH);
 	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of ethernet failed");
+		dpaa2_flow_hdr_hexdump(hex_dump, (const uint8_t *)mask,
+			sizeof(struct rte_flow_item_eth));
+		DPAA2_PMD_WARN("Extract ethernet(%s) failed(%d)",
+			hex_dump, ret);
 
 		return ret;
 	}
@@ -2128,40 +1940,7 @@ dpaa2_configure_flow_tunnel_eth(struct dpaa2_dev_flow *flow,
 			DPAA2_VXLAN_IN_SADDR0_OFFSET,
 			1, &spec->src.addr_bytes[0],
 			&mask->src.addr_bytes[0],
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-		/*SRC[1:2]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_SADDR1_OFFSET,
-			2, &spec->src.addr_bytes[1],
-			&mask->src.addr_bytes[1],
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-		/*SRC[3:1]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_SADDR3_OFFSET,
-			1, &spec->src.addr_bytes[3],
-			&mask->src.addr_bytes[3],
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-		/*SRC[4:2]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_SADDR4_OFFSET,
-			2, &spec->src.addr_bytes[4],
-			&mask->src.addr_bytes[4],
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		/*SRC[0:1]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_SADDR0_OFFSET,
-			1, &spec->src.addr_bytes[0],
-			&mask->src.addr_bytes[0],
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 		/*SRC[1:2]*/
@@ -2169,7 +1948,7 @@ dpaa2_configure_flow_tunnel_eth(struct dpaa2_dev_flow *flow,
 			DPAA2_VXLAN_IN_SADDR1_OFFSET,
 			2, &spec->src.addr_bytes[1],
 			&mask->src.addr_bytes[1],
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 		/*SRC[3:1]*/
@@ -2177,7 +1956,7 @@ dpaa2_configure_flow_tunnel_eth(struct dpaa2_dev_flow *flow,
 			DPAA2_VXLAN_IN_SADDR3_OFFSET,
 			1, &spec->src.addr_bytes[3],
 			&mask->src.addr_bytes[3],
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 		/*SRC[4:2]*/
@@ -2185,7 +1964,7 @@ dpaa2_configure_flow_tunnel_eth(struct dpaa2_dev_flow *flow,
 			DPAA2_VXLAN_IN_SADDR4_OFFSET,
 			2, &spec->src.addr_bytes[4],
 			&mask->src.addr_bytes[4],
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
@@ -2197,40 +1976,7 @@ dpaa2_configure_flow_tunnel_eth(struct dpaa2_dev_flow *flow,
 			DPAA2_VXLAN_IN_DADDR0_OFFSET,
 			1, &spec->dst.addr_bytes[0],
 			&mask->dst.addr_bytes[0],
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-		/*DST[1:1]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_DADDR1_OFFSET,
-			1, &spec->dst.addr_bytes[1],
-			&mask->dst.addr_bytes[1],
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-		/*DST[2:3]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_DADDR2_OFFSET,
-			3, &spec->dst.addr_bytes[2],
-			&mask->dst.addr_bytes[2],
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-		/*DST[5:1]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_DADDR5_OFFSET,
-			1, &spec->dst.addr_bytes[5],
-			&mask->dst.addr_bytes[5],
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		/*DST[0:1]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_DADDR0_OFFSET,
-			1, &spec->dst.addr_bytes[0],
-			&mask->dst.addr_bytes[0],
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 		/*DST[1:1]*/
@@ -2238,7 +1984,7 @@ dpaa2_configure_flow_tunnel_eth(struct dpaa2_dev_flow *flow,
 			DPAA2_VXLAN_IN_DADDR1_OFFSET,
 			1, &spec->dst.addr_bytes[1],
 			&mask->dst.addr_bytes[1],
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 		/*DST[2:3]*/
@@ -2246,7 +1992,7 @@ dpaa2_configure_flow_tunnel_eth(struct dpaa2_dev_flow *flow,
 			DPAA2_VXLAN_IN_DADDR2_OFFSET,
 			3, &spec->dst.addr_bytes[2],
 			&mask->dst.addr_bytes[2],
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 		/*DST[5:1]*/
@@ -2254,7 +2000,7 @@ dpaa2_configure_flow_tunnel_eth(struct dpaa2_dev_flow *flow,
 			DPAA2_VXLAN_IN_DADDR5_OFFSET,
 			1, &spec->dst.addr_bytes[5],
 			&mask->dst.addr_bytes[5],
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
@@ -2264,76 +2010,65 @@ dpaa2_configure_flow_tunnel_eth(struct dpaa2_dev_flow *flow,
 		ret = dpaa2_flow_add_pr_extract_rule(flow,
 			DPAA2_VXLAN_IN_TYPE_OFFSET,
 			sizeof(rte_be16_t), &spec->type, &mask->type,
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_TYPE_OFFSET,
-			sizeof(rte_be16_t), &spec->type, &mask->type,
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
 
-	(*device_configured) |= local_cfg;
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_eth(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_eth_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
 	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+	int *extract_cfg, enum dpaa2_flow_dist_type dist_type)
 {
 	int ret, local_cfg = 0;
-	uint32_t group;
+	uint32_t bit_offset;
 	const struct rte_flow_item_eth *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_priv *priv = flow->priv;
 	const char zero_cmp[RTE_ETHER_ADDR_LEN] = {0};
 	const struct rte_flow_item *pattern =
 		&dpaa2_pattern->generic_item;
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
 
 	if (dpaa2_pattern->in_tunnel) {
-		return dpaa2_configure_flow_tunnel_eth(flow,
-				dev, attr, pattern, device_configured);
+		return dpaa2_flow_tunnel_eth_extract_rule_set(flow,
+				attr, pattern, extract_cfg,
+				dist_type);
 	}
 
-	group = attr->group;
-
 	/* Parse pattern list to get the matching parameters */
 	spec = pattern->spec;
 	mask = pattern->mask ?
-			pattern->mask : &dpaa2_flow_item_eth_mask;
-
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
+		pattern->mask : &dpaa2_flow_item_eth_mask;
 
 	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_ETH_FRAM, DPAA2_FLOW_QOS_TYPE,
-				group, &local_cfg);
+		ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+			DPAA2_PARSER_MAC_ID);
 		if (ret)
 			return ret;
 
 		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_ETH_FRAM, DPAA2_FLOW_FS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
+				bit_offset, dist_type,
+				attr->group, &local_cfg);
+		if (extract_cfg && !ret)
+			(*extract_cfg) |= local_cfg;
 
-		(*device_configured) |= local_cfg;
-		return 0;
+		return ret;
 	}
 
 	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
 		RTE_FLOW_ITEM_TYPE_ETH);
 	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of ethernet failed");
+		dpaa2_flow_hdr_hexdump(hex_dump, (const uint8_t *)mask,
+			sizeof(struct rte_flow_item_eth));
+		DPAA2_PMD_WARN("Extract ethernet(%s) failed(%d)",
+			hex_dump, ret);
 
 		return ret;
 	}
@@ -2343,14 +2078,7 @@ dpaa2_configure_flow_eth(struct dpaa2_dev_flow *flow,
 		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ETH,
 			NH_FLD_ETH_SA, &spec->src.addr_bytes,
 			&mask->src.addr_bytes, RTE_ETHER_ADDR_LEN,
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ETH,
-			NH_FLD_ETH_SA, &spec->src.addr_bytes,
-			&mask->src.addr_bytes, RTE_ETHER_ADDR_LEN,
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
@@ -2360,14 +2088,7 @@ dpaa2_configure_flow_eth(struct dpaa2_dev_flow *flow,
 		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ETH,
 			NH_FLD_ETH_DA, &spec->dst.addr_bytes,
 			&mask->dst.addr_bytes, RTE_ETHER_ADDR_LEN,
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ETH,
-			NH_FLD_ETH_DA, &spec->dst.addr_bytes,
-			&mask->dst.addr_bytes, RTE_ETHER_ADDR_LEN,
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
@@ -2377,34 +2098,28 @@ dpaa2_configure_flow_eth(struct dpaa2_dev_flow *flow,
 		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ETH,
 			NH_FLD_ETH_TYPE, &spec->type,
 			&mask->type, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ETH,
-			NH_FLD_ETH_TYPE, &spec->type,
-			&mask->type, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
 
-	(*device_configured) |= local_cfg;
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_tunnel_vlan(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_tunnel_vlan_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
-	const struct rte_flow_item *pattern,
-	int *device_configured)
+	const struct rte_flow_item *pattern, int *extract_cfg,
+	enum dpaa2_flow_dist_type dist_type)
 {
-	int ret, local_cfg = 0;
-	uint32_t group;
+	int ret, local_cfg = false;
+	uint32_t group, bit_offset;
 	const struct rte_flow_item_vlan *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_priv *priv = flow->priv;
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
 
 	group = attr->group;
 
@@ -2413,33 +2128,30 @@ dpaa2_configure_flow_tunnel_vlan(struct dpaa2_dev_flow *flow,
 	mask = pattern->mask ?
 		pattern->mask : &dpaa2_flow_item_vlan_mask;
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
 	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_VLAN_FRAM,
-				DPAA2_FLOW_QOS_TYPE,
-				group, &local_cfg);
+		ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+			DPAA2_PARSER_TUNNEL_VLAN_ID);
 		if (ret)
 			return ret;
 
 		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_VLAN_FRAM,
-				DPAA2_FLOW_FS_TYPE,
-				group, &local_cfg);
+				bit_offset, dist_type,
+				attr->group, &local_cfg);
 		if (ret)
 			return ret;
 
-		(*device_configured) |= local_cfg;
+		if (extract_cfg)
+			(*extract_cfg) |= local_cfg;
 		return 0;
 	}
 
 	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
 		RTE_FLOW_ITEM_TYPE_VLAN);
 	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of vlan not support.");
+		dpaa2_flow_hdr_hexdump(hex_dump, (const uint8_t *)mask,
+			sizeof(struct rte_flow_item_vlan));
+		DPAA2_PMD_WARN("Extract vlan(%s) failed(%d)",
+			hex_dump, ret);
 
 		return ret;
 	}
@@ -2450,74 +2162,64 @@ dpaa2_configure_flow_tunnel_vlan(struct dpaa2_dev_flow *flow,
 	ret = dpaa2_flow_add_pr_extract_rule(flow,
 			DPAA2_VXLAN_IN_TCI_OFFSET,
 			sizeof(rte_be16_t), &spec->tci, &mask->tci,
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-	if (ret)
-		return ret;
-
-	ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_TCI_OFFSET,
-			sizeof(rte_be16_t), &spec->tci, &mask->tci,
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, group, &local_cfg, dist_type);
 	if (ret)
 		return ret;
 
-	(*device_configured) |= local_cfg;
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_vlan(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_vlan_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
 	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+	int *extract_cfg, enum dpaa2_flow_dist_type dist_type)
 {
 	int ret, local_cfg = 0;
-	uint32_t group;
+	uint32_t bit_offset;
 	const struct rte_flow_item_vlan *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_priv *priv = flow->priv;
 	const struct rte_flow_item *pattern =
 		&dpaa2_pattern->generic_item;
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
 
 	if (dpaa2_pattern->in_tunnel) {
-		return dpaa2_configure_flow_tunnel_vlan(flow,
-				dev, attr, pattern, device_configured);
+		return dpaa2_flow_tunnel_vlan_extract_rule_set(flow,
+			attr, pattern, extract_cfg,
+			dist_type);
 	}
 
-	group = attr->group;
-
 	/* Parse pattern list to get the matching parameters */
 	spec = pattern->spec;
 	mask = pattern->mask ? pattern->mask : &dpaa2_flow_item_vlan_mask;
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
-	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow, FAF_VLAN_FRAM,
-				DPAA2_FLOW_QOS_TYPE, group,
-				&local_cfg);
-		if (ret)
-			return ret;
+	ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+			DPAA2_PARSER_VLAN_ID);
+	if (ret)
+		return ret;
 
-		ret = dpaa2_flow_identify_by_faf(priv, flow, FAF_VLAN_FRAM,
-				DPAA2_FLOW_FS_TYPE, group,
-				&local_cfg);
-		if (ret)
-			return ret;
+	ret = dpaa2_flow_identify_by_faf(priv, flow,
+			bit_offset, dist_type, attr->group, &local_cfg);
+	if (ret)
+		return ret;
 
-		(*device_configured) |= local_cfg;
+	if (!spec) {
+		if (extract_cfg)
+			(*extract_cfg) |= local_cfg;
 		return 0;
 	}
 
 	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
 			RTE_FLOW_ITEM_TYPE_VLAN);
 	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of vlan not support.");
+		dpaa2_flow_hdr_hexdump(hex_dump, (const uint8_t *)mask,
+			sizeof(struct rte_flow_item_vlan));
+		DPAA2_PMD_WARN("Extract vlan(%s) failed(%d)",
+			hex_dump, ret);
+
 		return ret;
 	}
 
@@ -2527,45 +2229,34 @@ dpaa2_configure_flow_vlan(struct dpaa2_dev_flow *flow,
 	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_VLAN,
 			NH_FLD_VLAN_TCI, &spec->tci,
 			&mask->tci, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-	if (ret)
-		return ret;
-
-	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_VLAN,
-			NH_FLD_VLAN_TCI, &spec->tci,
-			&mask->tci, sizeof(rte_be16_t),
-			priv, group, &local_cfg,
-			DPAA2_FLOW_FS_TYPE);
+			priv, attr->group, &local_cfg, dist_type);
 	if (ret)
 		return ret;
 
-	(*device_configured) |= local_cfg;
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_ipv4(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_ipv4_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
 	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+	int *extract_cfg, enum dpaa2_flow_dist_type dist_type)
 {
 	int ret, local_cfg = 0;
-	uint32_t group;
+	uint32_t bit_offset;
 	const struct rte_flow_item_ipv4 *spec_ipv4 = 0, *mask_ipv4 = 0;
 	const void *key, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_priv *priv = flow->priv;
 	int size;
 	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
-
-	group = attr->group;
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
 
 	/* Parse pattern list to get the matching parameters */
 	spec_ipv4 = pattern->spec;
 	mask_ipv4 = pattern->mask ?
-		    pattern->mask : &dpaa2_flow_item_ipv4_mask;
+		pattern->mask : &dpaa2_flow_item_ipv4_mask;
 
 	if (dpaa2_pattern->in_tunnel) {
 		if (spec_ipv4) {
@@ -2573,44 +2264,48 @@ dpaa2_configure_flow_ipv4(struct dpaa2_dev_flow *flow,
 			return -ENOTSUP;
 		}
 
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_IPV4_FRAM,
-				DPAA2_FLOW_QOS_TYPE, group,
-				&local_cfg);
+		ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+			DPAA2_PARSER_TUNNEL_IPV4_ID);
 		if (ret)
 			return ret;
 
 		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_IPV4_FRAM,
-				DPAA2_FLOW_FS_TYPE, group,
-				&local_cfg);
-		return ret;
+				bit_offset, dist_type,
+				attr->group, &local_cfg);
+		if (ret)
+			return ret;
 	}
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
-	ret = dpaa2_flow_identify_by_faf(priv, flow, FAF_IPV4_FRAM,
-			DPAA2_FLOW_QOS_TYPE, group,
-			&local_cfg);
+	ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+		DPAA2_PARSER_IPV4_ID);
 	if (ret)
 		return ret;
 
-	ret = dpaa2_flow_identify_by_faf(priv, flow, FAF_IPV4_FRAM,
-			DPAA2_FLOW_FS_TYPE, group, &local_cfg);
+	ret = dpaa2_flow_identify_by_faf(priv, flow,
+			bit_offset, dist_type,
+			attr->group, &local_cfg);
 	if (ret)
 		return ret;
 
 	if (!spec_ipv4) {
-		(*device_configured) |= local_cfg;
+		if (flow->ip_key == NET_PROT_IPV6) {
+			DPAA2_PMD_ERR("IPv6 flow has been configured");
+			return -EINVAL;
+		}
+		flow->ip_key = NET_PROT_IPV4;
+		if (extract_cfg)
+			(*extract_cfg) |= local_cfg;
 		return 0;
 	}
 
 	ret = dpaa2_flow_extract_support((const uint8_t *)mask_ipv4,
 			RTE_FLOW_ITEM_TYPE_IPV4);
 	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of IPv4 not support.");
+		dpaa2_flow_hdr_hexdump(hex_dump, (const uint8_t *)mask_ipv4,
+			sizeof(struct rte_flow_item_ipv4));
+		DPAA2_PMD_WARN("Extract IPv4(%s) failed(%d)",
+			hex_dump, ret);
+
 		return ret;
 	}
 
@@ -2620,20 +2315,11 @@ dpaa2_configure_flow_ipv4(struct dpaa2_dev_flow *flow,
 		size = sizeof(rte_be32_t);
 
 		ret = dpaa2_flow_add_ipaddr_extract_rule(flow, NET_PROT_IPV4,
-				NH_FLD_IPV4_SRC_IP,
-				key, mask, size, priv,
-				group, &local_cfg,
-				DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_ipaddr_extract_rule(flow, NET_PROT_IPV4,
-				NH_FLD_IPV4_SRC_IP,
-				key, mask, size, priv,
-				group, &local_cfg,
-				DPAA2_FLOW_FS_TYPE);
+			NH_FLD_IPV4_SRC_IP, key, mask, size, priv,
+			attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
+		flow->ip_src = NET_PROT_IPV4;
 	}
 
 	if (mask_ipv4->hdr.dst_addr) {
@@ -2642,19 +2328,41 @@ dpaa2_configure_flow_ipv4(struct dpaa2_dev_flow *flow,
 		size = sizeof(rte_be32_t);
 
 		ret = dpaa2_flow_add_ipaddr_extract_rule(flow, NET_PROT_IPV4,
-				NH_FLD_IPV4_DST_IP,
-				key, mask, size, priv,
-				group, &local_cfg,
-				DPAA2_FLOW_QOS_TYPE);
+			NH_FLD_IPV4_DST_IP, key, mask, size, priv,
+			attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
-		ret = dpaa2_flow_add_ipaddr_extract_rule(flow, NET_PROT_IPV4,
-				NH_FLD_IPV4_DST_IP,
-				key, mask, size, priv,
-				group, &local_cfg,
-				DPAA2_FLOW_FS_TYPE);
+		flow->ip_dst = NET_PROT_IPV4;
+	}
+
+	if (mask_ipv4->hdr.packet_id) {
+		key = &spec_ipv4->hdr.packet_id;
+		mask = &mask_ipv4->hdr.packet_id;
+		size = sizeof(rte_be16_t);
+		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IP,
+			NH_FLD_IP_ID, key, mask, size,
+			priv, attr->group, &local_cfg, dist_type);
+		if (ret)
+			return ret;
+	}
+
+	if (mask_ipv4->hdr.fragment_offset) {
+		key = &spec_ipv4->hdr.fragment_offset;
+		mask = &mask_ipv4->hdr.fragment_offset;
+		size = sizeof(rte_be16_t);
+
+		ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+			DPAA2_PARSER_IP_FRAG_ID);
+		if (ret)
+			return ret;
+
+		ret = dpaa2_flow_identify_by_faf(priv, flow,
+			bit_offset, dist_type, attr->group, &local_cfg);
 		if (ret)
 			return ret;
+
+		if (spec_ipv4->hdr.fragment_offset)
+			DPAA2_PMD_WARN("Unsupport Extract of frag offset");
 	}
 
 	if (mask_ipv4->hdr.next_proto_id) {
@@ -2663,139 +2371,117 @@ dpaa2_configure_flow_ipv4(struct dpaa2_dev_flow *flow,
 		size = sizeof(uint8_t);
 
 		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IP,
-				NH_FLD_IP_PROTO, key,
-				mask, size, priv, group,
-				&local_cfg,
-				DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IP,
-				NH_FLD_IP_PROTO, key,
-				mask, size, priv, group,
-				&local_cfg,
-				DPAA2_FLOW_FS_TYPE);
+			NH_FLD_IP_PROTO, key, mask, size, priv, attr->group,
+			&local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
+	if (flow->ip_key == NET_PROT_IPV6) {
+		DPAA2_PMD_ERR("IPv6 flow has been configured");
+		return -EINVAL;
+	}
+	flow->ip_key = NET_PROT_IPV4;
 
-	(*device_configured) |= local_cfg;
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_ipv6(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_ipv6_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
 	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+	int *extract_cfg, enum dpaa2_flow_dist_type dist_type)
 {
 	int ret, local_cfg = 0;
-	uint32_t group;
+	uint32_t bit_offset;
 	const struct rte_flow_item_ipv6 *spec_ipv6 = 0, *mask_ipv6 = 0;
 	const void *key, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_priv *priv = flow->priv;
 	const char zero_cmp[NH_FLD_IPV6_ADDR_SIZE] = {0};
 	int size;
 	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
-
-	group = attr->group;
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
 
 	/* Parse pattern list to get the matching parameters */
 	spec_ipv6 = pattern->spec;
 	mask_ipv6 = pattern->mask ? pattern->mask : &dpaa2_flow_item_ipv6_mask;
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
 	if (dpaa2_pattern->in_tunnel) {
 		if (spec_ipv6) {
 			DPAA2_PMD_ERR("Tunnel-IPv6 distribution not support");
 			return -ENOTSUP;
 		}
 
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_IPV6_FRAM,
-				DPAA2_FLOW_QOS_TYPE, group,
-				&local_cfg);
+		ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+			DPAA2_PARSER_TUNNEL_IPV6_ID);
 		if (ret)
 			return ret;
 
 		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_IPV6_FRAM,
-				DPAA2_FLOW_FS_TYPE, group,
-				&local_cfg);
-		return ret;
+			bit_offset, dist_type,
+			attr->group, &local_cfg);
+		if (ret)
+			return ret;
 	}
 
-	ret = dpaa2_flow_identify_by_faf(priv, flow, FAF_IPV6_FRAM,
-			DPAA2_FLOW_QOS_TYPE, group,
-			&local_cfg);
+	ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+		DPAA2_PARSER_IPV6_ID);
 	if (ret)
 		return ret;
 
-	ret = dpaa2_flow_identify_by_faf(priv, flow, FAF_IPV6_FRAM,
-			DPAA2_FLOW_FS_TYPE, group, &local_cfg);
+	ret = dpaa2_flow_identify_by_faf(priv, flow,
+		bit_offset, dist_type, attr->group, &local_cfg);
 	if (ret)
 		return ret;
 
 	if (!spec_ipv6) {
-		(*device_configured) |= local_cfg;
+		if (flow->ip_key == NET_PROT_IPV4) {
+			DPAA2_PMD_ERR("IPv4 flow has been configured");
+			return -EINVAL;
+		}
+		flow->ip_key = NET_PROT_IPV6;
+
+		if (extract_cfg)
+			(*extract_cfg) |= local_cfg;
 		return 0;
 	}
 
 	ret = dpaa2_flow_extract_support((const uint8_t *)mask_ipv6,
 			RTE_FLOW_ITEM_TYPE_IPV6);
 	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of IPv6 not support.");
+		dpaa2_flow_hdr_hexdump(hex_dump, (const uint8_t *)mask_ipv6,
+			sizeof(struct rte_flow_item_ipv6));
+		DPAA2_PMD_WARN("Extract IPv6(%s) failed(%d)",
+			hex_dump, ret);
+
 		return ret;
 	}
 
-	if (memcmp((const char *)&mask_ipv6->hdr.src_addr, zero_cmp, NH_FLD_IPV6_ADDR_SIZE)) {
+	if (memcmp((const void *)&mask_ipv6->hdr.src_addr, zero_cmp, NH_FLD_IPV6_ADDR_SIZE)) {
 		key = &spec_ipv6->hdr.src_addr;
 		mask = &mask_ipv6->hdr.src_addr;
 		size = NH_FLD_IPV6_ADDR_SIZE;
 
 		ret = dpaa2_flow_add_ipaddr_extract_rule(flow, NET_PROT_IPV6,
-				NH_FLD_IPV6_SRC_IP,
-				key, mask, size, priv,
-				group, &local_cfg,
-				DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_ipaddr_extract_rule(flow, NET_PROT_IPV6,
-				NH_FLD_IPV6_SRC_IP,
-				key, mask, size, priv,
-				group, &local_cfg,
-				DPAA2_FLOW_FS_TYPE);
+			NH_FLD_IPV6_SRC_IP, key, mask, size, priv,
+			attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
+		flow->ip_src = NET_PROT_IPV6;
 	}
 
-	if (memcmp((const char *)&mask_ipv6->hdr.dst_addr, zero_cmp, NH_FLD_IPV6_ADDR_SIZE)) {
+	if (memcmp((const void *)&mask_ipv6->hdr.dst_addr, zero_cmp, NH_FLD_IPV6_ADDR_SIZE)) {
 		key = &spec_ipv6->hdr.dst_addr;
 		mask = &mask_ipv6->hdr.dst_addr;
 		size = NH_FLD_IPV6_ADDR_SIZE;
 
 		ret = dpaa2_flow_add_ipaddr_extract_rule(flow, NET_PROT_IPV6,
-				NH_FLD_IPV6_DST_IP,
-				key, mask, size, priv,
-				group, &local_cfg,
-				DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_ipaddr_extract_rule(flow, NET_PROT_IPV6,
-				NH_FLD_IPV6_DST_IP,
-				key, mask, size, priv,
-				group, &local_cfg,
-				DPAA2_FLOW_FS_TYPE);
+			NH_FLD_IPV6_DST_IP, key, mask, size, priv,
+			attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
+		flow->ip_dst = NET_PROT_IPV6;
 	}
 
 	if (mask_ipv6->hdr.proto) {
@@ -2804,78 +2490,68 @@ dpaa2_configure_flow_ipv6(struct dpaa2_dev_flow *flow,
 		size = sizeof(uint8_t);
 
 		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IP,
-				NH_FLD_IP_PROTO, key,
-				mask, size, priv, group,
-				&local_cfg,
-				DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IP,
-				NH_FLD_IP_PROTO, key,
-				mask, size, priv, group,
-				&local_cfg,
-				DPAA2_FLOW_FS_TYPE);
+			NH_FLD_IP_PROTO, key, mask, size, priv, attr->group,
+			&local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
+	if (flow->ip_key == NET_PROT_IPV4) {
+		DPAA2_PMD_ERR("IPv4 flow has been configured");
+		return -EINVAL;
+	}
+	flow->ip_key = NET_PROT_IPV6;
 
-	(*device_configured) |= local_cfg;
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_icmp(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_icmp_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
 	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+	int *extract_cfg, enum dpaa2_flow_dist_type dist_type)
 {
 	int ret, local_cfg = 0;
-	uint32_t group;
+	uint32_t bit_offset;
 	const struct rte_flow_item_icmp *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_priv *priv = flow->priv;
 	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
-
-	group = attr->group;
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
 
 	/* Parse pattern list to get the matching parameters */
 	spec = pattern->spec;
 	mask = pattern->mask ?
 		pattern->mask : &dpaa2_flow_item_icmp_mask;
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
 	if (dpaa2_pattern->in_tunnel) {
 		DPAA2_PMD_ERR("Tunnel-ICMP distribution not support");
 		return -ENOTSUP;
 	}
 
 	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_ICMP_FRAM, DPAA2_FLOW_QOS_TYPE,
-				group, &local_cfg);
+		ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+			DPAA2_PARSER_ICMP_ID);
 		if (ret)
 			return ret;
 
 		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_ICMP_FRAM, DPAA2_FLOW_FS_TYPE,
-				group, &local_cfg);
+			bit_offset, dist_type, attr->group, &local_cfg);
 		if (ret)
 			return ret;
 
-		(*device_configured) |= local_cfg;
+		if (extract_cfg)
+			(*extract_cfg) |= local_cfg;
 		return 0;
 	}
 
 	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
 		RTE_FLOW_ITEM_TYPE_ICMP);
 	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of ICMP not support.");
+		dpaa2_flow_hdr_hexdump(hex_dump, (const uint8_t *)mask,
+			sizeof(struct rte_flow_item_icmp));
+		DPAA2_PMD_WARN("Extract ICMP(%s) failed(%d)",
+			hex_dump, ret);
 
 		return ret;
 	}
@@ -2884,14 +2560,7 @@ dpaa2_configure_flow_icmp(struct dpaa2_dev_flow *flow,
 		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ICMP,
 			NH_FLD_ICMP_TYPE, &spec->hdr.icmp_type,
 			&mask->hdr.icmp_type, sizeof(uint8_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ICMP,
-			NH_FLD_ICMP_TYPE, &spec->hdr.icmp_type,
-			&mask->hdr.icmp_type, sizeof(uint8_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
@@ -2900,90 +2569,75 @@ dpaa2_configure_flow_icmp(struct dpaa2_dev_flow *flow,
 		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ICMP,
 			NH_FLD_ICMP_CODE, &spec->hdr.icmp_code,
 			&mask->hdr.icmp_code, sizeof(uint8_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ICMP,
-			NH_FLD_ICMP_CODE, &spec->hdr.icmp_code,
-			&mask->hdr.icmp_code, sizeof(uint8_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
 
-	(*device_configured) |= local_cfg;
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_udp(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_udp_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
 	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+	int *extract_cfg, enum dpaa2_flow_dist_type dist_type)
 {
 	int ret, local_cfg = 0;
-	uint32_t group;
+	uint32_t bit_offset;
 	const struct rte_flow_item_udp *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_priv *priv = flow->priv;
 	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
-
-	group = attr->group;
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
 
 	/* Parse pattern list to get the matching parameters */
 	spec = pattern->spec;
 	mask = pattern->mask ?
 		pattern->mask : &dpaa2_flow_item_udp_mask;
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
 	if (dpaa2_pattern->in_tunnel) {
 		if (spec) {
 			DPAA2_PMD_ERR("Tunnel-UDP distribution not support");
 			return -ENOTSUP;
 		}
 
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_UDP_FRAM,
-				DPAA2_FLOW_QOS_TYPE, group,
-				&local_cfg);
+		ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+			DPAA2_PARSER_TUNNEL_UDP_ID);
 		if (ret)
 			return ret;
 
 		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_UDP_FRAM,
-				DPAA2_FLOW_FS_TYPE, group,
-				&local_cfg);
-		return ret;
+			bit_offset, dist_type, attr->group, &local_cfg);
+		if (ret)
+			return ret;
 	}
 
-	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_UDP_FRAM, DPAA2_FLOW_QOS_TYPE,
-			group, &local_cfg);
+	ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+		DPAA2_PARSER_UDP_ID);
 	if (ret)
 		return ret;
 
 	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_UDP_FRAM, DPAA2_FLOW_FS_TYPE,
-			group, &local_cfg);
+		bit_offset, dist_type, attr->group, &local_cfg);
 	if (ret)
 		return ret;
 
 	if (!spec) {
-		(*device_configured) |= local_cfg;
+		if (extract_cfg)
+			(*extract_cfg) |= local_cfg;
 		return 0;
 	}
 
 	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
 		RTE_FLOW_ITEM_TYPE_UDP);
 	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of UDP not support.");
+		dpaa2_flow_hdr_hexdump(hex_dump, (const uint8_t *)mask,
+			sizeof(struct rte_flow_item_udp));
+		DPAA2_PMD_ERR("Extract UDP(%s) failed(%d)",
+			hex_dump, ret);
 
 		return ret;
 	}
@@ -2992,14 +2646,7 @@ dpaa2_configure_flow_udp(struct dpaa2_dev_flow *flow,
 		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_UDP,
 			NH_FLD_UDP_PORT_SRC, &spec->hdr.src_port,
 			&mask->hdr.src_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_UDP,
-			NH_FLD_UDP_PORT_SRC, &spec->hdr.src_port,
-			&mask->hdr.src_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
@@ -3008,90 +2655,75 @@ dpaa2_configure_flow_udp(struct dpaa2_dev_flow *flow,
 		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_UDP,
 			NH_FLD_UDP_PORT_DST, &spec->hdr.dst_port,
 			&mask->hdr.dst_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_UDP,
-			NH_FLD_UDP_PORT_DST, &spec->hdr.dst_port,
-			&mask->hdr.dst_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
 
-	(*device_configured) |= local_cfg;
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_tcp(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_tcp_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
 	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+	int *extract_cfg, enum dpaa2_flow_dist_type dist_type)
 {
 	int ret, local_cfg = 0;
-	uint32_t group;
+	uint32_t bit_offset;
 	const struct rte_flow_item_tcp *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_priv *priv = flow->priv;
 	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
-
-	group = attr->group;
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
 
 	/* Parse pattern list to get the matching parameters */
 	spec = pattern->spec;
 	mask = pattern->mask ?
 		pattern->mask : &dpaa2_flow_item_tcp_mask;
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
 	if (dpaa2_pattern->in_tunnel) {
 		if (spec) {
 			DPAA2_PMD_ERR("Tunnel-TCP distribution not support");
 			return -ENOTSUP;
 		}
 
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_TCP_FRAM,
-				DPAA2_FLOW_QOS_TYPE, group,
-				&local_cfg);
+		ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+			DPAA2_PARSER_TUNNEL_TCP_ID);
 		if (ret)
 			return ret;
 
 		ret = dpaa2_flow_identify_by_faf(priv, flow,
-						 FAFE_VXLAN_IN_TCP_FRAM,
-						 DPAA2_FLOW_FS_TYPE, group,
-						 &local_cfg);
-		return ret;
+			bit_offset, dist_type, attr->group, &local_cfg);
+		if (ret)
+			return ret;
 	}
 
-	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_TCP_FRAM, DPAA2_FLOW_QOS_TYPE,
-			group, &local_cfg);
+	ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+		DPAA2_PARSER_TCP_ID);
 	if (ret)
 		return ret;
 
 	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_TCP_FRAM, DPAA2_FLOW_FS_TYPE,
-			group, &local_cfg);
+		bit_offset, dist_type, attr->group, &local_cfg);
 	if (ret)
 		return ret;
 
 	if (!spec) {
-		(*device_configured) |= local_cfg;
+		if (extract_cfg)
+			(*extract_cfg) |= local_cfg;
 		return 0;
 	}
 
 	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
 		RTE_FLOW_ITEM_TYPE_TCP);
 	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of TCP not support.");
+		dpaa2_flow_hdr_hexdump(hex_dump, (const uint8_t *)mask,
+			sizeof(struct rte_flow_item_tcp));
+		DPAA2_PMD_ERR("Extract TCP(%s) failed(%d)",
+			hex_dump, ret);
 
 		return ret;
 	}
@@ -3100,14 +2732,7 @@ dpaa2_configure_flow_tcp(struct dpaa2_dev_flow *flow,
 		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_TCP,
 			NH_FLD_TCP_PORT_SRC, &spec->hdr.src_port,
 			&mask->hdr.src_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_TCP,
-			NH_FLD_TCP_PORT_SRC, &spec->hdr.src_port,
-			&mask->hdr.src_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
@@ -3116,76 +2741,64 @@ dpaa2_configure_flow_tcp(struct dpaa2_dev_flow *flow,
 		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_TCP,
 			NH_FLD_TCP_PORT_DST, &spec->hdr.dst_port,
 			&mask->hdr.dst_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_TCP,
-			NH_FLD_TCP_PORT_DST, &spec->hdr.dst_port,
-			&mask->hdr.dst_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
 
-	(*device_configured) |= local_cfg;
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_esp(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_esp_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
 	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+	int *extract_cfg, enum dpaa2_flow_dist_type dist_type)
 {
 	int ret, local_cfg = 0;
-	uint32_t group;
+	uint32_t bit_offset;
 	const struct rte_flow_item_esp *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_priv *priv = flow->priv;
 	const struct rte_flow_item *pattern =
 		&dpaa2_pattern->generic_item;
-
-	group = attr->group;
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
 
 	/* Parse pattern list to get the matching parameters */
 	spec = pattern->spec;
 	mask = pattern->mask ?
 		pattern->mask : &dpaa2_flow_item_esp_mask;
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
 	if (dpaa2_pattern->in_tunnel) {
 		DPAA2_PMD_ERR("Tunnel-ESP distribution not support");
 		return -ENOTSUP;
 	}
 
-	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_IPSEC_ESP_FRAM, DPAA2_FLOW_QOS_TYPE,
-			group, &local_cfg);
+	ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+		DPAA2_PARSER_IPSEC_ESP_ID);
 	if (ret)
 		return ret;
 
 	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_IPSEC_ESP_FRAM, DPAA2_FLOW_FS_TYPE,
-			group, &local_cfg);
+		bit_offset, dist_type, attr->group, &local_cfg);
 	if (ret)
 		return ret;
 
 	if (!spec) {
-		(*device_configured) |= local_cfg;
+		if (extract_cfg)
+			(*extract_cfg) |= local_cfg;
 		return 0;
 	}
 
 	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
 		RTE_FLOW_ITEM_TYPE_ESP);
 	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of ESP not support.");
+		dpaa2_flow_hdr_hexdump(hex_dump, (const uint8_t *)mask,
+			sizeof(struct rte_flow_item_esp));
+		DPAA2_PMD_ERR("Extract IPSEC ESP(%s) failed(%d)",
+			hex_dump, ret);
 
 		return ret;
 	}
@@ -3194,14 +2807,7 @@ dpaa2_configure_flow_esp(struct dpaa2_dev_flow *flow,
 		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IPSEC_ESP,
 			NH_FLD_IPSEC_ESP_SPI, &spec->hdr.spi,
 			&mask->hdr.spi, sizeof(rte_be32_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IPSEC_ESP,
-			NH_FLD_IPSEC_ESP_SPI, &spec->hdr.spi,
-			&mask->hdr.spi, sizeof(rte_be32_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
@@ -3210,76 +2816,64 @@ dpaa2_configure_flow_esp(struct dpaa2_dev_flow *flow,
 		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IPSEC_ESP,
 			NH_FLD_IPSEC_ESP_SEQUENCE_NUM, &spec->hdr.seq,
 			&mask->hdr.seq, sizeof(rte_be32_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IPSEC_ESP,
-			NH_FLD_IPSEC_ESP_SEQUENCE_NUM, &spec->hdr.seq,
-			&mask->hdr.seq, sizeof(rte_be32_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
 
-	(*device_configured) |= local_cfg;
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_ah(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_ah_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
 	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+	int *extract_cfg, enum dpaa2_flow_dist_type dist_type)
 {
 	int ret, local_cfg = 0;
-	uint32_t group;
+	uint32_t bit_offset;
 	const struct rte_flow_item_ah *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_priv *priv = flow->priv;
 	const struct rte_flow_item *pattern =
 		&dpaa2_pattern->generic_item;
-
-	group = attr->group;
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
 
 	/* Parse pattern list to get the matching parameters */
 	spec = pattern->spec;
 	mask = pattern->mask ?
 		pattern->mask : &dpaa2_flow_item_ah_mask;
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
 	if (dpaa2_pattern->in_tunnel) {
 		DPAA2_PMD_ERR("Tunnel-AH distribution not support");
 		return -ENOTSUP;
 	}
 
-	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_IPSEC_AH_FRAM, DPAA2_FLOW_QOS_TYPE,
-			group, &local_cfg);
+	ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+		DPAA2_PARSER_IPSEC_AH_ID);
 	if (ret)
 		return ret;
 
 	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_IPSEC_AH_FRAM, DPAA2_FLOW_FS_TYPE,
-			group, &local_cfg);
+		bit_offset, dist_type, attr->group, &local_cfg);
 	if (ret)
 		return ret;
 
 	if (!spec) {
-		(*device_configured) |= local_cfg;
+		if (extract_cfg)
+			(*extract_cfg) |= local_cfg;
 		return 0;
 	}
 
 	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
 		RTE_FLOW_ITEM_TYPE_AH);
 	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of AH not support.");
+		dpaa2_flow_hdr_hexdump(hex_dump, (const uint8_t *)mask,
+			sizeof(struct rte_flow_item_ah));
+		DPAA2_PMD_ERR("Extract IPSEC AH(%s) failed(%d)",
+			hex_dump, ret);
 
 		return ret;
 	}
@@ -3288,14 +2882,7 @@ dpaa2_configure_flow_ah(struct dpaa2_dev_flow *flow,
 		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IPSEC_AH,
 			NH_FLD_IPSEC_AH_SPI, &spec->spi,
 			&mask->spi, sizeof(rte_be32_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IPSEC_AH,
-			NH_FLD_IPSEC_AH_SPI, &spec->spi,
-			&mask->spi, sizeof(rte_be32_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
@@ -3305,63 +2892,58 @@ dpaa2_configure_flow_ah(struct dpaa2_dev_flow *flow,
 		return -ENOTSUP;
 	}
 
-	(*device_configured) |= local_cfg;
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_sctp(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_sctp_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
 	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+	int *extract_cfg, enum dpaa2_flow_dist_type dist_type)
 {
 	int ret, local_cfg = 0;
-	uint32_t group;
+	uint32_t bit_offset;
 	const struct rte_flow_item_sctp *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_priv *priv = flow->priv;
 	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
-
-	group = attr->group;
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
 
 	/* Parse pattern list to get the matching parameters */
 	spec = pattern->spec;
 	mask = pattern->mask ?
 		pattern->mask : &dpaa2_flow_item_sctp_mask;
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
 	if (dpaa2_pattern->in_tunnel) {
 		DPAA2_PMD_ERR("Tunnel-SCTP distribution not support");
 		return -ENOTSUP;
 	}
 
-	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_SCTP_FRAM, DPAA2_FLOW_QOS_TYPE,
-			group, &local_cfg);
+	ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+			DPAA2_PARSER_SCTP_ID);
 	if (ret)
 		return ret;
 
 	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_SCTP_FRAM, DPAA2_FLOW_FS_TYPE,
-			group, &local_cfg);
+		bit_offset, dist_type, attr->group, &local_cfg);
 	if (ret)
 		return ret;
 
 	if (!spec) {
-		(*device_configured) |= local_cfg;
+		if (extract_cfg)
+			(*extract_cfg) |= local_cfg;
 		return 0;
 	}
 
 	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
 		RTE_FLOW_ITEM_TYPE_SCTP);
 	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of SCTP not support.");
+		dpaa2_flow_hdr_hexdump(hex_dump, (const uint8_t *)mask,
+			sizeof(struct rte_flow_item_sctp));
+		DPAA2_PMD_ERR("Extract SCTP(%s) failed(%d)",
+			hex_dump, ret);
 
 		return ret;
 	}
@@ -3370,14 +2952,7 @@ dpaa2_configure_flow_sctp(struct dpaa2_dev_flow *flow,
 		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_SCTP,
 			NH_FLD_SCTP_PORT_SRC, &spec->hdr.src_port,
 			&mask->hdr.src_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_SCTP,
-			NH_FLD_SCTP_PORT_SRC, &spec->hdr.src_port,
-			&mask->hdr.src_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
@@ -3386,80 +2961,63 @@ dpaa2_configure_flow_sctp(struct dpaa2_dev_flow *flow,
 		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_SCTP,
 			NH_FLD_SCTP_PORT_DST, &spec->hdr.dst_port,
 			&mask->hdr.dst_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_SCTP,
-			NH_FLD_SCTP_PORT_DST, &spec->hdr.dst_port,
-			&mask->hdr.dst_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			priv, attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
 
-	(*device_configured) |= local_cfg;
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_gre(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_gre_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
 	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+	int *extract_cfg, enum dpaa2_flow_dist_type dist_type)
 {
 	int ret, local_cfg = 0;
-	uint32_t group;
+	uint32_t bit_offset;
 	const struct rte_flow_item_gre *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_priv *priv = flow->priv;
 	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
-
-	group = attr->group;
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
 
 	/* Parse pattern list to get the matching parameters */
 	spec = pattern->spec;
 	mask = pattern->mask ?
 		pattern->mask : &dpaa2_flow_item_gre_mask;
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
 	if (dpaa2_pattern->in_tunnel) {
 		DPAA2_PMD_ERR("Tunnel-GRE distribution not support");
 		return -ENOTSUP;
 	}
 
 	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_GRE_FRAM, DPAA2_FLOW_QOS_TYPE,
-				group, &local_cfg);
+		ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+			DPAA2_PARSER_GRE_ID);
 		if (ret)
 			return ret;
 
 		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_GRE_FRAM, DPAA2_FLOW_FS_TYPE,
-				group, &local_cfg);
+			bit_offset, dist_type, attr->group, &local_cfg);
 		if (ret)
 			return ret;
 
-		(*device_configured) |= local_cfg;
+		if (extract_cfg)
+			(*extract_cfg) |= local_cfg;
 		return 0;
 	}
 
-	if (!priv->sp_protocol) {
-		DPAA2_PMD_ERR("vXLAN flow with spec is not supported without SP.");
-		return -ENOTSUP;
-	}
-
 	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
 		RTE_FLOW_ITEM_TYPE_GRE);
 	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of GRE not support.");
+		dpaa2_flow_hdr_hexdump(hex_dump, (const uint8_t *)mask,
+			sizeof(struct rte_flow_item_gre));
+		DPAA2_PMD_ERR("Extract GRE(%s) failed(%d)",
+			hex_dump, ret);
 
 		return ret;
 	}
@@ -3468,81 +3026,65 @@ dpaa2_configure_flow_gre(struct dpaa2_dev_flow *flow,
 		return 0;
 
 	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_GRE,
-			NH_FLD_GRE_TYPE, &spec->protocol,
-			&mask->protocol, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-	if (ret)
-		return ret;
-
-	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_GRE,
-			NH_FLD_GRE_TYPE, &spec->protocol,
-			&mask->protocol, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+		NH_FLD_GRE_TYPE, &spec->protocol, &mask->protocol,
+		sizeof(rte_be16_t), priv, attr->group, &local_cfg, dist_type);
 	if (ret)
 		return ret;
 
-	(*device_configured) |= local_cfg;
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_vxlan(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_vxlan_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
 	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+	int *extract_cfg, enum dpaa2_flow_dist_type dist_type)
 {
 	int ret, local_cfg = 0;
-	uint32_t group;
+	uint32_t bit_offset;
 	const struct rte_flow_item_vxlan *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_priv *priv = flow->priv;
 	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
-
-	if (!priv->sp_protocol) {
-		DPAA2_PMD_ERR("eCPRI flow is not supported without SP.");
-		return -ENOTSUP;
-	}
-
-	group = attr->group;
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
 
 	/* Parse pattern list to get the matching parameters */
 	spec = pattern->spec;
 	mask = pattern->mask ?
 		pattern->mask : &dpaa2_flow_item_vxlan_mask;
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
 	if (dpaa2_pattern->in_tunnel) {
 		DPAA2_PMD_ERR("Tunnel-VXLAN distribution not support");
 		return -ENOTSUP;
 	}
 
-	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_VXLAN_FRAM, DPAA2_FLOW_QOS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
+	ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+		DPAA2_PARSER_VXLAN_ID);
+	if (ret)
+		return ret;
 
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_VXLAN_FRAM, DPAA2_FLOW_FS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
+	ret = dpaa2_flow_identify_by_faf(priv, flow,
+		bit_offset, dist_type, attr->group, &local_cfg);
+	if (ret)
+		return ret;
 
-		(*device_configured) |= local_cfg;
-		return 0;
+	if (!spec)
+		goto quit;
+
+	if (!priv->sp_protocol) {
+		DPAA2_PMD_ERR("vXLAN flow with spec is not supported without SP.");
+		return -ENOTSUP;
 	}
 
 	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
 		RTE_FLOW_ITEM_TYPE_VXLAN);
 	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of VXLAN not support.");
+		dpaa2_flow_hdr_hexdump(hex_dump, (const uint8_t *)mask,
+			sizeof(struct rte_flow_item_vxlan));
+		DPAA2_PMD_ERR("Extract vXLAN(%s) failed(%d)",
+			hex_dump, ret);
 
 		return ret;
 	}
@@ -3562,55 +3104,45 @@ dpaa2_configure_flow_vxlan(struct dpaa2_dev_flow *flow,
 	if (mask->vni[0] || mask->vni[1] || mask->vni[2]) {
 		ret = dpaa2_flow_add_pr_extract_rule(flow,
 			DPAA2_VXLAN_VNI_OFFSET,
-			sizeof(mask->vni), spec->vni,
-			mask->vni,
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_VNI_OFFSET,
-			sizeof(mask->vni), spec->vni,
-			mask->vni,
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+			sizeof(mask->vni), spec->vni, mask->vni,
+			priv, attr->group, &local_cfg, dist_type);
 		if (ret)
 			return ret;
 	}
 
-	(*device_configured) |= local_cfg;
+quit:
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_ecpri(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_ecpri_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
 	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+	int *extract_cfg, enum dpaa2_flow_dist_type dist_type)
 {
 	int ret, local_cfg = 0;
-	uint32_t group;
+	uint32_t bit_offset;
 	const struct rte_flow_item_ecpri *spec, *mask;
 	struct rte_flow_item_ecpri local_mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_priv *priv = flow->priv;
 	const struct rte_flow_item *pattern =
 		&dpaa2_pattern->generic_item;
-	uint8_t extract_nb = 0, i;
+	int extract_nb, i;
 	uint64_t rule_data[DPAA2_ECPRI_MAX_EXTRACT_NB];
 	uint64_t mask_data[DPAA2_ECPRI_MAX_EXTRACT_NB];
 	uint8_t extract_size[DPAA2_ECPRI_MAX_EXTRACT_NB];
 	uint8_t extract_off[DPAA2_ECPRI_MAX_EXTRACT_NB];
+	union dpaa2_sp_fafe_parse fafe;
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
 
 	if (!priv->sp_protocol) {
-		DPAA2_PMD_ERR("ROCEV2 flow is not supported without SP.");
+		DPAA2_PMD_ERR("eCPRI flow is not supported without SP.");
 		return -ENOTSUP;
 	}
 
-	group = attr->group;
-
 	/* Parse pattern list to get the matching parameters */
 	spec = pattern->spec;
 	if (pattern->mask) {
@@ -3623,353 +3155,111 @@ dpaa2_configure_flow_ecpri(struct dpaa2_dev_flow *flow,
 		mask = &dpaa2_flow_item_ecpri_mask;
 	}
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
 	if (dpaa2_pattern->in_tunnel) {
 		DPAA2_PMD_ERR("Tunnel-ECPRI distribution not support");
 		return -ENOTSUP;
 	}
 
-	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAFE_ECPRI_FRAM, DPAA2_FLOW_QOS_TYPE,
-			group, &local_cfg);
-		if (ret)
-			return ret;
+	ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+		DPAA2_PARSER_ECPRI_ID);
+	if (ret)
+		return ret;
 
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAFE_ECPRI_FRAM, DPAA2_FLOW_FS_TYPE,
-			group, &local_cfg);
-		if (ret)
-			return ret;
+	ret = dpaa2_flow_identify_by_faf(priv, flow,
+		bit_offset, dist_type,
+		attr->group, &local_cfg);
+	if (ret)
+		return ret;
 
-		(*device_configured) |= local_cfg;
-		return 0;
-	}
+	if (!spec)
+		goto quit;
 
 	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
 		RTE_FLOW_ITEM_TYPE_ECPRI);
 	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of ECPRI not support.");
+		dpaa2_flow_hdr_hexdump(hex_dump, (const uint8_t *)mask,
+			sizeof(struct rte_flow_item_ecpri));
+		DPAA2_PMD_ERR("Extract eCPRI(%s) failed(%d)",
+			hex_dump, ret);
 
 		return ret;
 	}
 
-	if (mask->hdr.common.type != 0xff) {
-		DPAA2_PMD_WARN("ECPRI header type not specified.");
-
-		return -EINVAL;
-	}
+	memset(&fafe, 0, sizeof(union dpaa2_sp_fafe_parse));
+	extract_nb = dpaa2_parser_ecpri_extract(spec, mask,
+		rule_data, mask_data, extract_size, extract_off,
+		&fafe, DPAA2_ECPRI_MAX_EXTRACT_NB);
+	if (extract_nb < 0) {
+		DPAA2_PMD_ERR("Extract eCPRI from spec/mask failed(%d)",
+			extract_nb);
 
-	if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_IQ_DATA) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_0;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type0.pc_id) {
-			rule_data[extract_nb] = spec->hdr.type0.pc_id;
-			mask_data[extract_nb] = mask->hdr.type0.pc_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_iq_data, pc_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type0.seq_id) {
-			rule_data[extract_nb] = spec->hdr.type0.seq_id;
-			mask_data[extract_nb] = mask->hdr.type0.seq_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_iq_data, seq_id);
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_BIT_SEQ) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_1;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type1.pc_id) {
-			rule_data[extract_nb] = spec->hdr.type1.pc_id;
-			mask_data[extract_nb] = mask->hdr.type1.pc_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_bit_seq, pc_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type1.seq_id) {
-			rule_data[extract_nb] = spec->hdr.type1.seq_id;
-			mask_data[extract_nb] = mask->hdr.type1.seq_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_bit_seq, seq_id);
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_RTC_CTRL) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_2;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type2.rtc_id) {
-			rule_data[extract_nb] = spec->hdr.type2.rtc_id;
-			mask_data[extract_nb] = mask->hdr.type2.rtc_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_rtc_ctrl, rtc_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type2.seq_id) {
-			rule_data[extract_nb] = spec->hdr.type2.seq_id;
-			mask_data[extract_nb] = mask->hdr.type2.seq_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_rtc_ctrl, seq_id);
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_GEN_DATA) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_3;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type3.pc_id || mask->hdr.type3.seq_id)
-			DPAA2_PMD_WARN("Extract type3 msg not support.");
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_RM_ACC) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_4;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type4.rma_id) {
-			rule_data[extract_nb] = spec->hdr.type4.rma_id;
-			mask_data[extract_nb] = mask->hdr.type4.rma_id;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET + 0;
-				/** Compiler not support to take address
-				 * of bit-field
-				 * offsetof(struct rte_ecpri_msg_rm_access,
-				 * rma_id);
-				 */
-			extract_nb++;
-		}
-		if (mask->hdr.type4.ele_id) {
-			rule_data[extract_nb] = spec->hdr.type4.ele_id;
-			mask_data[extract_nb] = mask->hdr.type4.ele_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET + 2;
-				/** Compiler not support to take address
-				 * of bit-field
-				 * offsetof(struct rte_ecpri_msg_rm_access,
-				 * ele_id);
-				 */
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_DLY_MSR) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_5;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type5.msr_id) {
-			rule_data[extract_nb] = spec->hdr.type5.msr_id;
-			mask_data[extract_nb] = mask->hdr.type5.msr_id;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_delay_measure,
-					msr_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type5.act_type) {
-			rule_data[extract_nb] = spec->hdr.type5.act_type;
-			mask_data[extract_nb] = mask->hdr.type5.act_type;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_delay_measure,
-					act_type);
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_RMT_RST) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_6;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type6.rst_id) {
-			rule_data[extract_nb] = spec->hdr.type6.rst_id;
-			mask_data[extract_nb] = mask->hdr.type6.rst_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_remote_reset,
-					rst_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type6.rst_op) {
-			rule_data[extract_nb] = spec->hdr.type6.rst_op;
-			mask_data[extract_nb] = mask->hdr.type6.rst_op;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_remote_reset,
-					rst_op);
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_EVT_IND) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_7;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type7.evt_id) {
-			rule_data[extract_nb] = spec->hdr.type7.evt_id;
-			mask_data[extract_nb] = mask->hdr.type7.evt_id;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_event_ind,
-					evt_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type7.evt_type) {
-			rule_data[extract_nb] = spec->hdr.type7.evt_type;
-			mask_data[extract_nb] = mask->hdr.type7.evt_type;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_event_ind,
-					evt_type);
-			extract_nb++;
-		}
-		if (mask->hdr.type7.seq) {
-			rule_data[extract_nb] = spec->hdr.type7.seq;
-			mask_data[extract_nb] = mask->hdr.type7.seq;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_event_ind,
-					seq);
-			extract_nb++;
-		}
-		if (mask->hdr.type7.number) {
-			rule_data[extract_nb] = spec->hdr.type7.number;
-			mask_data[extract_nb] = mask->hdr.type7.number;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_event_ind,
-					number);
-			extract_nb++;
-		}
-	} else {
-		DPAA2_PMD_ERR("Invalid ecpri header type(%d)",
-				spec->hdr.common.type);
-		return -EINVAL;
+		return extract_nb;
 	}
 
 	for (i = 0; i < extract_nb; i++) {
 		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			extract_off[i],
-			extract_size[i], &rule_data[i], &mask_data[i],
-			priv, group,
-			device_configured,
-			DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			extract_off[i],
-			extract_size[i], &rule_data[i], &mask_data[i],
-			priv, group,
-			device_configured,
-			DPAA2_FLOW_FS_TYPE);
+			extract_off[i], extract_size[i],
+			&rule_data[i], &mask_data[i],
+			priv, attr->group, extract_cfg,
+			dist_type);
 		if (ret)
 			return ret;
 	}
 
-	(*device_configured) |= local_cfg;
+quit:
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_gtp(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_gtp_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
 	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+	int *extract_cfg, enum dpaa2_flow_dist_type dist_type)
 {
 	int ret, local_cfg = 0;
-	uint32_t group;
+	uint32_t bit_offset;
 	const struct rte_flow_item_gtp *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_priv *priv = flow->priv;
 	const struct rte_flow_item *pattern =
 		&dpaa2_pattern->generic_item;
-
-	if (!priv->sp_protocol) {
-		DPAA2_PMD_ERR("GENEVE flow is not supported without SP.");
-		return -ENOTSUP;
-	}
-
-	group = attr->group;
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
 
 	/* Parse pattern list to get the matching parameters */
 	spec = pattern->spec;
 	mask = pattern->mask ?
 		pattern->mask : &dpaa2_flow_item_gtp_mask;
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
 	if (dpaa2_pattern->in_tunnel) {
 		DPAA2_PMD_ERR("Tunnel-GTP distribution not support");
 		return -ENOTSUP;
 	}
 
 	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_GTP_FRAM, DPAA2_FLOW_QOS_TYPE,
-				group, &local_cfg);
+		ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+			DPAA2_PARSER_GTP_ID);
 		if (ret)
 			return ret;
 
 		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_GTP_FRAM, DPAA2_FLOW_FS_TYPE,
-				group, &local_cfg);
+			bit_offset, dist_type, attr->group, &local_cfg);
 		if (ret)
 			return ret;
 
-		(*device_configured) |= local_cfg;
+		if (extract_cfg)
+			(*extract_cfg) |= local_cfg;
 		return 0;
 	}
 
 	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
 		RTE_FLOW_ITEM_TYPE_GTP);
 	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of GTP not support.");
+		dpaa2_flow_hdr_hexdump(hex_dump, (const uint8_t *)mask,
+			sizeof(struct rte_flow_item_gtp));
+		DPAA2_PMD_ERR("Extract GTP(%s) failed(%d)",
+			hex_dump, ret);
 
 		return ret;
 	}
@@ -3978,298 +3268,236 @@ dpaa2_configure_flow_gtp(struct dpaa2_dev_flow *flow,
 		return 0;
 
 	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_GTP,
-			NH_FLD_GTP_TEID, &spec->teid,
-			&mask->teid, sizeof(rte_be32_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-	if (ret)
-		return ret;
-
-	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_GTP,
-			NH_FLD_GTP_TEID, &spec->teid,
-			&mask->teid, sizeof(rte_be32_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+		NH_FLD_GTP_TEID, &spec->teid, &mask->teid,
+		sizeof(rte_be32_t), priv, attr->group,
+		&local_cfg, dist_type);
 	if (ret)
 		return ret;
 
-	(*device_configured) |= local_cfg;
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_mpls(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_raw_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
 	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+	int *extract_cfg, enum dpaa2_flow_dist_type dist_type)
 {
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_mpls *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const struct rte_flow_item *pattern =
-		&dpaa2_pattern->generic_item;
-
-	group = attr->group;
-
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	mask = pattern->mask ?
-		pattern->mask : &dpaa2_flow_item_mpls_mask;
-
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
+	struct dpaa2_dev_priv *priv = flow->priv;
+	int local_cfg = 0, ret;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
+	const struct rte_flow_item_raw *spec = pattern->spec;
+	const struct rte_flow_item_raw *mask = pattern->mask;
 
-	if (dpaa2_pattern->in_tunnel) {
-		DPAA2_PMD_ERR("Tunnel-MPLS distribution not support");
-		return -ENOTSUP;
+	/* Need both spec and mask */
+	if (!spec || !mask) {
+		DPAA2_PMD_ERR("spec or mask not present.");
+		return -EINVAL;
 	}
 
-	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_MPLS_FRAM, DPAA2_FLOW_QOS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_MPLS_FRAM, DPAA2_FLOW_FS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
+	if (spec->relative) {
+		/* TBD: relative offset support.
+		 * To support relative offset of previous L3 protocol item,
+		 * extracts should be expanded to identify if the frame is:
+		 * vlan or none-vlan.
+		 *
+		 * To support relative offset of previous L4 protocol item,
+		 * extracts should be expanded to identify if the frame is:
+		 * vlan/IPv4 or vlan/IPv6 or none-vlan/IPv4 or none-vlan/IPv6.
+		 */
+		DPAA2_PMD_ERR("relative not supported.");
+		return -EINVAL;
+	}
 
-		(*device_configured) |= local_cfg;
-		return 0;
+	if (spec->search) {
+		DPAA2_PMD_ERR("search not supported.");
+		return -EINVAL;
 	}
 
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_MPLS);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of MPLS not support.");
-		return ret;
+	/* Spec len and mask len should be same */
+	if (spec->length != mask->length) {
+		DPAA2_PMD_ERR("Spec len and mask len mismatch.");
+		return -EINVAL;
 	}
 
-	if (!mask->label_tc_s[0] && !mask->label_tc_s[1] &&
-		!mask->label_tc_s[2])
-		return 0;
+	if (dist_type == DPAA2_FLOW_QOS_TYPE)
+		tbl_profile = &priv->flow_profile.qos_profile;
+	else
+		tbl_profile = &priv->flow_profile.tc_profile[attr->group];
 
-	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_MPLS,
-			NH_FLD_MPLS_MPLSL_1, spec->label_tc_s,
-			mask->label_tc_s, sizeof(mask->label_tc_s),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-	if (ret)
+	ret = dpaa2_flow_extract_add_raw(priv,
+		spec->offset, spec->length, dist_type,
+		attr->group, &local_cfg);
+	if (ret) {
+		DPAA2_PMD_ERR("QoS Extract RAW add failed(%d).", ret);
 		return ret;
+	}
 
-	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_MPLS,
-			NH_FLD_MPLS_MPLSL_1, spec->label_tc_s,
-			mask->label_tc_s, sizeof(mask->label_tc_s),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-	if (ret)
-		return ret;
+	if (dist_type == DPAA2_FLOW_QOS_TYPE ||
+		dist_type == DPAA2_FLOW_FS_TYPE) {
+		ret = dpaa2_flow_raw_rule_data_set(flow,
+			&tbl_profile->key_profile,
+			spec->offset, spec->length,
+			spec->pattern, mask->pattern,
+			dist_type);
+		if (ret) {
+			DPAA2_PMD_ERR("QoS RAW rule data set failed(%d)", ret);
+			return ret;
+		}
+	}
 
-	(*device_configured) |= local_cfg;
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_pppoe(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+dpaa2_flow_geneve_extract_rule_set(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_attr *attr,
 	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+	int *extract_cfg, enum dpaa2_flow_dist_type dist_type)
 {
 	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_pppoe *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const struct rte_flow_item *pattern =
-		&dpaa2_pattern->generic_item;
+	uint32_t bit_offset;
+	const struct rte_flow_item_geneve *spec, *mask;
+	struct dpaa2_dev_priv *priv = flow->priv;
+	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
 
-	group = attr->group;
+	if (!priv->sp_protocol) {
+		DPAA2_PMD_ERR("GENEVE flow is not supported without SP.");
+		return -ENOTSUP;
+	}
 
 	/* Parse pattern list to get the matching parameters */
 	spec = pattern->spec;
 	mask = pattern->mask ?
-		pattern->mask : &dpaa2_flow_item_pppoe_mask;
-
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
+		pattern->mask : &dpaa2_flow_item_geneve_mask;
 
 	if (dpaa2_pattern->in_tunnel) {
-		DPAA2_PMD_ERR("Tunnel-PPPoE distribution not support");
+		DPAA2_PMD_ERR("Tunnel-GENEVE distribution not support");
 		return -ENOTSUP;
 	}
 
-	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_PPPOE_PPP_FRAM, DPAA2_FLOW_QOS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_PPPOE_PPP_FRAM, DPAA2_FLOW_FS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
-
-		(*device_configured) |= local_cfg;
-		return 0;
-	}
-
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_PPPOES);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of PPPoE not support.");
-		return ret;
-	}
-
-	if (!mask->session_id)
-		return 0;
-
-	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_PPPOE,
-			NH_FLD_PPPOE_SID, &spec->session_id,
-			&mask->session_id, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
+	ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+		DPAA2_PARSER_GENEVE_ID);
 	if (ret)
 		return ret;
 
-	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_PPPOE,
-			NH_FLD_PPPOE_SID, &spec->session_id,
-			&mask->session_id, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+	ret = dpaa2_flow_identify_by_faf(priv, flow,
+		bit_offset, dist_type, attr->group, &local_cfg);
 	if (ret)
 		return ret;
 
-	(*device_configured) |= local_cfg;
-
-	return 0;
-}
+	if (!spec)
+		goto quit;
 
-static int
-dpaa2_configure_flow_raw(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
-{
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	int local_cfg = 0, ret;
-	uint32_t group;
-	struct dpaa2_key_extract *qos_key_extract;
-	struct dpaa2_key_extract *tc_key_extract;
-	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
-	const struct rte_flow_item_raw *spec = pattern->spec;
-	const struct rte_flow_item_raw *mask = pattern->mask;
+	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
+		RTE_FLOW_ITEM_TYPE_GENEVE);
+	if (ret) {
+		dpaa2_flow_hdr_hexdump(hex_dump, (const uint8_t *)mask,
+			sizeof(struct rte_flow_item_geneve));
+		DPAA2_PMD_ERR("Extract GENEVE(%s) failed(%d)",
+			hex_dump, ret);
 
-	/* Need both spec and mask */
-	if (!spec || !mask) {
-		DPAA2_PMD_ERR("spec or mask not present.");
-		return -EINVAL;
+		return ret;
 	}
 
-	if (spec->relative) {
-		/* TBD: relative offset support.
-		 * To support relative offset of previous L3 protocol item,
-		 * extracts should be expanded to identify if the frame is:
-		 * vlan or none-vlan.
-		 *
-		 * To support relative offset of previous L4 protocol item,
-		 * extracts should be expanded to identify if the frame is:
-		 * vlan/IPv4 or vlan/IPv6 or none-vlan/IPv4 or none-vlan/IPv6.
-		 */
-		DPAA2_PMD_ERR("relative not supported.");
+	if (mask->protocol && mask->protocol != 0xffff) {
+		DPAA2_PMD_ERR("Not support to extract geneve protocol.");
 		return -EINVAL;
 	}
 
-	if (spec->search) {
-		DPAA2_PMD_ERR("search not supported.");
-		return -EINVAL;
+	if (mask->protocol) {
+		ret = dpaa2_flow_add_pr_extract_rule(flow,
+			DPAA2_GENEVE_PROTOCOL_OFFSET,
+			sizeof(mask->protocol), &spec->protocol,
+			&mask->protocol, priv, attr->group, &local_cfg,
+			dist_type);
+		if (ret)
+			return ret;
 	}
 
-	/* Spec len and mask len should be same */
-	if (spec->length != mask->length) {
-		DPAA2_PMD_ERR("Spec len and mask len mismatch.");
-		return -EINVAL;
+	if (mask->vni[0] || mask->vni[1] || mask->vni[2]) {
+		ret = dpaa2_flow_add_pr_extract_rule(flow,
+			DPAA2_GENEVE_VNI_OFFSET,
+			sizeof(mask->vni), spec->vni,
+			mask->vni,
+			priv, attr->group, &local_cfg, dist_type);
+		if (ret)
+			return ret;
 	}
 
-	/* Get traffic class index and flow id to be configured */
-	group = attr->group;
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
-	qos_key_extract = &priv->extract.qos_key_extract;
-	tc_key_extract = &priv->extract.tc_key_extract[group];
-
-	ret = dpaa2_flow_extract_add_raw(priv,
-			spec->offset, spec->length,
-			DPAA2_FLOW_QOS_TYPE, 0, &local_cfg);
-	if (ret) {
-		DPAA2_PMD_ERR("QoS Extract RAW add failed.");
-		return -EINVAL;
-	}
+quit:
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
 
-	ret = dpaa2_flow_extract_add_raw(priv,
-			spec->offset, spec->length,
-			DPAA2_FLOW_FS_TYPE, group, &local_cfg);
-	if (ret) {
-		DPAA2_PMD_ERR("FS[%d] Extract RAW add failed.",
-			group);
-		return -EINVAL;
-	}
+	return 0;
+}
 
-	ret = dpaa2_flow_raw_rule_data_set(flow,
-			&qos_key_extract->key_profile,
-			spec->offset, spec->length,
-			spec->pattern, mask->pattern,
-			DPAA2_FLOW_QOS_TYPE);
-	if (ret) {
-		DPAA2_PMD_ERR("QoS RAW rule data set failed");
-		return -EINVAL;
-	}
+static inline int
+dpaa2_flow_verify_entry(struct dpaa2_dev_priv *priv,
+	uint16_t tc, uint16_t entry_idx,
+	enum dpaa2_flow_dist_type dist_type)
+{
+	struct dpaa2_dev_flow *curr = LIST_FIRST(&priv->flows);
 
-	ret = dpaa2_flow_raw_rule_data_set(flow,
-			&tc_key_extract->key_profile,
-			spec->offset, spec->length,
-			spec->pattern, mask->pattern,
-			DPAA2_FLOW_FS_TYPE);
-	if (ret) {
-		DPAA2_PMD_ERR("FS RAW rule data set failed");
-		return -EINVAL;
+	while (curr) {
+		if (dist_type == DPAA2_FLOW_QOS_TYPE &&
+			curr->qos_flow &&
+			curr->qos_flow->entry_index == entry_idx) {
+			DPAA2_PMD_ERR("Flow QoS.entry[%d] exists",
+				curr->qos_flow->entry_index);
+			return -EEXIST;
+		}
+		if (dist_type == DPAA2_FLOW_FS_TYPE &&
+			curr->fs_flow && curr->fs_flow->tc_id == tc &&
+			curr->fs_flow->entry_index == entry_idx) {
+			DPAA2_PMD_ERR("Flow TC[%d].entry[%d] exists",
+				tc, curr->fs_flow->entry_index);
+			return -EEXIST;
+		}
+		curr = LIST_NEXT(curr, next);
 	}
 
-	(*device_configured) |= local_cfg;
-
 	return 0;
 }
 
 static inline int
-dpaa2_flow_verify_attr(struct dpaa2_dev_priv *priv,
-	const struct rte_flow_attr *attr)
+dpaa2_flow_acquire_entry_idx(struct dpaa2_dev_priv *priv,
+	uint16_t idx, enum dpaa2_flow_dist_type dist_type,
+	uint8_t group)
 {
-	struct dpaa2_dev_flow *curr = LIST_FIRST(&priv->flows);
+	int occupied = -1;
+	uint16_t max_entries;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 
-	while (curr) {
-		if (curr->tc_id == attr->group &&
-			curr->tc_index == attr->priority) {
-			DPAA2_PMD_ERR("Flow(TC[%d].entry[%d] exists",
-				attr->group, attr->priority);
+	if (dist_type == DPAA2_FLOW_QOS_TYPE) {
+		tbl_profile = &priv->flow_profile.qos_profile;
+		max_entries = priv->qos_entries;
+	} else {
+		tbl_profile = &priv->flow_profile.tc_profile[group];
+		max_entries = priv->fs_entries;
+	}
 
-			return -EINVAL;
+	if (!dpaa2_flow_entry_map_get(tbl_profile->entry_map, idx))
+		return idx;
+
+	idx = 0;
+	while (idx < max_entries) {
+		if (!dpaa2_flow_entry_map_get(tbl_profile->entry_map, idx)) {
+			occupied = idx;
+			break;
 		}
-		curr = LIST_NEXT(curr, next);
+		idx++;
 	}
 
-	return 0;
+	return occupied;
 }
 
 static inline struct rte_eth_dev *
@@ -4306,7 +3534,7 @@ dpaa2_flow_redirect_dev(struct dpaa2_dev_priv *priv,
 }
 
 static inline int
-dpaa2_flow_verify_action(struct dpaa2_dev_priv *priv,
+dpaa2_flow_verify_fs_action(struct dpaa2_dev_priv *priv,
 	const struct rte_flow_attr *attr,
 	const struct rte_flow_action actions[])
 {
@@ -4332,46 +3560,51 @@ dpaa2_flow_verify_action(struct dpaa2_dev_priv *priv,
 					rxq->tc_index, rxq->flow_id,
 					attr->group);
 
-				return -ENOTSUP;
+				return -EINVAL;
 			}
 			break;
 		case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
 		case RTE_FLOW_ACTION_TYPE_PORT_ID:
 			if (!dpaa2_flow_redirect_dev(priv, &actions[j])) {
 				DPAA2_PMD_ERR("Invalid port id of action");
-				return -ENOTSUP;
+				return -EINVAL;
 			}
 			break;
 		case RTE_FLOW_ACTION_TYPE_RSS:
-			rss_conf = (const struct rte_flow_action_rss *)
-					(actions[j].conf);
+			rss_conf = actions[j].conf;
 			if (rss_conf->queue_num > priv->dist_queues) {
 				DPAA2_PMD_ERR("RSS number too large");
-				return -ENOTSUP;
+				return -EINVAL;
 			}
-			for (i = 0; i < (int)rss_conf->queue_num; i++) {
-				if (rss_conf->queue[i] >= priv->nb_rx_queues) {
-					DPAA2_PMD_ERR("RSS queue not in range");
-					return -ENOTSUP;
-				}
-				rxq = priv->rx_vq[rss_conf->queue[i]];
-				if (rxq->tc_index != attr->group) {
-					DPAA2_PMD_ERR("RSS queue not in group");
-					return -ENOTSUP;
+			if (rss_conf->queue) {
+				for (i = 0; i < (int)rss_conf->queue_num; i++) {
+					if (rss_conf->queue[i] >= priv->nb_rx_queues) {
+						DPAA2_PMD_ERR("RSS queue not in range");
+						return -EINVAL;
+					}
+					rxq = priv->rx_vq[rss_conf->queue[i]];
+					if (rxq->tc_index != attr->group) {
+						DPAA2_PMD_ERR("RSS queue not in group");
+						return -EINVAL;
+					}
 				}
 			}
 
 			break;
 		case RTE_FLOW_ACTION_TYPE_PF:
-			/* Skip this action, have to add for vxlan */
+			/* Skip this action, have to add for vxlan*/
 		case RTE_FLOW_ACTION_TYPE_DROP:
 			break;
+		case RTE_FLOW_ACTION_TYPE_METER_MARK:
+			break;
+		case RTE_FLOW_ACTION_TYPE_METER:
+			break;
 		case RTE_FLOW_ACTION_TYPE_END:
 			end_of_list = 1;
 			break;
 		default:
 			DPAA2_PMD_ERR("Invalid action type");
-			return -ENOTSUP;
+			return -EINVAL;
 		}
 		j++;
 	}
@@ -4379,40 +3612,74 @@ dpaa2_flow_verify_action(struct dpaa2_dev_priv *priv,
 	return 0;
 }
 
+static struct dpaa2_queue *
+dpaa2_flow_queue_action_to_queue(struct dpaa2_dev_priv *priv,
+	uint8_t tc_id, uint16_t queue_id)
+{
+	struct dpaa2_queue *dest_q;
+
+	if (queue_id >= MAX_RX_QUEUES ||
+		!priv->rx_vq[queue_id]) {
+		DPAA2_PMD_ERR("Invalid FSQ index(%d)", queue_id);
+
+		return NULL;
+	}
+	dest_q = priv->rx_vq[queue_id];
+	if (tc_id != dest_q->tc_index) {
+		DPAA2_PMD_ERR("RXQ[%d](%d.%d) not in TC[%d]",
+			queue_id,
+			dest_q->tc_index, dest_q->flow_id,
+			tc_id);
+
+		return NULL;
+	}
+
+	return dest_q;
+}
+
 static int
-dpaa2_configure_flow_fs_action(struct dpaa2_dev_priv *priv,
-	struct dpaa2_dev_flow *flow,
+dpaa2_flow_fs_action_config(struct dpaa2_dev_priv *priv,
+	struct dpaa2_generic_flow *flow,
 	const struct rte_flow_action *rte_action)
 {
+	struct rte_dpaa2_device *dpaa2_dev;
 	struct rte_eth_dev *dest_dev;
 	struct dpaa2_dev_priv *dest_priv;
 	const struct rte_flow_action_queue *dest_queue;
 	struct dpaa2_queue *dest_q;
 	uint64_t flc = 0;
-
-	memset(&flow->fs_action_cfg, 0,
-		sizeof(struct dpni_fs_action_cfg));
-	flow->action_type = rte_action->type;
-
-	if (flow->action_type == RTE_FLOW_ACTION_TYPE_QUEUE) {
-		dest_queue = rte_action->conf;
-		if (dest_queue->index >= MAX_RX_QUEUES ||
-			!priv->rx_vq[dest_queue->index]) {
-			DPAA2_PMD_ERR("Invalid FSQ index(%d)",
-				dest_queue->index);
-
+	uint16_t num_tokens;
+	struct dpaa2_dev_flow_fs_action *fs_action;
+
+	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
+
+	fs_action = &flow->flow_action.fs_action;
+	if (fs_action->action_type != RTE_FLOW_ACTION_TYPE_END) {
+		if (dpaa2_dev->bus_info->mc_rev >= DPAA2_FLOW_FRM_REPLICATION_ACTION_MC_REV &&
+			(fs_action->action_type == RTE_FLOW_ACTION_TYPE_PORT_ID ||
+			fs_action->action_type == RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR)) {
+			if (rte_action->type != RTE_FLOW_ACTION_TYPE_PORT_ID &&
+				rte_action->type != RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR) {
+				DPAA2_PMD_ERR("Redirect action can't mix with other action(%d)",
+					rte_action->type);
+				return -EINVAL;
+			}
+		} else {
+			DPAA2_PMD_ERR("Single action support only with action(%d)",
+				fs_action->action_type);
 			return -EINVAL;
 		}
-		dest_q = priv->rx_vq[dest_queue->index];
-		if (flow->tc_id != dest_q->tc_index) {
-			DPAA2_PMD_ERR("RXQ[%d](%d.%d) not in TC[%d]",
-				dest_queue->index,
-				dest_q->tc_index, dest_q->flow_id,
-				flow->tc_id);
+	}
+	fs_action->action_type = rte_action->type;
 
+	if (fs_action->action_type == RTE_FLOW_ACTION_TYPE_QUEUE) {
+		dest_queue = rte_action->conf;
+		dest_q = dpaa2_flow_queue_action_to_queue(priv,
+			flow->tc_id, dest_queue->index);
+		if (!dest_q)
 			return -EINVAL;
-		}
-		flow->fs_action_cfg.options =
+
+		fs_action->fs_action_cfg.options =
 			DPNI_FS_OPT_SET_FLC | DPNI_FS_OPT_SET_STASH_CONTROL;
 
 		if (dest_q->data_stashing_off) {
@@ -4430,10 +3697,10 @@ dpaa2_configure_flow_fs_action(struct dpaa2_dev_priv *priv,
 		flc |= ((uint64_t)1) << DPAA2_FS_FLC_FS_MARK_OFFSET;
 		flc |= ((uint64_t)dest_q->tc_index) << DPAA2_FS_FLC_TC_OFFSET;
 		flc |= ((uint64_t)dest_q->flow_id) << DPAA2_FS_FLC_FLOW_OFFSET;
-		flow->fs_action_cfg.flc = flc;
-		flow->fs_action_cfg.flow_id = dest_q->flow_id;
-	} else if (flow->action_type == RTE_FLOW_ACTION_TYPE_PORT_ID ||
-		   flow->action_type == RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT) {
+		fs_action->fs_action_cfg.flc = flc;
+		fs_action->fs_action_cfg.flow_id = dest_q->flow_id;
+	} else if (fs_action->action_type == RTE_FLOW_ACTION_TYPE_PORT_ID ||
+		fs_action->action_type == RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT) {
 		dest_dev = dpaa2_flow_redirect_dev(priv, rte_action);
 		if (!dest_dev) {
 			DPAA2_PMD_ERR("Invalid device to redirect");
@@ -4441,15 +3708,34 @@ dpaa2_configure_flow_fs_action(struct dpaa2_dev_priv *priv,
 		}
 
 		dest_priv = dest_dev->data->dev_private;
-		dest_q = dest_priv->tx_vq[0];
-		flow->fs_action_cfg.options =
-			DPNI_FS_OPT_REDIRECT_TO_DPNI_TX;
-		flow->fs_action_cfg.num_tokens = 1;
-		flow->fs_action_cfg.redir_tokens[0] =
-			dest_priv->token;
-		flow->fs_action_cfg.flow_id = dest_q->flow_id;
-	} else if (flow->action_type == RTE_FLOW_ACTION_TYPE_DROP) {
-		flow->fs_action_cfg.options = DPNI_FS_OPT_DISCARD;
+		num_tokens = fs_action->fs_action_cfg.num_tokens;
+		if (num_tokens >= DPNI_FS_REDIR_MAX_NUM)
+			return -EINVAL;
+		fs_action->fs_action_cfg.redir_tokens[num_tokens] = dest_priv->token;
+		strlcpy(fs_action->dst_name[num_tokens],
+			dest_priv->eth_dev->data->name,
+			sizeof(fs_action->dst_name[num_tokens]));
+		fs_action->fs_action_cfg.num_tokens++;
+		if (fs_action->fs_action_cfg.num_tokens > 1) {
+			if (!(priv->options & DPNI_OPT_V8_HAS_REPLICATION)) {
+				DPAA2_PMD_ERR("0x%08x missed in DPNI creating options(0x%08x)",
+					DPNI_OPT_V8_HAS_REPLICATION, priv->options);
+				return -ENOTSUP;
+			}
+			fs_action->fs_action_cfg.options =
+				DPNI_FS_OPT_REDIRECT_TO_MULTIPLE_DPNI_TX;
+		} else {
+			fs_action->fs_action_cfg.options =
+				DPNI_FS_OPT_REDIRECT_TO_DPNI_TX;
+		}
+	} else if (fs_action->action_type == RTE_FLOW_ACTION_TYPE_DROP) {
+		fs_action->fs_action_cfg.options = DPNI_FS_OPT_DISCARD;
+	} else if (fs_action->action_type == RTE_FLOW_ACTION_TYPE_RSS) {
+		/** Do nothing...*/
+	} else {
+		DPAA2_PMD_ERR("Flow action(%d) not supported!",
+			fs_action->action_type);
+		return -ENOTSUP;
 	}
 
 	return 0;
@@ -4477,41 +3763,104 @@ dpaa2_flow_clear_fs_table(struct dpaa2_dev_priv *priv,
 	uint8_t tc_id)
 {
 	struct dpaa2_dev_flow *curr = LIST_FIRST(&priv->flows);
-	int need_clear = 0, ret;
+	int fs_num = 0, ret, rss_num = 0;
 	struct fsl_mc_io *dpni = priv->hw;
 
 	while (curr) {
-		if (curr->tc_id == tc_id) {
-			need_clear = 1;
-			break;
+		if (curr->fs_flow && curr->fs_flow->tc_id == tc_id) {
+			if (curr->fs_flow->is_rss)
+				rss_num++;
+			else
+				fs_num++;
 		}
 		curr = LIST_NEXT(curr, next);
 	}
 
-	if (need_clear) {
+	if (rss_num > 1) {
+		DPAA2_PMD_ERR("TC[%d] should have one RSS flow at most!",
+			tc_id);
+		return -EINVAL;
+	}
+	if (rss_num && fs_num) {
+		DPAA2_PMD_ERR("TC[%d] has RSS flow and %d FS flow(s)!",
+			tc_id, fs_num);
+		return -EINVAL;
+	}
+
+	if (fs_num) {
 		ret = dpni_clear_fs_entries(dpni, CMD_PRI_LOW,
 				priv->token, tc_id);
 		if (ret) {
 			DPAA2_PMD_ERR("TC[%d] clear failed", tc_id);
 			return ret;
 		}
+		priv->flow_profile.tc_profile[tc_id].entry_num = 0;
+		memset(priv->flow_profile.tc_profile[tc_id].entry_map,
+			0, priv->fs_entries);
+	}
+
+	return 0;
+}
+
+static int
+dpaa2_flow_fs_table_set_default(struct dpaa2_dev_priv *priv,
+	uint8_t tc_id, int discard, uint16_t default_queue)
+{
+	int ret;
+	struct rte_dpaa2_device *dpaa2_dev;
+	struct dpni_rx_dist_cfg *tc_cfg;
+	struct fsl_mc_io *dpni = priv->hw;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	struct dpaa2_queue *queue;
+	char mc_rev[1024];
+
+	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
+	tbl_profile = &priv->flow_profile.tc_profile[tc_id];
+	snprintf(mc_rev, 1024, "MC rev(%d.%d.%d)",
+		RTE_FSL_MC_REV_MAJOR(dpaa2_dev->bus_info->mc_rev),
+		RTE_FSL_MC_REV_MINOR(dpaa2_dev->bus_info->mc_rev),
+		RTE_FSL_MC_REV_REVISION(dpaa2_dev->bus_info->mc_rev));
+	if (!tbl_profile->dpkg.num_extracts &&
+		dpaa2_dev->bus_info->mc_rev < DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV) {
+		DPAA2_PMD_DEBUG("%s can't set miss action of FS table indepentently.",
+			mc_rev);
+		return 0;
+	}
+	tc_cfg = &tbl_profile->tc_cfg;
+	tc_cfg->enable = true;
+	if (discard) {
+		tbl_profile->default_drop = true;
+		tc_cfg->fs_miss_flow_id = DPNI_FS_MISS_ACTION_DROP;
+	} else {
+		queue = dpaa2_flow_queue_action_to_queue(priv, tc_id, default_queue);
+		if (!queue)
+			return -EINVAL;
+		tbl_profile->default_drop = false;
+		tbl_profile->default_queue.index = default_queue;
+		tc_cfg->fs_miss_flow_id = queue->flow_id;
+	}
+	ret = dpni_set_rx_fs_dist(dpni, CMD_PRI_LOW, priv->token, tc_cfg);
+	if (ret < 0) {
+		DPAA2_PMD_ERR("%s: Failed(%d) to set default action of TC[%d]",
+			__func__, ret, tc_id);
+		return ret;
 	}
 
 	return 0;
 }
 
 static int
-dpaa2_configure_fs_rss_table(struct dpaa2_dev_priv *priv,
-	uint8_t tc_id, uint16_t dist_size, int rss_dist)
+dpaa2_flow_fs_rss_table_config(struct dpaa2_dev_priv *priv,
+	uint8_t tc_id, int rss_dist)
 {
-	struct dpaa2_key_extract *tc_extract;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 	uint8_t *key_cfg_buf;
-	uint64_t key_cfg_iova;
 	int ret;
-	struct dpni_rx_dist_cfg tc_cfg;
+	struct dpni_rx_dist_cfg *tc_cfg;
 	struct fsl_mc_io *dpni = priv->hw;
 	uint16_t entry_size;
 	uint16_t key_max_size;
+	struct dpaa2_queue *queue;
 
 	ret = dpaa2_flow_clear_fs_table(priv, tc_id);
 	if (ret < 0) {
@@ -4519,38 +3868,30 @@ dpaa2_configure_fs_rss_table(struct dpaa2_dev_priv *priv,
 		return ret;
 	}
 
-	tc_extract = &priv->extract.tc_key_extract[tc_id];
-	key_cfg_buf = priv->extract.tc_extract_param[tc_id];
-	key_cfg_iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(key_cfg_buf,
-		DPAA2_EXTRACT_PARAM_MAX_SIZE);
-	if (key_cfg_iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for key cfg(%p)",
-			__func__, key_cfg_buf);
+	tbl_profile = &priv->flow_profile.tc_profile[tc_id];
+	if (!tbl_profile->dpkg.num_extracts)
+		return 0;
 
-		return -ENOBUFS;
-	}
+	key_cfg_buf = priv->flow_profile.tc_profile[tc_id].extract_param;
 
-	key_max_size = tc_extract->key_profile.key_max_size;
+	key_max_size = tbl_profile->key_profile.key_max_size;
 	entry_size = dpaa2_flow_entry_size(key_max_size);
 
-	dpaa2_flow_fs_extracts_log(priv, tc_id);
-	ret = dpkg_prepare_key_cfg(&tc_extract->dpkg,
+	dpaa2_flow_extracts_log(priv, "Configure", tc_id);
+	ret = dpkg_prepare_key_cfg(&tbl_profile->dpkg,
 			key_cfg_buf);
 	if (ret < 0) {
 		DPAA2_PMD_ERR("TC[%d] prepare key failed", tc_id);
 		return ret;
 	}
 
-	memset(&tc_cfg, 0, sizeof(struct dpni_rx_dist_cfg));
-	tc_cfg.dist_size = dist_size;
-	tc_cfg.key_cfg_iova = key_cfg_iova;
+	tc_cfg = &tbl_profile->tc_cfg;
 	if (rss_dist)
-		tc_cfg.enable = true;
+		tc_cfg->enable = true;
 	else
-		tc_cfg.enable = false;
-	tc_cfg.tc = tc_id;
+		tc_cfg->enable = false;
 	ret = dpni_set_rx_hash_dist(dpni, CMD_PRI_LOW,
-			priv->token, &tc_cfg);
+			priv->token, tc_cfg);
 	if (ret < 0) {
 		if (rss_dist) {
 			DPAA2_PMD_ERR("RSS TC[%d] set failed",
@@ -4563,13 +3904,27 @@ dpaa2_configure_fs_rss_table(struct dpaa2_dev_priv *priv,
 		return ret;
 	}
 
-	if (rss_dist)
-		return 0;
+	if (rss_dist) {
+		tbl_profile->is_rss = true;
+		goto successful_config;
+	}
 
-	tc_cfg.enable = true;
-	tc_cfg.fs_miss_flow_id = priv->default_flow;
-	ret = dpni_set_rx_fs_dist(dpni, CMD_PRI_LOW,
-			priv->token, &tc_cfg);
+	tbl_profile->is_rss = false;
+
+	tc_cfg->enable = true;
+	if (tbl_profile->default_drop) {
+		tc_cfg->fs_miss_flow_id = DPNI_FS_MISS_ACTION_DROP;
+	} else {
+		queue = dpaa2_flow_queue_action_to_queue(priv, tc_id,
+			tbl_profile->default_queue.index);
+		if (!queue) {
+			DPAA2_PMD_ERR("TC[%d] invalid default queue(%d)",
+				tc_id, tbl_profile->default_queue.index);
+			return -EINVAL;
+		}
+		tc_cfg->fs_miss_flow_id = queue->flow_id;
+	}
+	ret = dpni_set_rx_fs_dist(dpni, CMD_PRI_LOW, priv->token, tc_cfg);
 	if (ret < 0) {
 		DPAA2_PMD_ERR("TC[%d] FS configured failed", tc_id);
 		return ret;
@@ -4580,74 +3935,145 @@ dpaa2_configure_fs_rss_table(struct dpaa2_dev_priv *priv,
 	if (ret)
 		return ret;
 
+successful_config:
+	tbl_profile->enabled = true;
+
+	return 0;
+}
+
+static int
+dpaa2_flow_qos_table_set_default(struct dpaa2_dev_priv *priv,
+	int discard, uint8_t default_tc, uint16_t default_flow)
+{
+	int ret;
+	struct rte_dpaa2_device *dpaa2_dev;
+	struct dpni_qos_tbl_cfg qos_cfg;
+	struct fsl_mc_io *dpni = priv->hw;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	char mc_rev[1024];
+
+	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
+	tbl_profile = &priv->flow_profile.qos_profile;
+	snprintf(mc_rev, 1024, "MC rev(%d.%d.%d)",
+		RTE_FSL_MC_REV_MAJOR(dpaa2_dev->bus_info->mc_rev),
+		RTE_FSL_MC_REV_MINOR(dpaa2_dev->bus_info->mc_rev),
+		RTE_FSL_MC_REV_REVISION(dpaa2_dev->bus_info->mc_rev));
+	if (!tbl_profile->dpkg.num_extracts &&
+		dpaa2_dev->bus_info->mc_rev < DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV) {
+		DPAA2_PMD_DEBUG("%s can't set miss action of QoS table indepentently.",
+			mc_rev);
+		return 0;
+	}
+	if (default_flow < priv->dist_queues &&
+		dpaa2_dev->bus_info->mc_rev < DPAA2_QOS_FLOW_TABLE_MISS_FLOW_ACTION_MC_REV) {
+		DPAA2_PMD_WARN("%s can't direct miss traffic to TC%d-flow%d by QoS table only.",
+			mc_rev, default_tc, default_flow);
+		return 0;
+	}
+
+	rte_memcpy(&qos_cfg, &tbl_profile->qos_cfg, sizeof(struct dpni_qos_tbl_cfg));
+	qos_cfg.key_cfg_iova = 0;
+	qos_cfg.default_tc = default_tc;
+	qos_cfg.default_flow_id = default_flow;
+	qos_cfg.discard_on_miss = discard ? true : false;
+	qos_cfg.set_default_flow_id = default_flow < priv->dist_queues ? true : false;
+
+	ret = dpni_set_qos_table(dpni, CMD_PRI_LOW, priv->token, &qos_cfg);
+	if (ret < 0) {
+		DPAA2_PMD_ERR("%s: Failed(%d) to set default action of QoS",
+			__func__, ret);
+		return ret;
+	}
+	if (discard) {
+		tbl_profile->default_drop = true;
+	} else {
+		tbl_profile->default_drop = false;
+		tbl_profile->default_jump.group = default_tc;
+	}
+	rte_memcpy(&tbl_profile->qos_cfg.discard_on_miss,
+		&qos_cfg.discard_on_miss,
+		sizeof(struct dpni_qos_tbl_cfg) -
+		offsetof(struct dpni_qos_tbl_cfg, discard_on_miss));
+
 	return 0;
 }
 
 static int
-dpaa2_configure_qos_table(struct dpaa2_dev_priv *priv,
+dpaa2_flow_qos_table_config(struct dpaa2_dev_priv *priv,
 	int rss_dist)
 {
-	struct dpaa2_key_extract *qos_extract;
+	struct rte_dpaa2_device *dpaa2_dev;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 	uint8_t *key_cfg_buf;
-	uint64_t key_cfg_iova;
 	int ret;
-	struct dpni_qos_tbl_cfg qos_cfg;
+	struct dpni_qos_tbl_cfg *qos_cfg;
 	struct fsl_mc_io *dpni = priv->hw;
 	uint16_t entry_size;
 	uint16_t key_max_size;
+	struct dpaa2_dev_flow *flow;
 
 	if (!rss_dist && priv->num_rx_tc <= 1) {
 		/* QoS table is effecitive for FS multiple TCs or RSS.*/
 		return 0;
 	}
 
-	if (LIST_FIRST(&priv->flows)) {
+	flow = LIST_FIRST(&priv->flows);
+	while (flow) {
+		if (!flow->qos_flow) {
+			flow = LIST_NEXT(flow, next);
+			continue;
+		}
+		/** Clear existing QoS table if there is qos flow configured.*/
 		ret = dpni_clear_qos_table(dpni, CMD_PRI_LOW,
 				priv->token);
 		if (ret < 0) {
-			DPAA2_PMD_ERR("QoS table clear failed");
+			DPAA2_PMD_ERR("QoS table clear failed(%d)", ret);
 			return ret;
 		}
+		priv->flow_profile.qos_profile.entry_num = 0;
+		memset(priv->flow_profile.qos_profile.entry_map,
+			0, priv->qos_entries);
+		break;
 	}
 
-	qos_extract = &priv->extract.qos_key_extract;
-	key_cfg_buf = priv->extract.qos_extract_param;
-	key_cfg_iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(key_cfg_buf,
-		DPAA2_EXTRACT_PARAM_MAX_SIZE);
-	if (key_cfg_iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for key cfg(%p)",
-			__func__, key_cfg_buf);
+	tbl_profile = &priv->flow_profile.qos_profile;
+	if (!tbl_profile->dpkg.num_extracts)
+		return 0;
 
-		return -ENOBUFS;
-	}
+	key_cfg_buf = priv->flow_profile.qos_profile.extract_param;
 
-	key_max_size = qos_extract->key_profile.key_max_size;
+	key_max_size = tbl_profile->key_profile.key_max_size;
 	entry_size = dpaa2_flow_entry_size(key_max_size);
 
-	dpaa2_flow_qos_extracts_log(priv);
+	dpaa2_flow_extracts_log(priv, "Configure", MAX_TCS);
 
-	ret = dpkg_prepare_key_cfg(&qos_extract->dpkg,
+	ret = dpkg_prepare_key_cfg(&tbl_profile->dpkg,
 			key_cfg_buf);
 	if (ret < 0) {
 		DPAA2_PMD_ERR("QoS prepare extract failed");
 		return ret;
 	}
-	memset(&qos_cfg, 0, sizeof(struct dpni_qos_tbl_cfg));
-	qos_cfg.keep_entries = true;
-	qos_cfg.key_cfg_iova = key_cfg_iova;
+	qos_cfg = &tbl_profile->qos_cfg;
 	if (rss_dist) {
-		qos_cfg.discard_on_miss = true;
+		qos_cfg->discard_on_miss = true;
 	} else {
-		qos_cfg.discard_on_miss = false;
-		qos_cfg.default_tc = 0;
+		qos_cfg->default_tc = tbl_profile->default_jump.group;
+		if (tbl_profile->default_drop)
+			qos_cfg->discard_on_miss = true;
+		else
+			qos_cfg->discard_on_miss = false;
 	}
 
-	ret = dpni_set_qos_table(dpni, CMD_PRI_LOW,
-			priv->token, &qos_cfg);
+	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
+	if (dpaa2_dev->bus_info->mc_rev < DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV)
+		ret = dpni_set_qos_table_v2(dpni, CMD_PRI_LOW, priv->token, qos_cfg);
+	else
+		ret = dpni_set_qos_table(dpni, CMD_PRI_LOW, priv->token, qos_cfg);
 	if (ret < 0) {
-		DPAA2_PMD_ERR("QoS table set failed");
+		DPAA2_PMD_ERR("QoS table set failed(%d)", ret);
 		return ret;
 	}
+	tbl_profile->enabled = true;
 
 	ret = dpaa2_flow_rule_add_all(priv, DPAA2_FLOW_QOS_TYPE,
 			entry_size, 0);
@@ -4697,207 +4123,468 @@ dpaa2_flow_item_convert(const struct rte_flow_item pattern[],
 }
 
 static int
-dpaa2_generic_flow_set(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_flow_item pattern[],
-	const struct rte_flow_action actions[],
-	struct rte_flow_error *error)
+dpaa2_flow_table_update(struct dpaa2_dev_priv *priv,
+	enum dpaa2_flow_dist_type dist_type, uint8_t tc_id, int is_rss)
 {
-	const struct rte_flow_action_rss *rss_conf;
-	int is_keycfg_configured = 0, end_of_list = 0;
-	int ret = 0, i = 0, j = 0;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	struct dpaa2_dev_flow *curr = LIST_FIRST(&priv->flows);
-	uint16_t dist_size, key_size;
-	struct dpaa2_key_extract *qos_key_extract;
-	struct dpaa2_key_extract *tc_key_extract;
-	struct rte_dpaa2_flow_item *dpaa2_pattern = NULL;
-
-	ret = dpaa2_flow_verify_attr(priv, attr);
-	if (ret)
-		return ret;
+	int ret;
 
-	ret = dpaa2_flow_verify_action(priv, attr, actions);
-	if (ret)
-		return ret;
+	if (dist_type == DPAA2_FLOW_FS_TYPE) {
+		ret = dpaa2_flow_fs_rss_table_config(priv, tc_id, is_rss);
+		if (ret)
+			return ret;
+	} else if (dist_type == DPAA2_FLOW_QOS_TYPE) {
+		ret = dpaa2_flow_qos_table_config(priv, false);
+		if (ret)
+			return ret;
+	} else {
+		DPAA2_PMD_ERR("Invalid dist type(%d)!", dist_type);
+		return -EINVAL;
+	}
 
-	ret = dpaa2_flow_item_convert(pattern, &dpaa2_pattern,
-		priv->sp_protocol);
-	if (ret)
-		return ret;
+	return 0;
+}
 
-	/* Parse pattern list to get the matching parameters */
-	while (!end_of_list) {
-		switch (pattern[i].type) {
+static int
+dpaa2_flow_action_meter_mark_init(struct dpaa2_dev_priv *priv,
+	uint32_t mtr_id, struct rte_flow_action_meter_mark *meter_mark)
+{
+	struct dpaa2_dev_meter *meter;
+	struct dpaa2_dev_meter_profile *profile;
+	struct dpaa2_dev_meter_policy *policy;
+	int found = 0;
+
+	meter = LIST_FIRST(&priv->meters);
+	while (meter) {
+		if (meter->meter_id == mtr_id) {
+			found = 1;
+			break;
+		}
+		meter = LIST_NEXT(meter, next);
+	}
+
+	if (!found) {
+		DPAA2_PMD_ERR("Meter ID(%d) is not found!", mtr_id);
+		return -ENXIO;
+	}
+
+	found = 0;
+	profile = LIST_FIRST(&priv->profiles);
+	while (profile) {
+		if (profile->profile_id == meter->profile_id) {
+			found = 1;
+			break;
+		}
+		profile = LIST_NEXT(profile, next);
+	}
+	if (!found) {
+		DPAA2_PMD_ERR("Meter ID(%d)'s profile(%d) not exist!",
+			mtr_id, meter->profile_id);
+		return -ENXIO;
+	}
+
+	found = 0;
+	policy = LIST_FIRST(&priv->policies);
+	while (policy) {
+		if (policy->policy_id == meter->policy_id) {
+			found = 1;
+			break;
+		}
+		policy = LIST_NEXT(policy, next);
+	}
+	if (!found) {
+		/** Option.*/
+		DPAA2_PMD_WARN("Meter ID(%d)'s policy(%d) not exist!",
+			mtr_id, meter->policy_id);
+		policy = NULL;
+	}
+
+	meter_mark->profile = (void *)profile;
+	meter_mark->policy = (void *)policy;
+	meter_mark->color_mode = 1;
+
+	return 0;
+}
+
+static int
+dpaa2_flow_set_police_action(struct dpaa2_dev_priv *priv,
+	uint8_t tc_id, const struct rte_flow_action_meter_mark *meter_mark)
+{
+	struct rte_dpaa2_device *dpaa2_dev;
+	struct dpni_rx_tc_policing_cfg policing_cfg = {0};
+	const struct dpaa2_dev_meter_profile *dpaa2_profile;
+	const struct dpaa2_dev_meter_policy *dpaa2_policy = NULL;
+	int ret;
+
+	if (!(priv->options & DPNI_OPT_HAS_POLICING)) {
+		DPAA2_PMD_ERR("POLICING(0x%08x) was not added in DPNI creating options(0x%08x)",
+			DPNI_OPT_HAS_POLICING, priv->options);
+		return -ENOTSUP;
+	}
+
+	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
+
+	dpaa2_profile = (void *)meter_mark->profile;
+	if (!dpaa2_profile) {
+		DPAA2_PMD_ERR("Meter profile not specified!");
+		return -EINVAL;
+	}
+
+	/** Blind as default.*/
+	policing_cfg.options = 0;
+	if (meter_mark->color_mode)
+		policing_cfg.options = DPNI_POLICER_OPT_COLOR_AWARE;
+	if (meter_mark->policy)
+		dpaa2_policy = (void *)meter_mark->policy;
+	if (dpaa2_policy && dpaa2_policy->red_drop) {
+		policing_cfg.options |= DPNI_POLICER_OPT_DISCARD_RED;
+	} else if (!dpaa2_policy) {
+		/** Default: Red is discarded if no policy specified.*/
+		policing_cfg.options |= DPNI_POLICER_OPT_DISCARD_RED;
+	}
+
+	if (priv->flow_profile.mtr_flow[tc_id]) {
+		/** Update existing policer.*/
+		dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
+		policing_cfg.options |= DPNI_POLICER_OPT_DO_NOT_RESET_COUNTERS;
+		if (dpaa2_dev->bus_info->mc_rev < DPAA2_POLICER_NOT_RESET_COUNTER_MC_REV)
+			DPAA2_PMD_WARN("The existing policer's counters will be cleaned.");
+	}
+
+	policing_cfg.mode = dpaa2_profile->mode;
+	if (policing_cfg.mode < DPNI_POLICER_MODE_NONE ||
+		policing_cfg.mode > DPNI_POLICER_MODE_RFC_4115) {
+		DPAA2_PMD_ERR("Invalid policer mode(%d)",
+			policing_cfg.mode);
+		return -EINVAL;
+	}
+	policing_cfg.units = dpaa2_profile->policer_unit;
+	if (policing_cfg.units < DPNI_POLICER_UNIT_BYTES_L3 ||
+		policing_cfg.units > DPNI_POLICER_UNIT_BYTES_L2_WITHOUT_FCS) {
+		DPAA2_PMD_ERR("Invalid policer units(%d)",
+			policing_cfg.units);
+		return -EINVAL;
+	}
+	policing_cfg.cir = dpaa2_profile->cir;
+	policing_cfg.cbs = dpaa2_profile->cbs;
+	policing_cfg.eir = dpaa2_profile->pir;
+	policing_cfg.ebs = dpaa2_profile->pbs;
+
+	if (dpaa2_dev->bus_info->mc_rev < DPAA2_POLICER_SET_V2_MC_REV) {
+		ret = dpni_set_rx_tc_policing_v1(priv->hw, CMD_PRI_LOW,
+			priv->token, tc_id, &policing_cfg);
+	} else {
+		ret = dpni_set_rx_tc_policing(priv->hw, CMD_PRI_LOW,
+			priv->token, tc_id, &policing_cfg);
+	}
+	DPAA2_PMD_INFO("%s RX TC%d policer configure %s.",
+		priv->eth_dev->data->name, tc_id,
+		ret ? "failed" : "successfully");
+	if (!ret)
+		priv->flow_profile.tc_mtr_profile[tc_id] = (void *)meter_mark->profile;
+
+	return ret;
+}
+
+static int
+dpaa2_flow_action_single_type_check(const struct rte_flow_action actions[],
+	enum rte_flow_action_type type)
+{
+	if (actions[0].type == type &&
+		actions[1].type == RTE_FLOW_ACTION_TYPE_END)
+		return true;
+
+	return false;
+}
+
+static int
+dpaa2_flow_qos_action_update(struct dpaa2_dev_priv *priv,
+	struct dpaa2_generic_flow *flow,
+	const struct rte_flow_action actions[], int new_flow)
+{
+	int end_of_list = 0, ret = 0, i = 0, set_jump = 0;
+	struct dpaa2_dev_flow_qos_action *qos_action;
+
+	RTE_SET_USED(priv);
+	qos_action = &flow->flow_action.qos_action;
+
+	while (!end_of_list) {
+		switch (actions[i].type) {
+		case RTE_FLOW_ACTION_TYPE_JUMP:
+			qos_action->action_jump_type = actions[i].type;
+			rte_memcpy(&qos_action->action_jump_cfg, actions[i].conf,
+				sizeof(struct rte_flow_action_jump));
+			set_jump++;
+			break;
+		case RTE_FLOW_ACTION_TYPE_END:
+			end_of_list = 1;
+			break;
+		default:
+			DPAA2_PMD_ERR("Invalid action[%d]'s type(%d)",
+				i, actions[i].type);
+			ret = -ENOTSUP;
+			goto end_action_set;
+		}
+		i++;
+	}
+
+end_action_set:
+	if (!set_jump && !ret && new_flow)
+		return -EINVAL;
+
+	return ret;
+}
+
+static int
+dpaa2_flow_fs_action_update(struct dpaa2_dev_priv *priv,
+	struct dpaa2_generic_flow *fs_flow,
+	const struct rte_flow_action actions[])
+{
+	int end_of_list = 0, ret = 0, i = 0;
+	const struct rte_flow_action_meter *meter;
+	struct rte_flow_action_meter_mark meter_mark;
+	union dpaa2_dev_flow_action flow_action_rollback;
+
+	rte_memcpy(&flow_action_rollback, &fs_flow->flow_action,
+		sizeof(union dpaa2_dev_flow_action));
+	memset(&fs_flow->flow_action, 0, sizeof(union dpaa2_dev_flow_action));
+
+	while (!end_of_list) {
+		switch (actions[i].type) {
+		case RTE_FLOW_ACTION_TYPE_QUEUE:
+		case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
+		case RTE_FLOW_ACTION_TYPE_PORT_ID:
+		case RTE_FLOW_ACTION_TYPE_DROP:
+		case RTE_FLOW_ACTION_TYPE_RSS:
+			ret = dpaa2_flow_fs_action_config(priv, fs_flow, &actions[i]);
+			if (ret)
+				goto end_action_set;
+
+			break;
+		case RTE_FLOW_ACTION_TYPE_METER_MARK:
+			rte_memcpy(&meter_mark, actions[i].conf,
+				sizeof(meter_mark));
+			ret = dpaa2_flow_set_police_action(priv,
+				fs_flow->tc_id, &meter_mark);
+			if (ret)
+				goto end_action_set;
+			break;
+		case RTE_FLOW_ACTION_TYPE_METER:
+			meter = actions[i].conf;
+			ret = dpaa2_flow_action_meter_mark_init(priv,
+				meter->mtr_id, &meter_mark);
+			if (ret)
+				goto end_action_set;
+			ret = dpaa2_flow_set_police_action(priv,
+				fs_flow->tc_id, &meter_mark);
+			if (ret)
+				goto end_action_set;
+
+			break;
+		case RTE_FLOW_ACTION_TYPE_PF:
+			/* Skip this action, have to add for vxlan*/
+			break;
+		case RTE_FLOW_ACTION_TYPE_END:
+			end_of_list = 1;
+			break;
+		default:
+			DPAA2_PMD_ERR("Invalid action[%d]'s type(%d)",
+				i, actions[i].type);
+			ret = -ENOTSUP;
+			goto end_action_set;
+		}
+		i++;
+	}
+
+end_action_set:
+	if (ret || i < 1) {
+		rte_memcpy(&fs_flow->flow_action, &flow_action_rollback,
+			sizeof(union dpaa2_dev_flow_action));
+	}
+	if (ret)
+		return ret;
+
+	if (i < 1) {
+		DPAA2_PMD_ERR("No action is set!");
+		return -EINVAL;
+	}
+	if (i > 2) {
+		DPAA2_PMD_WARN("Only last of %d actions is applied",
+			i - 1);
+	}
+
+	return 0;
+}
+
+static int
+dpaa2_flow_generic_extract_rule_set(struct dpaa2_generic_flow *flow,
+	const struct rte_flow_attr *attr,
+	const struct rte_flow_item pattern[], int is_rss,
+	enum dpaa2_flow_dist_type dist_type, int update)
+{
+	int extract_cfg = 0, end_of_list = 0;
+	int ret = 0, i = 0;
+	struct dpaa2_dev_priv *priv = flow->priv;
+	uint16_t key_size;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	struct rte_dpaa2_flow_item *dpaa2_pattern = NULL;
+
+	ret = dpaa2_flow_item_convert(pattern, &dpaa2_pattern,
+		priv->sp_protocol);
+	if (ret)
+		return ret;
+
+	flow->ip_key = NET_PROT_NONE;
+	flow->ip_src = NET_PROT_NONE;
+	flow->ip_dst = NET_PROT_NONE;
+
+	if (dist_type == DPAA2_FLOW_QOS_TYPE)
+		tbl_profile = &priv->flow_profile.qos_profile;
+	else
+		tbl_profile = &priv->flow_profile.tc_profile[attr->group];
+
+	if (is_rss || (!is_rss && tbl_profile->is_rss)) {
+		RTE_ASSERT(dist_type == DPAA2_FLOW_FS_TYPE);
+		if (!update) {
+			dpaa2_flow_clean(priv->eth_dev, attr->group);
+			tbl_profile->rss_flow = NULL;
+		}
+		if (!is_rss)
+			tbl_profile->tc_cfg.dist_size = priv->dist_queues;
+		memset(&tbl_profile->dpkg, 0,
+			sizeof(struct dpkg_profile_cfg));
+		memset(&tbl_profile->key_profile, 0,
+			sizeof(struct dpaa2_key_profile));
+	}
+
+	/* Parse pattern list to get the matching parameters */
+	while (!end_of_list) {
+		switch (pattern[i].type) {
 		case RTE_FLOW_ITEM_TYPE_ETH:
-			ret = dpaa2_configure_flow_eth(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
+			ret = dpaa2_flow_eth_extract_rule_set(flow, attr,
+				&dpaa2_pattern[i], &extract_cfg, dist_type);
 			if (ret) {
 				DPAA2_PMD_ERR("ETH flow config failed!");
-				goto end_flow_set;
+				goto end_extract_set;
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_VLAN:
-			ret = dpaa2_configure_flow_vlan(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
+			ret = dpaa2_flow_vlan_extract_rule_set(flow, attr,
+				&dpaa2_pattern[i], &extract_cfg, dist_type);
 			if (ret) {
 				DPAA2_PMD_ERR("vLan flow config failed!");
-				goto end_flow_set;
+				goto end_extract_set;
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_IPV4:
-			ret = dpaa2_configure_flow_ipv4(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
+			ret = dpaa2_flow_ipv4_extract_rule_set(flow, attr,
+				&dpaa2_pattern[i], &extract_cfg, dist_type);
 			if (ret) {
 				DPAA2_PMD_ERR("IPV4 flow config failed!");
-				goto end_flow_set;
+				goto end_extract_set;
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_IPV6:
-			ret = dpaa2_configure_flow_ipv6(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
+			ret = dpaa2_flow_ipv6_extract_rule_set(flow, attr,
+				&dpaa2_pattern[i], &extract_cfg, dist_type);
 			if (ret) {
 				DPAA2_PMD_ERR("IPV6 flow config failed!");
-				goto end_flow_set;
+				goto end_extract_set;
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_ICMP:
-			ret = dpaa2_configure_flow_icmp(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
+			ret = dpaa2_flow_icmp_extract_rule_set(flow, attr,
+				&dpaa2_pattern[i], &extract_cfg, dist_type);
 			if (ret) {
 				DPAA2_PMD_ERR("ICMP flow config failed!");
-				goto end_flow_set;
+				goto end_extract_set;
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_UDP:
-			ret = dpaa2_configure_flow_udp(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
+			ret = dpaa2_flow_udp_extract_rule_set(flow, attr,
+				&dpaa2_pattern[i], &extract_cfg, dist_type);
 			if (ret) {
 				DPAA2_PMD_ERR("UDP flow config failed!");
-				goto end_flow_set;
+				goto end_extract_set;
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_TCP:
-			ret = dpaa2_configure_flow_tcp(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
+			ret = dpaa2_flow_tcp_extract_rule_set(flow, attr,
+				&dpaa2_pattern[i], &extract_cfg, dist_type);
 			if (ret) {
 				DPAA2_PMD_ERR("TCP flow config failed!");
-				goto end_flow_set;
+				goto end_extract_set;
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_SCTP:
-			ret = dpaa2_configure_flow_sctp(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
+			ret = dpaa2_flow_sctp_extract_rule_set(flow, attr,
+				&dpaa2_pattern[i], &extract_cfg, dist_type);
 			if (ret) {
 				DPAA2_PMD_ERR("SCTP flow config failed!");
-				goto end_flow_set;
+				goto end_extract_set;
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_ESP:
-			ret = dpaa2_configure_flow_esp(flow,
-					dev, attr, &dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
+			ret = dpaa2_flow_esp_extract_rule_set(flow, attr,
+				&dpaa2_pattern[i], &extract_cfg, dist_type);
 			if (ret) {
 				DPAA2_PMD_ERR("ESP flow config failed!");
-				goto end_flow_set;
+				goto end_extract_set;
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_AH:
-			ret = dpaa2_configure_flow_ah(flow,
-					dev, attr, &dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
+			ret = dpaa2_flow_ah_extract_rule_set(flow, attr,
+				&dpaa2_pattern[i], &extract_cfg, dist_type);
 			if (ret) {
 				DPAA2_PMD_ERR("AH flow config failed!");
-				goto end_flow_set;
+				goto end_extract_set;
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_GRE:
-			ret = dpaa2_configure_flow_gre(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
+			ret = dpaa2_flow_gre_extract_rule_set(flow, attr,
+				&dpaa2_pattern[i], &extract_cfg, dist_type);
 			if (ret) {
 				DPAA2_PMD_ERR("GRE flow config failed!");
-				goto end_flow_set;
+				goto end_extract_set;
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_VXLAN:
-			ret = dpaa2_configure_flow_vxlan(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
+			ret = dpaa2_flow_vxlan_extract_rule_set(flow, attr,
+				&dpaa2_pattern[i], &extract_cfg, dist_type);
 			if (ret) {
 				DPAA2_PMD_ERR("VXLAN flow config failed!");
-				goto end_flow_set;
+				goto end_extract_set;
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_ECPRI:
-			ret = dpaa2_configure_flow_ecpri(flow,
-					dev, attr, &dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
+			ret = dpaa2_flow_ecpri_extract_rule_set(flow, attr,
+				&dpaa2_pattern[i], &extract_cfg, dist_type);
 			if (ret) {
 				DPAA2_PMD_ERR("ECPRI flow config failed!");
-				goto end_flow_set;
+				goto end_extract_set;
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_GTP:
-			ret = dpaa2_configure_flow_gtp(flow,
-					dev, attr, &dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
+			ret = dpaa2_flow_gtp_extract_rule_set(flow, attr,
+				&dpaa2_pattern[i], &extract_cfg, dist_type);
 			if (ret) {
 				DPAA2_PMD_ERR("GTP flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_MPLS:
-			ret = dpaa2_configure_flow_mpls(flow,
-					dev, attr, &dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("MPLS flow config failed!");
-				goto end_flow_set;
+				goto end_extract_set;
 			}
 			break;
-		case RTE_FLOW_ITEM_TYPE_PPPOES:
-			ret = dpaa2_configure_flow_pppoe(flow,
-					dev, attr, &dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
+		case RTE_FLOW_ITEM_TYPE_GENEVE:
+			ret = dpaa2_flow_geneve_extract_rule_set(flow, attr,
+				&dpaa2_pattern[i], &extract_cfg, dist_type);
 			if (ret) {
-				DPAA2_PMD_ERR("PPPoE flow config failed!");
-				goto end_flow_set;
+				DPAA2_PMD_ERR("GENEVE flow config failed!");
+				goto end_extract_set;
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_RAW:
-			ret = dpaa2_configure_flow_raw(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
+			ret = dpaa2_flow_raw_extract_rule_set(flow, attr,
+				&dpaa2_pattern[i], &extract_cfg, dist_type);
 			if (ret) {
 				DPAA2_PMD_ERR("RAW flow config failed!");
-				goto end_flow_set;
+				goto end_extract_set;
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_END:
@@ -4907,164 +4594,104 @@ dpaa2_generic_flow_set(struct dpaa2_dev_flow *flow,
 			DPAA2_PMD_ERR("Invalid flow item[%d] type(%d)",
 				i, pattern[i].type);
 			ret = -ENOTSUP;
-			break;
+			goto end_extract_set;
 		}
 		i++;
 	}
 
-	qos_key_extract = &priv->extract.qos_key_extract;
-	key_size = qos_key_extract->key_profile.key_max_size;
-	flow->qos_rule.key_size = dpaa2_flow_entry_size(key_size);
-
-	tc_key_extract = &priv->extract.tc_key_extract[flow->tc_id];
-	key_size = tc_key_extract->key_profile.key_max_size;
-	flow->fs_rule.key_size = dpaa2_flow_entry_size(key_size);
-
-	/* Let's parse action on matching traffic */
-	end_of_list = 0;
-	while (!end_of_list) {
-		switch (actions[j].type) {
-		case RTE_FLOW_ACTION_TYPE_QUEUE:
-		case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
-		case RTE_FLOW_ACTION_TYPE_PORT_ID:
-		case RTE_FLOW_ACTION_TYPE_DROP:
-			ret = dpaa2_configure_flow_fs_action(priv, flow,
-							     &actions[j]);
-			if (ret)
-				goto end_flow_set;
-
-			/* Configure FS table first*/
-			dist_size = priv->nb_rx_queues / priv->num_rx_tc;
-			if (is_keycfg_configured & DPAA2_FLOW_FS_TYPE) {
-				ret = dpaa2_configure_fs_rss_table(priv,
-								   flow->tc_id,
-								   dist_size,
-								   false);
-				if (ret)
-					goto end_flow_set;
-			}
-
-			/* Configure QoS table then.*/
-			if (is_keycfg_configured & DPAA2_FLOW_QOS_TYPE) {
-				ret = dpaa2_configure_qos_table(priv, false);
-				if (ret)
-					goto end_flow_set;
-			}
-
-			if (priv->num_rx_tc > 1) {
-				ret = dpaa2_flow_add_qos_rule(priv, flow);
-				if (ret)
-					goto end_flow_set;
-			}
+	key_size = tbl_profile->key_profile.key_max_size;
+	flow->rule_cfg.key_size = dpaa2_flow_entry_size(key_size);
 
-			if (flow->tc_index >= priv->fs_entries) {
-				DPAA2_PMD_ERR("FS table with %d entries full",
-					priv->fs_entries);
-				return -1;
-			}
+	if (!extract_cfg)
+		goto end_extract_set;
 
-			ret = dpaa2_flow_add_fs_rule(priv, flow);
-			if (ret)
-				goto end_flow_set;
+	ret = dpaa2_flow_table_update(priv, dist_type, attr->group, is_rss);
 
-			break;
-		case RTE_FLOW_ACTION_TYPE_RSS:
-			rss_conf = actions[j].conf;
-			flow->action_type = RTE_FLOW_ACTION_TYPE_RSS;
-
-			ret = dpaa2_distset_to_dpkg_profile_cfg(rss_conf->types,
-					&tc_key_extract->dpkg);
-			if (ret < 0) {
-				DPAA2_PMD_ERR("TC[%d] distset RSS failed",
-					      flow->tc_id);
-				goto end_flow_set;
-			}
+end_extract_set:
+	if (dpaa2_pattern)
+		rte_free(dpaa2_pattern);
 
-			dist_size = rss_conf->queue_num;
-			if (is_keycfg_configured & DPAA2_FLOW_FS_TYPE) {
-				ret = dpaa2_configure_fs_rss_table(priv,
-								   flow->tc_id,
-								   dist_size,
-								   true);
-				if (ret)
-					goto end_flow_set;
-			}
+	return ret;
+}
 
-			if (is_keycfg_configured & DPAA2_FLOW_QOS_TYPE) {
-				ret = dpaa2_configure_qos_table(priv, true);
-				if (ret)
-					goto end_flow_set;
-			}
+static inline int
+dpaa2_flow_verify_attr(struct dpaa2_dev_priv *priv,
+	const struct rte_flow_attr *attr, uint32_t *pgroup_type,
+	uint32_t *pgroup_id)
+{
+	int ret = 0;
+	uint32_t group_id, group_type;
 
-			ret = dpaa2_flow_add_qos_rule(priv, flow);
-			if (ret)
-				goto end_flow_set;
+	group_type = RTE_DPAA2_FLOW_GROUP_TYPE_GET(attr->group);
+	group_id = RTE_DPAA2_FLOW_GROUP_ID_GET(attr->group);
+	if (group_id >= priv->num_rx_tc &&
+		group_type == RTE_DPAA2_ONE_LEVEL_GROUP_FLOW) {
+		group_type = RTE_DPAA2_QOS_GROUP_FLOW;
+		group_id = DPAA2_FLOW_QOS_GROUP_ID;
+	}
 
-			ret = dpaa2_flow_add_fs_rule(priv, flow);
-			if (ret)
-				goto end_flow_set;
+	if (group_type == RTE_DPAA2_FS_GROUP_FLOW && !priv->fs_entries) {
+		DPAA2_PMD_ERR("No FS table created to support FS flow!");
+		ret = -EINVAL;
+		goto complete_verify;
+	}
 
-			break;
-		case RTE_FLOW_ACTION_TYPE_PF:
-			/* Skip this action, have to add for vxlan */
-			break;
-		case RTE_FLOW_ACTION_TYPE_END:
-			end_of_list = 1;
-			break;
-		default:
-			DPAA2_PMD_ERR("Invalid action type");
+	if (group_type == RTE_DPAA2_QOS_GROUP_FLOW) {
+		if (attr->priority >= priv->qos_entries) {
+			DPAA2_PMD_ERR("Prior(%d) is out of range(%d)",
+				attr->priority, priv->qos_entries);
 			ret = -ENOTSUP;
-			break;
+			goto complete_verify;
 		}
-		j++;
+		goto complete_verify_group;
 	}
 
-end_flow_set:
-	if (!ret) {
-		/* New rules are inserted. */
-		if (!curr) {
-			LIST_INSERT_HEAD(&priv->flows, flow, next);
-		} else {
-			while (LIST_NEXT(curr, next))
-				curr = LIST_NEXT(curr, next);
-			LIST_INSERT_AFTER(curr, flow, next);
+	if (group_type == RTE_DPAA2_ONE_LEVEL_GROUP_FLOW ||
+		group_type == RTE_DPAA2_FS_GROUP_FLOW) {
+		if (group_id >= priv->num_rx_tc) {
+			DPAA2_PMD_ERR("Group(%d) is out of range(%d)",
+				group_id, priv->num_rx_tc);
+			ret = -ENOTSUP;
+			goto complete_verify;
+		}
+		if (group_type == RTE_DPAA2_ONE_LEVEL_GROUP_FLOW &&
+			(attr->priority + priv->fs_entries * group_id) >= priv->qos_entries) {
+			DPAA2_PMD_ERR("Prior(%d) + fs entries(%d) * group(%d) is out of range(%d)",
+				attr->priority, priv->fs_entries, group_id,
+				priv->qos_entries);
+			ret = -ENOTSUP;
+			goto complete_verify;
 		}
+	} else {
+		DPAA2_PMD_ERR("Invalid group type(%d)", group_type);
+		ret = -EINVAL;
+		goto complete_verify;
 	}
 
-	rte_free(dpaa2_pattern);
-
-	return ret;
-}
-
-static inline int
-dpaa2_dev_verify_attr(struct dpni_attr *dpni_attr,
-	const struct rte_flow_attr *attr)
-{
-	int ret = 0;
-
-	if (unlikely(attr->group >= dpni_attr->num_rx_tcs)) {
-		DPAA2_PMD_ERR("Group/TC(%d) is out of range(%d)",
-			attr->group, dpni_attr->num_rx_tcs);
-		ret = -ENOTSUP;
-	}
-	if (unlikely(attr->priority >= dpni_attr->fs_entries)) {
-		DPAA2_PMD_ERR("Priority(%d) within group is out of range(%d)",
-			attr->priority, dpni_attr->fs_entries);
-		ret = -ENOTSUP;
-	}
+complete_verify_group:
 	if (unlikely(attr->egress)) {
 		DPAA2_PMD_ERR("Egress flow configuration is not supported");
 		ret = -ENOTSUP;
+		goto complete_verify;
 	}
 	if (unlikely(!attr->ingress)) {
 		DPAA2_PMD_ERR("Ingress flag must be configured");
 		ret = -EINVAL;
 	}
+
+complete_verify:
+	if (!ret) {
+		if (pgroup_type)
+			*pgroup_type = group_type;
+		if (pgroup_id)
+			*pgroup_id = group_id;
+	}
+
 	return ret;
 }
 
 static inline int
-dpaa2_dev_verify_patterns(const struct rte_flow_item pattern[],
+dpaa2_flow_verify_patterns(const struct rte_flow_item pattern[],
 	int sp_support)
 {
 	unsigned int i, j, is_found = 0;
@@ -5109,29 +4736,32 @@ dpaa2_dev_verify_patterns(const struct rte_flow_item pattern[],
 }
 
 static inline int
-dpaa2_dev_verify_actions(const struct rte_flow_action actions[])
+dpaa2_flow_check_actions_support(const struct rte_flow_action actions[],
+	const enum rte_flow_action_type supported[], uint16_t len)
 {
 	unsigned int i, j, is_found = 0;
-	int ret = 0;
 
 	for (j = 0; actions[j].type != RTE_FLOW_ACTION_TYPE_END; j++) {
-		for (i = 0; i < RTE_DIM(dpaa2_supported_action_type); i++) {
-			if (dpaa2_supported_action_type[i] == actions[j].type) {
+		is_found = 0;
+		for (i = 0; i < len; i++) {
+			if (supported[i] == actions[j].type) {
 				is_found = 1;
 				break;
 			}
 		}
-		if (!is_found) {
-			ret = -ENOTSUP;
-			break;
-		}
+		if (!is_found)
+			return false;
 	}
 	for (j = 0; actions[j].type != RTE_FLOW_ACTION_TYPE_END; j++) {
 		if (actions[j].type != RTE_FLOW_ACTION_TYPE_DROP &&
-		    !actions[j].conf)
-			ret = -EINVAL;
+			!actions[j].conf) {
+			DPAA2_PMD_ERR("No config for actions[%d].type(%d)",
+				j, actions[j].type);
+			return false;
+		}
 	}
-	return ret;
+
+	return true;
 }
 
 static int
@@ -5142,238 +4772,1649 @@ dpaa2_flow_validate(struct rte_eth_dev *dev,
 	struct rte_flow_error *error)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	struct dpni_attr dpni_attr;
-	struct fsl_mc_io *dpni = (struct fsl_mc_io *)priv->hw;
-	uint16_t token = priv->token;
+	uint16_t supported_len = 0;
 	int ret = 0;
+	uint32_t group_type;
+	const enum rte_flow_action_type *supported = NULL;
+	const char *err_str = NULL;
+	const void *cause = NULL;
+	enum rte_flow_error_type err_type = RTE_FLOW_ERROR_TYPE_NONE;
 
-	memset(&dpni_attr, 0, sizeof(struct dpni_attr));
-	ret = dpni_get_attributes(dpni, CMD_PRI_LOW, token, &dpni_attr);
-	if (ret < 0) {
-		DPAA2_PMD_ERR("Get dpni@%d attribute failed(%d)",
-			priv->hw_id, ret);
-		rte_flow_error_set(error, EPERM,
-			RTE_FLOW_ERROR_TYPE_ATTR,
-			flow_attr, "invalid");
-		return ret;
+	/* Verify input attributes */
+	ret = dpaa2_flow_verify_attr(priv, flow_attr, &group_type, NULL);
+	if (ret) {
+		err_str = "Invalid attributes are given";
+		cause = flow_attr;
+		err_type = RTE_FLOW_ERROR_TYPE_ATTR;
+		goto invalid_params;
 	}
 
-	/* Verify input attributes */
-	ret = dpaa2_dev_verify_attr(&dpni_attr, flow_attr);
-	if (ret < 0) {
-		DPAA2_PMD_ERR("Invalid attributes are given");
-		rte_flow_error_set(error, EPERM,
-			RTE_FLOW_ERROR_TYPE_ATTR,
-			flow_attr, "invalid");
-		goto not_valid_params;
-	}
-	/* Verify input pattern list */
-	ret = dpaa2_dev_verify_patterns(pattern, priv->sp_protocol);
-	if (ret < 0) {
-		DPAA2_PMD_ERR("Invalid pattern list is given");
-		rte_flow_error_set(error, EPERM,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			pattern, "invalid");
-		goto not_valid_params;
+	if (pattern) {
+		/* Verify input pattern list */
+		ret = dpaa2_flow_verify_patterns(pattern, priv->sp_protocol);
+		if (ret) {
+			err_str = "Invalid pattern list is given";
+			cause = pattern;
+			err_type = RTE_FLOW_ERROR_TYPE_ITEM;
+			goto invalid_params;
+		}
+	}
+
+	supported = dpaa2_supported_meter_action_type;
+	supported_len = RTE_DIM(dpaa2_supported_meter_action_type);
+	if (dpaa2_flow_check_actions_support(actions, supported, supported_len)) {
+		DPAA2_PMD_DEBUG("This is meter flow.");
+		if (group_type == RTE_DPAA2_QOS_GROUP_FLOW) {
+			err_str = "Meter flow's type can't be QoS flow.";
+			cause = actions;
+			err_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			ret = -EPERM;
+			goto invalid_params;
+		}
+		if (actions[1].type != RTE_FLOW_ACTION_TYPE_END) {
+			err_str = "Meter flow can't support multi-actions.";
+			cause = actions;
+			err_type = RTE_FLOW_ERROR_TYPE_ACTION_NUM;
+			ret = -EPERM;
+			goto invalid_params;
+		}
+		if (pattern)
+			DPAA2_PMD_WARN("Meter flow ingores flow items!");
+		return 0;
 	}
+
 	/* Verify input action list */
-	ret = dpaa2_dev_verify_actions(actions);
-	if (ret < 0) {
-		DPAA2_PMD_ERR("Invalid action list is given");
-		rte_flow_error_set(error, EPERM,
-			RTE_FLOW_ERROR_TYPE_ACTION,
-			actions, "invalid");
-		goto not_valid_params;
+	if (group_type == RTE_DPAA2_ONE_LEVEL_GROUP_FLOW ||
+		group_type == RTE_DPAA2_FS_GROUP_FLOW) {
+		supported = dpaa2_supported_fs_action_type;
+		supported_len = RTE_DIM(dpaa2_supported_fs_action_type);
+	} else {
+		supported = dpaa2_supported_qos_action_type;
+		supported_len = RTE_DIM(dpaa2_supported_qos_action_type);
+	}
+	if (!dpaa2_flow_check_actions_support(actions, supported, supported_len)) {
+		err_str = "Invalid action list is given";
+		cause = actions;
+		err_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		ret = -ENOTSUP;
+		goto invalid_params;
 	}
-not_valid_params:
+
+invalid_params:
+	if (err_str)
+		DPAA2_PMD_ERR("%s: %s", __func__, err_str);
+	rte_flow_error_set(error, -ret, err_type, cause, err_str);
+
 	return ret;
 }
 
-static struct rte_flow *
-dpaa2_flow_create(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
-		  const struct rte_flow_item pattern[],
-		  const struct rte_flow_action actions[],
-		  struct rte_flow_error *error)
+static int
+dpaa2_flow_is_ip_addr_extract(const struct dpkg_extract *extract)
 {
-	struct dpaa2_dev_flow *flow = NULL;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	int ret;
-	uint64_t iova;
+	enum dpkg_extract_type type = extract->type;
+	enum net_prot prot = extract->extract.from_hdr.prot;
+	uint32_t field = extract->extract.from_hdr.field;
 
-	dpaa2_flow_control_log =
-		getenv("DPAA2_FLOW_CONTROL_LOG");
+	if (type == DPKG_EXTRACT_FROM_HDR && prot == NET_PROT_IP &&
+		(field == NH_FLD_IP_SRC || field == NH_FLD_IP_DST))
+		return true;
 
-	flow = rte_zmalloc(NULL, sizeof(struct dpaa2_dev_flow),
-			   RTE_CACHE_LINE_SIZE);
-	if (!flow) {
-		DPAA2_PMD_ERR("Failure to allocate memory for flow");
-		goto mem_failure;
-	}
+	return false;
+}
 
-	/* Allocate DMA'ble memory to write the qos rules */
-	flow->qos_key_addr = rte_zmalloc(NULL,
-		DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE, RTE_CACHE_LINE_SIZE);
-	if (!flow->qos_key_addr) {
-		DPAA2_PMD_ERR("Memory allocation failed");
-		goto mem_failure;
-	}
-	iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(flow->qos_key_addr,
-			DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE);
-	if (iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for qos key(%p)",
-			__func__, flow->qos_key_addr);
-		goto mem_failure;
+static int
+dpaa2_flow_ip_addr_extract_pos(uint32_t field,
+	const struct dpaa2_key_profile *profile)
+{
+	if (field != NH_FLD_IP_SRC && field != NH_FLD_IP_DST)
+		return -EINVAL;
+	if (profile->ip_addr_extracts[0].field == field)
+		return 0;
+	else if (profile->ip_addr_extracts[1].field == field)
+		return 1;
+	else
+		return -ENXIO;
+}
+
+static int
+dpaa2_flow_key_offset_size(struct dpaa2_dev_flow *flow,
+	struct dpaa2_flow_tbl_profile *tbl_profile, uint8_t idx,
+	uint8_t *offset, uint8_t *size,
+	enum dpaa2_flow_dist_type type)
+{
+	struct dpkg_profile_cfg *dpkg = &tbl_profile->dpkg;
+	struct dpaa2_key_profile *profile = &tbl_profile->key_profile;
+	int pos, prev_ip_addr_pos;
+	uint32_t field;
+	uint8_t ip_addr_size = 0, ip_addr_offset = 0;
+	struct dpaa2_generic_flow *_flow;
+
+	_flow = type == DPAA2_FLOW_QOS_TYPE ? flow->qos_flow : flow->fs_flow;
+
+	if (_flow->ip_key == NET_PROT_IPV4)
+		ip_addr_size = NH_FLD_IPV4_ADDR_SIZE;
+	else if (_flow->ip_key == NET_PROT_IPV6)
+		ip_addr_size = NH_FLD_IPV6_ADDR_SIZE;
+
+	field = dpkg->extracts[idx].extract.from_hdr.field;
+	prev_ip_addr_pos = dpaa2_extract_prev_ip_addr_pos(profile);
+	if (prev_ip_addr_pos >= 0) {
+		ip_addr_offset =
+			profile->key_offset[prev_ip_addr_pos] +
+			profile->key_size[prev_ip_addr_pos];
 	}
-	flow->qos_rule.key_iova = iova;
 
-	flow->qos_mask_addr = rte_zmalloc(NULL,
-		DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE, RTE_CACHE_LINE_SIZE);
-	if (!flow->qos_mask_addr) {
-		DPAA2_PMD_ERR("Memory allocation failed");
-		goto mem_failure;
+	if (dpaa2_flow_is_ip_addr_extract(&dpkg->extracts[idx])) {
+		pos = dpaa2_flow_ip_addr_extract_pos(field, profile);
+		if (!ip_addr_size)
+			return -EINVAL;
+		*offset = ip_addr_offset + ip_addr_size * pos;
+		*size = ip_addr_size;
+	} else {
+		*offset = profile->key_offset[idx];
+		*size = profile->key_size[idx];
 	}
-	iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(flow->qos_mask_addr,
-			DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE);
-	if (iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for qos mask(%p)",
-			__func__, flow->qos_mask_addr);
+
+	return 0;
+}
+
+static int
+dpaa2_flow_rule_data_valid(struct dpaa2_dev_flow *flow,
+	uint8_t key_offset, uint8_t key_size,
+	enum dpaa2_flow_dist_type type)
+{
+	uint8_t *mask, i;
+	int valid = 0;
+	struct dpaa2_generic_flow *_flow;
+
+	_flow = type == DPAA2_FLOW_QOS_TYPE ? flow->qos_flow : flow->fs_flow;
+	mask = _flow->mask_addr + key_offset;
+
+	for (i = 0; i < key_size; i++) {
+		if (mask[i]) {
+			valid = 1;
+			break;
+		}
+	}
+
+	return valid;
+}
+
+static void
+dpaa2_flow_remove_invalid_rule_data(struct dpaa2_dev_priv *priv,
+	enum dpaa2_flow_dist_type type, uint8_t tc_id,
+	uint8_t key_offset, uint8_t key_size)
+{
+	struct dpaa2_dev_flow *flow, *next;
+	struct dpaa2_generic_flow *_flow;
+
+	flow = LIST_FIRST(&priv->flows);
+	while (flow) {
+		next = LIST_NEXT(flow, next);
+		if (type == DPAA2_FLOW_QOS_TYPE) {
+			_flow = flow->qos_flow;
+			if (!_flow)
+				goto skip_update_flow;
+		} else {
+			_flow = flow->fs_flow;
+			if (!_flow)
+				goto skip_update_flow;
+			if (_flow->tc_id != tc_id)
+				goto skip_update_flow;
+		}
+
+		if (key_offset < _flow->rule_size) {
+			memmove(_flow->key_addr + key_offset,
+				_flow->key_addr + key_offset + key_size,
+				_flow->rule_size - (key_offset + key_size));
+			memmove(_flow->mask_addr + key_offset,
+				_flow->mask_addr + key_offset + key_size,
+				_flow->rule_size - (key_offset + key_size));
+				_flow->rule_size -= key_size;
+		}
+		if (_flow->rule_cfg.key_size > _flow->rule_size) {
+			memset(_flow->key_addr + _flow->rule_size, 0,
+				_flow->rule_cfg.key_size - _flow->rule_size);
+			memset(_flow->mask_addr + _flow->rule_size, 0,
+				_flow->rule_cfg.key_size - _flow->rule_size);
+		}
+
+skip_update_flow:
+		flow = next;
+	}
+}
+
+static int
+dpaa2_flow_remove_invalid_extract(struct rte_eth_dev *dev,
+	enum dpaa2_flow_dist_type type, uint8_t tc_id)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_flow *flow, *next;
+	uint8_t i, key_offset, key_size, j, remove_conut = 0;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	struct dpkg_profile_cfg *dpkg;
+	struct dpaa2_key_profile *key_profile;
+	int valid[DPKG_MAX_NUM_OF_EXTRACTS], update = 0, ret, ipaddr;
+	enum net_prot prot;
+	uint32_t field, start, end;
+	uint32_t ip_src_size, ip_dst_size;
+	struct dpaa2_generic_flow *_flow;
+
+	if (type == DPAA2_FLOW_QOS_TYPE &&
+		priv->num_rx_tc <= 1) {
+		/** No QoS table.*/
+		return 0;
+	}
+
+	if (type == DPAA2_FLOW_QOS_TYPE)
+		tbl_profile = &priv->flow_profile.qos_profile;
+	else
+		tbl_profile = &priv->flow_profile.tc_profile[tc_id];
+
+	dpkg = &tbl_profile->dpkg;
+	key_profile = &tbl_profile->key_profile;
+	for (i = 0; i < key_profile->num; i++) {
+		valid[i] = 0;
+		flow = LIST_FIRST(&priv->flows);
+		while (flow) {
+			next = LIST_NEXT(flow, next);
+			_flow = type == DPAA2_FLOW_QOS_TYPE ?
+				flow->qos_flow : flow->fs_flow;
+			if (!_flow)
+				goto skip_validation;
+
+			if (type == DPAA2_FLOW_FS_TYPE &&
+				_flow->tc_id != tc_id)
+				goto skip_validation;
+
+			key_offset = 0;
+			key_size = 0;
+
+			ret = dpaa2_flow_key_offset_size(flow, tbl_profile, i,
+				&key_offset, &key_size, type);
+			if (ret)
+				goto skip_validation;
+
+			if (dpaa2_flow_rule_data_valid(flow,
+				key_offset, key_size, type)) {
+				valid[i] = 1;
+				break;
+			}
+skip_validation:
+			flow = next;
+		}
+		if (!valid[i])
+			remove_conut++;
+	}
+
+	if (remove_conut > 0) {
+		if (type == DPAA2_FLOW_QOS_TYPE) {
+			dpaa2_flow_extracts_log(priv,
+				"Before removing extract(s)", MAX_TCS);
+		} else {
+			dpaa2_flow_extracts_log(priv,
+				"Before removing extract(s)", tc_id);
+		}
+	} else {
+		return 0;
+	}
+
+	i = key_profile->num - 1;
+	while (remove_conut) {
+		if (valid[i]) {
+			if (i == 0) {
+				DPAA2_PMD_ERR("Fatal: %d key(s) not removed!",
+					remove_conut);
+				return -EINVAL;
+			}
+			i--;
+			continue;
+		}
+		key_size = key_profile->key_size[i];
+		key_offset = key_profile->key_offset[i];
+
+		for (j = i + 1; j < key_profile->num; j++)
+			key_profile->key_offset[j] -= key_size;
+
+		ipaddr = 0;
+		if (dpkg->extracts[i].type == DPKG_EXTRACT_FROM_HDR) {
+			prot = dpkg->extracts[i].extract.from_hdr.prot;
+			field = dpkg->extracts[i].extract.from_hdr.field;
+			ipaddr = dpaa2_flow_ip_address_extract(prot, field);
+		}
+		if (!ipaddr)
+			update += key_size;
+
+		if ((i + 1) < key_profile->num) {
+			memmove(&key_profile->key_offset[i],
+				&key_profile->key_offset[i + 1],
+				key_profile->num - i - 1);
+			memmove(&key_profile->key_size[i],
+				&key_profile->key_size[i + 1],
+				key_profile->num - i - 1);
+			memmove(&key_profile->prot_field[i],
+				&key_profile->prot_field[i + 1],
+				(key_profile->num - i - 1) *
+				sizeof(struct key_prot_field));
+
+			memmove(&dpkg->extracts[i], &dpkg->extracts[i + 1],
+				(key_profile->num - i - 1) *
+				sizeof(struct dpkg_extract));
+		}
+
+		dpaa2_flow_remove_invalid_rule_data(priv, type, tc_id,
+			key_offset, key_size);
+
+		key_profile->num--;
+		dpkg->num_extracts--;
+		i--;
+		remove_conut--;
+	};
+
+	key_profile->key_max_size -= update;
+	key_profile->key_max_size -=
+		(key_profile->ip_addr_extracts[0].max_size +
+		key_profile->ip_addr_extracts[1].max_size);
+
+	key_profile->l4_sp_present = 0;
+	key_profile->l4_dp_present = 0;
+	memset(key_profile->ip_addr_extracts, 0,
+		sizeof(struct dpaa2_ip_addr_extract) * 2);
+
+	if (key_profile->num >= 2)
+		start = key_profile->num - 2;
+	else if (key_profile->num >= 1)
+		start = key_profile->num - 1;
+	else
+		goto skip_ip_addr_extract;
+	end = key_profile->num;
+
+	j = 0;
+	for (i = start; i < end; i++) {
+		if (dpaa2_flow_is_ip_addr_extract(&dpkg->extracts[i])) {
+			key_profile->ip_addr_extracts[j].field =
+				dpkg->extracts[i].extract.from_hdr.field;
+			key_profile->ip_addr_extracts[j].max_size =
+				sizeof(rte_be32_t);
+			j++;
+		}
+	}
+
+	ip_src_size = sizeof(rte_be32_t);
+	ip_dst_size = sizeof(rte_be32_t);
+	flow = LIST_FIRST(&priv->flows);
+	while (flow) {
+		next = LIST_NEXT(flow, next);
+		_flow = type == DPAA2_FLOW_QOS_TYPE ?
+			flow->qos_flow : flow->fs_flow;
+		if (!_flow)
+			goto next_flow;
+
+		if (type == DPAA2_FLOW_FS_TYPE &&
+			_flow->tc_id != tc_id)
+			goto next_flow;
+
+		if (_flow->ip_key == NET_PROT_IPV6) {
+			if (_flow->ip_src == NET_PROT_IPV6)
+				ip_src_size = NH_FLD_IPV6_ADDR_SIZE;
+			if (_flow->ip_dst == NET_PROT_IPV6)
+				ip_dst_size = NH_FLD_IPV6_ADDR_SIZE;
+		}
+
+next_flow:
+		flow = next;
+	}
+	if (key_profile->ip_addr_extracts[0].field == NH_FLD_IP_SRC)
+		key_profile->ip_addr_extracts[0].max_size = ip_src_size;
+	else if (key_profile->ip_addr_extracts[0].field == NH_FLD_IP_DST)
+		key_profile->ip_addr_extracts[0].max_size = ip_dst_size;
+
+	if (key_profile->ip_addr_extracts[1].field == NH_FLD_IP_SRC)
+		key_profile->ip_addr_extracts[1].max_size = ip_src_size;
+	else if (key_profile->ip_addr_extracts[1].field == NH_FLD_IP_DST)
+		key_profile->ip_addr_extracts[1].max_size = ip_dst_size;
+
+	key_profile->key_max_size +=
+		(key_profile->ip_addr_extracts[0].max_size +
+		key_profile->ip_addr_extracts[1].max_size);
+
+skip_ip_addr_extract:
+	for (i = 0; i < dpkg->num_extracts; i++) {
+		if ((dpkg->extracts[i].type == DPKG_EXTRACT_FROM_HDR &&
+			dpkg->extracts[i].extract.from_hdr.prot ==
+			NET_PROT_TCP &&
+			dpkg->extracts[i].extract.from_hdr.field ==
+			NH_FLD_TCP_PORT_SRC) ||
+			(dpkg->extracts[i].type == DPKG_EXTRACT_FROM_HDR &&
+			dpkg->extracts[i].extract.from_hdr.prot ==
+			NET_PROT_UDP &&
+			dpkg->extracts[i].extract.from_hdr.field ==
+			NH_FLD_UDP_PORT_SRC) ||
+			(dpkg->extracts[i].type == DPKG_EXTRACT_FROM_HDR &&
+			dpkg->extracts[i].extract.from_hdr.prot ==
+			NET_PROT_SCTP &&
+			dpkg->extracts[i].extract.from_hdr.field ==
+			NH_FLD_SCTP_PORT_SRC)) {
+			key_profile->l4_sp_present = 1;
+			key_profile->l4_sp_extract_idx = i;
+			key_profile->l4_sp_key_offset =
+				key_profile->key_offset[i];
+		} else if ((dpkg->extracts[i].type == DPKG_EXTRACT_FROM_HDR &&
+			dpkg->extracts[i].extract.from_hdr.prot ==
+			NET_PROT_TCP &&
+			dpkg->extracts[i].extract.from_hdr.field ==
+			NH_FLD_TCP_PORT_DST) ||
+			(dpkg->extracts[i].type == DPKG_EXTRACT_FROM_HDR &&
+			dpkg->extracts[i].extract.from_hdr.prot ==
+			NET_PROT_UDP &&
+			dpkg->extracts[i].extract.from_hdr.field ==
+			NH_FLD_UDP_PORT_DST) ||
+			(dpkg->extracts[i].type == DPKG_EXTRACT_FROM_HDR &&
+			dpkg->extracts[i].extract.from_hdr.prot ==
+			NET_PROT_SCTP &&
+			dpkg->extracts[i].extract.from_hdr.field ==
+			NH_FLD_SCTP_PORT_DST)) {
+			key_profile->l4_dp_present = 1;
+			key_profile->l4_dp_extract_idx = i;
+			key_profile->l4_dp_key_offset =
+				key_profile->key_offset[i];
+		}
+	}
+
+	if (type == DPAA2_FLOW_QOS_TYPE) {
+		dpaa2_flow_extracts_log(priv,
+			"After removing extract(s)", MAX_TCS);
+	} else {
+		dpaa2_flow_extracts_log(priv,
+			"After removing extract(s)", tc_id);
+	}
+
+	return update;
+}
+
+static int
+dpaa2_flow_remove_generic_entry(struct rte_eth_dev *dev,
+	struct dpaa2_generic_flow *flow, enum dpaa2_flow_dist_type type)
+{
+	int ret = 0;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct fsl_mc_io *dpni = priv->hw;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	struct dpaa2_dev_flow_fs_action *fs_action;
+	uint8_t tc_id;
+
+	if (type == DPAA2_FLOW_QOS_TYPE)
+		goto remove_qos_flow;
+
+	fs_action = &flow->flow_action.fs_action;
+	tc_id = flow->tc_id;
+	switch (fs_action->action_type) {
+	case RTE_FLOW_ACTION_TYPE_QUEUE:
+	case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
+	case RTE_FLOW_ACTION_TYPE_PORT_ID:
+	case RTE_FLOW_ACTION_TYPE_DROP:
+		/* Then remove entry from FS table */
+		ret = dpni_remove_fs_entry(dpni, CMD_PRI_LOW, priv->token,
+			flow->tc_id, &flow->rule_cfg);
+		if (ret) {
+			DPAA2_PMD_ERR("Remove entry from FS[%d] failed(%d)",
+				flow->tc_id, ret);
+			dpaa2_flow_fs_entry_log("Delete failed", flow);
+		} else {
+			dpaa2_flow_fs_entry_log("Delete success", flow);
+			tbl_profile = &priv->flow_profile.tc_profile[tc_id];
+			tbl_profile->entry_num--;
+			dpaa2_flow_entry_map_set(tbl_profile->entry_map,
+				flow->entry_index, 0);
+		}
+		break;
+	case RTE_FLOW_ACTION_TYPE_RSS:
+		/** Remove QoS entry later.*/
+		break;
+	default:
+		DPAA2_PMD_ERR("Action(%d) not supported",
+			fs_action->action_type);
+		ret = -ENOTSUP;
+		break;
+	}
+
+	return ret;
+
+remove_qos_flow:
+	if (priv->num_rx_tc > 1) {
+		/* Remove entry from QoS table first */
+		ret = dpni_remove_qos_entry(dpni, CMD_PRI_LOW,
+			priv->token, &flow->rule_cfg);
+		if (ret) {
+			DPAA2_PMD_ERR("Remove QoS entry failed(%d)", ret);
+			dpaa2_flow_qos_entry_log("Delete failed", flow);
+			/** Will not remove FS entry.*/
+		} else {
+			dpaa2_flow_qos_entry_log("Delete success", flow);
+			tbl_profile = &priv->flow_profile.qos_profile;
+			tbl_profile->entry_num--;
+			dpaa2_flow_entry_map_set(tbl_profile->entry_map,
+				flow->entry_index, 0);
+		}
+	}
+
+	return ret;
+}
+
+static int
+dpaa2_flow_generic_flow_destroy(struct rte_eth_dev *dev,
+	struct dpaa2_generic_flow *flow, enum dpaa2_flow_dist_type type)
+{
+	int ret = 0, update;
+	uint8_t tc_id = 0;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+
+	dpaa2_dump_extract_map(priv, "Start destroying flow", type,
+		type == DPAA2_FLOW_FS_TYPE ? flow->tc_id : 0);
+
+	ret = dpaa2_flow_remove_generic_entry(dev, flow, type);
+	if (ret)
+		return ret;
+
+	if (type == DPAA2_FLOW_FS_TYPE)
+		tc_id = flow->tc_id;
+
+	update = dpaa2_flow_remove_invalid_extract(dev, type, tc_id);
+	if (update > 0) {
+		if (type == DPAA2_FLOW_FS_TYPE) {
+			ret = dpaa2_flow_fs_rss_table_config(priv,
+				flow->tc_id, false);
+			if (ret)
+				DPAA2_PMD_ERR("Re-configure FS table failed(%d)", ret);
+		} else {
+			ret = dpaa2_flow_qos_table_config(priv, false);
+			if (ret)
+				DPAA2_PMD_ERR("Re-configure QoS table failed(%d)", ret);
+		}
+	}
+
+	if (!ret) {
+		dpaa2_dump_extract_map(priv, "End destroying flow",
+			type, tc_id);
+	}
+
+	return ret;
+}
+
+static int
+dpaa2_flow_qos_fs_action_set(const struct rte_flow_action actions[],
+	struct rte_flow_action qos_actions[],
+	struct rte_flow_action fs_actions[],
+	uint8_t *qos_action_num, uint8_t *fs_action_num)
+{
+	uint8_t qos_act_num = 0, fs_act_num = 0;
+	int end_of_list = 0, i = 0, is_qos_act, is_fs_act;
+	struct rte_flow_action action_check[2];
+
+	action_check[1].type = RTE_FLOW_ACTION_TYPE_END;
+	while (!end_of_list) {
+		if (actions[i].type == RTE_FLOW_ACTION_TYPE_END) {
+			if (qos_action_num)
+				*qos_action_num = qos_act_num;
+			if (fs_action_num)
+				*fs_action_num = fs_act_num;
+			qos_actions[qos_act_num].type = actions[i].type;
+			fs_actions[fs_act_num].type = actions[i].type;
+			end_of_list = 1;
+			continue;
+		}
+		action_check[0].type = actions[i].type;
+		action_check[0].conf = actions[i].conf;
+		is_qos_act = dpaa2_flow_check_actions_support(action_check,
+			dpaa2_supported_qos_action_type,
+			RTE_DIM(dpaa2_supported_qos_action_type));
+		is_fs_act = dpaa2_flow_check_actions_support(action_check,
+			dpaa2_supported_fs_action_type,
+			RTE_DIM(dpaa2_supported_fs_action_type));
+		if (!is_qos_act && !is_fs_act)
+			return -EINVAL;
+		if (is_qos_act && is_fs_act)
+			is_qos_act = false;
+		if (is_qos_act) {
+			qos_actions[qos_act_num].type = actions[i].type;
+			qos_actions[qos_act_num].conf = actions[i].conf;
+			qos_act_num++;
+		}
+		if (is_fs_act) {
+			fs_actions[fs_act_num].type = actions[i].type;
+			fs_actions[fs_act_num].conf = actions[i].conf;
+			fs_act_num++;
+		}
+		i++;
+	}
+
+	return 0;
+}
+
+static struct dpaa2_generic_flow *
+dpaa2_flow_generic_flow_create(struct rte_eth_dev *dev,
+	const struct rte_flow_attr *attr,
+	const struct rte_flow_item pattern[],
+	const struct rte_flow_action actions[],
+	struct rte_flow_error *error, enum dpaa2_flow_dist_type type,
+	int mix_extract, int is_rss)
+{
+	struct dpaa2_generic_flow *flow = NULL;
+	struct rte_dpaa2_device *dpaa2_dev;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	int ret, idx = -1;
+	uint64_t iova, mc_rev;
+	uint8_t qos_action_num = 0, fs_action_num = 0;
+	struct rte_flow_action qos_actions[DPAA2_MAX_ACTION_PER_FLOW_NUM];
+	struct rte_flow_action fs_actions[DPAA2_MAX_ACTION_PER_FLOW_NUM];
+	struct rte_flow_action_jump action_jump;
+	const struct rte_flow_action_rss *action_rss;
+	const struct rte_flow_action_queue *action_q;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	struct dpaa2_queue *dir_rxq = NULL;
+
+	if (type != DPAA2_FLOW_QOS_TYPE && type != DPAA2_FLOW_FS_TYPE)
+		return NULL;
+
+	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
+	mc_rev = dpaa2_dev->bus_info->mc_rev;
+
+	if (actions) {
+		ret = dpaa2_flow_qos_fs_action_set(actions, qos_actions,
+			fs_actions, &qos_action_num, &fs_action_num);
+		if (ret) {
+			DPAA2_PMD_ERR("Failed(%d) to set qos/fs actions!", ret);
+			goto creation_error;
+		}
+		if (type == DPAA2_FLOW_QOS_TYPE &&
+			dpaa2_flow_action_single_type_check(fs_actions,
+				RTE_FLOW_ACTION_TYPE_QUEUE)) {
+			action_q = fs_actions[0].conf;
+			if (action_q->index >= dev->data->nb_rx_queues) {
+				DPAA2_PMD_ERR("direct queue index(%d) >= max(%d)",
+					action_q->index,
+					dev->data->nb_rx_queues);
+				ret = -EINVAL;
+				goto creation_error;
+			}
+			if ((mc_rev < DPAA2_QOS_FLOW_HW_ACTION_UPDATE_MC_REV ||
+				mc_rev < DPAA2_QOS_FLOW_TABLE_MISS_FLOW_ACTION_MC_REV) &&
+				mix_extract) {
+				/** We don't recommend steering flow by QoS table here
+				 * because this version doesn't support QoS flow HW update
+				 * and QoS table miss flow.
+				 */
+				dir_rxq = NULL;
+			} else {
+				dir_rxq = dev->data->rx_queues[action_q->index];
+			}
+		}
+	}
+
+	if (type == DPAA2_FLOW_FS_TYPE && attr) {
+		if (attr->group >= priv->num_rx_tc) {
+			DPAA2_PMD_ERR("Flow group(%d) >= max(%d)",
+				attr->group, priv->num_rx_tc);
+			return NULL;
+		}
+		if (attr->priority >= priv->fs_entries && !is_rss) {
+			DPAA2_PMD_ERR("FS[%d].entry(%d) >= max(%d)",
+				attr->group, attr->priority, priv->fs_entries);
+			return NULL;
+		}
+	}
+
+	if (dir_rxq) {
+		qos_actions[0].type = RTE_FLOW_ACTION_TYPE_JUMP;
+		qos_actions[0].conf = &action_jump;
+		qos_actions[1].type = RTE_FLOW_ACTION_TYPE_END;
+		/** Ignore attr->group*/
+		if ((mix_extract || type == DPAA2_FLOW_FS_TYPE) &&
+			attr->group < priv->num_rx_tc &&
+			attr->group != dir_rxq->tc_index) {
+			DPAA2_PMD_ERR("Attribute group(%d) conflicts with dest queue's TC(%d)",
+				attr->group, dir_rxq->tc_index);
+			return NULL;
+		}
+		action_jump.group = dir_rxq->tc_index;
+		if (attr->group >= priv->num_rx_tc)
+			idx = attr->priority;
+		else if (!priv->fs_entries)
+			idx = action_jump.group * priv->dist_queues + attr->priority;
+		else
+			idx = action_jump.group * priv->fs_entries + attr->priority;
+	} else if (mix_extract && type == DPAA2_FLOW_QOS_TYPE) {
+		/** Move end action.*/
+		rte_memcpy(&qos_actions[qos_action_num + 1],
+			&qos_actions[qos_action_num],
+			sizeof(struct rte_flow_action));
+		/** Jump to FS[group]*/
+		qos_actions[qos_action_num].type = RTE_FLOW_ACTION_TYPE_JUMP;
+		qos_actions[qos_action_num].conf = &action_jump;
+		action_jump.group = attr->group;
+		idx = action_jump.group * priv->fs_entries + attr->priority;
+		qos_action_num++;
+	} else if (!mix_extract && type == DPAA2_FLOW_QOS_TYPE) {
+		if (!qos_action_num) {
+			DPAA2_PMD_ERR("No QoS flow's action!");
+			return NULL;
+		}
+		if (!is_rss) {
+			idx = dpaa2_flow_acquire_entry_idx(priv, attr->priority,
+				DPAA2_FLOW_QOS_TYPE, attr->group);
+		}
+	} else if (type == DPAA2_FLOW_FS_TYPE) {
+		ret = dpaa2_flow_verify_fs_action(priv, attr, actions);
+		if (ret)
+			return NULL;
+		if (!is_rss) {
+			idx = dpaa2_flow_acquire_entry_idx(priv, attr->priority,
+				DPAA2_FLOW_FS_TYPE, attr->group);
+		}
+	} else {
+		DPAA2_PMD_ERR("Invalid flow type(%d) or extract type(%d)",
+			type, mix_extract);
+		return NULL;
+	}
+	if (idx < 0 && !is_rss)
+		return NULL;
+	if (idx >= 0 && idx < RTE_ETH_DCB_NUM_USER_PRIORITIES && !is_rss &&
+		type == DPAA2_FLOW_QOS_TYPE && priv->dcb_flow[idx]) {
+		DPAA2_PMD_ERR("QoS flow[%d] added conflicts with dcb flow", idx);
+		return NULL;
+	}
+
+	if (!is_rss) {
+		ret = dpaa2_flow_verify_entry(priv, attr->group, idx, type);
+		if (ret)
+			return NULL;
+		if ((type == DPAA2_FLOW_QOS_TYPE && idx >= priv->qos_entries) ||
+			(type == DPAA2_FLOW_FS_TYPE && idx >= priv->fs_entries)) {
+			DPAA2_PMD_ERR("%s flow[%d] added more than max entries(%d)",
+				type == DPAA2_FLOW_QOS_TYPE ? "QoS" : "FS", idx,
+				type == DPAA2_FLOW_QOS_TYPE ? priv->qos_entries : priv->fs_entries);
+			return NULL;
+		}
+	}
+
+	dpaa2_dump_extract_map(priv, "Start creating flow",
+		type, attr->group);
+
+	flow = rte_zmalloc(NULL, sizeof(struct dpaa2_generic_flow),
+		RTE_CACHE_LINE_SIZE);
+	if (!flow) {
+		DPAA2_PMD_ERR("Failure to allocate memory for flow");
 		goto mem_failure;
 	}
-	flow->qos_rule.mask_iova = iova;
+	flow->priv = priv;
 
-	/* Allocate DMA'ble memory to write the FS rules */
-	flow->fs_key_addr = rte_zmalloc(NULL,
+	/* Allocate DMA'ble memory to write the qos rules */
+	flow->key_addr = rte_zmalloc(NULL,
 		DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE, RTE_CACHE_LINE_SIZE);
-	if (!flow->fs_key_addr) {
+	if (!flow->key_addr) {
 		DPAA2_PMD_ERR("Memory allocation failed");
 		goto mem_failure;
 	}
-	iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(flow->fs_key_addr,
+	iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(flow->key_addr,
 			DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE);
 	if (iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for fs key(%p)",
-			__func__, flow->fs_key_addr);
+		DPAA2_PMD_ERR("%s: No IOMMU map for key(%p)",
+			__func__, flow->key_addr);
 		goto mem_failure;
 	}
-	flow->fs_rule.key_iova = iova;
+	flow->rule_cfg.key_iova = iova;
 
-	flow->fs_mask_addr = rte_zmalloc(NULL,
+	flow->mask_addr = rte_zmalloc(NULL,
 		DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE, RTE_CACHE_LINE_SIZE);
-	if (!flow->fs_mask_addr) {
+	if (!flow->mask_addr) {
 		DPAA2_PMD_ERR("Memory allocation failed");
 		goto mem_failure;
 	}
-	iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(flow->fs_mask_addr,
-		DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE);
+	iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(flow->mask_addr,
+			DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE);
 	if (iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for fs mask(%p)",
-			__func__, flow->fs_mask_addr);
+		DPAA2_PMD_ERR("%s: No IOMMU map for mask(%p)",
+			__func__, flow->mask_addr);
 		goto mem_failure;
 	}
-	flow->fs_rule.mask_iova = iova;
+	flow->rule_cfg.mask_iova = iova;
 
-	priv->curr = flow;
+	flow->ip_key = NET_PROT_NONE;
 
-	ret = dpaa2_generic_flow_set(flow, dev, attr, pattern, actions, error);
+	priv->cur_flow = flow;
+	if (is_rss) {
+		action_rss = actions[0].conf;
+		tbl_profile = &priv->flow_profile.tc_profile[attr->group];
+		tbl_profile->tc_cfg.dist_size = action_rss->queue_num;
+	}
+	ret = dpaa2_flow_generic_extract_rule_set(flow,
+		attr, pattern, is_rss, type, false);
 	if (ret < 0) {
-		if (error && error->type > RTE_FLOW_ERROR_TYPE_ACTION)
+		if (error && error->type > RTE_FLOW_ERROR_TYPE_ACTION) {
 			rte_flow_error_set(error, EPERM,
-					   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-					   attr, "unknown");
-		DPAA2_PMD_ERR("Create flow failed (%d)", ret);
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+				attr, "unknown");
+		}
+		DPAA2_PMD_ERR("Create %s flow failed (%d)",
+			type == DPAA2_FLOW_QOS_TYPE ?
+			"QoS" : "FS", ret);
 		goto creation_error;
 	}
 
-	priv->curr = NULL;
-	return (struct rte_flow *)flow;
+	flow->entry_index = idx;
+	if (type == DPAA2_FLOW_QOS_TYPE) {
+		ret = dpaa2_flow_qos_action_update(priv, flow, qos_actions, true);
+		if (ret)
+			goto creation_error;
+		if (dir_rxq) {
+			flow->direct_queue = true;
+			flow->flow_id = dir_rxq->flow_id;
+		}
+		ret = dpaa2_flow_add_qos_rule(priv, flow);
+		if (ret)
+			goto creation_error;
+	} else {
+		flow->tc_id = attr->group;
+		ret = dpaa2_flow_fs_action_update(priv, flow, fs_actions);
+		if (ret)
+			goto creation_error;
+		if (!is_rss) {
+			ret = dpaa2_flow_add_fs_rule(priv, flow);
+			if (ret)
+				goto creation_error;
+		} else {
+			flow->is_rss = true;
+		}
+	}
+	priv->cur_flow = NULL;
+
+	dpaa2_dump_extract_map(priv, "Complete creating flow",
+		type, attr->group);
+
+	return flow;
 
 mem_failure:
 	rte_flow_error_set(error, EPERM, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
-			   "memory alloc");
+		"memory alloc");
 
 creation_error:
 	if (flow) {
-		rte_free(flow->qos_key_addr);
-		rte_free(flow->qos_mask_addr);
-		rte_free(flow->fs_key_addr);
-		rte_free(flow->fs_mask_addr);
+		if (flow->key_addr)
+			rte_free(flow->key_addr);
+		if (flow->mask_addr)
+			rte_free(flow->mask_addr);
 		rte_free(flow);
 	}
-	priv->curr = NULL;
+
+	return NULL;
+}
+
+static struct rte_flow *
+dpaa2_flow_create_meter_flow(struct rte_eth_dev *dev,
+	const struct rte_flow_attr *attr,
+	const struct rte_flow_action meter_action[])
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_flow *flow = NULL;
+	struct dpaa2_generic_flow *fs_flow = NULL;
+	int ret;
+
+	if (attr->group >= priv->num_rx_tc)
+		return NULL;
+
+	if (priv->flow_profile.mtr_flow[attr->group])
+		return NULL;
+
+	fs_flow = rte_zmalloc(NULL, sizeof(struct dpaa2_generic_flow),
+		RTE_CACHE_LINE_SIZE);
+	if (!fs_flow) {
+		DPAA2_PMD_ERR("Failure to allocate memory for flow");
+		return NULL;
+	}
+	flow = rte_zmalloc(NULL, sizeof(struct dpaa2_dev_flow),
+		RTE_CACHE_LINE_SIZE);
+	if (!flow) {
+		rte_free(fs_flow);
+		DPAA2_PMD_ERR("Failure to allocate memory for flow");
+		return NULL;
+	}
+	fs_flow->tc_id = attr->group;
+	fs_flow->priv = priv;
+	flow->fs_flow = fs_flow;
+	flow->priv = priv;
+
+	ret = dpaa2_flow_fs_action_update(priv, fs_flow, meter_action);
+	if (ret) {
+		rte_free(fs_flow);
+		rte_free(flow);
+		return NULL;
+	}
+	flow->is_meter_flow = true;
+	priv->flow_profile.mtr_flow[fs_flow->tc_id] = flow;
+
+	return (struct rte_flow *)flow;
+}
+
+static struct rte_flow *
+dpaa2_flow_create(struct rte_eth_dev *dev,
+	const struct rte_flow_attr *attr,
+	const struct rte_flow_item pattern[],
+	const struct rte_flow_action actions[],
+	struct rte_flow_error *error)
+{
+	struct dpaa2_dev_flow *flow = NULL, *curr;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	int ret, is_rss = false;
+	struct dpaa2_generic_flow *qos_flow = NULL;
+	struct dpaa2_generic_flow *fs_flow = NULL;
+	uint32_t group_id, group_type;
+	const struct rte_flow_action_rss *rss_conf;
+	struct rte_flow_item items[DPKG_MAX_NUM_OF_EXTRACTS + 1];
+	int rss_item = false, err_code = 0;
+	uint8_t spec_buf[1024];
+	enum rte_flow_error_type error_type = RTE_FLOW_ERROR_TYPE_NONE;
+	const char *err_str = NULL;
+	struct rte_flow_attr local_attr;
+
+	if (getenv("DPAA2_FLOW_CONTROL_LOG"))
+		dpaa2_flow_control_log = 1;
+
+	group_type = RTE_DPAA2_FLOW_GROUP_TYPE_GET(attr->group);
+	group_id = RTE_DPAA2_FLOW_GROUP_ID_GET(attr->group);
+	if (group_id >= priv->num_rx_tc &&
+		group_type == RTE_DPAA2_ONE_LEVEL_GROUP_FLOW) {
+		group_type = RTE_DPAA2_QOS_GROUP_FLOW;
+		group_id = DPAA2_FLOW_QOS_GROUP_ID;
+	}
+	rte_memcpy(&local_attr, attr, sizeof(struct rte_flow_attr));
+	local_attr.group = group_id;
+
+	if (actions) {
+		is_rss = dpaa2_flow_action_single_type_check(actions,
+			RTE_FLOW_ACTION_TYPE_RSS);
+	}
+	if (is_rss && group_type == RTE_DPAA2_QOS_GROUP_FLOW) {
+		err_str = "RSS doesn't supports QoS table!";
+		error_type = RTE_FLOW_ERROR_TYPE_ATTR;
+		err_code = -EINVAL;
+		goto flow_failure;
+	}
+	if (is_rss && group_type != RTE_DPAA2_FS_GROUP_FLOW) {
+		DPAA2_PMD_WARN("RSS distribution in TC%d.", group_id);
+		group_type = RTE_DPAA2_FS_GROUP_FLOW;
+	}
+	if (is_rss && !pattern) {
+		rss_conf = actions[0].conf;
+		ret = dpaa2_flow_rss_conf_to_item(rss_conf->types, items,
+			spec_buf, 1024);
+		if (ret < 0) {
+			DPAA2_PMD_ERR("TC[%d] converts to RSS items failed(%d)",
+				group_id, ret);
+			error_type = RTE_FLOW_ERROR_TYPE_ITEM;
+			err_code = ret;
+			err_str = "Failed to converts RSS config type to RSS items!";
+			goto flow_failure;
+		}
+		rss_item = true;
+	}
+
+	if (dpaa2_flow_check_actions_support(actions,
+		dpaa2_supported_meter_action_type,
+		RTE_DIM(dpaa2_supported_meter_action_type))) {
+		/** Assume it's meter flow per TC.*/
+		if (group_type == RTE_DPAA2_QOS_GROUP_FLOW) {
+			error_type = RTE_FLOW_ERROR_TYPE_ATTR_GROUP;
+			err_code = -EINVAL;
+			err_str = "Failed to converts RSS config type to RSS items!";
+			goto flow_failure;
+		}
+		if (actions[1].type != RTE_FLOW_ACTION_TYPE_END) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION_NUM;
+			err_code = -EPERM;
+			err_str = "Meter flow can't support multi-actions.";
+			goto flow_failure;
+		}
+		flow = (void *)dpaa2_flow_create_meter_flow(dev, &local_attr, actions);
+		if (flow)
+			return (struct rte_flow *)flow;
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		err_code = -EINVAL;
+		err_str = "Failed to create meter flow!";
+		goto flow_failure;
+	}
+
+	DPAA2_PMD_DEBUG("Port %s-%s: group type:%d, group id:%d, total RX TCs:%d",
+		dev->data->name, __func__, group_type, group_id, priv->num_rx_tc);
+	if (group_type == RTE_DPAA2_ONE_LEVEL_GROUP_FLOW) {
+		if (priv->qos_entries > 0) {
+			qos_flow = dpaa2_flow_generic_flow_create(dev, &local_attr, pattern,
+				actions, error, DPAA2_FLOW_QOS_TYPE, true, is_rss);
+			if (!qos_flow) {
+				err_str = "Failed to create QoS flow!";
+				error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+				err_code = -EINVAL;
+				goto flow_failure;
+			}
+		}
+		if (priv->fs_entries > 0 && !(qos_flow && qos_flow->direct_queue)) {
+			fs_flow = dpaa2_flow_generic_flow_create(dev, &local_attr, pattern,
+				actions, error, DPAA2_FLOW_FS_TYPE, true, is_rss);
+			if (!fs_flow) {
+				if (qos_flow) {
+					ret = dpaa2_flow_generic_flow_destroy(dev, qos_flow,
+						DPAA2_FLOW_QOS_TYPE);
+					if (ret) {
+						DPAA2_PMD_ERR("%s: QoS flow destroy failed(%d)!",
+							__func__, ret);
+					}
+				}
+				err_str = "Failed to create FS flow!";
+				error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+				err_code = -EINVAL;
+				goto flow_failure;
+			}
+		}
+	} else if (group_type == RTE_DPAA2_QOS_GROUP_FLOW) {
+		if (!priv->qos_entries) {
+			err_str = "No QoS entry available!";
+			error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+			err_code = -EINVAL;
+			goto flow_failure;
+		}
+		qos_flow = dpaa2_flow_generic_flow_create(dev, &local_attr, pattern,
+			actions, error, DPAA2_FLOW_QOS_TYPE, false, is_rss);
+		if (!qos_flow) {
+			err_str = "QoS flow create failed!";
+			error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+			err_code = -EINVAL;
+			goto flow_failure;
+		}
+	} else if (group_type == RTE_DPAA2_FS_GROUP_FLOW) {
+		if (!priv->fs_entries && !is_rss) {
+			err_str = "No FS entry available!";
+			error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+			err_code = -EINVAL;
+			goto flow_failure;
+		}
+		fs_flow = dpaa2_flow_generic_flow_create(dev, &local_attr,
+			rss_item ? items : pattern,
+			actions, error, DPAA2_FLOW_FS_TYPE, false, is_rss);
+		if (!fs_flow) {
+			err_str = "FS flow create failed!";
+			error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+			err_code = -EINVAL;
+			goto flow_failure;
+		}
+	} else {
+		err_str = "Invalid flow attribut parameter!";
+		error_type = RTE_FLOW_ERROR_TYPE_ATTR;
+		err_code = -EINVAL;
+		goto flow_failure;
+	}
+	if (!qos_flow && !fs_flow) {
+		err_str = "Both QoS flow and FS flow are NULL!";
+		error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+		err_code = -EINVAL;
+		goto flow_failure;
+	}
+	flow = rte_zmalloc(NULL, sizeof(struct dpaa2_dev_flow),
+		RTE_CACHE_LINE_SIZE);
+	if (!flow) {
+		err_str = "Failure to allocate memory for flow!";
+		error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+		err_code = -ENOMEM;
+		goto flow_failure;
+	}
+	flow->qos_flow = qos_flow;
+	flow->fs_flow = fs_flow;
+	flow->priv = priv;
+	if (fs_flow && fs_flow->is_rss)
+		priv->flow_profile.tc_profile[group_id].rss_flow = flow;
+
+	/* New rules are inserted. */
+	curr = LIST_FIRST(&priv->flows);
+	if (!curr) {
+		LIST_INSERT_HEAD(&priv->flows, flow, next);
+	} else {
+		while (LIST_NEXT(curr, next))
+			curr = LIST_NEXT(curr, next);
+		LIST_INSERT_AFTER(curr, flow, next);
+	}
+
+	return (struct rte_flow *)flow;
+
+flow_failure:
+	if (err_str)
+		DPAA2_PMD_ERR("%s: %s", __func__, err_str);
+	rte_flow_error_set(error, -err_code, error_type, NULL, err_str);
+
+	if (flow) {
+		if (flow->qos_flow && flow->qos_flow->key_addr)
+			rte_free(flow->qos_flow->key_addr);
+		if (flow->qos_flow && flow->qos_flow->mask_addr)
+			rte_free(flow->qos_flow->mask_addr);
+		if (flow->fs_flow && flow->fs_flow->key_addr)
+			rte_free(flow->fs_flow->key_addr);
+		if (flow->fs_flow && flow->fs_flow->mask_addr)
+			rte_free(flow->fs_flow->mask_addr);
+		if (flow->qos_flow)
+			rte_free(flow->qos_flow);
+		if (flow->fs_flow)
+			rte_free(flow->fs_flow);
+		rte_free(flow);
+	}
+	priv->cur_flow = NULL;
 
 	return NULL;
 }
 
 static int
-dpaa2_flow_destroy(struct rte_eth_dev *dev, struct rte_flow *_flow,
-		   struct rte_flow_error *error)
+dpaa2_flow_destroy_meter_flow(struct rte_eth_dev *dev,
+	struct dpaa2_dev_flow *flow)
 {
-	int ret = 0;
+	struct rte_dpaa2_device *dpaa2_dev;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpni_rx_tc_policing_cfg cfg;
+	int ret;
+	uint8_t tc_id;
+
+	RTE_ASSERT(!flow->qos_flow && flow->fs_flow);
+	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
+	tc_id = flow->fs_flow->tc_id;
+	RTE_ASSERT(priv->flow_profile.mtr_flow[tc_id] == flow);
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.mode = DPNI_POLICER_MODE_NONE;
+	if (dpaa2_dev->bus_info->mc_rev < DPAA2_POLICER_SET_V2_MC_REV) {
+		ret = dpni_set_rx_tc_policing_v1(priv->hw, CMD_PRI_LOW,
+			priv->token, tc_id, &cfg);
+	} else {
+		ret = dpni_set_rx_tc_policing(priv->hw, CMD_PRI_LOW,
+			priv->token, tc_id, &cfg);
+	}
+	if (ret)
+		return ret;
+	priv->flow_profile.tc_mtr_profile[tc_id] = NULL;
+	priv->flow_profile.mtr_flow[tc_id] = NULL;
+	rte_free(flow->fs_flow);
+	rte_free(flow);
+
+	return 0;
+}
+
+static int
+dpaa2_flow_destroy(struct rte_eth_dev *dev,
+	struct rte_flow *_flow, struct rte_flow_error *error)
+{
+	int qos_ret = 0, fs_ret = 0;
 	struct dpaa2_dev_flow *flow;
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	struct fsl_mc_io *dpni = priv->hw;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	uint8_t tc_id;
+
+	RTE_SET_USED(error);
 
 	flow = (struct dpaa2_dev_flow *)_flow;
+	if (flow->is_meter_flow)
+		return dpaa2_flow_destroy_meter_flow(dev, flow);
 
-	switch (flow->action_type) {
-	case RTE_FLOW_ACTION_TYPE_QUEUE:
-	case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
-	case RTE_FLOW_ACTION_TYPE_PORT_ID:
-	case RTE_FLOW_ACTION_TYPE_DROP:
-		if (priv->num_rx_tc > 1) {
-			/* Remove entry from QoS table first */
-			ret = dpni_remove_qos_entry(dpni, CMD_PRI_LOW,
-						    priv->token,
-						    &flow->qos_rule);
-			if (ret < 0) {
-				DPAA2_PMD_ERR("Remove FS QoS entry failed");
-				dpaa2_flow_qos_entry_log("Delete failed", flow,
-							 -1);
-				abort();
-				goto error;
+	LIST_REMOVE(flow, next);
+
+	if (flow->qos_flow) {
+		qos_ret = dpaa2_flow_generic_flow_destroy(dev, flow->qos_flow,
+			DPAA2_FLOW_QOS_TYPE);
+		if (qos_ret) {
+			DPAA2_PMD_ERR("%s: destroy QoS flow failed(%d)",
+				__func__, qos_ret);
+		}
+		if (flow->qos_flow->key_addr)
+			rte_free(flow->qos_flow->key_addr);
+		if (flow->qos_flow->mask_addr)
+			rte_free(flow->qos_flow->mask_addr);
+		rte_free(flow->qos_flow);
+		flow->qos_flow = NULL;
+	}
+	if (flow->fs_flow) {
+		fs_ret = dpaa2_flow_generic_flow_destroy(dev, flow->fs_flow,
+			DPAA2_FLOW_FS_TYPE);
+		if (fs_ret) {
+			DPAA2_PMD_ERR("%s: destroy FS flow failed(%d)",
+				__func__, fs_ret);
+		}
+		if (flow->fs_flow->key_addr)
+			rte_free(flow->fs_flow->key_addr);
+		if (flow->fs_flow->mask_addr)
+			rte_free(flow->fs_flow->mask_addr);
+		if (flow->fs_flow->is_rss) {
+			tc_id = flow->fs_flow->tc_id;
+			tbl_profile = &priv->flow_profile.tc_profile[tc_id];
+			tbl_profile->rss_flow = NULL;
+		}
+		rte_free(flow->fs_flow);
+		flow->fs_flow = NULL;
+	}
+	rte_free(flow);
+
+	if (!qos_ret && !fs_ret)
+		return 0;
+
+	return qos_ret ? qos_ret : fs_ret;
+}
+
+static int
+dpaa2_flow_set_miss_actions(struct rte_eth_dev *dev,
+	uint32_t group, const struct rte_flow_group_attr *attr,
+	const struct rte_flow_action actions[], struct rte_flow_error *err)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	enum dpaa2_flow_dist_type flow_type = DPAA2_FLOW_NULL_TYPE;
+	int end_of_list = 0, i = 0, discard = false, err_code = 0;
+	const struct rte_flow_action_jump *action_jump = NULL;
+	const struct rte_flow_action_queue *dest_queue = NULL;
+	uint32_t group_id, group_type;
+	enum rte_flow_error_type error_type = RTE_FLOW_ERROR_TYPE_NONE;
+	const char *err_str = NULL;
+	struct dpaa2_queue *miss_rxq = NULL;
+	uint8_t qos_tc = 0xff;
+	uint16_t qos_flow = 0xffff;
+
+	RTE_SET_USED(attr);
+
+	group_type = RTE_DPAA2_FLOW_GROUP_TYPE_GET(group);
+	group_id = RTE_DPAA2_FLOW_GROUP_ID_GET(group);
+	if (group_id >= priv->num_rx_tc &&
+		group_type == RTE_DPAA2_ONE_LEVEL_GROUP_FLOW) {
+		group_type = RTE_DPAA2_QOS_GROUP_FLOW;
+		group_id = 0;
+	}
+	if (group_type == RTE_DPAA2_QOS_GROUP_FLOW)
+		flow_type = DPAA2_FLOW_QOS_TYPE;
+	else if (group_type == RTE_DPAA2_FS_GROUP_FLOW)
+		flow_type = DPAA2_FLOW_FS_TYPE;
+	else if (group >= priv->num_rx_tc)
+		flow_type = DPAA2_FLOW_QOS_TYPE;
+	else
+		flow_type = DPAA2_FLOW_FS_TYPE;
+
+	while (!end_of_list) {
+		switch (actions[i].type) {
+		case RTE_FLOW_ACTION_TYPE_QUEUE:
+			dest_queue = actions[i].conf;
+			if (dest_queue->index >= dev->data->nb_rx_queues) {
+				error_type = RTE_FLOW_ERROR_TYPE_ACTION_CONF;
+				err_code = -EINVAL;
+				err_str = "Queue index overflows";
+				goto failure_to_set_miss_actions;
 			}
+			miss_rxq = priv->rx_vq[dest_queue->index];
+			break;
+		case RTE_FLOW_ACTION_TYPE_JUMP:
+			action_jump = actions[i].conf;
+			break;
+		case RTE_FLOW_ACTION_TYPE_DROP:
+			discard = true;
+			break;
+		case RTE_FLOW_ACTION_TYPE_END:
+			end_of_list = 1;
+			break;
+		default:
+			DPAA2_PMD_WARN("Invalid default action type[%d]:(%d)",
+				i, actions[i].type);
+			break;
 		}
+		i++;
+	}
 
-		/* Then remove entry from FS table */
-		ret = dpni_remove_fs_entry(dpni, CMD_PRI_LOW, priv->token,
-					   flow->tc_id, &flow->fs_rule);
-		if (ret < 0) {
-			DPAA2_PMD_ERR("Remove entry from FS[%d] failed",
-				      flow->tc_id);
-			goto error;
+	if (flow_type == DPAA2_FLOW_QOS_TYPE) {
+		if (!priv->qos_entries) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_code = -EINVAL;
+			err_str = "No QoS table available!";
+			goto failure_to_set_miss_actions;
 		}
-		break;
-	case RTE_FLOW_ACTION_TYPE_RSS:
-		if (priv->num_rx_tc > 1) {
-			ret = dpni_remove_qos_entry(dpni, CMD_PRI_LOW,
-						    priv->token,
-						    &flow->qos_rule);
-			if (ret < 0) {
-				DPAA2_PMD_ERR("Remove RSS QoS entry failed");
-				goto error;
+		if (action_jump && miss_rxq) {
+			if (action_jump->group != miss_rxq->tc_index) {
+				error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+				err_code = -EINVAL;
+				err_str = "Jump group conflicts to miss queue's TC";
+				goto failure_to_set_miss_actions;
 			}
 		}
-		break;
-	default:
-		DPAA2_PMD_ERR("Action(%d) not supported", flow->action_type);
-		ret = -ENOTSUP;
-		break;
+		if (action_jump)
+			qos_tc = action_jump->group;
+		if (miss_rxq) {
+			qos_tc = miss_rxq->tc_index;
+			qos_flow = miss_rxq->flow_id;
+		}
+		if ((!discard && qos_tc == 0xff) ||
+			(discard && qos_tc != 0xff)) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_code = -EINVAL;
+			err_str = "Invalid miss action set for QoS table";
+			goto failure_to_set_miss_actions;
+		}
+		err_code = dpaa2_flow_qos_table_set_default(priv, discard, qos_tc, qos_flow);
+		if (err_code) {
+			error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+			err_str = "Failed to set miss action for QoS table";
+			goto failure_to_set_miss_actions;
+		}
+
+		return 0;
 	}
 
-	LIST_REMOVE(flow, next);
-	rte_free(flow->qos_key_addr);
-	rte_free(flow->qos_mask_addr);
-	rte_free(flow->fs_key_addr);
-	rte_free(flow->fs_mask_addr);
-	/* Now free the flow */
-	rte_free(flow);
+	if (!priv->fs_entries) {
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		err_code = -EINVAL;
+		err_str = "No FS table available!";
+		goto failure_to_set_miss_actions;
+	}
+	if (!discard && !miss_rxq) {
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		err_code = -EINVAL;
+		err_str = "Invalid miss action set for FS table";
+		goto failure_to_set_miss_actions;
+	}
+	if (miss_rxq && miss_rxq->tc_index != group_id) {
+		error_type = RTE_FLOW_ERROR_TYPE_ATTR_GROUP;
+		err_code = -EINVAL;
+		err_str = "Group conflicts with dest queue's TC ID";
+		goto failure_to_set_miss_actions;
+	}
+	err_code = dpaa2_flow_fs_table_set_default(priv, group_id, discard,
+		dest_queue ? dest_queue->index : 0);
+	if (err_code) {
+		error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+		err_str = "Failed to set miss action for FS table";
+	}
 
-error:
-	if (ret)
-		rte_flow_error_set(error, EPERM,
-				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				   NULL, "unknown");
-	return ret;
+failure_to_set_miss_actions:
+	if (err_str)
+		DPAA2_PMD_ERR("%s: %s", __func__, err_str);
+	rte_flow_error_set(err, -err_code, error_type, NULL, err_str);
+
+	return err_code;
+}
+
+static int
+dpaa2_flow_actions_update(struct rte_eth_dev *dev,
+	struct rte_flow *_flow,
+	const struct rte_flow_action actions[],
+	struct rte_flow_error *error)
+{
+	struct rte_dpaa2_device *dpaa2_dev;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_flow *flow;
+	struct dpaa2_flow_tbl_profile *tbl_profile = NULL;
+	int ret = 0, is_rss = false, hw_update = false, err_code = 0, qos_direct;
+	struct dpaa2_dev_flow_fs_action *fs_action;
+	uint8_t qos_action_num = 0, fs_action_num = 0, tc_id;
+	struct rte_flow_action qos_actions[DPAA2_MAX_ACTION_PER_FLOW_NUM];
+	struct rte_flow_action fs_actions[DPAA2_MAX_ACTION_PER_FLOW_NUM];
+	const struct rte_flow_action_rss *rss_conf;
+	struct rte_flow_action_jump jump_conf;
+	struct rte_flow_item items[DPKG_MAX_NUM_OF_EXTRACTS + 1];
+	uint8_t spec_buf[1024];
+	struct rte_flow_attr attr;
+	const enum rte_flow_action_type *supported = NULL;
+	uint16_t supported_len = 0;
+	enum rte_flow_error_type error_type = RTE_FLOW_ERROR_TYPE_NONE;
+	const char *err_str = NULL;
+	const struct rte_flow_action_queue *action_q;
+	struct dpaa2_queue *rxq = NULL;
+
+	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
+
+	/* check for the valid flow */
+	flow = (void *)_flow;
+	if (flow->is_meter_flow) {
+		RTE_ASSERT(flow->fs_flow);
+		tc_id = flow->fs_flow->tc_id;
+		RTE_ASSERT(priv->flow_profile.mtr_flow[tc_id] == flow);
+		supported = dpaa2_supported_meter_action_type;
+		supported_len = RTE_DIM(dpaa2_supported_meter_action_type);
+		if (!dpaa2_flow_check_actions_support(actions, supported, supported_len)) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_str = "Failed to verify meter action!";
+			err_code = -ENOTSUP;
+			goto quit;
+		}
+		ret = dpaa2_flow_fs_action_update(priv, flow->fs_flow, actions);
+		if (ret) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_str = "Failed to update meter action!";
+			err_code = ret;
+		}
+		goto quit;
+	}
+	LIST_FOREACH(flow, &priv->flows, next) {
+		if ((struct rte_flow *)flow == _flow)
+			goto action_update;
+	}
+	DPAA2_PMD_ERR("%s: Flow(%p) is not in %s's flow list",
+		__func__, flow, dev->data->name);
+	error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+	err_str = "Invalid flow for action update!";
+	err_code = -EINVAL;
+
+	goto quit;
+
+action_update:
+	if (flow->fs_flow) {
+		supported = dpaa2_supported_fs_action_type;
+		supported_len = RTE_DIM(dpaa2_supported_fs_action_type);
+	} else {
+		supported = dpaa2_supported_qos_action_type;
+		supported_len = RTE_DIM(dpaa2_supported_qos_action_type);
+	}
+	if (!dpaa2_flow_check_actions_support(actions, supported, supported_len)) {
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		err_str = "Failed to verify QoS/FS action!";
+		err_code = -ENOTSUP;
+		goto quit;
+	}
+	ret = dpaa2_flow_qos_fs_action_set(actions, qos_actions, fs_actions,
+		&qos_action_num, &fs_action_num);
+	if (ret) {
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		err_str = "Failed to set QoS/FS action!";
+		err_code = ret;
+		goto quit;
+	}
+	flow = (struct dpaa2_dev_flow *)_flow;
+	qos_direct = false;
+	if (flow->qos_flow && flow->qos_flow->direct_queue)
+		qos_direct = true;
+	if (flow->fs_flow && flow->qos_flow && qos_action_num > 0) {
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION_NUM;
+		err_str = "One-level flow can't update QoS action!";
+		err_code = -ENOTSUP;
+		goto quit;
+	}
+	if ((!flow->fs_flow && fs_action_num > 0 && !qos_direct) ||
+		(!flow->qos_flow && qos_action_num > 0)) {
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		err_str = "Flow type and flow action don't match!";
+		err_code = -EINVAL;
+		goto quit;
+	}
+	if (fs_action_num > 0 &&
+		dpaa2_flow_action_single_type_check(fs_actions,
+		RTE_FLOW_ACTION_TYPE_QUEUE)) {
+		action_q = fs_actions[0].conf;
+		if (action_q->index >= dev->data->nb_rx_queues) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_str = "Queue index is too large!";
+			err_code = -EINVAL;
+			goto quit;
+		}
+		rxq = dev->data->rx_queues[action_q->index];
+		if (flow->fs_flow && flow->fs_flow->tc_id != rxq->tc_index) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_str = "Update queue is not in this TC!";
+			err_code = -EINVAL;
+			goto quit;
+		}
+	}
+
+	if (!flow->fs_flow)
+		goto qos_action_update;
+	fs_action = &flow->fs_flow->flow_action.fs_action;
+	if (fs_action->action_type == RTE_FLOW_ACTION_TYPE_RSS) {
+		is_rss = true;
+		tc_id = flow->fs_flow->tc_id;
+		tbl_profile = &priv->flow_profile.tc_profile[tc_id];
+		if (tbl_profile->rss_flow != flow) {
+			DPAA2_PMD_ERR("%s: RSS flow(%p) != TC[%d]'s rss flow(%p)",
+				__func__, flow, flow->fs_flow->tc_id, tbl_profile->rss_flow);
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_str = "The flow to update is not specified TC's RSS flow!";
+			err_code = -EINVAL;
+			goto quit;
+		}
+	}
+	if (fs_action_num > 0 &&
+		fs_actions[0].type != RTE_FLOW_ACTION_TYPE_PORT_ID &&
+		fs_actions[0].type != RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT &&
+		dpaa2_dev->bus_info->mc_rev >= DPAA2_FS_FLOW_HW_ACTION_UPDATE_MC_REV) {
+		/** Action HW update doesn't support redirecting frames to other DPNIs.*/
+		hw_update = true;
+		goto skip_remove_fs_entry;
+	}
+
+	if (!is_rss) {
+		ret = dpaa2_flow_remove_generic_entry(dev, flow->fs_flow,
+			DPAA2_FLOW_FS_TYPE);
+		if (ret) {
+			DPAA2_PMD_ERR("%s: remove flow fs entry failed(%d)",
+				__func__, ret);
+			error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+			err_str = "Failed to remove flow in flow action update!";
+			err_code = ret;
+
+			goto quit;
+		}
+	}
+
+skip_remove_fs_entry:
+	if (is_rss) {
+		rss_conf = fs_actions[0].conf;
+		ret = dpaa2_flow_rss_conf_to_item(rss_conf->types, items,
+			spec_buf, 1024);
+		if (ret < 0) {
+			DPAA2_PMD_ERR("TC[%d] converts to RSS items failed(%d)",
+				flow->fs_flow->tc_id, ret);
+			error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+			err_str = "Failed to gen rss items in flow action update!";
+			err_code = ret;
+			goto quit;
+		} else if (!ret) {
+			DPAA2_PMD_ERR("No item is generated by rss type(0x%" PRIx64 ")",
+				rss_conf->types);
+			error_type = RTE_FLOW_ERROR_TYPE_ITEM;
+			err_str = "No item is generated by rss type!";
+			err_code = -ENOTSUP;
+			goto quit;
+		}
+		memset(&attr, 0, sizeof(attr));
+		attr.group = flow->fs_flow->tc_id;
+		attr.ingress = 1;
+		tbl_profile->tc_cfg.dist_size = rss_conf->queue_num;
+		memset(&flow->fs_flow->rule_cfg, 0, sizeof(struct dpni_rule_cfg));
+		memset(flow->fs_flow->key_addr, 0, DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE);
+		memset(flow->fs_flow->mask_addr, 0, DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE);
+		flow->fs_flow->rule_size = 0;
+		flow->fs_flow->ip_key = NET_PROT_NONE;
+		flow->fs_flow->ip_src = NET_PROT_NONE;
+		flow->fs_flow->ip_dst = NET_PROT_NONE;
+		ret = dpaa2_flow_generic_extract_rule_set(flow->fs_flow, &attr,
+				items, true, DPAA2_FLOW_FS_TYPE, true);
+		if (ret) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_str = "RSS action update failed!";
+			err_code = ret;
+			goto quit;
+		}
+	} else {
+		ret = dpaa2_flow_fs_action_update(priv, flow->fs_flow, fs_actions);
+		if (ret) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_str = "FS action update failed!";
+			err_code = ret;
+			goto quit;
+		}
+		if (hw_update)
+			ret = dpaa2_flow_update_fs_rule_action(priv, flow->fs_flow);
+		else
+			ret = dpaa2_flow_add_fs_rule(priv, flow->fs_flow);
+		if (ret) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_str = "FS rule action update failed!";
+			err_code = ret;
+			goto quit;
+		}
+	}
+qos_action_update:
+	if (!flow->qos_flow)
+		goto quit;
+
+	if (rxq) {
+		jump_conf.group = rxq->tc_index;
+		qos_actions[qos_action_num].type = RTE_FLOW_ACTION_TYPE_JUMP;
+		qos_actions[qos_action_num].conf = &jump_conf;
+		qos_actions[qos_action_num + 1].type = RTE_FLOW_ACTION_TYPE_END;
+	}
+
+	hw_update = false;
+	if (dpaa2_dev->bus_info->mc_rev >= DPAA2_QOS_FLOW_HW_ACTION_UPDATE_MC_REV) {
+		/** Action HW update doesn't support redirecting frames to other DPNIs.*/
+		hw_update = true;
+		goto skip_remove_qos_entry;
+	}
+
+	ret = dpaa2_flow_remove_generic_entry(dev, flow->qos_flow,
+		DPAA2_FLOW_QOS_TYPE);
+	if (ret) {
+		DPAA2_PMD_ERR("%s: remove flow qos entry failed(%d)",
+			__func__, ret);
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		err_str = "Failed to remove QoS entry in action update!";
+		err_code = ret;
+
+		goto quit;
+	}
+
+skip_remove_qos_entry:
+	ret = dpaa2_flow_qos_action_update(priv, flow->qos_flow, qos_actions,
+		false);
+	if (ret) {
+		DPAA2_PMD_ERR("%s: QoS action update failed(%d)",
+			__func__, ret);
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		err_str = "Failed to QoS action update!";
+		err_code = ret;
+
+		goto quit;
+	}
+	if (rxq) {
+		flow->qos_flow->direct_queue = true;
+		flow->qos_flow->flow_id = rxq->flow_id;
+	}
+	if (hw_update)
+		ret = dpaa2_flow_update_qos_rule_action(priv, flow->qos_flow);
+	else
+		ret = dpaa2_flow_add_qos_rule(priv, flow->qos_flow);
+	if (ret) {
+		DPAA2_PMD_ERR("%s: %s qos flow entry failed(%d)",
+			__func__, hw_update ? "update" : "add", ret);
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		err_str = "Failed to update QoS entry action to HW!";
+		err_code = ret;
+	}
+
+quit:
+	if (err_str)
+		DPAA2_PMD_ERR("%s: %s", __func__, err_str);
+	return rte_flow_error_set(error, -err_code, error_type, NULL, err_str);
 }
 
 /**
@@ -5390,24 +6431,113 @@ dpaa2_flow_flush(struct rte_eth_dev *dev,
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct dpaa2_dev_flow *flow = LIST_FIRST(&priv->flows);
+	int ret = 0;
 
 	while (flow) {
 		struct dpaa2_dev_flow *next = LIST_NEXT(flow, next);
 
-		dpaa2_flow_destroy(dev, (struct rte_flow *)flow, error);
+		ret = dpaa2_flow_destroy(dev, (struct rte_flow *)flow, error);
+		if (ret) {
+			DPAA2_PMD_ERR("%s: Remove flow failed(%d)",
+				__func__, ret);
+		}
+
 		flow = next;
 	}
-	return 0;
+
+	return ret;
 }
 
 static int
-dpaa2_flow_query(struct rte_eth_dev *dev __rte_unused,
-	struct rte_flow *_flow __rte_unused,
-	const struct rte_flow_action *actions __rte_unused,
-	void *data __rte_unused,
-	struct rte_flow_error *error __rte_unused)
+dpaa2_flow_query(struct rte_eth_dev *dev,
+	struct rte_flow *_flow, const struct rte_flow_action *actions,
+	void *data, struct rte_flow_error *error)
 {
-	return 0;
+	struct dpaa2_dev_flow *flow;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	uint16_t num = 0, num_rsp, i, tc_id = 0;
+	int ret = 0, found = false;
+	size_t size, iova;
+	struct dpni_dump_table_rsp *rsp = NULL;
+
+	RTE_SET_USED(actions);
+	RTE_SET_USED(data);
+	RTE_SET_USED(error);
+
+	flow = LIST_FIRST(&priv->flows);
+	while (flow) {
+		num++;
+		if (flow == (struct dpaa2_dev_flow *)_flow)
+			found = true;
+		flow = LIST_NEXT(flow, next);
+	}
+	if (!num || !found)
+		return -ENXIO;
+	num = num * 2;/** Max: FS entry + QoS entry.*/
+	flow = (void *)_flow;
+	size = sizeof(struct dpni_dump_table_header) +
+		num * sizeof(struct dpni_dump_table_entry);
+	rsp = rte_zmalloc(NULL, size, RTE_CACHE_LINE_SIZE);
+	if (!rsp)
+		return -ENOMEM;
+	iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(rsp, size);
+	if (iova == RTE_BAD_IOVA) {
+		DPAA2_PMD_ERR("%s: No IOMMU map for dump table result!",
+			__func__);
+		ret = -EIO;
+		goto quit;
+	}
+
+	if (priv->num_rx_tc <= 1)
+		goto dump_fs;
+
+	ret = dpni_dump_table(priv->hw, CMD_PRI_LOW,
+		priv->token, DPNI_QOS_TABLE, 0/**Any*/,
+		iova, size, &num_rsp);
+	if (ret) {
+		DPAA2_PMD_ERR("dump %s's QoS table failed(%d)",
+			dev->data->name, ret);
+		goto quit;
+	}
+
+	if (!flow->qos_flow)
+		goto dump_fs;
+
+	for (i = 0; i < num_rsp; i++) {
+		if (!memcmp(rsp->entry[i].key, flow->qos_flow->key_addr,
+			flow->qos_flow->rule_size) &&
+			!memcmp(rsp->entry[i].mask,
+			flow->qos_flow->mask_addr, flow->qos_flow->rule_size))
+			break;
+	}
+
+dump_fs:
+	if (!flow->fs_flow)
+		goto quit;
+
+	tc_id = flow->fs_flow->tc_id;
+	ret = dpni_dump_table(priv->hw, CMD_PRI_LOW,
+		priv->token, DPNI_FS_TABLE, tc_id,
+		iova, size, &num_rsp);
+	if (ret) {
+		DPAA2_PMD_ERR("dump %s's FS%d table failed(%d)",
+			dev->data->name, tc_id, ret);
+		goto quit;
+	}
+	for (i = 0; i < num_rsp; i++) {
+		if (!memcmp(rsp->entry[i].key, flow->fs_flow->key_addr,
+			flow->fs_flow->rule_size) &&
+			!memcmp(rsp->entry[i].mask,
+			flow->fs_flow->mask_addr, flow->fs_flow->rule_size)) {
+			break;
+		}
+	}
+
+quit:
+	if (rsp)
+		rte_free(rsp);
+
+	return ret;
 }
 
 /**
@@ -5420,19 +6550,45 @@ dpaa2_flow_query(struct rte_eth_dev *dev __rte_unused,
  *   Pointer to private structure.
  */
 void
-dpaa2_flow_clean(struct rte_eth_dev *dev)
+dpaa2_flow_clean(struct rte_eth_dev *dev, uint8_t tc_id)
 {
-	struct dpaa2_dev_flow *flow;
+	struct dpaa2_dev_flow *flow, *next_flow;
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	int ret;
 
-	while ((flow = LIST_FIRST(&priv->flows)))
-		dpaa2_flow_destroy(dev, (struct rte_flow *)flow, NULL);
+	flow = LIST_FIRST(&priv->flows);
+	if (tc_id >= MAX_TCS)
+		goto clean_all;
+	while (flow) {
+		next_flow = LIST_NEXT(flow, next);
+		if (flow->fs_flow && flow->fs_flow->tc_id == tc_id) {
+			ret = dpaa2_flow_destroy(dev, (struct rte_flow *)flow, NULL);
+			if (ret) {
+				DPAA2_PMD_ERR("%s: Remove flow failed(%d)",
+					__func__, ret);
+			}
+		}
+		flow = next_flow;
+	}
+	return;
+
+clean_all:
+	while (flow) {
+		ret = dpaa2_flow_destroy(dev, (struct rte_flow *)flow, NULL);
+		if (ret) {
+			DPAA2_PMD_ERR("%s: Remove flow failed(%d)",
+				__func__, ret);
+		}
+		flow = LIST_FIRST(&priv->flows);
+	}
 }
 
 const struct rte_flow_ops dpaa2_flow_ops = {
 	.create	= dpaa2_flow_create,
 	.validate = dpaa2_flow_validate,
 	.destroy = dpaa2_flow_destroy,
+	.group_set_miss_actions = dpaa2_flow_set_miss_actions,
+	.actions_update = dpaa2_flow_actions_update,
 	.flush	= dpaa2_flow_flush,
 	.query	= dpaa2_flow_query,
 };
diff --git a/drivers/net/dpaa2/meson.build b/drivers/net/dpaa2/meson.build
index 4f774f7c82..3f8bee9146 100644
--- a/drivers/net/dpaa2/meson.build
+++ b/drivers/net/dpaa2/meson.build
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: BSD-3-Clause
-# Copyright 2018-2021 NXP
+# Copyright 2018-2026 NXP
 
 if not is_linux
     build = false
@@ -8,7 +8,6 @@ endif
 
 deps += ['mempool_dpaa2']
 sources = files(
-        'base/dpaa2_hw_dpni.c',
         'base/dpaa2_tlu_hash.c',
         'dpaa2_tm.c',
         'dpaa2_meter.c',
-- 
2.43.0

