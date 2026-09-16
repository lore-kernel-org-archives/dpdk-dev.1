Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08961C88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 12:20:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ABF042F55;
	Wed, 16 Sep 2026 14:19:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 6187942EB2
 for <dev@dpdk.org>; Wed, 16 Sep 2026 14:18:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789561139; x=1821097139;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=7VaJf8eETmq37kbLsPygJrIjtnBSNKYxFrtWWbhqhdw=;
 b=AXBRJKN18yoZTgYO5nhWuXBWwE82DLW1G0qfJ53f2wThLKPvdC+5VNTZ
 0m9trnlGOgis1QZi90uoOUXiF3WNekUMyYik1cOh0V7KafzbuwE68QWbo
 5TjeWmmzjKu52WrKjdX/sIMq3/bqv6+kOz+whuRXAppoYjgGzPB8AwFXK
 spk7Vw5Ip3Tio1Yvb9Bi+DckpxEmR6cFCILzFSqukvZbxS9jmr6LqKcdB
 KpIHRHVwqf1S1xIt4d5AQzH+JcYhq+q4bmx4WbXX7/xa1hCKyOHa/BpWt
 yyaYrzrfuMO/r9/YThKWoVdpaDeOtrp0I8PSzBrIbmfU/MDkV8B0XDz67 A==;
X-CSE-ConnectionGUID: mCrx+N3GQG6CyY9FSa/+kA==
X-CSE-MsgGUID: 3WDG070ISciwzDFzyOq2Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112702971"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112702971"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 05:18:58 -0700
X-CSE-ConnectionGUID: Q6fSgy5PT0G2FVtDmRAhhg==
X-CSE-MsgGUID: OojNisYRR1eq/tvVXbP7Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="272850304"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 16 Sep 2026 05:18:57 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 17/19] net/i40e: reimplement tunnel parsers
Date: Wed, 16 Sep 2026 13:18:23 +0100
Message-ID: <9049334630046d6bfc240a79bdfa68ab1085de6d.1789560946.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1789560943.git.anatoly.burakov@intel.com>
 <cover.1789560943.git.anatoly.burakov@intel.com>
References: 
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

Use the new flow graph API and the common parsing framework to implement
flow parser for tunnel filters: QinQ, VXLAN, NVGRE, MPLS, GTP, and L4.

As a result of transitioning to more formalized validation, some
checks have become more stringent:

- VLAN TCI mask is now required to be fully masked (all-ones); previously
  the mask was only checked for eth_proto and any non-zero vlan_tci mask
  value was silently accepted

In addition to using the new graph infrastructure, some of the checks were
made more stringent and/or more correct. In particular:

- old code did not check for whether fields other than ports are masked
  (they are now rejected)
- old code did not check for whether src/ports are fully masked (masks
  other than full are now rejected)
- old code used spec to decide which port to copy (as a result, it was not
  possible to match port 0 - this is now allowed)

Tunnel engine now also share a refcounted global state, and track all
flows and do deduplication inside the engine.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c      |  554 +++----
 drivers/net/intel/i40e/i40e_ethdev.h      |   53 +-
 drivers/net/intel/i40e/i40e_flow.c        | 1702 +--------------------
 drivers/net/intel/i40e/i40e_flow.h        |    6 +
 drivers/net/intel/i40e/i40e_flow_tunnel.c | 1590 +++++++++++++++++++
 drivers/net/intel/i40e/meson.build        |    1 +
 6 files changed, 1834 insertions(+), 2072 deletions(-)
 create mode 100644 drivers/net/intel/i40e/i40e_flow_tunnel.c

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 39182aabc39..fb03eaba7dc 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -392,14 +392,8 @@ static int i40e_set_default_mac_addr(struct rte_eth_dev *dev,
 
 static int i40e_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu);
 
-static int i40e_tunnel_filter_convert(
-	struct i40e_aqc_cloud_filters_element_bb *cld_filter,
-	struct i40e_tunnel_filter *tunnel_filter);
-static int i40e_sw_tunnel_filter_insert(struct i40e_pf *pf,
-				struct i40e_tunnel_filter *tunnel_filter);
 static int i40e_cloud_filter_qinq_create(struct i40e_pf *pf);
 
-static void i40e_tunnel_filter_restore(struct i40e_pf *pf);
 static void i40e_filter_restore(struct i40e_pf *pf);
 static void i40e_notify_all_vfs_link_status(struct rte_eth_dev *dev);
 static int i40e_fec_get_capability(struct rte_eth_dev *dev,
@@ -996,49 +990,43 @@ config_floating_veb(struct rte_eth_dev *dev)
 #define I40E_L2_TAGS_S_TAG_SHIFT 1
 #define I40E_L2_TAGS_S_TAG_MASK I40E_MASK(0x1, I40E_L2_TAGS_S_TAG_SHIFT)
 
-static int
-i40e_init_tunnel_filter_list(struct rte_eth_dev *dev)
+struct i40e_tunnel_state *
+i40e_tunnel_state_attach(struct rte_eth_dev_data *dev_data)
 {
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	struct i40e_tunnel_rule *tunnel_rule = &pf->tunnel;
-	char tunnel_hash_name[RTE_HASH_NAMESIZE];
-	int ret;
-
-	struct rte_hash_parameters tunnel_hash_params = {
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev_data->dev_private);
+	struct i40e_tunnel_state *state = &pf->tunnel_state;
+	char tunnel_hash_name[RTE_HASH_NAMESIZE] = {0};
+	struct rte_hash_parameters hash_params = {
 		.name = tunnel_hash_name,
 		.entries = I40E_MAX_TUNNEL_FILTER_NUM,
-		.key_len = sizeof(struct i40e_tunnel_filter_input),
+		.key_len = sizeof(struct i40e_tunnel_filter_match_key),
 		.hash_func = rte_hash_crc,
 		.hash_func_init_val = 0,
 		.socket_id = rte_socket_id(),
 	};
 
-	/* Initialize tunnel filter rule list and hash */
-	TAILQ_INIT(&tunnel_rule->tunnel_list);
-	snprintf(tunnel_hash_name, RTE_HASH_NAMESIZE,
-		 "tunnel_%s", dev->device->name);
-	tunnel_rule->hash_table = rte_hash_create(&tunnel_hash_params);
-	if (!tunnel_rule->hash_table) {
-		PMD_INIT_LOG(ERR, "Failed to create tunnel hash table!");
-		return -EINVAL;
-	}
-	tunnel_rule->hash_map = rte_zmalloc("i40e_tunnel_hash_map",
-				    sizeof(struct i40e_tunnel_filter *) *
-				    I40E_MAX_TUNNEL_FILTER_NUM,
-				    0);
-	if (!tunnel_rule->hash_map) {
-		PMD_INIT_LOG(ERR,
-			     "Failed to allocate memory for tunnel hash map!");
-		ret = -ENOMEM;
-		goto err_tunnel_hash_map_alloc;
+	snprintf(tunnel_hash_name, RTE_HASH_NAMESIZE, "i40e_tunnel_hash_%s", dev_data->name);
+
+	if (ci_refcount_acquire(&state->ref)) {
+		state->hash_table = rte_hash_create(&hash_params);
+		if (state->hash_table == NULL) {
+			PMD_DRV_LOG(ERR, "Failed to create tunnel hash table");
+			ci_refcount_release(&state->ref);
+			return NULL;
+		}
 	}
 
-	return 0;
+	return state;
+}
 
-err_tunnel_hash_map_alloc:
-	rte_hash_free(tunnel_rule->hash_table);
+void
+i40e_tunnel_state_detach(struct i40e_tunnel_state *state)
+{
+	if (!ci_refcount_release(&state->ref))
+		return;
 
-	return ret;
+	rte_hash_free(state->hash_table);
+	*state = (struct i40e_tunnel_state){0};
 }
 
 static void
@@ -1656,9 +1644,6 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
 	/* Initialize the filter invalidation configuration */
 	i40e_init_filter_invalidation(pf);
 
-	ret = i40e_init_tunnel_filter_list(dev);
-	if (ret < 0)
-		goto err_init_tunnel_filter_list;
 	i40e_fdir_flow_store_init(dev);
 
 	/* initialize flow engine configuration */
@@ -1676,9 +1661,6 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
 	return 0;
 
 err_flow_engine_conf_init:
-	rte_hash_free(pf->tunnel.hash_table);
-	rte_free(pf->tunnel.hash_map);
-err_init_tunnel_filter_list:
 	rte_intr_callback_unregister(intr_handle,
 		i40e_dev_interrupt_handler, dev);
 	rte_free(dev->data->mac_addrs);
@@ -1701,23 +1683,6 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
 	return ret;
 }
 
-static void
-i40e_rm_tunnel_filter_list(struct i40e_pf *pf)
-{
-	struct i40e_tunnel_filter *p_tunnel;
-	struct i40e_tunnel_rule *tunnel_rule;
-
-	tunnel_rule = &pf->tunnel;
-	/* Remove all tunnel director rules and hash */
-	rte_free(tunnel_rule->hash_map);
-	rte_hash_free(tunnel_rule->hash_table);
-
-	while ((p_tunnel = TAILQ_FIRST(&tunnel_rule->tunnel_list))) {
-		TAILQ_REMOVE(&tunnel_rule->tunnel_list, p_tunnel, rules);
-		rte_free(p_tunnel);
-	}
-}
-
 static void
 i40e_fdir_memory_cleanup(struct i40e_pf *pf)
 {
@@ -2578,8 +2543,6 @@ i40e_dev_close(struct rte_eth_dev *dev)
 		i40e_msec_delay(500);
 	} while (retries++ < 5);
 
-	i40e_rm_tunnel_filter_list(pf);
-
 	/* Remove all flows */
 	while ((p_flow = TAILQ_FIRST(&pf->flow_list))) {
 		TAILQ_REMOVE(&pf->flow_list, p_flow, node);
@@ -7747,96 +7710,6 @@ i40e_dev_get_filter_type(uint16_t filter_type, uint16_t *flag)
 	return 0;
 }
 
-/* Convert tunnel filter structure */
-static int
-i40e_tunnel_filter_convert(
-	struct i40e_aqc_cloud_filters_element_bb *cld_filter,
-	struct i40e_tunnel_filter *tunnel_filter)
-{
-	rte_ether_addr_copy((struct rte_ether_addr *)
-			&cld_filter->element.outer_mac,
-		(struct rte_ether_addr *)&tunnel_filter->input.outer_mac);
-	rte_ether_addr_copy((struct rte_ether_addr *)
-			&cld_filter->element.inner_mac,
-		(struct rte_ether_addr *)&tunnel_filter->input.inner_mac);
-	tunnel_filter->input.inner_vlan = cld_filter->element.inner_vlan;
-	if ((rte_le_to_cpu_16(cld_filter->element.flags) &
-	     I40E_AQC_ADD_CLOUD_FLAGS_IPV6) ==
-	    I40E_AQC_ADD_CLOUD_FLAGS_IPV6)
-		tunnel_filter->input.ip_type = I40E_TUNNEL_IPTYPE_IPV6;
-	else
-		tunnel_filter->input.ip_type = I40E_TUNNEL_IPTYPE_IPV4;
-	tunnel_filter->input.flags = cld_filter->element.flags;
-	tunnel_filter->input.tenant_id = cld_filter->element.tenant_id;
-	tunnel_filter->queue = cld_filter->element.queue_number;
-	memcpy(tunnel_filter->input.general_fields,
-		   cld_filter->general_fields,
-		   sizeof(cld_filter->general_fields));
-
-	return 0;
-}
-
-/* Check if there exists the tunnel filter */
-struct i40e_tunnel_filter *
-i40e_sw_tunnel_filter_lookup(struct i40e_tunnel_rule *tunnel_rule,
-			     const struct i40e_tunnel_filter_input *input)
-{
-	int ret;
-
-	ret = rte_hash_lookup(tunnel_rule->hash_table, (const void *)input);
-	if (ret < 0)
-		return NULL;
-
-	return tunnel_rule->hash_map[ret];
-}
-
-/* Add a tunnel filter into the SW list */
-static int
-i40e_sw_tunnel_filter_insert(struct i40e_pf *pf,
-			     struct i40e_tunnel_filter *tunnel_filter)
-{
-	struct i40e_tunnel_rule *rule = &pf->tunnel;
-	int ret;
-
-	ret = rte_hash_add_key(rule->hash_table, &tunnel_filter->input);
-	if (ret < 0) {
-		PMD_DRV_LOG(ERR,
-			    "Failed to insert tunnel filter to hash table %d!",
-			    ret);
-		return ret;
-	}
-	rule->hash_map[ret] = tunnel_filter;
-
-	TAILQ_INSERT_TAIL(&rule->tunnel_list, tunnel_filter, rules);
-
-	return 0;
-}
-
-/* Delete a tunnel filter from the SW list */
-int
-i40e_sw_tunnel_filter_del(struct i40e_pf *pf,
-			  struct i40e_tunnel_filter_input *input)
-{
-	struct i40e_tunnel_rule *rule = &pf->tunnel;
-	struct i40e_tunnel_filter *tunnel_filter;
-	int ret;
-
-	ret = rte_hash_del_key(rule->hash_table, input);
-	if (ret < 0) {
-		PMD_DRV_LOG(ERR,
-			    "Failed to delete tunnel filter to hash table %d!",
-			    ret);
-		return ret;
-	}
-	tunnel_filter = rule->hash_map[ret];
-	rule->hash_map[ret] = NULL;
-
-	TAILQ_REMOVE(&rule->tunnel_list, tunnel_filter, rules);
-	rte_free(tunnel_filter);
-
-	return 0;
-}
-
 #define I40E_AQC_REPLACE_CLOUD_CMD_INPUT_TR_WORD0 0x48
 #define I40E_TR_VXLAN_GRE_KEY_MASK		0x4
 #define I40E_TR_GENEVE_KEY_MASK			0x8
@@ -8275,41 +8148,35 @@ i40e_replace_port_cloud_filter(struct i40e_pf *pf,
 	return status;
 }
 
-int
-i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
-		      struct i40e_tunnel_filter_conf *tunnel_filter,
-		      uint8_t add)
+static int
+i40e_tunnel_filter_convert_conf(struct i40e_pf *pf,
+		struct i40e_tunnel_filter_conf *tunnel_filter,
+		struct i40e_aqc_cloud_filters_element_bb *cld_filter,
+		struct i40e_vsi **vsi, bool *big_buffer)
 {
 	uint16_t ip_type;
 	uint32_t ipv4_addr, ipv4_addr_le;
 	uint8_t i, tun_type = 0;
 	/* internal variable to convert ipv6 byte order */
 	uint32_t convert_ipv6[4];
-	int val, ret = 0;
+	int val;
 	struct i40e_pf_vf *vf = NULL;
-	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
-	struct i40e_vsi *vsi;
-	struct i40e_aqc_cloud_filters_element_bb cld_filter = {0};
-	struct i40e_tunnel_rule *tunnel_rule = &pf->tunnel;
-	struct i40e_tunnel_filter *node;
-	struct i40e_tunnel_filter check_filter; /* Check if filter exists */
 	uint32_t teid_le;
-	bool big_buffer = 0;
 
 	rte_ether_addr_copy(&tunnel_filter->outer_mac,
-			(struct rte_ether_addr *)&cld_filter.element.outer_mac);
+			(struct rte_ether_addr *)&cld_filter->element.outer_mac);
 	rte_ether_addr_copy(&tunnel_filter->inner_mac,
-			(struct rte_ether_addr *)&cld_filter.element.inner_mac);
+			(struct rte_ether_addr *)&cld_filter->element.inner_mac);
 
-	cld_filter.element.inner_vlan =
+	cld_filter->element.inner_vlan =
 		rte_cpu_to_le_16(tunnel_filter->inner_vlan);
 	if (tunnel_filter->ip_type == I40E_TUNNEL_IPTYPE_IPV4) {
 		ip_type = I40E_AQC_ADD_CLOUD_FLAGS_IPV4;
 		ipv4_addr = rte_be_to_cpu_32(tunnel_filter->ip_addr.ipv4_addr);
 		ipv4_addr_le = rte_cpu_to_le_32(ipv4_addr);
-		memcpy(&cld_filter.element.ipaddr.v4.data,
+		memcpy(&cld_filter->element.ipaddr.v4.data,
 				&ipv4_addr_le,
-				sizeof(cld_filter.element.ipaddr.v4.data));
+				sizeof(cld_filter->element.ipaddr.v4.data));
 	} else {
 		ip_type = I40E_AQC_ADD_CLOUD_FLAGS_IPV6;
 		for (i = 0; i < 4; i++) {
@@ -8317,9 +8184,9 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 			rte_cpu_to_le_32(rte_be_to_cpu_32(
 					 tunnel_filter->ip_addr.ipv6_addr[i]));
 		}
-		memcpy(&cld_filter.element.ipaddr.v6.data,
+		memcpy(&cld_filter->element.ipaddr.v6.data,
 			   &convert_ipv6,
-			   sizeof(cld_filter.element.ipaddr.v6.data));
+			   sizeof(cld_filter->element.ipaddr.v6.data));
 	}
 
 	/* check tunneled type */
@@ -8334,139 +8201,96 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 		tun_type = I40E_AQC_ADD_CLOUD_TNL_TYPE_IP;
 		break;
 	case I40E_TUNNEL_TYPE_MPLSoUDP:
-		if (!pf->mpls_replace_flag) {
-			i40e_replace_mpls_l1_filter(pf);
-			i40e_replace_mpls_cloud_filter(pf);
-			pf->mpls_replace_flag = 1;
-		}
 		teid_le = rte_cpu_to_le_32(tunnel_filter->tenant_id);
-		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD0] =
+		cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD0] =
 			teid_le >> 4;
-		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
+		cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
 			(teid_le & 0xF) << 12;
-		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD2] =
+		cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD2] =
 			0x40;
-		big_buffer = 1;
+		*big_buffer = 1;
 		tun_type = I40E_AQC_ADD_CLOUD_TNL_TYPE_MPLSOUDP;
 		break;
 	case I40E_TUNNEL_TYPE_MPLSoGRE:
-		if (!pf->mpls_replace_flag) {
-			i40e_replace_mpls_l1_filter(pf);
-			i40e_replace_mpls_cloud_filter(pf);
-			pf->mpls_replace_flag = 1;
-		}
 		teid_le = rte_cpu_to_le_32(tunnel_filter->tenant_id);
-		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD0] =
+		cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD0] =
 			teid_le >> 4;
-		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
+		cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
 			(teid_le & 0xF) << 12;
-		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD2] =
+		cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD2] =
 			0x0;
-		big_buffer = 1;
+		*big_buffer = 1;
 		tun_type = I40E_AQC_ADD_CLOUD_TNL_TYPE_MPLSOGRE;
 		break;
 	case I40E_TUNNEL_TYPE_GTPC:
-		if (!pf->gtp_replace_flag) {
-			i40e_replace_gtp_l1_filter(pf);
-			i40e_replace_gtp_cloud_filter(pf);
-			pf->gtp_replace_flag = 1;
-		}
 		teid_le = rte_cpu_to_le_32(tunnel_filter->tenant_id);
-		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X12_WORD0] =
+		cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X12_WORD0] =
 			(teid_le >> 16) & 0xFFFF;
-		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X12_WORD1] =
+		cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X12_WORD1] =
 			teid_le & 0xFFFF;
-		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X12_WORD2] =
+		cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X12_WORD2] =
 			0x0;
-		big_buffer = 1;
+		*big_buffer = 1;
 		break;
 	case I40E_TUNNEL_TYPE_GTPU:
-		if (!pf->gtp_replace_flag) {
-			i40e_replace_gtp_l1_filter(pf);
-			i40e_replace_gtp_cloud_filter(pf);
-			pf->gtp_replace_flag = 1;
-		}
 		teid_le = rte_cpu_to_le_32(tunnel_filter->tenant_id);
-		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X13_WORD0] =
+		cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X13_WORD0] =
 			(teid_le >> 16) & 0xFFFF;
-		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X13_WORD1] =
+		cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X13_WORD1] =
 			teid_le & 0xFFFF;
-		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X13_WORD2] =
+		cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X13_WORD2] =
 			0x0;
-		big_buffer = 1;
+		*big_buffer = 1;
 		break;
 	case I40E_TUNNEL_TYPE_QINQ:
-		if (!pf->qinq_replace_flag) {
-			ret = i40e_cloud_filter_qinq_create(pf);
-			if (ret < 0) {
-				PMD_DRV_LOG(ERR, "Failed to create QinQ tunnel filter.");
-				/* ret is a raw i40e_status_code, not an errno */
-				return -ENOTSUP;
-			}
-			pf->qinq_replace_flag = 1;
-		}
 		/*	Add in the General fields the values of
 		 *	the Outer and Inner VLAN
 		 *	Big Buffer should be set, see changes in
 		 *	i40e_aq_add_cloud_filters
 		 */
-		cld_filter.general_fields[0] = tunnel_filter->inner_vlan;
-		cld_filter.general_fields[1] = tunnel_filter->outer_vlan;
-		big_buffer = 1;
+		cld_filter->general_fields[0] = tunnel_filter->inner_vlan;
+		cld_filter->general_fields[1] = tunnel_filter->outer_vlan;
+		*big_buffer = 1;
 		break;
 	case I40E_CLOUD_TYPE_UDP:
 	case I40E_CLOUD_TYPE_TCP:
 	case I40E_CLOUD_TYPE_SCTP:
 		if (tunnel_filter->l4_port_type == I40E_L4_PORT_TYPE_SRC) {
-			if (!pf->sport_replace_flag) {
-				i40e_replace_port_l1_filter(pf,
-						tunnel_filter->l4_port_type);
-				i40e_replace_port_cloud_filter(pf,
-						tunnel_filter->l4_port_type);
-				pf->sport_replace_flag = 1;
-			}
 			teid_le = rte_cpu_to_le_32(tunnel_filter->tenant_id);
-			cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD0] =
+			cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD0] =
 				I40E_DIRECTION_INGRESS_KEY;
 
 			if (tunnel_filter->tunnel_type == I40E_CLOUD_TYPE_UDP)
-				cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
+				cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
 					I40E_TR_L4_TYPE_UDP;
 			else if (tunnel_filter->tunnel_type == I40E_CLOUD_TYPE_TCP)
-				cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
+				cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
 					I40E_TR_L4_TYPE_TCP;
 			else
-				cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
+				cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
 					I40E_TR_L4_TYPE_SCTP;
 
-			cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD2] =
+			cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD2] =
 				(teid_le >> 16) & 0xFFFF;
-			big_buffer = 1;
+			*big_buffer = 1;
 		} else {
-			if (!pf->dport_replace_flag) {
-				i40e_replace_port_l1_filter(pf,
-						tunnel_filter->l4_port_type);
-				i40e_replace_port_cloud_filter(pf,
-						tunnel_filter->l4_port_type);
-				pf->dport_replace_flag = 1;
-			}
 			teid_le = rte_cpu_to_le_32(tunnel_filter->tenant_id);
-			cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD0] =
+			cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD0] =
 				I40E_DIRECTION_INGRESS_KEY;
 
 			if (tunnel_filter->tunnel_type == I40E_CLOUD_TYPE_UDP)
-				cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD1] =
+				cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD1] =
 					I40E_TR_L4_TYPE_UDP;
 			else if (tunnel_filter->tunnel_type == I40E_CLOUD_TYPE_TCP)
-				cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD1] =
+				cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD1] =
 					I40E_TR_L4_TYPE_TCP;
 			else
-				cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD1] =
+				cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD1] =
 					I40E_TR_L4_TYPE_SCTP;
 
-			cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD2] =
+			cld_filter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD2] =
 				(teid_le >> 16) & 0xFFFF;
-			big_buffer = 1;
+			*big_buffer = 1;
 		}
 
 		break;
@@ -8477,74 +8301,193 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 	}
 
 	if (tunnel_filter->tunnel_type == I40E_TUNNEL_TYPE_MPLSoUDP)
-		cld_filter.element.flags =
+		cld_filter->element.flags =
 			I40E_AQC_ADD_CLOUD_FILTER_0X11;
 	else if (tunnel_filter->tunnel_type == I40E_TUNNEL_TYPE_MPLSoGRE)
-		cld_filter.element.flags =
+		cld_filter->element.flags =
 			I40E_AQC_ADD_CLOUD_FILTER_0X12;
 	else if (tunnel_filter->tunnel_type == I40E_TUNNEL_TYPE_GTPC)
-		cld_filter.element.flags =
+		cld_filter->element.flags =
 			I40E_AQC_ADD_CLOUD_FILTER_0X11;
 	else if (tunnel_filter->tunnel_type == I40E_TUNNEL_TYPE_GTPU)
-		cld_filter.element.flags =
+		cld_filter->element.flags =
 			I40E_AQC_ADD_CLOUD_FILTER_0X12;
 	else if (tunnel_filter->tunnel_type == I40E_TUNNEL_TYPE_QINQ)
-		cld_filter.element.flags |=
+		cld_filter->element.flags |=
 			I40E_AQC_ADD_CLOUD_FILTER_0X10;
 	else if (tunnel_filter->tunnel_type == I40E_CLOUD_TYPE_UDP ||
 		 tunnel_filter->tunnel_type == I40E_CLOUD_TYPE_TCP ||
 		 tunnel_filter->tunnel_type == I40E_CLOUD_TYPE_SCTP) {
 		if (tunnel_filter->l4_port_type == I40E_L4_PORT_TYPE_SRC)
-			cld_filter.element.flags |=
+			cld_filter->element.flags |=
 				I40E_AQC_ADD_CLOUD_FILTER_0X11;
 		else
-			cld_filter.element.flags |=
+			cld_filter->element.flags |=
 				I40E_AQC_ADD_CLOUD_FILTER_0X10;
 	} else {
 		val = i40e_dev_get_filter_type(tunnel_filter->filter_type,
-						&cld_filter.element.flags);
+						&cld_filter->element.flags);
 		if (val < 0) {
 			return -EINVAL;
 		}
 	}
 
-	cld_filter.element.flags |=
+	cld_filter->element.flags |=
 			rte_cpu_to_le_16(I40E_AQC_ADD_CLOUD_FLAGS_TO_QUEUE | ip_type |
 				(tun_type << I40E_AQC_ADD_CLOUD_TNL_TYPE_SHIFT));
-	cld_filter.element.tenant_id = rte_cpu_to_le_32(tunnel_filter->tenant_id);
-	cld_filter.element.queue_number =
+	cld_filter->element.tenant_id = rte_cpu_to_le_32(tunnel_filter->tenant_id);
+	cld_filter->element.queue_number =
 		rte_cpu_to_le_16(tunnel_filter->queue_id);
 
 	if (!tunnel_filter->is_to_vf)
-		vsi = pf->main_vsi;
+		*vsi = pf->main_vsi;
 	else {
 		if (tunnel_filter->vf_id >= pf->vf_num) {
 			PMD_DRV_LOG(ERR, "Invalid argument.");
 			return -EINVAL;
 		}
 		vf = &pf->vfs[tunnel_filter->vf_id];
-		vsi = vf->vsi;
+		*vsi = vf->vsi;
 	}
 
-	/* Check if there is the filter in SW list */
-	memset(&check_filter, 0, sizeof(check_filter));
-	i40e_tunnel_filter_convert(&cld_filter, &check_filter);
-	check_filter.is_to_vf = tunnel_filter->is_to_vf;
-	check_filter.vf_id = tunnel_filter->vf_id;
-	node = i40e_sw_tunnel_filter_lookup(tunnel_rule, &check_filter.input);
-	if (add && node) {
-		PMD_DRV_LOG(ERR, "Conflict with existing tunnel rules!");
-		return -EINVAL;
-	}
+	return 0;
+}
+
+static int
+i40e_tunnel_filter_prepare_hw(struct i40e_pf *pf,
+		struct i40e_tunnel_filter_conf *tunnel_filter)
+{
+	int ret;
 
-	if (!add && !node) {
-		PMD_DRV_LOG(ERR, "There's no corresponding tunnel filter!");
-		return -EINVAL;
+	switch (tunnel_filter->tunnel_type) {
+	case I40E_TUNNEL_TYPE_MPLSoUDP:
+	case I40E_TUNNEL_TYPE_MPLSoGRE:
+		if (!pf->mpls_replace_flag) {
+			ret = i40e_replace_mpls_l1_filter(pf);
+			if (ret < 0)
+				return ret;
+			ret = i40e_replace_mpls_cloud_filter(pf);
+			if (ret < 0)
+				return ret;
+			pf->mpls_replace_flag = 1;
+		}
+		break;
+	case I40E_TUNNEL_TYPE_GTPC:
+	case I40E_TUNNEL_TYPE_GTPU:
+		if (!pf->gtp_replace_flag) {
+			ret = i40e_replace_gtp_l1_filter(pf);
+			if (ret < 0)
+				return ret;
+			ret = i40e_replace_gtp_cloud_filter(pf);
+			if (ret < 0)
+				return ret;
+			pf->gtp_replace_flag = 1;
+		}
+		break;
+	case I40E_TUNNEL_TYPE_QINQ:
+		if (!pf->qinq_replace_flag) {
+			ret = i40e_cloud_filter_qinq_create(pf);
+			if (ret < 0) {
+				PMD_DRV_LOG(ERR, "Failed to create QinQ tunnel filter.");
+				/* ret is a raw i40e_status_code, not an errno */
+				return -ENOTSUP;
+			}
+			pf->qinq_replace_flag = 1;
+		}
+		break;
+	case I40E_CLOUD_TYPE_UDP:
+	case I40E_CLOUD_TYPE_TCP:
+	case I40E_CLOUD_TYPE_SCTP:
+		if (tunnel_filter->l4_port_type == I40E_L4_PORT_TYPE_SRC) {
+			if (!pf->sport_replace_flag) {
+				ret = i40e_replace_port_l1_filter(pf,
+						tunnel_filter->l4_port_type);
+				if (ret < 0)
+					return ret;
+				ret = i40e_replace_port_cloud_filter(pf,
+						tunnel_filter->l4_port_type);
+				if (ret < 0)
+					return ret;
+				pf->sport_replace_flag = 1;
+			}
+		} else if (!pf->dport_replace_flag) {
+			ret = i40e_replace_port_l1_filter(pf,
+					tunnel_filter->l4_port_type);
+			if (ret < 0)
+				return ret;
+			ret = i40e_replace_port_cloud_filter(pf,
+					tunnel_filter->l4_port_type);
+			if (ret < 0)
+				return ret;
+			pf->dport_replace_flag = 1;
+		}
+		break;
+	default:
+		break;
 	}
 
+	return 0;
+}
+
+int
+i40e_tunnel_filter_match_key_get(struct i40e_pf *pf,
+		struct i40e_tunnel_filter_conf *tunnel_filter,
+		struct i40e_tunnel_filter_match_key *input)
+{
+	struct i40e_aqc_cloud_filters_element_bb cld_filter = {0};
+	struct i40e_vsi *vsi;
+	bool big_buffer = 0;
+	int ret;
+
+	ret = i40e_tunnel_filter_convert_conf(pf, tunnel_filter, &cld_filter,
+			&vsi, &big_buffer);
+	if (ret != 0)
+		return ret;
+
+	rte_ether_addr_copy((struct rte_ether_addr *)
+			&cld_filter.element.outer_mac,
+		(struct rte_ether_addr *)&input->outer_mac);
+	rte_ether_addr_copy((struct rte_ether_addr *)
+			&cld_filter.element.inner_mac,
+		(struct rte_ether_addr *)&input->inner_mac);
+	input->inner_vlan = cld_filter.element.inner_vlan;
+	if ((rte_le_to_cpu_16(cld_filter.element.flags) &
+	     I40E_AQC_ADD_CLOUD_FLAGS_IPV6) ==
+	    I40E_AQC_ADD_CLOUD_FLAGS_IPV6)
+		input->ip_type = I40E_TUNNEL_IPTYPE_IPV6;
+	else
+		input->ip_type = I40E_TUNNEL_IPTYPE_IPV4;
+	input->flags = cld_filter.element.flags;
+	input->tenant_id = cld_filter.element.tenant_id;
+	memcpy(input->general_fields, cld_filter.general_fields,
+			sizeof(cld_filter.general_fields));
+
+	return 0;
+}
+
+int
+i40e_tunnel_filter_program(struct i40e_pf *pf,
+		struct i40e_tunnel_filter_conf *tunnel_filter,
+		uint8_t add)
+{
+	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
+	struct i40e_aqc_cloud_filters_element_bb cld_filter = {0};
+	struct i40e_vsi *vsi;
+	bool big_buffer = 0;
+	int ret;
+
+	ret = i40e_tunnel_filter_convert_conf(pf, tunnel_filter, &cld_filter,
+			&vsi, &big_buffer);
+	if (ret != 0)
+		return ret;
+
 	if (add) {
-		struct i40e_tunnel_filter *tunnel;
+		ret = i40e_tunnel_filter_prepare_hw(pf, tunnel_filter);
+		if (ret < 0)
+			return ret;
+	}
 
+	if (add) {
 		if (big_buffer)
 			ret = i40e_aq_add_cloud_filters_bb(hw,
 						   vsi->seid, &cld_filter, 1);
@@ -8555,16 +8498,6 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 			PMD_DRV_LOG(ERR, "Failed to add a tunnel filter.");
 			return -ENOTSUP;
 		}
-		tunnel = rte_zmalloc("tunnel_filter", sizeof(*tunnel), 0);
-		if (tunnel == NULL) {
-			PMD_DRV_LOG(ERR, "Failed to alloc memory.");
-			return -ENOMEM;
-		}
-
-		memcpy(tunnel, &check_filter, sizeof(check_filter));
-		ret = i40e_sw_tunnel_filter_insert(pf, tunnel);
-		if (ret < 0)
-			rte_free(tunnel);
 	} else {
 		if (big_buffer)
 			ret = i40e_aq_rem_cloud_filters_bb(
@@ -8576,7 +8509,6 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 			PMD_DRV_LOG(ERR, "Failed to delete a tunnel filter.");
 			return -ENOTSUP;
 		}
-		ret = i40e_sw_tunnel_filter_del(pf, &node->input);
 	}
 
 	return ret;
@@ -11284,65 +11216,9 @@ i40e_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu __rte_unused)
 	return 0;
 }
 
-/* Restore tunnel filter */
-static void
-i40e_tunnel_filter_restore(struct i40e_pf *pf)
-{
-	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
-	struct i40e_vsi *vsi;
-	struct i40e_pf_vf *vf;
-	struct i40e_tunnel_filter_list
-		*tunnel_list = &pf->tunnel.tunnel_list;
-	struct i40e_tunnel_filter *f;
-	struct i40e_aqc_cloud_filters_element_bb cld_filter;
-	bool big_buffer = 0;
-
-	TAILQ_FOREACH(f, tunnel_list, rules) {
-		if (!f->is_to_vf)
-			vsi = pf->main_vsi;
-		else {
-			vf = &pf->vfs[f->vf_id];
-			vsi = vf->vsi;
-		}
-		memset(&cld_filter, 0, sizeof(cld_filter));
-		rte_ether_addr_copy((struct rte_ether_addr *)
-				&f->input.outer_mac,
-			(struct rte_ether_addr *)&cld_filter.element.outer_mac);
-		rte_ether_addr_copy((struct rte_ether_addr *)
-				&f->input.inner_mac,
-			(struct rte_ether_addr *)&cld_filter.element.inner_mac);
-		cld_filter.element.inner_vlan = f->input.inner_vlan;
-		cld_filter.element.flags = f->input.flags;
-		cld_filter.element.tenant_id = f->input.tenant_id;
-		cld_filter.element.queue_number = f->queue;
-		memcpy(cld_filter.general_fields,
-			   f->input.general_fields,
-			   sizeof(f->input.general_fields));
-
-		if (((f->input.flags &
-		     I40E_AQC_ADD_CLOUD_FILTER_0X11) ==
-		     I40E_AQC_ADD_CLOUD_FILTER_0X11) ||
-		    ((f->input.flags &
-		     I40E_AQC_ADD_CLOUD_FILTER_0X12) ==
-		     I40E_AQC_ADD_CLOUD_FILTER_0X12) ||
-		    ((f->input.flags &
-		     I40E_AQC_ADD_CLOUD_FILTER_0X10) ==
-		     I40E_AQC_ADD_CLOUD_FILTER_0X10))
-			big_buffer = 1;
-
-		if (big_buffer)
-			i40e_aq_add_cloud_filters_bb(hw,
-					vsi->seid, &cld_filter, 1);
-		else
-			i40e_aq_add_cloud_filters(hw, vsi->seid,
-						  &cld_filter.element, 1);
-	}
-}
-
 static void
 i40e_filter_restore(struct i40e_pf *pf)
 {
-	i40e_tunnel_filter_restore(pf);
 	i40e_fdir_filter_restore(pf);
 	(void)i40e_hash_filter_restore(pf);
 }
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 7a326fa75bd..1a15916e925 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -22,6 +22,7 @@
 #include "base/virtchnl.h"
 
 #include "../common/flow_engine.h"
+#include "../common/flow_util.h"
 
 #define I40E_AQ_LEN               32
 #define I40E_AQ_BUF_SZ            4096
@@ -877,8 +878,8 @@ enum i40e_tunnel_iptype {
 	I40E_TUNNEL_IPTYPE_IPV6,
 };
 
-/* Tunnel filter struct */
-struct i40e_tunnel_filter_input {
+/* Tunnel filter hash table match key */
+struct i40e_tunnel_filter_match_key {
 	uint8_t outer_mac[6];    /* Outer mac address to match */
 	uint8_t inner_mac[6];    /* Inner mac address to match */
 	uint16_t inner_vlan;     /* Inner vlan address to match */
@@ -888,19 +889,8 @@ struct i40e_tunnel_filter_input {
 	uint16_t general_fields[32];  /* Big buffer */
 };
 
-struct i40e_tunnel_filter {
-	TAILQ_ENTRY(i40e_tunnel_filter) rules;
-	struct i40e_tunnel_filter_input input;
-	uint8_t is_to_vf; /* 0 - to PF, 1 - to VF */
-	uint16_t vf_id;   /* VF id, available when is_to_vf is 1. */
-	uint16_t queue; /* Queue assigned to when match */
-};
-
-TAILQ_HEAD(i40e_tunnel_filter_list, i40e_tunnel_filter);
-
-struct i40e_tunnel_rule {
-	struct i40e_tunnel_filter_list tunnel_list;
-	struct i40e_tunnel_filter  **hash_map;
+struct i40e_tunnel_state {
+	struct ci_refcount ref;
 	struct rte_hash *hash_table;
 };
 
@@ -1170,7 +1160,7 @@ struct i40e_pf {
 	struct i40e_vmdq_info *vmdq;
 
 	struct i40e_fdir_info fdir; /* flow director info */
-	struct i40e_tunnel_rule tunnel; /* Tunnel filter rule */
+	struct i40e_tunnel_state tunnel_state; /* tunnel flow engine state */
 	struct i40e_rss_conf_list rss_config_list; /* RSS rule list */
 	struct i40e_queue_regions queue_region; /* queue region info */
 	struct i40e_fc_conf fc_conf; /* Flow control conf */
@@ -1317,23 +1307,10 @@ struct i40e_vf_representor {
 extern const struct rte_flow_ops i40e_flow_ops;
 
 struct i40e_filter_ctx {
-	union {
-		struct i40e_tunnel_filter_conf consistent_tunnel_filter;
-		struct i40e_rte_flow_rss_conf rss_conf;
-	};
+	struct i40e_rte_flow_rss_conf rss_conf;
 	enum rte_filter_type type;
 };
 
-typedef int (*parse_filter_t)(struct rte_eth_dev *dev,
-			      const struct rte_flow_item pattern[],
-			      const struct rte_flow_action actions[],
-			      struct rte_flow_error *error,
-			      struct i40e_filter_ctx *filter);
-struct i40e_valid_pattern {
-	enum rte_flow_item_type *items;
-	parse_filter_t parse_filter;
-};
-
 int i40e_dev_switch_queues(struct i40e_pf *pf, bool on);
 int i40e_vsi_release(struct i40e_vsi *vsi);
 struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf,
@@ -1399,11 +1376,6 @@ int i40e_rx_burst_mode_get(struct rte_eth_dev *dev, uint16_t queue_id,
 			   struct rte_eth_burst_mode *mode);
 int i40e_tx_burst_mode_get(struct rte_eth_dev *dev, uint16_t queue_id,
 			   struct rte_eth_burst_mode *mode);
-struct i40e_tunnel_filter *
-i40e_sw_tunnel_filter_lookup(struct i40e_tunnel_rule *tunnel_rule,
-			     const struct i40e_tunnel_filter_input *input);
-int i40e_sw_tunnel_filter_del(struct i40e_pf *pf,
-			      struct i40e_tunnel_filter_input *input);
 uint64_t i40e_get_default_input_set(uint16_t pctype);
 int i40e_ethertype_filter_program(struct i40e_pf *pf,
 			      struct rte_eth_ethertype_filter *filter,
@@ -1433,9 +1405,14 @@ void i40e_fdir_flex_store(struct i40e_pf *pf,
 int i40e_dev_tunnel_filter_set(struct i40e_pf *pf,
 			       struct rte_eth_tunnel_filter_conf *tunnel_filter,
 			       uint8_t add);
-int i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
-				  struct i40e_tunnel_filter_conf *tunnel_filter,
-				  uint8_t add);
+int i40e_tunnel_filter_match_key_get(struct i40e_pf *pf,
+				 struct i40e_tunnel_filter_conf *tunnel_filter,
+				 struct i40e_tunnel_filter_match_key *out);
+struct i40e_tunnel_state *i40e_tunnel_state_attach(struct rte_eth_dev_data *dev_data);
+void i40e_tunnel_state_detach(struct i40e_tunnel_state *state);
+int i40e_tunnel_filter_program(struct i40e_pf *pf,
+			       struct i40e_tunnel_filter_conf *tunnel_filter,
+			       uint8_t add);
 int i40e_fdir_flush(struct i40e_pf *pf);
 int i40e_find_all_vlan_for_mac(struct i40e_vsi *vsi,
 			       struct i40e_macvlan_filter *mv_f,
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 104749eb8cc..0de0c825214 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -34,6 +34,12 @@ const struct ci_flow_engine_list i40e_flow_engine_list = {
 	{
 		&i40e_flow_engine_ethertype,
 		&i40e_flow_engine_fdir,
+		&i40e_flow_engine_tunnel_qinq,
+		&i40e_flow_engine_tunnel_vxlan,
+		&i40e_flow_engine_tunnel_nvgre,
+		&i40e_flow_engine_tunnel_mpls,
+		&i40e_flow_engine_tunnel_gtp,
+		&i40e_flow_engine_tunnel_l4,
 	}
 };
 
@@ -60,50 +66,7 @@ static int i40e_flow_dev_dump(struct rte_eth_dev *dev,
 			      struct rte_flow *flow,
 			      FILE *file,
 			      struct rte_flow_error *error);
-static int i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
-				 const struct rte_flow_action *actions,
-				 struct rte_flow_error *error,
-				 struct i40e_tunnel_filter_conf *filter);
-static int i40e_flow_parse_vxlan_filter(struct rte_eth_dev *dev,
-					const struct rte_flow_item pattern[],
-					const struct rte_flow_action actions[],
-					struct rte_flow_error *error,
-					struct i40e_filter_ctx *filter);
-static int i40e_flow_parse_nvgre_filter(struct rte_eth_dev *dev,
-					const struct rte_flow_item pattern[],
-					const struct rte_flow_action actions[],
-					struct rte_flow_error *error,
-					struct i40e_filter_ctx *filter);
-static int i40e_flow_parse_mpls_filter(struct rte_eth_dev *dev,
-				       const struct rte_flow_item pattern[],
-				       const struct rte_flow_action actions[],
-				       struct rte_flow_error *error,
-				       struct i40e_filter_ctx *filter);
-static int i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
-				      const struct rte_flow_item pattern[],
-				      const struct rte_flow_action actions[],
-				      struct rte_flow_error *error,
-				      struct i40e_filter_ctx *filter);
-static int i40e_flow_destroy_tunnel_filter(struct i40e_pf *pf,
-					   struct i40e_tunnel_filter *filter);
-static int i40e_flow_flush_tunnel_filter(struct i40e_pf *pf);
-static int
-i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
-			      const struct rte_flow_item pattern[],
-			      const struct rte_flow_action actions[],
-			      struct rte_flow_error *error,
-			      struct i40e_filter_ctx *filter);
-static int
-i40e_flow_parse_qinq_pattern(struct rte_eth_dev *dev,
-			      const struct rte_flow_item *pattern,
-			      struct rte_flow_error *error,
-			      struct i40e_tunnel_filter_conf *filter);
 
-static int i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
-					   const struct rte_flow_item pattern[],
-					   const struct rte_flow_action actions[],
-					   struct rte_flow_error *error,
-					   struct i40e_filter_ctx *filter);
 const struct rte_flow_ops i40e_flow_ops = {
 	.validate = i40e_flow_validate,
 	.create = i40e_flow_create,
@@ -113,322 +76,12 @@ const struct rte_flow_ops i40e_flow_ops = {
 	.dev_dump = i40e_flow_dev_dump,
 };
 
-static enum rte_flow_item_type pattern_fdir_ipv4_udp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_tcp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_sctp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_SCTP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_gtpc[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_GTPC,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_gtpu[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_GTPU,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_udp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_tcp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_sctp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_SCTP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_gtpc[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_GTPC,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_gtpu[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_GTPU,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Pattern matched tunnel filter */
-static enum rte_flow_item_type pattern_vxlan_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_vxlan_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_vxlan_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_vxlan_4[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_nvgre_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_NVGRE,
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_nvgre_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_NVGRE,
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_nvgre_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_NVGRE,
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_nvgre_4[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_NVGRE,
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_mpls_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_MPLS,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_mpls_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_MPLS,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_mpls_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_GRE,
-	RTE_FLOW_ITEM_TYPE_MPLS,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_mpls_4[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_GRE,
-	RTE_FLOW_ITEM_TYPE_MPLS,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_qinq_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static struct i40e_valid_pattern i40e_supported_patterns[] = {
-	/* VXLAN */
-	{ pattern_vxlan_1, i40e_flow_parse_vxlan_filter },
-	{ pattern_vxlan_2, i40e_flow_parse_vxlan_filter },
-	{ pattern_vxlan_3, i40e_flow_parse_vxlan_filter },
-	{ pattern_vxlan_4, i40e_flow_parse_vxlan_filter },
-	/* NVGRE */
-	{ pattern_nvgre_1, i40e_flow_parse_nvgre_filter },
-	{ pattern_nvgre_2, i40e_flow_parse_nvgre_filter },
-	{ pattern_nvgre_3, i40e_flow_parse_nvgre_filter },
-	{ pattern_nvgre_4, i40e_flow_parse_nvgre_filter },
-	/* MPLSoUDP & MPLSoGRE */
-	{ pattern_mpls_1, i40e_flow_parse_mpls_filter },
-	{ pattern_mpls_2, i40e_flow_parse_mpls_filter },
-	{ pattern_mpls_3, i40e_flow_parse_mpls_filter },
-	{ pattern_mpls_4, i40e_flow_parse_mpls_filter },
-	/* GTP-C & GTP-U */
-	{ pattern_fdir_ipv4_gtpc, i40e_flow_parse_gtp_filter },
-	{ pattern_fdir_ipv4_gtpu, i40e_flow_parse_gtp_filter },
-	{ pattern_fdir_ipv6_gtpc, i40e_flow_parse_gtp_filter },
-	{ pattern_fdir_ipv6_gtpu, i40e_flow_parse_gtp_filter },
-	/* QINQ */
-	{ pattern_qinq_1, i40e_flow_parse_qinq_filter },
-	/* L4 over port */
-	{ pattern_fdir_ipv4_udp, i40e_flow_parse_l4_cloud_filter },
-	{ pattern_fdir_ipv4_tcp, i40e_flow_parse_l4_cloud_filter },
-	{ pattern_fdir_ipv4_sctp, i40e_flow_parse_l4_cloud_filter },
-	{ pattern_fdir_ipv6_udp, i40e_flow_parse_l4_cloud_filter },
-	{ pattern_fdir_ipv6_tcp, i40e_flow_parse_l4_cloud_filter },
-	{ pattern_fdir_ipv6_sctp, i40e_flow_parse_l4_cloud_filter },
-};
-
-/* Find the first VOID or non-VOID item pointer */
-static const struct rte_flow_item *
-i40e_find_first_item(const struct rte_flow_item *item, bool is_void)
-{
-	bool is_find;
-
-	while (item->type != RTE_FLOW_ITEM_TYPE_END) {
-		if (is_void)
-			is_find = item->type == RTE_FLOW_ITEM_TYPE_VOID;
-		else
-			is_find = item->type != RTE_FLOW_ITEM_TYPE_VOID;
-		if (is_find)
-			break;
-		item++;
-	}
-	return item;
-}
-
-/* Skip all VOID items of the pattern */
-static void
-i40e_pattern_skip_void_item(struct rte_flow_item *items,
-			    const struct rte_flow_item *pattern)
-{
-	uint32_t cpy_count = 0;
-	const struct rte_flow_item *pb = pattern, *pe = pattern;
-
-	for (;;) {
-		/* Find a non-void item first */
-		pb = i40e_find_first_item(pb, false);
-		if (pb->type == RTE_FLOW_ITEM_TYPE_END) {
-			pe = pb;
-			break;
-		}
-
-		/* Find a void item */
-		pe = i40e_find_first_item(pb + 1, true);
-
-		cpy_count = pe - pb;
-		memcpy(items, pb, sizeof(struct rte_flow_item) * cpy_count);
-
-		items += cpy_count;
-
-		if (pe->type == RTE_FLOW_ITEM_TYPE_END) {
-			pb = pe;
-			break;
-		}
-
-		pb = pe + 1;
-	}
-	/* Copy the END item. */
-	memcpy(items, pe, sizeof(struct rte_flow_item));
-}
-
-/* Check if the pattern matches a supported item type array */
-static bool
-i40e_match_pattern(enum rte_flow_item_type *item_array,
-		   struct rte_flow_item *pattern)
-{
-	struct rte_flow_item *item = pattern;
-
-	while ((*item_array == item->type) &&
-	       (*item_array != RTE_FLOW_ITEM_TYPE_END)) {
-		item_array++;
-		item++;
-	}
-
-	return (*item_array == RTE_FLOW_ITEM_TYPE_END &&
-		item->type == RTE_FLOW_ITEM_TYPE_END);
-}
-
-/* Find if there's parse filter function matched */
-static parse_filter_t
-i40e_find_parse_filter_func(struct rte_flow_item *pattern, uint32_t *idx)
-{
-	parse_filter_t parse_filter = NULL;
-	uint8_t i = *idx;
-
-	for (; i < RTE_DIM(i40e_supported_patterns); i++) {
-		if (i40e_match_pattern(i40e_supported_patterns[i].items,
-					pattern)) {
-			parse_filter = i40e_supported_patterns[i].parse_filter;
-			break;
-		}
-	}
-
-	*idx = ++i;
-
-	return parse_filter;
-}
-
 #define I40E_FLOW_DUMP_CHUNK_BYTES 32
 
 static const char *
 i40e_flow_rule_name(enum rte_filter_type filter_type)
 {
 	switch (filter_type) {
-	case RTE_ETH_FILTER_TUNNEL:
-		return "tunnel";
 	case RTE_ETH_FILTER_HASH:
 		return "hash";
 	default:
@@ -440,8 +93,6 @@ static size_t
 i40e_flow_rule_size(enum rte_filter_type filter_type)
 {
 	switch (filter_type) {
-	case RTE_ETH_FILTER_TUNNEL:
-		return sizeof(struct i40e_tunnel_filter);
 	case RTE_ETH_FILTER_HASH:
 		return sizeof(struct i40e_rss_filter);
 	default:
@@ -631,1190 +282,6 @@ i40e_flow_fdir_get_pctype_value(struct i40e_pf *pf,
 	return I40E_FILTER_PCTYPE_INVALID;
 }
 
-/* Parse to get the action info of a tunnel filter
- * Tunnel action only supports PF, VF and QUEUE.
- */
-static int
-i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
-			      const struct rte_flow_action *actions,
-			      struct rte_flow_error *error,
-			      struct i40e_tunnel_filter_conf *filter)
-{
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	const struct rte_flow_action_queue *act_q;
-	struct ci_flow_actions parsed_actions = {0};
-	struct ci_flow_actions_check_param ac_param = {
-		.allowed_types = (enum rte_flow_action_type[]) {
-			RTE_FLOW_ACTION_TYPE_QUEUE,
-			RTE_FLOW_ACTION_TYPE_PF,
-			RTE_FLOW_ACTION_TYPE_VF,
-			RTE_FLOW_ACTION_TYPE_END
-		},
-		.max_actions = 2,
-	};
-	const struct rte_flow_action *first, *second;
-	int ret;
-
-	ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
-	if (ret)
-		return ret;
-	first = parsed_actions.actions[0];
-	/* can be NULL */
-	second = parsed_actions.actions[1];
-
-	/* first action must be PF or VF */
-	if (first->type == RTE_FLOW_ACTION_TYPE_VF) {
-		const struct rte_flow_action_vf *vf = first->conf;
-		if (vf->id >= pf->vf_num) {
-			rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ACTION, first,
-					"Invalid VF ID for tunnel filter");
-			return -rte_errno;
-		}
-		filter->vf_id = vf->id;
-		filter->is_to_vf = 1;
-	} else if (first->type != RTE_FLOW_ACTION_TYPE_PF) {
-		return rte_flow_error_set(error, EINVAL,
-					  RTE_FLOW_ERROR_TYPE_ACTION, first,
-					  "Unsupported action");
-	}
-
-	/* check if second action is QUEUE */
-	if (second == NULL)
-		return 0;
-
-	act_q = second->conf;
-	/* check queue ID for PF flow */
-	if (!filter->is_to_vf && act_q->index >= pf->dev_data->nb_rx_queues) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF, act_q,
-				"Invalid queue ID for tunnel filter");
-	}
-	/* check queue ID for VF flow */
-	if (filter->is_to_vf && act_q->index >= pf->vf_nb_qps) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF, act_q,
-				"Invalid queue ID for tunnel filter");
-	}
-	filter->queue_id = act_q->index;
-
-	return 0;
-}
-
-/* 1. Last in item should be NULL as range is not supported.
- * 2. Supported filter types: Source port only and Destination port only.
- * 3. Mask of fields which need to be matched should be
- *    filled with 1.
- * 4. Mask of fields which needn't to be matched should be
- *    filled with 0.
- */
-static int
-i40e_flow_parse_l4_pattern(const struct rte_flow_item *pattern,
-			   struct rte_flow_error *error,
-			   struct i40e_tunnel_filter_conf *filter)
-{
-	const struct rte_flow_item_sctp *sctp_spec, *sctp_mask;
-	const struct rte_flow_item_tcp *tcp_spec, *tcp_mask;
-	const struct rte_flow_item_udp *udp_spec, *udp_mask;
-	const struct rte_flow_item *item = pattern;
-	enum rte_flow_item_type item_type;
-
-	for (; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Not support range");
-			return -rte_errno;
-		}
-		item_type = item->type;
-		switch (item_type) {
-		case RTE_FLOW_ITEM_TYPE_ETH:
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid ETH item");
-				return -rte_errno;
-			}
-
-			break;
-		case RTE_FLOW_ITEM_TYPE_IPV4:
-			filter->ip_type = I40E_TUNNEL_IPTYPE_IPV4;
-			/* IPv4 is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid IPv4 item");
-				return -rte_errno;
-			}
-
-			break;
-		case RTE_FLOW_ITEM_TYPE_IPV6:
-			filter->ip_type = I40E_TUNNEL_IPTYPE_IPV6;
-			/* IPv6 is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid IPv6 item");
-				return -rte_errno;
-			}
-
-			break;
-		case RTE_FLOW_ITEM_TYPE_UDP:
-			udp_spec = item->spec;
-			udp_mask = item->mask;
-
-			if (!udp_spec || !udp_mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid udp item");
-				return -rte_errno;
-			}
-
-			if (udp_spec->hdr.src_port != 0 &&
-			    udp_spec->hdr.dst_port != 0) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid udp spec");
-				return -rte_errno;
-			}
-
-			if (udp_spec->hdr.src_port != 0) {
-				filter->l4_port_type =
-					I40E_L4_PORT_TYPE_SRC;
-				filter->tenant_id =
-				rte_be_to_cpu_32(udp_spec->hdr.src_port);
-			}
-
-			if (udp_spec->hdr.dst_port != 0) {
-				filter->l4_port_type =
-					I40E_L4_PORT_TYPE_DST;
-				filter->tenant_id =
-				rte_be_to_cpu_32(udp_spec->hdr.dst_port);
-			}
-
-			filter->tunnel_type = I40E_CLOUD_TYPE_UDP;
-
-			break;
-		case RTE_FLOW_ITEM_TYPE_TCP:
-			tcp_spec = item->spec;
-			tcp_mask = item->mask;
-
-			if (!tcp_spec || !tcp_mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid tcp item");
-				return -rte_errno;
-			}
-
-			if (tcp_spec->hdr.src_port != 0 &&
-			    tcp_spec->hdr.dst_port != 0) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid tcp spec");
-				return -rte_errno;
-			}
-
-			if (tcp_spec->hdr.src_port != 0) {
-				filter->l4_port_type =
-					I40E_L4_PORT_TYPE_SRC;
-				filter->tenant_id =
-				rte_be_to_cpu_32(tcp_spec->hdr.src_port);
-			}
-
-			if (tcp_spec->hdr.dst_port != 0) {
-				filter->l4_port_type =
-					I40E_L4_PORT_TYPE_DST;
-				filter->tenant_id =
-				rte_be_to_cpu_32(tcp_spec->hdr.dst_port);
-			}
-
-			filter->tunnel_type = I40E_CLOUD_TYPE_TCP;
-
-			break;
-		case RTE_FLOW_ITEM_TYPE_SCTP:
-			sctp_spec = item->spec;
-			sctp_mask = item->mask;
-
-			if (!sctp_spec || !sctp_mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid sctp item");
-				return -rte_errno;
-			}
-
-			if (sctp_spec->hdr.src_port != 0 &&
-			    sctp_spec->hdr.dst_port != 0) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid sctp spec");
-				return -rte_errno;
-			}
-
-			if (sctp_spec->hdr.src_port != 0) {
-				filter->l4_port_type =
-					I40E_L4_PORT_TYPE_SRC;
-				filter->tenant_id =
-					rte_be_to_cpu_32(sctp_spec->hdr.src_port);
-			}
-
-			if (sctp_spec->hdr.dst_port != 0) {
-				filter->l4_port_type =
-					I40E_L4_PORT_TYPE_DST;
-				filter->tenant_id =
-					rte_be_to_cpu_32(sctp_spec->hdr.dst_port);
-			}
-
-			filter->tunnel_type = I40E_CLOUD_TYPE_SCTP;
-
-			break;
-		default:
-			break;
-		}
-	}
-
-	return 0;
-}
-
-static int
-i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
-				const struct rte_flow_item pattern[],
-				const struct rte_flow_action actions[],
-				struct rte_flow_error *error,
-				struct i40e_filter_ctx *filter)
-{
-	struct i40e_tunnel_filter_conf *tunnel_filter = &filter->consistent_tunnel_filter;
-	int ret;
-
-	ret = i40e_flow_parse_l4_pattern(pattern, error, tunnel_filter);
-	if (ret)
-		return ret;
-
-	ret = i40e_flow_parse_tunnel_action(dev, actions, error, tunnel_filter);
-	if (ret)
-		return ret;
-
-	filter->type = RTE_ETH_FILTER_TUNNEL;
-
-	return ret;
-}
-
-static uint16_t i40e_supported_tunnel_filter_types[] = {
-	RTE_ETH_TUNNEL_FILTER_IMAC | RTE_ETH_TUNNEL_FILTER_TENID |
-	RTE_ETH_TUNNEL_FILTER_IVLAN,
-	RTE_ETH_TUNNEL_FILTER_IMAC | RTE_ETH_TUNNEL_FILTER_IVLAN,
-	RTE_ETH_TUNNEL_FILTER_IMAC | RTE_ETH_TUNNEL_FILTER_TENID,
-	RTE_ETH_TUNNEL_FILTER_OMAC | RTE_ETH_TUNNEL_FILTER_TENID |
-	RTE_ETH_TUNNEL_FILTER_IMAC,
-	RTE_ETH_TUNNEL_FILTER_IMAC,
-};
-
-static int
-i40e_check_tunnel_filter_type(uint8_t filter_type)
-{
-	uint8_t i;
-
-	for (i = 0; i < RTE_DIM(i40e_supported_tunnel_filter_types); i++) {
-		if (filter_type == i40e_supported_tunnel_filter_types[i])
-			return 0;
-	}
-
-	return -1;
-}
-
-/* 1. Last in item should be NULL as range is not supported.
- * 2. Supported filter types: IMAC_IVLAN_TENID, IMAC_IVLAN,
- *    IMAC_TENID, OMAC_TENID_IMAC and IMAC.
- * 3. Mask of fields which need to be matched should be
- *    filled with 1.
- * 4. Mask of fields which needn't to be matched should be
- *    filled with 0.
- */
-static int
-i40e_flow_parse_vxlan_pattern(__rte_unused struct rte_eth_dev *dev,
-			      const struct rte_flow_item *pattern,
-			      struct rte_flow_error *error,
-			      struct i40e_tunnel_filter_conf *filter)
-{
-	const struct rte_flow_item *item = pattern;
-	const struct rte_flow_item_eth *eth_spec;
-	const struct rte_flow_item_eth *eth_mask;
-	const struct rte_flow_item_vxlan *vxlan_spec;
-	const struct rte_flow_item_vxlan *vxlan_mask;
-	const struct rte_flow_item_vlan *vlan_spec;
-	const struct rte_flow_item_vlan *vlan_mask;
-	uint8_t filter_type = 0;
-	bool is_vni_masked = 0;
-	uint8_t vni_mask[] = {0xFF, 0xFF, 0xFF};
-	enum rte_flow_item_type item_type;
-	bool vxlan_flag = 0;
-	uint32_t tenant_id_be = 0;
-	int ret;
-
-	for (; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Not support range");
-			return -rte_errno;
-		}
-		item_type = item->type;
-		switch (item_type) {
-		case RTE_FLOW_ITEM_TYPE_ETH:
-			eth_spec = item->spec;
-			eth_mask = item->mask;
-
-			/* Check if ETH item is used for place holder.
-			 * If yes, both spec and mask should be NULL.
-			 * If no, both spec and mask shouldn't be NULL.
-			 */
-			if ((!eth_spec && eth_mask) ||
-			    (eth_spec && !eth_mask)) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid ether spec/mask");
-				return -rte_errno;
-			}
-
-			if (eth_spec && eth_mask) {
-				/* DST address of inner MAC shouldn't be masked.
-				 * SRC address of Inner MAC should be masked.
-				 */
-				if (!rte_is_broadcast_ether_addr(&eth_mask->hdr.dst_addr) ||
-				    !rte_is_zero_ether_addr(&eth_mask->hdr.src_addr) ||
-				    eth_mask->hdr.ether_type) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid ether spec/mask");
-					return -rte_errno;
-				}
-
-				if (!vxlan_flag) {
-					memcpy(&filter->outer_mac,
-						   &eth_spec->hdr.dst_addr,
-						   RTE_ETHER_ADDR_LEN);
-					filter_type |= RTE_ETH_TUNNEL_FILTER_OMAC;
-				} else {
-					memcpy(&filter->inner_mac,
-						   &eth_spec->hdr.dst_addr,
-						   RTE_ETHER_ADDR_LEN);
-					filter_type |= RTE_ETH_TUNNEL_FILTER_IMAC;
-				}
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_VLAN:
-			vlan_spec = item->spec;
-			vlan_mask = item->mask;
-			if (!(vlan_spec && vlan_mask) ||
-			    vlan_mask->hdr.eth_proto) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid vlan item");
-				return -rte_errno;
-			}
-
-			if (vlan_spec && vlan_mask) {
-				if (vlan_mask->hdr.vlan_tci ==
-				    rte_cpu_to_be_16(I40E_VLAN_TCI_MASK))
-					filter->inner_vlan =
-					      rte_be_to_cpu_16(vlan_spec->hdr.vlan_tci) &
-					      I40E_VLAN_TCI_MASK;
-				filter_type |= RTE_ETH_TUNNEL_FILTER_IVLAN;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_IPV4:
-			filter->ip_type = I40E_TUNNEL_IPTYPE_IPV4;
-			/* IPv4 is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid IPv4 item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_IPV6:
-			filter->ip_type = I40E_TUNNEL_IPTYPE_IPV6;
-			/* IPv6 is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid IPv6 item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_UDP:
-			/* UDP is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Invalid UDP item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_VXLAN:
-			vxlan_spec = item->spec;
-			vxlan_mask = item->mask;
-			/* Check if VXLAN item is used to describe protocol.
-			 * If yes, both spec and mask should be NULL.
-			 * If no, both spec and mask shouldn't be NULL.
-			 */
-			if ((!vxlan_spec && vxlan_mask) ||
-			    (vxlan_spec && !vxlan_mask)) {
-				rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Invalid VXLAN item");
-				return -rte_errno;
-			}
-
-			/* Check if VNI is masked. */
-			if (vxlan_spec && vxlan_mask) {
-				is_vni_masked =
-					!!memcmp(vxlan_mask->hdr.vni, vni_mask,
-						 RTE_DIM(vni_mask));
-				if (is_vni_masked) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid VNI mask");
-					return -rte_errno;
-				}
-
-				memcpy(((uint8_t *)&tenant_id_be + 1),
-					   vxlan_spec->hdr.vni, 3);
-				filter->tenant_id =
-					rte_be_to_cpu_32(tenant_id_be);
-				filter_type |= RTE_ETH_TUNNEL_FILTER_TENID;
-			}
-
-			vxlan_flag = 1;
-			break;
-		default:
-			break;
-		}
-	}
-
-	ret = i40e_check_tunnel_filter_type(filter_type);
-	if (ret < 0) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ITEM,
-				   NULL,
-				   "Invalid filter type");
-		return -rte_errno;
-	}
-	filter->filter_type = filter_type;
-
-	filter->tunnel_type = I40E_TUNNEL_TYPE_VXLAN;
-
-	return 0;
-}
-
-static int
-i40e_flow_parse_vxlan_filter(struct rte_eth_dev *dev,
-			     const struct rte_flow_item pattern[],
-			     const struct rte_flow_action actions[],
-			     struct rte_flow_error *error,
-			     struct i40e_filter_ctx *filter)
-{
-	struct i40e_tunnel_filter_conf *tunnel_filter = &filter->consistent_tunnel_filter;
-	int ret;
-
-	ret = i40e_flow_parse_vxlan_pattern(dev, pattern,
-					    error, tunnel_filter);
-	if (ret)
-		return ret;
-
-	ret = i40e_flow_parse_tunnel_action(dev, actions, error, tunnel_filter);
-	if (ret)
-		return ret;
-
-	filter->type = RTE_ETH_FILTER_TUNNEL;
-
-	return ret;
-}
-
-/* 1. Last in item should be NULL as range is not supported.
- * 2. Supported filter types: IMAC_IVLAN_TENID, IMAC_IVLAN,
- *    IMAC_TENID, OMAC_TENID_IMAC and IMAC.
- * 3. Mask of fields which need to be matched should be
- *    filled with 1.
- * 4. Mask of fields which needn't to be matched should be
- *    filled with 0.
- */
-static int
-i40e_flow_parse_nvgre_pattern(__rte_unused struct rte_eth_dev *dev,
-			      const struct rte_flow_item *pattern,
-			      struct rte_flow_error *error,
-			      struct i40e_tunnel_filter_conf *filter)
-{
-	const struct rte_flow_item *item = pattern;
-	const struct rte_flow_item_eth *eth_spec;
-	const struct rte_flow_item_eth *eth_mask;
-	const struct rte_flow_item_nvgre *nvgre_spec;
-	const struct rte_flow_item_nvgre *nvgre_mask;
-	const struct rte_flow_item_vlan *vlan_spec;
-	const struct rte_flow_item_vlan *vlan_mask;
-	enum rte_flow_item_type item_type;
-	uint8_t filter_type = 0;
-	bool is_tni_masked = 0;
-	uint8_t tni_mask[] = {0xFF, 0xFF, 0xFF};
-	bool nvgre_flag = 0;
-	uint32_t tenant_id_be = 0;
-	int ret;
-
-	for (; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Not support range");
-			return -rte_errno;
-		}
-		item_type = item->type;
-		switch (item_type) {
-		case RTE_FLOW_ITEM_TYPE_ETH:
-			eth_spec = item->spec;
-			eth_mask = item->mask;
-
-			/* Check if ETH item is used for place holder.
-			 * If yes, both spec and mask should be NULL.
-			 * If no, both spec and mask shouldn't be NULL.
-			 */
-			if ((!eth_spec && eth_mask) ||
-			    (eth_spec && !eth_mask)) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid ether spec/mask");
-				return -rte_errno;
-			}
-
-			if (eth_spec && eth_mask) {
-				/* DST address of inner MAC shouldn't be masked.
-				 * SRC address of Inner MAC should be masked.
-				 */
-				if (!rte_is_broadcast_ether_addr(&eth_mask->hdr.dst_addr) ||
-				    !rte_is_zero_ether_addr(&eth_mask->hdr.src_addr) ||
-				    eth_mask->hdr.ether_type) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid ether spec/mask");
-					return -rte_errno;
-				}
-
-				if (!nvgre_flag) {
-					memcpy(&filter->outer_mac,
-						   &eth_spec->hdr.dst_addr,
-						   RTE_ETHER_ADDR_LEN);
-					filter_type |= RTE_ETH_TUNNEL_FILTER_OMAC;
-				} else {
-					memcpy(&filter->inner_mac,
-						   &eth_spec->hdr.dst_addr,
-						   RTE_ETHER_ADDR_LEN);
-					filter_type |= RTE_ETH_TUNNEL_FILTER_IMAC;
-				}
-			}
-
-			break;
-		case RTE_FLOW_ITEM_TYPE_VLAN:
-			vlan_spec = item->spec;
-			vlan_mask = item->mask;
-			if (!(vlan_spec && vlan_mask) ||
-			    vlan_mask->hdr.eth_proto) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid vlan item");
-				return -rte_errno;
-			}
-
-			if (vlan_spec && vlan_mask) {
-				if (vlan_mask->hdr.vlan_tci ==
-				    rte_cpu_to_be_16(I40E_VLAN_TCI_MASK))
-					filter->inner_vlan =
-					      rte_be_to_cpu_16(vlan_spec->hdr.vlan_tci) &
-					      I40E_VLAN_TCI_MASK;
-				filter_type |= RTE_ETH_TUNNEL_FILTER_IVLAN;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_IPV4:
-			filter->ip_type = I40E_TUNNEL_IPTYPE_IPV4;
-			/* IPv4 is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid IPv4 item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_IPV6:
-			filter->ip_type = I40E_TUNNEL_IPTYPE_IPV6;
-			/* IPv6 is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid IPv6 item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_NVGRE:
-			nvgre_spec = item->spec;
-			nvgre_mask = item->mask;
-			/* Check if NVGRE item is used to describe protocol.
-			 * If yes, both spec and mask should be NULL.
-			 * If no, both spec and mask shouldn't be NULL.
-			 */
-			if ((!nvgre_spec && nvgre_mask) ||
-			    (nvgre_spec && !nvgre_mask)) {
-				rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Invalid NVGRE item");
-				return -rte_errno;
-			}
-
-			if (nvgre_spec && nvgre_mask) {
-				is_tni_masked =
-					!!memcmp(nvgre_mask->tni, tni_mask,
-						 RTE_DIM(tni_mask));
-				if (is_tni_masked) {
-					rte_flow_error_set(error, EINVAL,
-						       RTE_FLOW_ERROR_TYPE_ITEM,
-						       item,
-						       "Invalid TNI mask");
-					return -rte_errno;
-				}
-				if (nvgre_mask->protocol &&
-					nvgre_mask->protocol != 0xFFFF) {
-					rte_flow_error_set(error, EINVAL,
-						RTE_FLOW_ERROR_TYPE_ITEM,
-						item,
-						"Invalid NVGRE item");
-					return -rte_errno;
-				}
-				if (nvgre_mask->c_k_s_rsvd0_ver &&
-					nvgre_mask->c_k_s_rsvd0_ver !=
-					rte_cpu_to_be_16(0xFFFF)) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid NVGRE item");
-					return -rte_errno;
-				}
-				if (nvgre_spec->c_k_s_rsvd0_ver !=
-					rte_cpu_to_be_16(0x2000) &&
-					nvgre_mask->c_k_s_rsvd0_ver) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid NVGRE item");
-					return -rte_errno;
-				}
-				if (nvgre_mask->protocol &&
-					nvgre_spec->protocol !=
-					rte_cpu_to_be_16(0x6558)) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid NVGRE item");
-					return -rte_errno;
-				}
-				memcpy(((uint8_t *)&tenant_id_be + 1),
-					   nvgre_spec->tni, 3);
-				filter->tenant_id =
-					rte_be_to_cpu_32(tenant_id_be);
-				filter_type |= RTE_ETH_TUNNEL_FILTER_TENID;
-			}
-
-			nvgre_flag = 1;
-			break;
-		default:
-			break;
-		}
-	}
-
-	ret = i40e_check_tunnel_filter_type(filter_type);
-	if (ret < 0) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ITEM,
-				   NULL,
-				   "Invalid filter type");
-		return -rte_errno;
-	}
-	filter->filter_type = filter_type;
-
-	filter->tunnel_type = I40E_TUNNEL_TYPE_NVGRE;
-
-	return 0;
-}
-
-static int
-i40e_flow_parse_nvgre_filter(struct rte_eth_dev *dev,
-			     const struct rte_flow_item pattern[],
-			     const struct rte_flow_action actions[],
-			     struct rte_flow_error *error,
-			     struct i40e_filter_ctx *filter)
-{
-	struct i40e_tunnel_filter_conf *tunnel_filter = &filter->consistent_tunnel_filter;
-	int ret;
-
-	ret = i40e_flow_parse_nvgre_pattern(dev, pattern,
-					    error, tunnel_filter);
-	if (ret)
-		return ret;
-
-	ret = i40e_flow_parse_tunnel_action(dev, actions, error, tunnel_filter);
-	if (ret)
-		return ret;
-
-	filter->type = RTE_ETH_FILTER_TUNNEL;
-
-	return ret;
-}
-
-/* 1. Last in item should be NULL as range is not supported.
- * 2. Supported filter types: MPLS label.
- * 3. Mask of fields which need to be matched should be
- *    filled with 1.
- * 4. Mask of fields which needn't to be matched should be
- *    filled with 0.
- */
-static int
-i40e_flow_parse_mpls_pattern(__rte_unused struct rte_eth_dev *dev,
-			     const struct rte_flow_item *pattern,
-			     struct rte_flow_error *error,
-			     struct i40e_tunnel_filter_conf *filter)
-{
-	const struct rte_flow_item *item = pattern;
-	const struct rte_flow_item_mpls *mpls_spec;
-	const struct rte_flow_item_mpls *mpls_mask;
-	enum rte_flow_item_type item_type;
-	bool is_mplsoudp = 0; /* 1 - MPLSoUDP, 0 - MPLSoGRE */
-	const uint8_t label_mask[3] = {0xFF, 0xFF, 0xF0};
-	uint32_t label_be = 0;
-
-	for (; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Not support range");
-			return -rte_errno;
-		}
-		item_type = item->type;
-		switch (item_type) {
-		case RTE_FLOW_ITEM_TYPE_ETH:
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid ETH item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_IPV4:
-			filter->ip_type = I40E_TUNNEL_IPTYPE_IPV4;
-			/* IPv4 is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid IPv4 item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_IPV6:
-			filter->ip_type = I40E_TUNNEL_IPTYPE_IPV6;
-			/* IPv6 is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid IPv6 item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_UDP:
-			/* UDP is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid UDP item");
-				return -rte_errno;
-			}
-			is_mplsoudp = 1;
-			break;
-		case RTE_FLOW_ITEM_TYPE_GRE:
-			/* GRE is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid GRE item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_MPLS:
-			mpls_spec = item->spec;
-			mpls_mask = item->mask;
-
-			if (!mpls_spec || !mpls_mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid MPLS item");
-				return -rte_errno;
-			}
-
-			if (memcmp(mpls_mask->label_tc_s, label_mask, 3)) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid MPLS label mask");
-				return -rte_errno;
-			}
-			memcpy(((uint8_t *)&label_be + 1),
-				   mpls_spec->label_tc_s, 3);
-			filter->tenant_id = rte_be_to_cpu_32(label_be) >> 4;
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (is_mplsoudp)
-		filter->tunnel_type = I40E_TUNNEL_TYPE_MPLSoUDP;
-	else
-		filter->tunnel_type = I40E_TUNNEL_TYPE_MPLSoGRE;
-
-	return 0;
-}
-
-static int
-i40e_flow_parse_mpls_filter(struct rte_eth_dev *dev,
-			    const struct rte_flow_item pattern[],
-			    const struct rte_flow_action actions[],
-			    struct rte_flow_error *error,
-			    struct i40e_filter_ctx *filter)
-{
-	struct i40e_tunnel_filter_conf *tunnel_filter = &filter->consistent_tunnel_filter;
-	int ret;
-
-	ret = i40e_flow_parse_mpls_pattern(dev, pattern,
-					   error, tunnel_filter);
-	if (ret)
-		return ret;
-
-	ret = i40e_flow_parse_tunnel_action(dev, actions, error, tunnel_filter);
-	if (ret)
-		return ret;
-
-	filter->type = RTE_ETH_FILTER_TUNNEL;
-
-	return ret;
-}
-
-/* 1. Last in item should be NULL as range is not supported.
- * 2. Supported filter types: GTP TEID.
- * 3. Mask of fields which need to be matched should be
- *    filled with 1.
- * 4. Mask of fields which needn't to be matched should be
- *    filled with 0.
- * 5. GTP profile supports GTPv1 only.
- * 6. GTP-C response message ('source_port' = 2123) is not supported.
- */
-static int
-i40e_flow_parse_gtp_pattern(struct rte_eth_dev *dev,
-			    const struct rte_flow_item *pattern,
-			    struct rte_flow_error *error,
-			    struct i40e_tunnel_filter_conf *filter)
-{
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	const struct rte_flow_item *item = pattern;
-	const struct rte_flow_item_gtp *gtp_spec;
-	const struct rte_flow_item_gtp *gtp_mask;
-	enum rte_flow_item_type item_type;
-
-	if (!pf->gtp_support) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ITEM,
-				   item,
-				   "GTP is not supported by default.");
-		return -rte_errno;
-	}
-
-	for (; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Not support range");
-			return -rte_errno;
-		}
-		item_type = item->type;
-		switch (item_type) {
-		case RTE_FLOW_ITEM_TYPE_ETH:
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid ETH item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_IPV4:
-			filter->ip_type = I40E_TUNNEL_IPTYPE_IPV4;
-			/* IPv4 is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid IPv4 item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_IPV6:
-			filter->ip_type = I40E_TUNNEL_IPTYPE_IPV6;
-			/* IPv6 is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid IPv6 item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_UDP:
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid UDP item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_GTPC:
-		case RTE_FLOW_ITEM_TYPE_GTPU:
-			gtp_spec = item->spec;
-			gtp_mask = item->mask;
-
-			if (!gtp_spec || !gtp_mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid GTP item");
-				return -rte_errno;
-			}
-
-			if (gtp_mask->hdr.gtp_hdr_info ||
-			    gtp_mask->hdr.msg_type ||
-			    gtp_mask->hdr.plen ||
-			    gtp_mask->hdr.teid != UINT32_MAX) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid GTP mask");
-				return -rte_errno;
-			}
-
-			if (item_type == RTE_FLOW_ITEM_TYPE_GTPC)
-				filter->tunnel_type = I40E_TUNNEL_TYPE_GTPC;
-			else if (item_type == RTE_FLOW_ITEM_TYPE_GTPU)
-				filter->tunnel_type = I40E_TUNNEL_TYPE_GTPU;
-
-			filter->tenant_id = rte_be_to_cpu_32(gtp_spec->hdr.teid);
-
-			break;
-		default:
-			break;
-		}
-	}
-
-	return 0;
-}
-
-static int
-i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
-			   const struct rte_flow_item pattern[],
-			   const struct rte_flow_action actions[],
-			   struct rte_flow_error *error,
-			   struct i40e_filter_ctx *filter)
-{
-	struct i40e_tunnel_filter_conf *tunnel_filter = &filter->consistent_tunnel_filter;
-	int ret;
-
-	ret = i40e_flow_parse_gtp_pattern(dev, pattern,
-					  error, tunnel_filter);
-	if (ret)
-		return ret;
-
-	ret = i40e_flow_parse_tunnel_action(dev, actions, error, tunnel_filter);
-	if (ret)
-		return ret;
-
-	filter->type = RTE_ETH_FILTER_TUNNEL;
-
-	return ret;
-}
-
-/* 1. Last in item should be NULL as range is not supported.
- * 2. Supported filter types: QINQ.
- * 3. Mask of fields which need to be matched should be
- *    filled with 1.
- * 4. Mask of fields which needn't to be matched should be
- *    filled with 0.
- */
-static int
-i40e_flow_parse_qinq_pattern(__rte_unused struct rte_eth_dev *dev,
-			      const struct rte_flow_item *pattern,
-			      struct rte_flow_error *error,
-			      struct i40e_tunnel_filter_conf *filter)
-{
-	const struct rte_flow_item *item = pattern;
-	const struct rte_flow_item_vlan *vlan_spec = NULL;
-	const struct rte_flow_item_vlan *vlan_mask = NULL;
-	const struct rte_flow_item_vlan *i_vlan_spec = NULL;
-	const struct rte_flow_item_vlan *i_vlan_mask = NULL;
-	const struct rte_flow_item_vlan *o_vlan_spec = NULL;
-	const struct rte_flow_item_vlan *o_vlan_mask = NULL;
-
-	enum rte_flow_item_type item_type;
-	bool vlan_flag = 0;
-
-	for (; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Not support range");
-			return -rte_errno;
-		}
-		item_type = item->type;
-		switch (item_type) {
-		case RTE_FLOW_ITEM_TYPE_ETH:
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid ETH item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_VLAN:
-			vlan_spec = item->spec;
-			vlan_mask = item->mask;
-
-			if (!(vlan_spec && vlan_mask) ||
-			    vlan_mask->hdr.eth_proto) {
-				rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Invalid vlan item");
-				return -rte_errno;
-			}
-
-			if (!vlan_flag) {
-				o_vlan_spec = vlan_spec;
-				o_vlan_mask = vlan_mask;
-				vlan_flag = 1;
-			} else {
-				i_vlan_spec = vlan_spec;
-				i_vlan_mask = vlan_mask;
-				vlan_flag = 0;
-			}
-			break;
-
-		default:
-			break;
-		}
-	}
-
-	/* Get filter specification */
-	if (o_vlan_mask != NULL &&  i_vlan_mask != NULL) {
-		filter->outer_vlan = rte_be_to_cpu_16(o_vlan_spec->hdr.vlan_tci);
-		filter->inner_vlan = rte_be_to_cpu_16(i_vlan_spec->hdr.vlan_tci);
-	} else {
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   NULL,
-					   "Invalid filter type");
-			return -rte_errno;
-	}
-
-	filter->tunnel_type = I40E_TUNNEL_TYPE_QINQ;
-	return 0;
-}
-
-static int
-i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
-			      const struct rte_flow_item pattern[],
-			      const struct rte_flow_action actions[],
-			      struct rte_flow_error *error,
-			      struct i40e_filter_ctx *filter)
-{
-	struct i40e_tunnel_filter_conf *tunnel_filter = &filter->consistent_tunnel_filter;
-	int ret;
-
-	ret = i40e_flow_parse_qinq_pattern(dev, pattern,
-					     error, tunnel_filter);
-	if (ret)
-		return ret;
-
-	ret = i40e_flow_parse_tunnel_action(dev, actions, error, tunnel_filter);
-	if (ret)
-		return ret;
-
-	filter->type = RTE_ETH_FILTER_TUNNEL;
-
-	return ret;
-}
-
 static int
 i40e_flow_check(struct rte_eth_dev *dev,
 		   const struct rte_flow_attr *attr,
@@ -1823,11 +290,6 @@ i40e_flow_check(struct rte_eth_dev *dev,
 		   struct i40e_filter_ctx *filter_ctx,
 		   struct rte_flow_error *error)
 {
-	struct rte_flow_item *items; /* internal pattern w/o VOID items */
-	parse_filter_t parse_filter;
-	uint32_t item_num = 0; /* non-void item number of pattern*/
-	uint32_t i = 0;
-	bool flag = false;
 	int ret;
 
 	ret = ci_flow_check_attr(attr, NULL, error);
@@ -1851,51 +313,8 @@ i40e_flow_check(struct rte_eth_dev *dev,
 
 	/* try parsing as RSS */
 	filter_ctx->type = RTE_ETH_FILTER_HASH;
-	ret = i40e_hash_parse(dev, pattern, actions, &filter_ctx->rss_conf, error);
-	if (!ret)
-		return ret;
 
-	i = 0;
-	/* Get the non-void item number of pattern */
-	while ((pattern + i)->type != RTE_FLOW_ITEM_TYPE_END) {
-		if ((pattern + i)->type != RTE_FLOW_ITEM_TYPE_VOID)
-			item_num++;
-		i++;
-	}
-	item_num++;
-	items = calloc(item_num, sizeof(struct rte_flow_item));
-	if (items == NULL) {
-		rte_flow_error_set(error, ENOMEM,
-				RTE_FLOW_ERROR_TYPE_ITEM_NUM,
-				NULL,
-				"No memory for PMD internal items.");
-		return -ENOMEM;
-	}
-
-	i40e_pattern_skip_void_item(items, pattern);
-
-	i = 0;
-	ret = I40E_NOT_SUPPORTED;
-	do {
-		parse_filter = i40e_find_parse_filter_func(items, &i);
-		if (!parse_filter && !flag) {
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   pattern, "Unsupported pattern");
-
-			free(items);
-			return -rte_errno;
-		}
-
-		if (parse_filter)
-			ret = parse_filter(dev, items, actions, error, filter_ctx);
-
-		flag = true;
-	} while ((ret < 0) && (i < RTE_DIM(i40e_supported_patterns)));
-
-	free(items);
-
-	return ret;
+	return i40e_hash_parse(dev, pattern, actions, &filter_ctx->rss_conf, error);
 }
 
 static int
@@ -1948,14 +367,6 @@ i40e_flow_create(struct rte_eth_dev *dev,
 	}
 
 	switch (filter_ctx.type) {
-	case RTE_ETH_FILTER_TUNNEL:
-		ret = i40e_dev_consistent_tunnel_filter_set(pf,
-				&filter_ctx.consistent_tunnel_filter, 1);
-		if (ret)
-			goto free_flow;
-		flow->rule = TAILQ_LAST(&pf->tunnel.tunnel_list,
-					i40e_tunnel_filter_list);
-		break;
 	case RTE_ETH_FILTER_HASH:
 		ret = i40e_hash_filter_create(pf, &filter_ctx.rss_conf);
 		if (ret)
@@ -1996,10 +407,6 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 		return 0;
 
 	switch (filter_type) {
-	case RTE_ETH_FILTER_TUNNEL:
-		ret = i40e_flow_destroy_tunnel_filter(pf,
-			      (struct i40e_tunnel_filter *)flow->rule);
-		break;
 	case RTE_ETH_FILTER_HASH:
 		ret = i40e_hash_filter_destroy(pf, flow->rule);
 		break;
@@ -2022,65 +429,6 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 	return ret;
 }
 
-static int
-i40e_flow_destroy_tunnel_filter(struct i40e_pf *pf,
-				struct i40e_tunnel_filter *filter)
-{
-	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
-	struct i40e_vsi *vsi;
-	struct i40e_pf_vf *vf;
-	struct i40e_aqc_cloud_filters_element_bb cld_filter;
-	struct i40e_tunnel_rule *tunnel_rule = &pf->tunnel;
-	struct i40e_tunnel_filter *node;
-	bool big_buffer = 0;
-	int ret = 0;
-
-	memset(&cld_filter, 0, sizeof(cld_filter));
-	rte_ether_addr_copy((struct rte_ether_addr *)&filter->input.outer_mac,
-			(struct rte_ether_addr *)&cld_filter.element.outer_mac);
-	rte_ether_addr_copy((struct rte_ether_addr *)&filter->input.inner_mac,
-			(struct rte_ether_addr *)&cld_filter.element.inner_mac);
-	cld_filter.element.inner_vlan = filter->input.inner_vlan;
-	cld_filter.element.flags = filter->input.flags;
-	cld_filter.element.tenant_id = filter->input.tenant_id;
-	cld_filter.element.queue_number = filter->queue;
-	memcpy(cld_filter.general_fields,
-		   filter->input.general_fields,
-		   sizeof(cld_filter.general_fields));
-
-	if (!filter->is_to_vf)
-		vsi = pf->main_vsi;
-	else {
-		vf = &pf->vfs[filter->vf_id];
-		vsi = vf->vsi;
-	}
-
-	if (((filter->input.flags & I40E_AQC_ADD_CLOUD_FILTER_0X11) ==
-	    I40E_AQC_ADD_CLOUD_FILTER_0X11) ||
-	    ((filter->input.flags & I40E_AQC_ADD_CLOUD_FILTER_0X12) ==
-	    I40E_AQC_ADD_CLOUD_FILTER_0X12) ||
-	    ((filter->input.flags & I40E_AQC_ADD_CLOUD_FILTER_0X10) ==
-	    I40E_AQC_ADD_CLOUD_FILTER_0X10))
-		big_buffer = 1;
-
-	if (big_buffer)
-		ret = i40e_aq_rem_cloud_filters_bb(hw, vsi->seid,
-						&cld_filter, 1);
-	else
-		ret = i40e_aq_rem_cloud_filters(hw, vsi->seid,
-						&cld_filter.element, 1);
-	if (ret < 0)
-		return -ENOTSUP;
-
-	node = i40e_sw_tunnel_filter_lookup(tunnel_rule, &filter->input);
-	if (!node)
-		return -EINVAL;
-
-	ret = i40e_sw_tunnel_filter_del(pf, &node->input);
-
-	return ret;
-}
-
 static int
 i40e_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
 {
@@ -2092,14 +440,6 @@ i40e_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
 	if (ret != 0)
 		return ret;
 
-	ret = i40e_flow_flush_tunnel_filter(pf);
-	if (ret) {
-		rte_flow_error_set(error, -ret,
-				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				   "Failed to flush tunnel flows.");
-		return -rte_errno;
-	}
-
 	ret = i40e_hash_filter_flush(pf);
 	if (ret)
 		rte_flow_error_set(error, -ret,
@@ -2108,34 +448,6 @@ i40e_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
 	return ret;
 }
 
-/* Flush all tunnel filters */
-static int
-i40e_flow_flush_tunnel_filter(struct i40e_pf *pf)
-{
-	struct i40e_tunnel_filter_list
-		*tunnel_list = &pf->tunnel.tunnel_list;
-	struct i40e_tunnel_filter *filter;
-	struct rte_flow *flow;
-	void *temp;
-	int ret = 0;
-
-	while ((filter = TAILQ_FIRST(tunnel_list))) {
-		ret = i40e_flow_destroy_tunnel_filter(pf, filter);
-		if (ret)
-			return ret;
-	}
-
-	/* Delete tunnel flows in flow list. */
-	RTE_TAILQ_FOREACH_SAFE(flow, &pf->flow_list, node, temp) {
-		if (flow->filter_type == RTE_ETH_FILTER_TUNNEL) {
-			TAILQ_REMOVE(&pf->flow_list, flow, node);
-			rte_free(flow);
-		}
-	}
-
-	return ret;
-}
-
 static int
 i40e_flow_query(struct rte_eth_dev *dev,
 		struct rte_flow *flow,
diff --git a/drivers/net/intel/i40e/i40e_flow.h b/drivers/net/intel/i40e/i40e_flow.h
index 6823dbef332..28e342210ce 100644
--- a/drivers/net/intel/i40e/i40e_flow.h
+++ b/drivers/net/intel/i40e/i40e_flow.h
@@ -17,5 +17,11 @@ extern const struct ci_flow_engine_list i40e_flow_engine_list;
 
 extern const struct ci_flow_engine i40e_flow_engine_ethertype;
 extern const struct ci_flow_engine i40e_flow_engine_fdir;
+extern const struct ci_flow_engine i40e_flow_engine_tunnel_qinq;
+extern const struct ci_flow_engine i40e_flow_engine_tunnel_vxlan;
+extern const struct ci_flow_engine i40e_flow_engine_tunnel_nvgre;
+extern const struct ci_flow_engine i40e_flow_engine_tunnel_mpls;
+extern const struct ci_flow_engine i40e_flow_engine_tunnel_gtp;
+extern const struct ci_flow_engine i40e_flow_engine_tunnel_l4;
 
 #endif /* _I40E_FLOW_H_ */
diff --git a/drivers/net/intel/i40e/i40e_flow_tunnel.c b/drivers/net/intel/i40e/i40e_flow_tunnel.c
new file mode 100644
index 00000000000..fc7a67bcea7
--- /dev/null
+++ b/drivers/net/intel/i40e/i40e_flow_tunnel.c
@@ -0,0 +1,1590 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include "i40e_ethdev.h"
+#include "i40e_flow.h"
+
+#include "../common/flow_engine.h"
+#include "../common/flow_check.h"
+#include "../common/flow_util.h"
+
+struct i40e_tunnel_priv {
+	struct i40e_tunnel_state *state;
+};
+
+struct i40e_tunnel_ctx {
+	struct ci_flow_engine_ctx base;
+	struct i40e_tunnel_filter_conf filter;
+};
+
+struct i40e_tunnel_flow {
+	struct rte_flow base;
+	struct i40e_tunnel_filter_conf filter;
+	struct i40e_tunnel_filter_match_key match_key;
+};
+
+static int
+i40e_check_tunnel_filter_type(uint8_t filter_type)
+{
+	const uint16_t i40e_supported_tunnel_filter_types[] = {
+		RTE_ETH_TUNNEL_FILTER_IMAC | RTE_ETH_TUNNEL_FILTER_TENID |
+		RTE_ETH_TUNNEL_FILTER_IVLAN,
+		RTE_ETH_TUNNEL_FILTER_IMAC | RTE_ETH_TUNNEL_FILTER_IVLAN,
+		RTE_ETH_TUNNEL_FILTER_IMAC | RTE_ETH_TUNNEL_FILTER_TENID,
+		RTE_ETH_TUNNEL_FILTER_OMAC | RTE_ETH_TUNNEL_FILTER_TENID |
+		RTE_ETH_TUNNEL_FILTER_IMAC,
+		RTE_ETH_TUNNEL_FILTER_IMAC,
+	};
+	uint8_t i;
+
+	for (i = 0; i < RTE_DIM(i40e_supported_tunnel_filter_types); i++) {
+		if (filter_type == i40e_supported_tunnel_filter_types[i])
+			return 0;
+	}
+	return -1;
+}
+
+/**
+ * QinQ tunnel filter graph implementation
+ * Pattern: START -> ETH -> OUTER_VLAN -> INNER_VLAN -> END
+ */
+enum i40e_tunnel_qinq_node_id {
+	I40E_TUNNEL_QINQ_NODE_START = FLOW_GRAPH_NODE_FIRST,
+	I40E_TUNNEL_QINQ_NODE_ETH,
+	I40E_TUNNEL_QINQ_NODE_OUTER_VLAN,
+	I40E_TUNNEL_QINQ_NODE_INNER_VLAN,
+	I40E_TUNNEL_QINQ_NODE_END,
+	I40E_TUNNEL_QINQ_NODE_MAX,
+};
+
+static int
+i40e_tunnel_node_vlan_validate(const void *ctx __rte_unused, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_vlan *vlan_mask = item->mask;
+
+	/* matching eth proto not supported */
+	if (vlan_mask->hdr.eth_proto) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid VLAN mask");
+	}
+
+	/* VLAN TCI must be fully masked */
+	if (!CI_FIELD_IS_MASKED(&vlan_mask->hdr.vlan_tci)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid VLAN mask");
+	}
+
+	return 0;
+}
+
+/* common VLAN processing for both outer and inner VLAN nodes */
+static int
+i40e_tunnel_node_vlan_process(struct i40e_tunnel_ctx *tunnel_ctx,
+		const struct rte_flow_item *item, bool is_inner)
+{
+	const struct rte_flow_item_vlan *vlan_spec = item->spec;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	/* Store the VLAN ID and set filter flag */
+	if (is_inner) {
+		tunnel_filter->inner_vlan = rte_be_to_cpu_16(vlan_spec->hdr.vlan_tci);
+		tunnel_filter->filter_type |= RTE_ETH_TUNNEL_FILTER_IVLAN;
+	} else {
+		tunnel_filter->outer_vlan = rte_be_to_cpu_16(vlan_spec->hdr.vlan_tci);
+		/* no special flag for outer VLAN matching */
+	}
+
+	return 0;
+}
+
+static int
+i40e_tunnel_node_outer_vlan_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+
+	return i40e_tunnel_node_vlan_process(tunnel_ctx, item, false);
+}
+
+static int
+i40e_tunnel_node_inner_vlan_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+
+	return i40e_tunnel_node_vlan_process(tunnel_ctx, item, true);
+}
+
+static int
+i40e_tunnel_qinq_node_end_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	tunnel_filter->tunnel_type = I40E_TUNNEL_TYPE_QINQ;
+
+	/* QinQ filter is not meant to set this flag */
+	tunnel_filter->filter_type &= ~RTE_ETH_TUNNEL_FILTER_IVLAN;
+
+	return 0;
+}
+
+static const struct flow_graph i40e_tunnel_qinq_graph = {
+	.nodes = (struct flow_graph_node[]) {
+		[I40E_TUNNEL_QINQ_NODE_START] = {
+			.name = "START",
+		},
+		[I40E_TUNNEL_QINQ_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[I40E_TUNNEL_QINQ_NODE_OUTER_VLAN] = {
+			.name = "OUTER_VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_vlan_validate,
+			.process = i40e_tunnel_node_outer_vlan_process,
+		},
+		[I40E_TUNNEL_QINQ_NODE_INNER_VLAN] = {
+			.name = "INNER_VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_vlan_validate,
+			.process = i40e_tunnel_node_inner_vlan_process,
+		},
+		[I40E_TUNNEL_QINQ_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+			.process = i40e_tunnel_qinq_node_end_process,
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[I40E_TUNNEL_QINQ_NODE_START] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_QINQ_NODE_ETH,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_QINQ_NODE_ETH] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_QINQ_NODE_OUTER_VLAN,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_QINQ_NODE_OUTER_VLAN] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_QINQ_NODE_INNER_VLAN,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_QINQ_NODE_INNER_VLAN] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_QINQ_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+/**
+ * VXLAN tunnel filter graph implementation
+ * Pattern: START -> ETH -> (IPv4 | IPv6) -> UDP -> VXLAN -> ETH -> [VLAN] -> END
+ */
+enum i40e_tunnel_vxlan_node_id {
+	I40E_TUNNEL_VXLAN_NODE_START  = FLOW_GRAPH_NODE_FIRST,
+	I40E_TUNNEL_VXLAN_NODE_OUTER_ETH,
+	I40E_TUNNEL_VXLAN_NODE_IPV4,
+	I40E_TUNNEL_VXLAN_NODE_IPV6,
+	I40E_TUNNEL_VXLAN_NODE_UDP,
+	I40E_TUNNEL_VXLAN_NODE_VXLAN,
+	I40E_TUNNEL_VXLAN_NODE_INNER_ETH,
+	I40E_TUNNEL_VXLAN_NODE_INNER_VLAN,
+	I40E_TUNNEL_VXLAN_NODE_END,
+	I40E_TUNNEL_VXLAN_NODE_MAX,
+};
+
+static int
+i40e_tunnel_node_eth_validate(const void *ctx __rte_unused, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+
+	/* spec/mask is optional */
+	if (eth_spec == NULL && eth_mask == NULL)
+		return 0;
+
+	/* matching eth type not supported */
+	if (eth_mask->hdr.ether_type) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid ETH mask");
+	}
+
+	/* source MAC must be fully unmasked */
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.src_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid ETH mask");
+	}
+	/* destination MAC must be fully masked */
+	if (!CI_FIELD_IS_MASKED(&eth_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid ETH mask");
+	}
+
+	return 0;
+}
+
+static int
+i40e_tunnel_eth_process(struct i40e_tunnel_ctx *tunnel_ctx,
+		const struct rte_flow_item *item, bool is_inner)
+{
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	/* eth spec/mask is optional */
+	if (eth_spec == NULL && eth_mask == NULL)
+		return 0;
+
+	/* Store the MAC addresses and set filter flags */
+	if (is_inner) {
+		memcpy(&tunnel_filter->inner_mac, &eth_spec->hdr.dst_addr,
+				sizeof(tunnel_filter->inner_mac));
+		tunnel_filter->filter_type |= RTE_ETH_TUNNEL_FILTER_IMAC;
+	} else {
+		memcpy(&tunnel_filter->outer_mac, &eth_spec->hdr.dst_addr,
+				sizeof(tunnel_filter->outer_mac));
+		tunnel_filter->filter_type |= RTE_ETH_TUNNEL_FILTER_OMAC;
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_node_outer_eth_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+
+	return i40e_tunnel_eth_process(tunnel_ctx, item, false);
+}
+
+static int
+i40e_tunnel_node_inner_eth_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+
+	return i40e_tunnel_eth_process(tunnel_ctx, item, true);
+}
+
+static int
+i40e_tunnel_node_ipv4_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	tunnel_filter->ip_type = I40E_TUNNEL_IPTYPE_IPV4;
+
+	return 0;
+}
+
+static int
+i40e_tunnel_node_ipv6_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	tunnel_filter->ip_type = I40E_TUNNEL_IPTYPE_IPV6;
+
+	return 0;
+}
+
+static int
+i40e_tunnel_node_vxlan_validate(const void *ctx __rte_unused,
+		const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_vxlan *vxlan_spec = item->spec;
+	const struct rte_flow_item_vxlan *vxlan_mask = item->mask;
+
+	/* spec/mask are optional */
+	if (vxlan_spec == NULL && vxlan_mask == NULL)
+		return 0;
+
+	/* VNI must be fully masked */
+	if (!CI_FIELD_IS_MASKED(&vxlan_mask->hdr.vni)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid VXLAN mask");
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_node_vxlan_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct rte_flow_item_vxlan *vxlan_spec = item->spec;
+	const struct rte_flow_item_vxlan *vxlan_mask = item->mask;
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	/* spec/mask are optional */
+	if (vxlan_spec == NULL && vxlan_mask == NULL)
+		return 0;
+
+	/* Store the VNI and set filter flag */
+	tunnel_filter->tenant_id = ci_be24_to_cpu(vxlan_spec->hdr.vni);
+	tunnel_filter->filter_type |= RTE_ETH_TUNNEL_FILTER_TENID;
+
+	return 0;
+}
+
+static int
+i40e_tunnel_node_end_validate(const void *ctx,
+		const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	const struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	/* this shouldn't happen but check this just in case */
+	if (i40e_check_tunnel_filter_type(tunnel_filter->filter_type) != 0) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid tunnel filter configuration");
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_vxlan_node_end_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	tunnel_filter->tunnel_type = I40E_TUNNEL_TYPE_VXLAN;
+
+	return 0;
+}
+
+static const struct flow_graph i40e_tunnel_vxlan_graph = {
+	.nodes = (struct flow_graph_node[]) {
+		[I40E_TUNNEL_VXLAN_NODE_START] = {
+			.name = "START",
+		},
+		[I40E_TUNNEL_VXLAN_NODE_OUTER_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+			               FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_eth_validate,
+			.process = i40e_tunnel_node_outer_eth_process,
+		},
+		[I40E_TUNNEL_VXLAN_NODE_IPV4] = {
+			.name = "IPv4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv4_process,
+		},
+		[I40E_TUNNEL_VXLAN_NODE_IPV6] = {
+			.name = "IPv6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv6_process,
+		},
+		[I40E_TUNNEL_VXLAN_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[I40E_TUNNEL_VXLAN_NODE_VXLAN] = {
+			.name = "VXLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VXLAN,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+			               FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_vxlan_validate,
+			.process = i40e_tunnel_node_vxlan_process,
+		},
+		[I40E_TUNNEL_VXLAN_NODE_INNER_ETH] = {
+			.name = "INNER_ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+			               FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_eth_validate,
+			.process = i40e_tunnel_node_inner_eth_process,
+		},
+		[I40E_TUNNEL_VXLAN_NODE_INNER_VLAN] = {
+			.name = "INNER_VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_vlan_validate,
+			.process = i40e_tunnel_node_inner_vlan_process,
+		},
+		[I40E_TUNNEL_VXLAN_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+			.validate = i40e_tunnel_node_end_validate,
+			.process = i40e_tunnel_vxlan_node_end_process
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[I40E_TUNNEL_VXLAN_NODE_START] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_VXLAN_NODE_OUTER_ETH,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_VXLAN_NODE_OUTER_ETH] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_VXLAN_NODE_IPV4,
+				I40E_TUNNEL_VXLAN_NODE_IPV6,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_VXLAN_NODE_IPV4] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_VXLAN_NODE_UDP,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_VXLAN_NODE_IPV6] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_VXLAN_NODE_UDP,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_VXLAN_NODE_UDP] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_VXLAN_NODE_VXLAN,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_VXLAN_NODE_VXLAN] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_VXLAN_NODE_INNER_ETH,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_VXLAN_NODE_INNER_ETH] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_VXLAN_NODE_INNER_VLAN,
+				I40E_TUNNEL_VXLAN_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_VXLAN_NODE_INNER_VLAN] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_VXLAN_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+/**
+ * NVGRE tunnel filter graph implementation
+ * Pattern: START -> ETH -> (IPv4 | IPv6) -> NVGRE -> ETH -> [VLAN] -> END
+ */
+enum i40e_tunnel_nvgre_node_id {
+	I40E_TUNNEL_NVGRE_NODE_START  = FLOW_GRAPH_NODE_FIRST,
+	I40E_TUNNEL_NVGRE_NODE_OUTER_ETH,
+	I40E_TUNNEL_NVGRE_NODE_IPV4,
+	I40E_TUNNEL_NVGRE_NODE_IPV6,
+	I40E_TUNNEL_NVGRE_NODE_NVGRE,
+	I40E_TUNNEL_NVGRE_NODE_INNER_ETH,
+	I40E_TUNNEL_NVGRE_NODE_INNER_VLAN,
+	I40E_TUNNEL_NVGRE_NODE_END,
+	I40E_TUNNEL_NVGRE_NODE_MAX,
+};
+
+static int
+i40e_tunnel_node_nvgre_validate(const void *ctx __rte_unused,
+		const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_nvgre *nvgre_spec = item->spec;
+	const struct rte_flow_item_nvgre *nvgre_mask = item->mask;
+
+	/* spec/mask are optional */
+	if (nvgre_spec == NULL && nvgre_mask == NULL)
+		return 0;
+
+	/* TNI must be fully masked */
+	if (!CI_FIELD_IS_MASKED(&nvgre_mask->tni)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM_MASK, item,
+				"Invalid NVGRE mask");
+	}
+	/* protocol must either be unmasked or fully masked */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&nvgre_mask->protocol)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM_MASK, item,
+				"Invalid NVGRE mask");
+	}
+	/* reserved/version field must either be unmasked or fully masked */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&nvgre_mask->c_k_s_rsvd0_ver)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM_MASK, item,
+				"Invalid NVGRE mask");
+	}
+	/* if reserved/version field is masked, it must be set to 0x2000 */
+	if (nvgre_mask->c_k_s_rsvd0_ver &&
+			nvgre_spec->c_k_s_rsvd0_ver != rte_cpu_to_be_16(0x2000)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM_MASK, item,
+				"Invalid NVGRE spec");
+	}
+	/* if protocol field is masked, it must be set to 0x6558 */
+	if (nvgre_mask->protocol &&
+			nvgre_spec->protocol != rte_cpu_to_be_16(0x6558)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM_MASK, item,
+				"Invalid NVGRE spec");
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_node_nvgre_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct rte_flow_item_nvgre *nvgre_spec = item->spec;
+	const struct rte_flow_item_nvgre *nvgre_mask = item->mask;
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	/* spec/mask are optional */
+	if (nvgre_spec == NULL && nvgre_mask == NULL)
+		return 0;
+
+	/* Store the VNI and set filter flag */
+	tunnel_filter->tenant_id = ci_be24_to_cpu(nvgre_spec->tni);
+	tunnel_filter->filter_type |= RTE_ETH_TUNNEL_FILTER_TENID;
+
+	return 0;
+}
+
+static int
+i40e_tunnel_node_nvgre_end_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	tunnel_filter->tunnel_type = I40E_TUNNEL_TYPE_NVGRE;
+
+	return 0;
+}
+
+static const struct flow_graph i40e_tunnel_nvgre_graph = {
+	.nodes = (struct flow_graph_node[]) {
+		[I40E_TUNNEL_NVGRE_NODE_START] = {
+			.name = "START",
+		},
+		[I40E_TUNNEL_NVGRE_NODE_OUTER_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+			               FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_eth_validate,
+			.process = i40e_tunnel_node_outer_eth_process,
+		},
+		[I40E_TUNNEL_NVGRE_NODE_IPV4] = {
+			.name = "IPv4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv4_process,
+		},
+		[I40E_TUNNEL_NVGRE_NODE_IPV6] = {
+			.name = "IPv6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv6_process,
+		},
+		[I40E_TUNNEL_NVGRE_NODE_NVGRE] = {
+			.name = "NVGRE",
+			.type = RTE_FLOW_ITEM_TYPE_NVGRE,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+			               FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_nvgre_validate,
+			.process = i40e_tunnel_node_nvgre_process,
+		},
+		[I40E_TUNNEL_NVGRE_NODE_INNER_ETH] = {
+			.name = "INNER_ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+			               FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_eth_validate,
+			.process = i40e_tunnel_node_inner_eth_process,
+		},
+		[I40E_TUNNEL_NVGRE_NODE_INNER_VLAN] = {
+			.name = "INNER_VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_vlan_validate,
+			.process = i40e_tunnel_node_inner_vlan_process,
+		},
+		[I40E_TUNNEL_NVGRE_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+			.validate = i40e_tunnel_node_end_validate,
+			.process = i40e_tunnel_node_nvgre_end_process
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[I40E_TUNNEL_NVGRE_NODE_START] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_NVGRE_NODE_OUTER_ETH,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_NVGRE_NODE_OUTER_ETH] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_NVGRE_NODE_IPV4,
+				I40E_TUNNEL_NVGRE_NODE_IPV6,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_NVGRE_NODE_IPV4] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_NVGRE_NODE_NVGRE,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_NVGRE_NODE_IPV6] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_NVGRE_NODE_NVGRE,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_NVGRE_NODE_NVGRE] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_NVGRE_NODE_INNER_ETH,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_NVGRE_NODE_INNER_ETH] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_NVGRE_NODE_INNER_VLAN,
+				I40E_TUNNEL_NVGRE_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_NVGRE_NODE_INNER_VLAN] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_NVGRE_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+/**
+ * MPLS tunnel filter graph implementation
+ * Pattern: START -> ETH -> (IPv4 | IPv6) -> (UDP | GRE) -> MPLS -> END
+ */
+enum i40e_tunnel_mpls_node_id {
+	I40E_TUNNEL_MPLS_NODE_START  = FLOW_GRAPH_NODE_FIRST,
+	I40E_TUNNEL_MPLS_NODE_ETH,
+	I40E_TUNNEL_MPLS_NODE_IPV4,
+	I40E_TUNNEL_MPLS_NODE_IPV6,
+	I40E_TUNNEL_MPLS_NODE_UDP,
+	I40E_TUNNEL_MPLS_NODE_GRE,
+	I40E_TUNNEL_MPLS_NODE_MPLS,
+	I40E_TUNNEL_MPLS_NODE_END,
+	I40E_TUNNEL_MPLS_NODE_MAX,
+};
+
+static int
+i40e_tunnel_mpls_node_udp_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	tunnel_filter->tunnel_type = I40E_TUNNEL_TYPE_MPLSoUDP;
+
+	return 0;
+}
+
+static int
+i40e_tunnel_mpls_node_gre_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	tunnel_filter->tunnel_type = I40E_TUNNEL_TYPE_MPLSoGRE;
+
+	return 0;
+}
+
+static int
+i40e_tunnel_node_mpls_validate(const void *ctx __rte_unused,
+		const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_mpls *mpls_mask = item->mask;
+	const uint8_t label_mask[3] = {0xFF, 0xFF, 0xF0};
+
+	/* MPLS label and TC must be fully masked */
+	if (memcmp(mpls_mask->label_tc_s, label_mask, 3)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid MPLS mask");
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_node_mpls_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct rte_flow_item_mpls *mpls_spec = item->spec;
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	tunnel_filter->tenant_id = ci_be24_to_cpu(mpls_spec->label_tc_s) >> 4;
+
+	return 0;
+}
+
+static const struct flow_graph i40e_tunnel_mpls_graph = {
+	.nodes = (struct flow_graph_node[]) {
+		[I40E_TUNNEL_MPLS_NODE_START] = {
+			.name = "START",
+		},
+		[I40E_TUNNEL_MPLS_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[I40E_TUNNEL_MPLS_NODE_IPV4] = {
+			.name = "IPv4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv4_process,
+		},
+		[I40E_TUNNEL_MPLS_NODE_IPV6] = {
+			.name = "IPv6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv6_process,
+		},
+		[I40E_TUNNEL_MPLS_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_mpls_node_udp_process,
+		},
+		[I40E_TUNNEL_MPLS_NODE_GRE] = {
+			.name = "GRE",
+			.type = RTE_FLOW_ITEM_TYPE_GRE,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_mpls_node_gre_process,
+		},
+		[I40E_TUNNEL_MPLS_NODE_MPLS] = {
+			.name = "MPLS",
+			.type = RTE_FLOW_ITEM_TYPE_MPLS,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_mpls_validate,
+			.process = i40e_tunnel_node_mpls_process,
+		},
+		[I40E_TUNNEL_MPLS_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[I40E_TUNNEL_MPLS_NODE_START] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_MPLS_NODE_ETH,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_MPLS_NODE_ETH] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_MPLS_NODE_IPV4,
+				I40E_TUNNEL_MPLS_NODE_IPV6,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_MPLS_NODE_IPV4] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_MPLS_NODE_UDP,
+				I40E_TUNNEL_MPLS_NODE_GRE,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_MPLS_NODE_IPV6] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_MPLS_NODE_UDP,
+				I40E_TUNNEL_MPLS_NODE_GRE,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_MPLS_NODE_UDP] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_MPLS_NODE_MPLS,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_MPLS_NODE_GRE] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_MPLS_NODE_MPLS,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_MPLS_NODE_MPLS] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_MPLS_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+/**
+ * GTP tunnel filter graph implementation
+ * Pattern: START -> ETH -> (IPv4 | IPv6) -> UDP -> (GTPC | GTPU) -> END
+ */
+enum i40e_tunnel_gtp_node_id {
+	I40E_TUNNEL_GTP_NODE_START  = FLOW_GRAPH_NODE_FIRST,
+	I40E_TUNNEL_GTP_NODE_ETH,
+	I40E_TUNNEL_GTP_NODE_IPV4,
+	I40E_TUNNEL_GTP_NODE_IPV6,
+	I40E_TUNNEL_GTP_NODE_UDP,
+	I40E_TUNNEL_GTP_NODE_GTPC,
+	I40E_TUNNEL_GTP_NODE_GTPU,
+	I40E_TUNNEL_GTP_NODE_END,
+	I40E_TUNNEL_GTP_NODE_MAX,
+};
+
+static int
+i40e_tunnel_node_gtp_validate(const void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_gtp *gtp_mask = item->mask;
+	const struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	const struct rte_eth_dev_data *dev_data = tunnel_ctx->base.dev_data;
+	const struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev_data->dev_private);
+
+	/* does HW support GTP? */
+	if (!pf->gtp_support) {
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"GTP not supported");
+	}
+
+	/* reject unsupported fields */
+	if (gtp_mask->hdr.gtp_hdr_info ||
+	    gtp_mask->hdr.msg_type ||
+	    gtp_mask->hdr.plen) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid GTP mask");
+	}
+
+	/* teid must be fully masked */
+	if (!CI_FIELD_IS_MASKED(&gtp_mask->hdr.teid)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid GTP mask");
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_node_gtp_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_gtp *gtp_spec = item->spec;
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	if (item->type == RTE_FLOW_ITEM_TYPE_GTPC)
+		tunnel_filter->tunnel_type = I40E_TUNNEL_TYPE_GTPC;
+	else if (item->type == RTE_FLOW_ITEM_TYPE_GTPU)
+		tunnel_filter->tunnel_type = I40E_TUNNEL_TYPE_GTPU;
+	else {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid GTP item type");
+	}
+	tunnel_filter->tenant_id = rte_be_to_cpu_32(gtp_spec->hdr.teid);
+
+	return 0;
+}
+
+static const struct flow_graph i40e_tunnel_gtp_graph = {
+	.nodes = (struct flow_graph_node[]) {
+		[I40E_TUNNEL_GTP_NODE_START] = {
+			.name = "START",
+		},
+		[I40E_TUNNEL_GTP_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[I40E_TUNNEL_GTP_NODE_IPV4] = {
+			.name = "IPv4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv4_process,
+		},
+		[I40E_TUNNEL_GTP_NODE_IPV6] = {
+			.name = "IPv6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv6_process,
+		},
+		[I40E_TUNNEL_GTP_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[I40E_TUNNEL_GTP_NODE_GTPC] = {
+			.name = "GTPC",
+			.type = RTE_FLOW_ITEM_TYPE_GTPC,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_gtp_validate,
+			.process = i40e_tunnel_node_gtp_process,
+		},
+		[I40E_TUNNEL_GTP_NODE_GTPU] = {
+			.name = "GTPU",
+			.type = RTE_FLOW_ITEM_TYPE_GTPU,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_gtp_validate,
+			.process = i40e_tunnel_node_gtp_process,
+		},
+		[I40E_TUNNEL_GTP_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[I40E_TUNNEL_GTP_NODE_START] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_GTP_NODE_ETH,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_GTP_NODE_ETH] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_GTP_NODE_IPV4,
+				I40E_TUNNEL_GTP_NODE_IPV6,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_GTP_NODE_IPV4] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_GTP_NODE_UDP,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_GTP_NODE_IPV6] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_GTP_NODE_UDP,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_GTP_NODE_UDP] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_GTP_NODE_GTPC,
+				I40E_TUNNEL_GTP_NODE_GTPU,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_GTP_NODE_GTPC] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_GTP_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_GTP_NODE_GTPU] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_GTP_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+/**
+ * L4 tunnel filter graph implementation
+ * Pattern: START -> ETH -> (IPv4 | IPv6) -> (TCP | UDP | SCTP) -> END
+ */
+enum i40e_tunnel_l4_node_id {
+	I40E_TUNNEL_L4_NODE_START  = FLOW_GRAPH_NODE_FIRST,
+	I40E_TUNNEL_L4_NODE_ETH,
+	I40E_TUNNEL_L4_NODE_IPV4,
+	I40E_TUNNEL_L4_NODE_IPV6,
+	I40E_TUNNEL_L4_NODE_TCP,
+	I40E_TUNNEL_L4_NODE_UDP,
+	I40E_TUNNEL_L4_NODE_SCTP,
+	I40E_TUNNEL_L4_NODE_END,
+	I40E_TUNNEL_L4_NODE_MAX,
+};
+
+static int
+i40e_tunnel_node_tcp_validate(const void *ctx __rte_unused,
+		const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_tcp *tcp_mask = item->mask;
+
+	/* only source/destination ports are supported */
+	if (tcp_mask->hdr.sent_seq ||
+	    tcp_mask->hdr.recv_ack ||
+	    tcp_mask->hdr.data_off ||
+	    tcp_mask->hdr.tcp_flags ||
+	    tcp_mask->hdr.rx_win ||
+	    tcp_mask->hdr.cksum ||
+	    tcp_mask->hdr.tcp_urp) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid TCP mask");
+	}
+
+	/* src/dst ports have to be fully masked or fully unmasked */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&tcp_mask->hdr.src_port) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&tcp_mask->hdr.dst_port)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid TCP mask");
+	}
+	/* there can be only one! */
+	if (tcp_mask->hdr.src_port && tcp_mask->hdr.dst_port) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid TCP mask");
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_node_tcp_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+	const struct rte_flow_item_tcp *tcp_spec = item->spec;
+	const struct rte_flow_item_tcp *tcp_mask = item->mask;
+
+	if (tcp_mask->hdr.src_port) {
+		tunnel_filter->l4_port_type = I40E_L4_PORT_TYPE_SRC;
+		tunnel_filter->tenant_id = rte_be_to_cpu_32(tcp_spec->hdr.src_port);
+	} else if (tcp_mask->hdr.dst_port) {
+		tunnel_filter->l4_port_type = I40E_L4_PORT_TYPE_DST;
+		tunnel_filter->tenant_id = rte_be_to_cpu_32(tcp_spec->hdr.dst_port);
+	}
+	tunnel_filter->tunnel_type = I40E_CLOUD_TYPE_TCP;
+
+	return 0;
+}
+
+static int
+i40e_tunnel_node_udp_validate(const void *ctx __rte_unused,
+		const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_udp *udp_mask = item->mask;
+
+	/* only source/destination ports are supported */
+	if (udp_mask->hdr.dgram_len ||
+	    udp_mask->hdr.dgram_cksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid UDP mask");
+	}
+
+	/* src/dst ports have to be fully masked or fully unmasked */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&udp_mask->hdr.src_port) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&udp_mask->hdr.dst_port)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid UDP mask");
+	}
+	/* there can be only one! */
+	if (udp_mask->hdr.src_port && udp_mask->hdr.dst_port) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid UDP mask");
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_node_udp_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+	const struct rte_flow_item_udp *udp_spec = item->spec;
+	const struct rte_flow_item_udp *udp_mask = item->mask;
+
+	if (udp_mask->hdr.src_port) {
+		tunnel_filter->l4_port_type = I40E_L4_PORT_TYPE_SRC;
+		tunnel_filter->tenant_id = rte_be_to_cpu_32(udp_spec->hdr.src_port);
+	} else if (udp_mask->hdr.dst_port) {
+		tunnel_filter->l4_port_type = I40E_L4_PORT_TYPE_DST;
+		tunnel_filter->tenant_id = rte_be_to_cpu_32(udp_spec->hdr.dst_port);
+	}
+	tunnel_filter->tunnel_type = I40E_CLOUD_TYPE_UDP;
+
+	return 0;
+}
+
+static int
+i40e_tunnel_node_sctp_validate(const void *ctx __rte_unused,
+		const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_sctp *sctp_mask = item->mask;
+
+	/* only source/destination ports are supported */
+	if (sctp_mask->hdr.cksum || sctp_mask->hdr.tag) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid SCTP mask");
+	}
+
+	/* src/dst ports have to be fully masked or fully unmasked */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&sctp_mask->hdr.src_port) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&sctp_mask->hdr.dst_port)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid SCTP mask");
+	}
+	/* there can be only one! */
+	if (sctp_mask->hdr.src_port && sctp_mask->hdr.dst_port) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid SCTP mask");
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_node_sctp_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+	const struct rte_flow_item_sctp *sctp_spec = item->spec;
+	const struct rte_flow_item_sctp *sctp_mask = item->mask;
+
+	if (sctp_mask->hdr.src_port) {
+		tunnel_filter->l4_port_type = I40E_L4_PORT_TYPE_SRC;
+		tunnel_filter->tenant_id = rte_be_to_cpu_32(sctp_spec->hdr.src_port);
+	} else if (sctp_mask->hdr.dst_port) {
+		tunnel_filter->l4_port_type = I40E_L4_PORT_TYPE_DST;
+		tunnel_filter->tenant_id = rte_be_to_cpu_32(sctp_spec->hdr.dst_port);
+	}
+	tunnel_filter->tunnel_type = I40E_CLOUD_TYPE_SCTP;
+
+	return 0;
+}
+
+static const struct flow_graph i40e_tunnel_l4_graph = {
+	.nodes = (struct flow_graph_node[]) {
+		[I40E_TUNNEL_L4_NODE_START] = {
+			.name = "START",
+		},
+		[I40E_TUNNEL_L4_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[I40E_TUNNEL_L4_NODE_IPV4] = {
+			.name = "IPv4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv4_process,
+		},
+		[I40E_TUNNEL_L4_NODE_IPV6] = {
+			.name = "IPv6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv6_process,
+		},
+		[I40E_TUNNEL_L4_NODE_TCP] = {
+			.name = "TCP",
+			.type = RTE_FLOW_ITEM_TYPE_TCP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_tcp_validate,
+			.process = i40e_tunnel_node_tcp_process,
+		},
+		[I40E_TUNNEL_L4_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_udp_validate,
+			.process = i40e_tunnel_node_udp_process,
+		},
+		[I40E_TUNNEL_L4_NODE_SCTP] = {
+			.name = "SCTP",
+			.type = RTE_FLOW_ITEM_TYPE_SCTP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_sctp_validate,
+			.process = i40e_tunnel_node_sctp_process,
+		},
+		[I40E_TUNNEL_L4_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[I40E_TUNNEL_L4_NODE_START] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_L4_NODE_ETH,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_L4_NODE_ETH] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_L4_NODE_IPV4,
+				I40E_TUNNEL_L4_NODE_IPV6,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_L4_NODE_IPV4] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_L4_NODE_TCP,
+				I40E_TUNNEL_L4_NODE_UDP,
+				I40E_TUNNEL_L4_NODE_SCTP,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_L4_NODE_IPV6] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_L4_NODE_TCP,
+				I40E_TUNNEL_L4_NODE_UDP,
+				I40E_TUNNEL_L4_NODE_SCTP,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_L4_NODE_TCP] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_L4_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_L4_NODE_UDP] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_L4_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_L4_NODE_SCTP] = {
+			.next = (size_t[]) {
+				I40E_TUNNEL_L4_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static int
+i40e_tunnel_action_check(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(param->driver_ctx);
+	const struct rte_flow_action *first, *second;
+	const struct rte_flow_action_queue *act_q;
+	bool is_to_vf = false;
+
+	first = actions->actions[0];
+	/* can be NULL */
+	second = actions->actions[1];
+
+	/* first action must be PF or VF */
+	if (first->type == RTE_FLOW_ACTION_TYPE_VF) {
+		const struct rte_flow_action_vf *vf = first->conf;
+		if (vf->id >= pf->vf_num) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, first,
+					"Invalid VF ID for tunnel filter");
+		}
+		is_to_vf = true;
+	} else if (first->type != RTE_FLOW_ACTION_TYPE_PF) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, first,
+				"Unsupported action");
+	}
+
+	/* check if second action is QUEUE */
+	if (second == NULL)
+		return 0;
+
+	if (second->type != RTE_FLOW_ACTION_TYPE_QUEUE) {
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_ACTION, second,
+					  "Unsupported action");
+	}
+
+	act_q = second->conf;
+	/* check queue ID for PF flow */
+	if (!is_to_vf && act_q->index >= pf->dev_data->nb_rx_queues) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, act_q,
+				"Invalid queue ID for tunnel filter");
+	}
+	/* check queue ID for VF flow */
+	if (is_to_vf && act_q->index >= pf->vf_nb_qps) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, act_q,
+				"Invalid queue ID for tunnel filter");
+	}
+
+	return 0;
+}
+
+static int
+i40e_tunnel_ctx_init(const struct rte_flow_action actions[],
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = (struct i40e_tunnel_ctx *)ctx;
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param ac_param = {
+		.allowed_types = (enum rte_flow_action_type[]) {
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_PF,
+			RTE_FLOW_ACTION_TYPE_VF,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 2,
+		.check = i40e_tunnel_action_check,
+		.driver_ctx = ctx->dev_data->dev_private,
+	};
+	const struct rte_flow_action *first, *second;
+	const struct rte_flow_action_queue *act_q;
+	int ret;
+
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
+
+	ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
+	first = parsed_actions.actions[0];
+	/* can be NULL */
+	second = parsed_actions.actions[1];
+
+	if (first->type == RTE_FLOW_ACTION_TYPE_VF) {
+		const struct rte_flow_action_vf *vf = first->conf;
+		tunnel_ctx->filter.vf_id = vf->id;
+		tunnel_ctx->filter.is_to_vf = 1;
+	} else if (first->type == RTE_FLOW_ACTION_TYPE_PF) {
+		tunnel_ctx->filter.is_to_vf = 0;
+	}
+
+	/* check if second action is QUEUE */
+	if (second == NULL)
+		return 0;
+
+	act_q = second->conf;
+	tunnel_ctx->filter.queue_id = act_q->index;
+
+	return 0;
+}
+
+static int
+i40e_tunnel_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	const struct i40e_tunnel_ctx *tunnel_ctx = (const struct i40e_tunnel_ctx *)ctx;
+	struct i40e_tunnel_flow *tunnel_flow = (struct i40e_tunnel_flow *)flow;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(flow->dev_data->dev_private);
+	int ret;
+
+	/* copy filter configuration from context to flow */
+	tunnel_flow->filter = tunnel_ctx->filter;
+
+	/* compute hash input */
+	ret = i40e_tunnel_filter_match_key_get(pf, &tunnel_flow->filter,
+			&tunnel_flow->match_key);
+	if (ret != 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to build tunnel filter input");
+	}
+
+	return 0;
+}
+
+static int
+i40e_tunnel_flow_register(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct i40e_tunnel_flow *tunnel_flow = (struct i40e_tunnel_flow *)flow;
+	struct i40e_tunnel_priv *priv = flow->engine_priv;
+	struct i40e_tunnel_state *state = priv->state;
+	int ret;
+
+	if (rte_hash_lookup(state->hash_table, &tunnel_flow->match_key) >= 0) {
+		return rte_flow_error_set(error, EEXIST,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Conflict with existing tunnel rule");
+	}
+
+	ret = rte_hash_add_key(state->hash_table, &tunnel_flow->match_key);
+	if (ret < 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Tunnel filter table is full");
+	}
+
+	return 0;
+}
+
+static int
+i40e_tunnel_flow_unregister(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct i40e_tunnel_flow *tunnel_flow = (struct i40e_tunnel_flow *)flow;
+	struct i40e_tunnel_priv *priv = flow->engine_priv;
+	struct i40e_tunnel_state *state = priv->state;
+
+	if (rte_hash_del_key(state->hash_table, &tunnel_flow->match_key) < 0) {
+		return rte_flow_error_set(error, ENOENT,
+				RTE_FLOW_ERROR_TYPE_HANDLE, flow,
+				"Tunnel filter is missing from the filter table");
+	}
+
+	return 0;
+}
+
+static int
+i40e_tunnel_flow_install(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(flow->dev_data->dev_private);
+	struct i40e_tunnel_flow *tunnel_flow = (struct i40e_tunnel_flow *)flow;
+	int ret;
+
+	ret = i40e_tunnel_filter_program(pf, &tunnel_flow->filter, 1);
+	if (ret) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, flow,
+				"Failed to install tunnel filter");
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_flow_uninstall(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(flow->dev_data->dev_private);
+	struct i40e_tunnel_flow *tunnel_flow = (struct i40e_tunnel_flow *)flow;
+	int ret;
+
+	ret = i40e_tunnel_filter_program(pf, &tunnel_flow->filter, 0);
+	if (ret) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, flow,
+				"Failed to uninstall tunnel filter");
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_flow_engine_init(const struct ci_flow_engine *engine __rte_unused,
+		struct rte_eth_dev_data *dev_data,
+		void *priv)
+{
+	struct i40e_tunnel_priv *tunnel_priv = priv;
+
+	tunnel_priv->state = i40e_tunnel_state_attach(dev_data);
+	return tunnel_priv->state == NULL ? -ENOMEM : 0;
+}
+
+static void
+i40e_tunnel_flow_engine_uninit(const struct ci_flow_engine *engine __rte_unused,
+		void *priv)
+{
+	struct i40e_tunnel_priv *tunnel_priv = priv;
+
+	i40e_tunnel_state_detach(tunnel_priv->state);
+}
+
+static const struct ci_flow_engine_ops i40e_flow_engine_tunnel_ops = {
+	.engine_init = i40e_tunnel_flow_engine_init,
+	.engine_uninit = i40e_tunnel_flow_engine_uninit,
+	.ctx_init = i40e_tunnel_ctx_init,
+	.ctx_to_flow = i40e_tunnel_ctx_to_flow,
+	.flow_register = i40e_tunnel_flow_register,
+	.flow_unregister = i40e_tunnel_flow_unregister,
+	.flow_install = i40e_tunnel_flow_install,
+	.flow_uninstall = i40e_tunnel_flow_uninstall,
+};
+
+const struct ci_flow_engine i40e_flow_engine_tunnel_nvgre = {
+	.name = "i40e_tunnel_nvgre",
+	.ops = &i40e_flow_engine_tunnel_ops,
+	.ctx_size = sizeof(struct i40e_tunnel_ctx),
+	.flow_size = sizeof(struct i40e_tunnel_flow),
+	.priv_size = sizeof(struct i40e_tunnel_priv),
+	.graph = &i40e_tunnel_nvgre_graph,
+};
+
+const struct ci_flow_engine i40e_flow_engine_tunnel_vxlan = {
+	.name = "i40e_tunnel_vxlan",
+	.ops = &i40e_flow_engine_tunnel_ops,
+	.ctx_size = sizeof(struct i40e_tunnel_ctx),
+	.flow_size = sizeof(struct i40e_tunnel_flow),
+	.priv_size = sizeof(struct i40e_tunnel_priv),
+	.graph = &i40e_tunnel_vxlan_graph,
+};
+
+const struct ci_flow_engine i40e_flow_engine_tunnel_mpls = {
+	.name = "i40e_tunnel_mpls",
+	.ops = &i40e_flow_engine_tunnel_ops,
+	.ctx_size = sizeof(struct i40e_tunnel_ctx),
+	.flow_size = sizeof(struct i40e_tunnel_flow),
+	.priv_size = sizeof(struct i40e_tunnel_priv),
+	.graph = &i40e_tunnel_mpls_graph,
+};
+
+const struct ci_flow_engine i40e_flow_engine_tunnel_gtp = {
+	.name = "i40e_tunnel_gtp",
+	.ops = &i40e_flow_engine_tunnel_ops,
+	.ctx_size = sizeof(struct i40e_tunnel_ctx),
+	.flow_size = sizeof(struct i40e_tunnel_flow),
+	.priv_size = sizeof(struct i40e_tunnel_priv),
+	.graph = &i40e_tunnel_gtp_graph,
+};
+
+const struct ci_flow_engine i40e_flow_engine_tunnel_l4 = {
+	.name = "i40e_tunnel_l4",
+	.ops = &i40e_flow_engine_tunnel_ops,
+	.ctx_size = sizeof(struct i40e_tunnel_ctx),
+	.flow_size = sizeof(struct i40e_tunnel_flow),
+	.priv_size = sizeof(struct i40e_tunnel_priv),
+	.graph = &i40e_tunnel_l4_graph,
+};
+
+const struct ci_flow_engine i40e_flow_engine_tunnel_qinq = {
+	.name = "i40e_tunnel_qinq",
+	.ops = &i40e_flow_engine_tunnel_ops,
+	.ctx_size = sizeof(struct i40e_tunnel_ctx),
+	.flow_size = sizeof(struct i40e_tunnel_flow),
+	.priv_size = sizeof(struct i40e_tunnel_priv),
+	.graph = &i40e_tunnel_qinq_graph,
+};
diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
index c07257cb807..0db60c1e99e 100644
--- a/drivers/net/intel/i40e/meson.build
+++ b/drivers/net/intel/i40e/meson.build
@@ -35,6 +35,7 @@ sources += files(
         'i40e_flow.c',
         'i40e_flow_ethertype.c',
         'i40e_flow_fdir.c',
+        'i40e_flow_tunnel.c',
         'i40e_tm.c',
         'i40e_hash.c',
         'i40e_vf_representor.c',
-- 
2.52.0

