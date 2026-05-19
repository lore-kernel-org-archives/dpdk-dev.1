Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1A6CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 16:09:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1958B40679;
	Tue, 19 May 2026 18:08:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id EB8A84066E
 for <dev@dpdk.org>; Tue, 19 May 2026 18:08:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779206921; x=1810742921;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KQtfHGnDwcXXfRvW7NlgmOQvMGrbFJXSl07749lZz9Q=;
 b=gmn98tmpNJWe2DSEkw6Mwa77k8ZxGXu8rr6t5GVdZIixpLm3Jsq0m1UO
 6GFJu01q4ZgMbiWrcoim8lAwn2jTrzKiUuHR1hvkLD09rzbjrKWZOI8Qg
 5QL7poJP72WsFf+51ZYBchlM9KdHUuJ/L3mzS7KlAftKzu+4f06ySX/7m
 sAbFuZ7PuyAUmHvGxaLp0OQPu9D3coZK+UOfDJRs5oZxY60cddxfj9wxg
 MFlrqjll0gx8Auoc2NajNig7cBLIO8qXkgVq5gL+ujBbJ/QlFHOvokbpC
 jqPcsTsGRLg0MQ5FnaN/YdVr6fjLYdmLVuwGxARhY0jUkCJdfVtba2vD+ Q==;
X-CSE-ConnectionGUID: Qu1TYcyOQf2D9PhidkgaJw==
X-CSE-MsgGUID: 1Ni24NjNTe6nIBaW6RVxhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80070056"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80070056"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 09:08:40 -0700
X-CSE-ConnectionGUID: nLFojqQpRNWlo+PnRRIn+Q==
X-CSE-MsgGUID: h9ETLJG6TumgYelXl8gabw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="244784782"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.20.224.247])
 by orviesa005.jf.intel.com with ESMTP; 19 May 2026 09:08:39 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 4/8] net/ixgbe: replace use of DPDK-specific memcpy
 function
Date: Tue, 19 May 2026 16:06:01 +0000
Message-ID: <20260519160823.1004973-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519160823.1004973-1-bruce.richardson@intel.com>
References: <20260519160823.1004973-1-bruce.richardson@intel.com>
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

The driver use of memcpy is for control path work, for example, flow
configuration and so is fine using the standard libc memcpy function in
place of the DPDK-specific rte_memcpy version.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c  |  4 ++--
 drivers/net/intel/ixgbe/ixgbe_fdir.c    |  6 ++---
 drivers/net/intel/ixgbe/ixgbe_flow.c    | 32 ++++++++++++-------------
 drivers/net/intel/ixgbe/ixgbe_ipsec.c   |  4 ++--
 drivers/net/intel/ixgbe/ixgbe_pf.c      |  5 ++--
 drivers/net/intel/ixgbe/ixgbe_tm.c      |  6 ++---
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.c |  2 +-
 7 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 57d929cf2c..d4e3d643f8 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -6805,7 +6805,7 @@ ixgbe_add_del_ntuple_filter(struct rte_eth_dev *dev,
 				sizeof(struct ixgbe_5tuple_filter), 0);
 		if (filter == NULL)
 			return -ENOMEM;
-		rte_memcpy(&filter->filter_info,
+		memcpy(&filter->filter_info,
 				 &filter_5tuple,
 				 sizeof(struct ixgbe_5tuple_filter_info));
 		filter->queue = ntuple_filter->queue;
@@ -7867,7 +7867,7 @@ ixgbe_dev_l2_tunnel_filter_add(struct rte_eth_dev *dev,
 		if (!node)
 			return -ENOMEM;
 
-		rte_memcpy(&node->key,
+		memcpy(&node->key,
 				 &key,
 				 sizeof(struct ixgbe_l2_tn_key));
 		node->pool = l2_tunnel->pool;
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index 0bdfbd411a..003f8240bd 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -53,7 +53,7 @@
 #define IPV6_ADDR_TO_MASK(ipaddr, ipv6m) do { \
 	uint8_t ipv6_addr[16]; \
 	uint8_t i; \
-	rte_memcpy(ipv6_addr, (ipaddr), sizeof(ipv6_addr));\
+	memcpy(ipv6_addr, (ipaddr), sizeof(ipv6_addr));\
 	(ipv6m) = 0; \
 	for (i = 0; i < sizeof(ipv6_addr); i++) { \
 		if (ipv6_addr[i] == UINT8_MAX) \
@@ -73,7 +73,7 @@
 		else \
 			ipv6_addr[i] = 0; \
 	} \
-	rte_memcpy((ipaddr), ipv6_addr, sizeof(ipv6_addr));\
+	memcpy((ipaddr), ipv6_addr, sizeof(ipv6_addr));\
 } while (0)
 
 #define IXGBE_FDIRIP6M_INNER_MAC_SHIFT 4
@@ -1219,7 +1219,7 @@ ixgbe_fdir_filter_program(struct rte_eth_dev *dev,
 				   0);
 		if (!node)
 			return -ENOMEM;
-		rte_memcpy(&node->ixgbe_fdir,
+		memcpy(&node->ixgbe_fdir,
 				 &rule->ixgbe_fdir,
 				 sizeof(union ixgbe_atr_input));
 		node->fdirflags = fdircmd_flags;
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 01cd4f9bde..8671761bc5 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -2024,9 +2024,9 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 		if (item->spec) {
 			rule->b_spec = TRUE;
 			ipv6_spec = item->spec;
-			rte_memcpy(rule->ixgbe_fdir.formatted.src_ip,
+			memcpy(rule->ixgbe_fdir.formatted.src_ip,
 				   &ipv6_spec->hdr.src_addr, 16);
-			rte_memcpy(rule->ixgbe_fdir.formatted.dst_ip,
+			memcpy(rule->ixgbe_fdir.formatted.dst_ip,
 				   &ipv6_spec->hdr.dst_addr, 16);
 		}
 
@@ -2581,13 +2581,13 @@ ixgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 			return -rte_errno;
 		}
 
-		rte_memcpy(&rule->mask.tunnel_id_mask, vxlan_mask->hdr.vni,
+		memcpy(&rule->mask.tunnel_id_mask, vxlan_mask->hdr.vni,
 			RTE_DIM(vxlan_mask->hdr.vni));
 
 		if (item->spec) {
 			rule->b_spec = TRUE;
 			vxlan_spec = item->spec;
-			rte_memcpy(((uint8_t *)
+			memcpy(((uint8_t *)
 				&rule->ixgbe_fdir.formatted.tni_vni),
 				vxlan_spec->hdr.vni, RTE_DIM(vxlan_spec->hdr.vni));
 		}
@@ -2658,7 +2658,7 @@ ixgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 			return -rte_errno;
 		}
 		/* tni is a 24-bits bit field */
-		rte_memcpy(&rule->mask.tunnel_id_mask, nvgre_mask->tni,
+		memcpy(&rule->mask.tunnel_id_mask, nvgre_mask->tni,
 			RTE_DIM(nvgre_mask->tni));
 		rule->mask.tunnel_id_mask <<= 8;
 
@@ -2684,7 +2684,7 @@ ixgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 				return -rte_errno;
 			}
 			/* tni is a 24-bits bit field */
-			rte_memcpy(&rule->ixgbe_fdir.formatted.tni_vni,
+			memcpy(&rule->ixgbe_fdir.formatted.tni_vni,
 			nvgre_spec->tni, RTE_DIM(nvgre_spec->tni));
 		}
 	}
@@ -3155,7 +3155,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 				PMD_DRV_LOG(ERR, "failed to allocate memory");
 				goto out;
 			}
-			rte_memcpy(&ntuple_filter_ptr->filter_info,
+			memcpy(&ntuple_filter_ptr->filter_info,
 				&ntuple_filter,
 				sizeof(struct rte_eth_ntuple_filter));
 			TAILQ_INSERT_TAIL(&filter_ntuple_list,
@@ -3181,7 +3181,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 				PMD_DRV_LOG(ERR, "failed to allocate memory");
 				goto out;
 			}
-			rte_memcpy(&ethertype_filter_ptr->filter_info,
+			memcpy(&ethertype_filter_ptr->filter_info,
 				&ethertype_filter,
 				sizeof(struct rte_eth_ethertype_filter));
 			TAILQ_INSERT_TAIL(&filter_ethertype_list,
@@ -3205,7 +3205,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 				PMD_DRV_LOG(ERR, "failed to allocate memory");
 				goto out;
 			}
-			rte_memcpy(&syn_filter_ptr->filter_info,
+			memcpy(&syn_filter_ptr->filter_info,
 				&syn_filter,
 				sizeof(struct rte_eth_syn_filter));
 			TAILQ_INSERT_TAIL(&filter_syn_list,
@@ -3268,7 +3268,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 					PMD_DRV_LOG(ERR, "failed to allocate memory");
 					goto out;
 				}
-				rte_memcpy(&fdir_rule_ptr->filter_info,
+				memcpy(&fdir_rule_ptr->filter_info,
 					&fdir_rule,
 					sizeof(struct ixgbe_fdir_rule));
 				TAILQ_INSERT_TAIL(&filter_fdir_list,
@@ -3305,7 +3305,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 				PMD_DRV_LOG(ERR, "failed to allocate memory");
 				goto out;
 			}
-			rte_memcpy(&l2_tn_filter_ptr->filter_info,
+			memcpy(&l2_tn_filter_ptr->filter_info,
 				&l2_tn_filter,
 				sizeof(struct ixgbe_l2_tunnel_conf));
 			TAILQ_INSERT_TAIL(&filter_l2_tunnel_list,
@@ -3447,7 +3447,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	case RTE_ETH_FILTER_NTUPLE:
 		ntuple_filter_ptr = (struct ixgbe_ntuple_filter_ele *)
 					pmd_flow->rule;
-		rte_memcpy(&ntuple_filter,
+		memcpy(&ntuple_filter,
 			&ntuple_filter_ptr->filter_info,
 			sizeof(struct rte_eth_ntuple_filter));
 		ret = ixgbe_add_del_ntuple_filter(dev, &ntuple_filter, FALSE);
@@ -3460,7 +3460,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	case RTE_ETH_FILTER_ETHERTYPE:
 		ethertype_filter_ptr = (struct ixgbe_ethertype_filter_ele *)
 					pmd_flow->rule;
-		rte_memcpy(&ethertype_filter,
+		memcpy(&ethertype_filter,
 			&ethertype_filter_ptr->filter_info,
 			sizeof(struct rte_eth_ethertype_filter));
 		ret = ixgbe_add_del_ethertype_filter(dev,
@@ -3474,7 +3474,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	case RTE_ETH_FILTER_SYN:
 		syn_filter_ptr = (struct ixgbe_eth_syn_filter_ele *)
 				pmd_flow->rule;
-		rte_memcpy(&syn_filter,
+		memcpy(&syn_filter,
 			&syn_filter_ptr->filter_info,
 			sizeof(struct rte_eth_syn_filter));
 		ret = ixgbe_syn_filter_set(dev, &syn_filter, FALSE);
@@ -3486,7 +3486,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		break;
 	case RTE_ETH_FILTER_FDIR:
 		fdir_rule_ptr = (struct ixgbe_fdir_rule_ele *)pmd_flow->rule;
-		rte_memcpy(&fdir_rule,
+		memcpy(&fdir_rule,
 			&fdir_rule_ptr->filter_info,
 			sizeof(struct ixgbe_fdir_rule));
 		ret = ixgbe_fdir_filter_program(dev, &fdir_rule, TRUE, FALSE);
@@ -3501,7 +3501,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	case RTE_ETH_FILTER_L2_TUNNEL:
 		l2_tn_filter_ptr = (struct ixgbe_eth_l2_tunnel_conf_ele *)
 				pmd_flow->rule;
-		rte_memcpy(&l2_tn_filter, &l2_tn_filter_ptr->filter_info,
+		memcpy(&l2_tn_filter, &l2_tn_filter_ptr->filter_info,
 			sizeof(struct ixgbe_l2_tunnel_conf));
 		ret = ixgbe_dev_l2_tunnel_filter_del(dev, &l2_tn_filter);
 		if (!ret) {
diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
index fe9a96c54d..fd3d7a6689 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
@@ -674,9 +674,9 @@ ixgbe_crypto_add_ingress_sa_from_flow(struct rte_security_session *sess,
 			const struct rte_flow_item_ipv6 *ipv6 = &spec->spec.ipv6;
 			ic_session->src_ip.type = IPv6;
 			ic_session->dst_ip.type = IPv6;
-			rte_memcpy(ic_session->src_ip.ipv6,
+			memcpy(ic_session->src_ip.ipv6,
 				   &ipv6->hdr.src_addr, 16);
-			rte_memcpy(ic_session->dst_ip.ipv6,
+			memcpy(ic_session->dst_ip.ipv6,
 				   &ipv6->hdr.dst_addr, 16);
 		} else {
 			const struct rte_flow_item_ipv4 *ipv4 = &spec->spec.ipv4;
diff --git a/drivers/net/intel/ixgbe/ixgbe_pf.c b/drivers/net/intel/ixgbe/ixgbe_pf.c
index d9a775f99a..d3db571918 100644
--- a/drivers/net/intel/ixgbe/ixgbe_pf.c
+++ b/drivers/net/intel/ixgbe/ixgbe_pf.c
@@ -16,7 +16,6 @@
 #include <rte_eal.h>
 #include <rte_ether.h>
 #include <ethdev_driver.h>
-#include <rte_memcpy.h>
 #include <rte_malloc.h>
 #include <rte_random.h>
 
@@ -452,7 +451,7 @@ ixgbe_vf_reset(struct rte_eth_dev *dev, uint16_t vf, uint32_t *msgbuf)
 
 	/* reply to reset with success and vf mac address */
 	msgbuf[0] = IXGBE_VF_RESET | IXGBE_VT_MSGTYPE_SUCCESS;
-	rte_memcpy(new_mac, vf_mac, RTE_ETHER_ADDR_LEN);
+	memcpy(new_mac, vf_mac, RTE_ETHER_ADDR_LEN);
 	/*
 	 * Piggyback the multicast filter type so VF can compute the
 	 * correct vectors
@@ -474,7 +473,7 @@ ixgbe_vf_set_mac_addr(struct rte_eth_dev *dev, uint32_t vf, uint32_t *msgbuf)
 
 	if (rte_is_valid_assigned_ether_addr(
 			(struct rte_ether_addr *)new_mac)) {
-		rte_memcpy(vfinfo[vf].vf_mac_addresses, new_mac, 6);
+		memcpy(vfinfo[vf].vf_mac_addresses, new_mac, 6);
 		return hw->mac.ops.set_rar(hw, rar_entry, new_mac, vf, IXGBE_RAH_AV);
 	}
 	return -1;
diff --git a/drivers/net/intel/ixgbe/ixgbe_tm.c b/drivers/net/intel/ixgbe/ixgbe_tm.c
index 27a821285d..e1d8364f46 100644
--- a/drivers/net/intel/ixgbe/ixgbe_tm.c
+++ b/drivers/net/intel/ixgbe/ixgbe_tm.c
@@ -289,7 +289,7 @@ ixgbe_shaper_profile_add(struct rte_eth_dev *dev,
 	if (!shaper_profile)
 		return -ENOMEM;
 	shaper_profile->shaper_profile_id = shaper_profile_id;
-	rte_memcpy(&shaper_profile->profile, profile,
+	memcpy(&shaper_profile->profile, profile,
 			 sizeof(struct rte_tm_shaper_params));
 	TAILQ_INSERT_TAIL(&tm_conf->shaper_profile_list,
 			  shaper_profile, node);
@@ -637,7 +637,7 @@ ixgbe_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 		tm_node->no = 0;
 		tm_node->parent = NULL;
 		tm_node->shaper_profile = shaper_profile;
-		rte_memcpy(&tm_node->params, params,
+		memcpy(&tm_node->params, params,
 				 sizeof(struct rte_tm_node_params));
 		tm_conf->root = tm_node;
 
@@ -718,7 +718,7 @@ ixgbe_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 	tm_node->reference_count = 0;
 	tm_node->parent = parent_node;
 	tm_node->shaper_profile = shaper_profile;
-	rte_memcpy(&tm_node->params, params,
+	memcpy(&tm_node->params, params,
 			 sizeof(struct rte_tm_node_params));
 	if (parent_node_type == IXGBE_TM_NODE_TYPE_PORT) {
 		tm_node->no = parent_node->reference_count;
diff --git a/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c b/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
index c2300a8955..30dec57be8 100644
--- a/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
+++ b/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
@@ -39,7 +39,7 @@ rte_pmd_ixgbe_set_vf_mac_addr(uint16_t port, uint16_t vf,
 
 	if (rte_is_valid_assigned_ether_addr(
 			(struct rte_ether_addr *)new_mac)) {
-		rte_memcpy(vfinfo[vf].vf_mac_addresses, new_mac,
+		memcpy(vfinfo[vf].vf_mac_addresses, new_mac,
 			   RTE_ETHER_ADDR_LEN);
 		return hw->mac.ops.set_rar(hw, rar_entry, new_mac, vf,
 					   IXGBE_RAH_AV);
-- 
2.51.0

