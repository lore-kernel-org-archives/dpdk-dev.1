Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BD4CD5BAB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 16:09:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B12C4066E;
	Tue, 19 May 2026 18:08:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 2DFC0402F0
 for <dev@dpdk.org>; Tue, 19 May 2026 18:08:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779206920; x=1810742920;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eEMDnvPP2kQ/iFQZbLrwhqELVsdKWv55JAWFxn/g/gI=;
 b=WmzqMb2fo3GmhYKTC+rA61/1kNSR7IEpDbUYzuA4QoLN3MhpQkHztpQk
 KZhHbeRPB1a2jHEIxf24TkD75oi6WprAH09rb/8ueA3u1nsNpdLtwmKkK
 uP1A1IdVzRbsU6D1xt7MRJnLfQsFajyU9cMFuTlsxOY5jJqnxebQLQlea
 lBNuB8o3cg/j/0RgQ9ZSKLYySQhtXw3fRXH5HXbmnrshmcBPT+ZA9/GCw
 NIRIyqD7BCnNd8cI8zKZgqG6zf9W8U1CiiBMoZuAxaeO0XgKD1P95NWSs
 igP7vYHwarlIzruTbXgcPBQwtZM21dON6Uki0AElDuBPjViNQg/vJtqn2 A==;
X-CSE-ConnectionGUID: 541XEinjQ8e417h9EbgTbw==
X-CSE-MsgGUID: R4q+5KWDTam8q+vx2ukQNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80070051"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80070051"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 09:08:39 -0700
X-CSE-ConnectionGUID: NX2DE9LyRiSCBgNvuvVuvA==
X-CSE-MsgGUID: 8O1aeVr6TqmCD4+RykjC3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="244784777"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.20.224.247])
 by orviesa005.jf.intel.com with ESMTP; 19 May 2026 09:08:38 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 3/8] net/i40e: replace use of DPDK-specific memcpy function
Date: Tue, 19 May 2026 16:06:00 +0000
Message-ID: <20260519160823.1004973-4-bruce.richardson@intel.com>
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
 drivers/net/intel/i40e/base/i40e_osdep.h |  3 +-
 drivers/net/intel/i40e/i40e_ethdev.c     | 57 ++++++++++++------------
 drivers/net/intel/i40e/i40e_fdir.c       | 18 ++++----
 drivers/net/intel/i40e/i40e_flow.c       | 26 +++++------
 drivers/net/intel/i40e/i40e_pf.c         |  3 +-
 drivers/net/intel/i40e/i40e_tm.c         |  6 +--
 drivers/net/intel/i40e/rte_pmd_i40e.c    | 20 ++++-----
 7 files changed, 65 insertions(+), 68 deletions(-)

diff --git a/drivers/net/intel/i40e/base/i40e_osdep.h b/drivers/net/intel/i40e/base/i40e_osdep.h
index 197f4678bf..9c5a94f055 100644
--- a/drivers/net/intel/i40e/base/i40e_osdep.h
+++ b/drivers/net/intel/i40e/base/i40e_osdep.h
@@ -12,7 +12,6 @@
 #include <stdarg.h>
 
 #include <rte_common.h>
-#include <rte_memcpy.h>
 #include <rte_byteorder.h>
 #include <rte_cycles.h>
 #include <rte_spinlock.h>
@@ -226,7 +225,7 @@ struct i40e_spinlock {
 #define I40E_HTONL(a) rte_cpu_to_be_32(a)
 
 #define i40e_memset(a, b, c, d) memset((a), (b), (c))
-#define i40e_memcpy(a, b, c, d) rte_memcpy((a), (b), (c))
+#define i40e_memcpy(a, b, c, d) memcpy((a), (b), (c))
 
 #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
 #define DELAY(x) rte_delay_us_sleep(x)
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 100a751225..adc8502736 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -23,7 +23,6 @@
 #include <ethdev_pci.h>
 #include <rte_memzone.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_alarm.h>
 #include <dev_driver.h>
 #include <rte_tailq.h>
@@ -4468,7 +4467,7 @@ i40e_macaddr_add(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	rte_memcpy(&mac_filter.mac_addr, mac_addr, RTE_ETHER_ADDR_LEN);
+	memcpy(&mac_filter.mac_addr, mac_addr, RTE_ETHER_ADDR_LEN);
 	if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_FILTER)
 		mac_filter.filter_type = I40E_MACVLAN_PERFECT_MATCH;
 	else
@@ -5335,7 +5334,7 @@ i40e_vsi_vlan_pvid_set(struct i40e_vsi *vsi,
 	vsi->info.valid_sections =
 		rte_cpu_to_le_16(I40E_AQ_VSI_PROP_VLAN_VALID);
 	memset(&ctxt, 0, sizeof(ctxt));
-	rte_memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
+	memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
 	ctxt.seid = vsi->seid;
 
 	hw = I40E_VSI_TO_HW(vsi);
@@ -5374,7 +5373,7 @@ i40e_vsi_update_tc_bandwidth(struct i40e_vsi *vsi, uint8_t enabled_tcmap)
 		return ret;
 	}
 
-	rte_memcpy(vsi->info.qs_handle, tc_bw_data.qs_handles,
+	memcpy(vsi->info.qs_handle, tc_bw_data.qs_handles,
 					sizeof(vsi->info.qs_handle));
 	return I40E_SUCCESS;
 }
@@ -5632,7 +5631,7 @@ i40e_update_default_filter_setting(struct i40e_vsi *vsi)
 	if (vsi->type != I40E_VSI_MAIN)
 		return I40E_ERR_CONFIG;
 	memset(&def_filter, 0, sizeof(def_filter));
-	rte_memcpy(def_filter.mac_addr, hw->mac.perm_addr,
+	memcpy(def_filter.mac_addr, hw->mac.perm_addr,
 					ETH_ADDR_LEN);
 	def_filter.vlan_tag = 0;
 	def_filter.flags = I40E_AQC_MACVLAN_DEL_PERFECT_MATCH |
@@ -5651,7 +5650,7 @@ i40e_update_default_filter_setting(struct i40e_vsi *vsi)
 			return I40E_ERR_NO_MEMORY;
 		}
 		mac = &f->mac_info.mac_addr;
-		rte_memcpy(&mac->addr_bytes, hw->mac.perm_addr,
+		memcpy(&mac->addr_bytes, hw->mac.perm_addr,
 				ETH_ADDR_LEN);
 		f->mac_info.filter_type = I40E_MACVLAN_PERFECT_MATCH;
 		TAILQ_INSERT_TAIL(&vsi->mac_list, f, next);
@@ -5659,7 +5658,7 @@ i40e_update_default_filter_setting(struct i40e_vsi *vsi)
 
 		return ret;
 	}
-	rte_memcpy(&filter.mac_addr,
+	memcpy(&filter.mac_addr,
 		(struct rte_ether_addr *)(hw->mac.perm_addr), ETH_ADDR_LEN);
 	filter.filter_type = I40E_MACVLAN_PERFECT_MATCH;
 	return i40e_vsi_add_mac(vsi, &filter);
@@ -6016,15 +6015,15 @@ i40e_vsi_setup(struct i40e_pf *pf,
 			goto fail_msix_alloc;
 		}
 
-		rte_memcpy(&vsi->info.tc_mapping, &ctxt.info.tc_mapping,
+		memcpy(&vsi->info.tc_mapping, &ctxt.info.tc_mapping,
 						sizeof(vsi->info.tc_mapping));
-		rte_memcpy(&vsi->info.queue_mapping,
+		memcpy(&vsi->info.queue_mapping,
 				&ctxt.info.queue_mapping,
 			sizeof(vsi->info.queue_mapping));
 		vsi->info.mapping_flags = ctxt.info.mapping_flags;
 		vsi->info.valid_sections = 0;
 
-		rte_memcpy(pf->dev_addr.addr_bytes, hw->mac.perm_addr,
+		memcpy(pf->dev_addr.addr_bytes, hw->mac.perm_addr,
 				ETH_ADDR_LEN);
 
 		/**
@@ -6168,7 +6167,7 @@ i40e_vsi_setup(struct i40e_pf *pf,
 
 	if (vsi->type != I40E_VSI_FDIR) {
 		/* MAC/VLAN configuration for non-FDIR VSI*/
-		rte_memcpy(&filter.mac_addr, &broadcast, RTE_ETHER_ADDR_LEN);
+		memcpy(&filter.mac_addr, &broadcast, RTE_ETHER_ADDR_LEN);
 		filter.filter_type = I40E_MACVLAN_PERFECT_MATCH;
 
 		ret = i40e_vsi_add_mac(vsi, &filter);
@@ -6276,7 +6275,7 @@ i40e_vsi_config_vlan_stripping(struct i40e_vsi *vsi, bool on)
 	vsi->info.port_vlan_flags &= ~(I40E_AQ_VSI_PVLAN_EMOD_MASK);
 	vsi->info.port_vlan_flags |= vlan_flags;
 	ctxt.seid = vsi->seid;
-	rte_memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
+	memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
 	ret = i40e_aq_update_vsi_params(hw, &ctxt, NULL);
 	if (ret)
 		PMD_DRV_LOG(INFO, "Update VSI failed to %s vlan stripping",
@@ -7138,7 +7137,7 @@ i40e_add_macvlan_filters(struct i40e_vsi *vsi,
 		memset(req_list, 0, ele_buff_size);
 
 		for (i = 0; i < actual_num; i++) {
-			rte_memcpy(req_list[i].mac_addr,
+			memcpy(req_list[i].mac_addr,
 				&filter[num + i].macaddr, ETH_ADDR_LEN);
 			req_list[i].vlan_tag =
 				rte_cpu_to_le_16(filter[num + i].vlan_id);
@@ -7211,7 +7210,7 @@ i40e_remove_macvlan_filters(struct i40e_vsi *vsi,
 		memset(req_list, 0, ele_buff_size);
 
 		for (i = 0; i < actual_num; i++) {
-			rte_memcpy(req_list[i].mac_addr,
+			memcpy(req_list[i].mac_addr,
 				&filter[num + i].macaddr, ETH_ADDR_LEN);
 			req_list[i].vlan_tag =
 				rte_cpu_to_le_16(filter[num + i].vlan_id);
@@ -7363,7 +7362,7 @@ i40e_find_all_vlan_for_mac(struct i40e_vsi *vsi,
 							"vlan number doesn't match");
 						return I40E_ERR_PARAM;
 					}
-					rte_memcpy(&mv_f[i].macaddr,
+					memcpy(&mv_f[i].macaddr,
 							addr, ETH_ADDR_LEN);
 					mv_f[i].vlan_id =
 						j * I40E_UINT32_BIT_SIZE + k;
@@ -7392,7 +7391,7 @@ i40e_find_all_mac_for_vlan(struct i40e_vsi *vsi,
 			PMD_DRV_LOG(ERR, "buffer number not match");
 			return I40E_ERR_PARAM;
 		}
-		rte_memcpy(&mv_f[i].macaddr, &f->mac_info.mac_addr,
+		memcpy(&mv_f[i].macaddr, &f->mac_info.mac_addr,
 				ETH_ADDR_LEN);
 		mv_f[i].vlan_id = vlan;
 		mv_f[i].filter_type = f->mac_info.filter_type;
@@ -7428,7 +7427,7 @@ i40e_vsi_remove_all_macvlan_filter(struct i40e_vsi *vsi)
 	i = 0;
 	if (vsi->vlan_num == 0) {
 		TAILQ_FOREACH(f, &vsi->mac_list, next) {
-			rte_memcpy(&mv_f[i].macaddr,
+			memcpy(&mv_f[i].macaddr,
 				&f->mac_info.mac_addr, ETH_ADDR_LEN);
 			mv_f[i].filter_type = f->mac_info.filter_type;
 			mv_f[i].vlan_id = 0;
@@ -7586,7 +7585,7 @@ i40e_vsi_add_mac(struct i40e_vsi *vsi, struct i40e_mac_filter_info *mac_filter)
 
 	for (i = 0; i < vlan_num; i++) {
 		mv_f[i].filter_type = mac_filter->filter_type;
-		rte_memcpy(&mv_f[i].macaddr, &mac_filter->mac_addr,
+		memcpy(&mv_f[i].macaddr, &mac_filter->mac_addr,
 				ETH_ADDR_LEN);
 	}
 
@@ -7609,7 +7608,7 @@ i40e_vsi_add_mac(struct i40e_vsi *vsi, struct i40e_mac_filter_info *mac_filter)
 		ret = I40E_ERR_NO_MEMORY;
 		goto DONE;
 	}
-	rte_memcpy(&f->mac_info.mac_addr, &mac_filter->mac_addr,
+	memcpy(&f->mac_info.mac_addr, &mac_filter->mac_addr,
 			ETH_ADDR_LEN);
 	f->mac_info.filter_type = mac_filter->filter_type;
 	TAILQ_INSERT_TAIL(&vsi->mac_list, f, next);
@@ -7656,7 +7655,7 @@ i40e_vsi_delete_mac(struct i40e_vsi *vsi, struct rte_ether_addr *addr)
 
 	for (i = 0; i < vlan_num; i++) {
 		mv_f[i].filter_type = filter_type;
-		rte_memcpy(&mv_f[i].macaddr, &f->mac_info.mac_addr,
+		memcpy(&mv_f[i].macaddr, &f->mac_info.mac_addr,
 				ETH_ADDR_LEN);
 	}
 	if (filter_type == I40E_MACVLAN_PERFECT_MATCH ||
@@ -7943,7 +7942,7 @@ i40e_tunnel_filter_convert(
 	tunnel_filter->input.flags = cld_filter->element.flags;
 	tunnel_filter->input.tenant_id = cld_filter->element.tenant_id;
 	tunnel_filter->queue = cld_filter->element.queue_number;
-	rte_memcpy(tunnel_filter->input.general_fields,
+	memcpy(tunnel_filter->input.general_fields,
 		   cld_filter->general_fields,
 		   sizeof(cld_filter->general_fields));
 
@@ -8481,7 +8480,7 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 		ip_type = I40E_AQC_ADD_CLOUD_FLAGS_IPV4;
 		ipv4_addr = rte_be_to_cpu_32(tunnel_filter->ip_addr.ipv4_addr);
 		ipv4_addr_le = rte_cpu_to_le_32(ipv4_addr);
-		rte_memcpy(&cld_filter.element.ipaddr.v4.data,
+		memcpy(&cld_filter.element.ipaddr.v4.data,
 				&ipv4_addr_le,
 				sizeof(cld_filter.element.ipaddr.v4.data));
 	} else {
@@ -8491,7 +8490,7 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 			rte_cpu_to_le_32(rte_be_to_cpu_32(
 					 tunnel_filter->ip_addr.ipv6_addr[i]));
 		}
-		rte_memcpy(&cld_filter.element.ipaddr.v6.data,
+		memcpy(&cld_filter.element.ipaddr.v6.data,
 			   &convert_ipv6,
 			   sizeof(cld_filter.element.ipaddr.v6.data));
 	}
@@ -8733,7 +8732,7 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 			return -ENOMEM;
 		}
 
-		rte_memcpy(tunnel, &check_filter, sizeof(check_filter));
+		memcpy(tunnel, &check_filter, sizeof(check_filter));
 		ret = i40e_sw_tunnel_filter_insert(pf, tunnel);
 		if (ret < 0)
 			rte_free(tunnel);
@@ -9855,7 +9854,7 @@ static int
 i40e_ethertype_filter_convert(const struct rte_eth_ethertype_filter *input,
 			      struct i40e_ethertype_filter *filter)
 {
-	rte_memcpy(&filter->input.mac_addr, &input->mac_addr,
+	memcpy(&filter->input.mac_addr, &input->mac_addr,
 		RTE_ETHER_ADDR_LEN);
 	filter->input.ether_type = input->ether_type;
 	filter->flags = input->flags;
@@ -10003,7 +10002,7 @@ i40e_ethertype_filter_set(struct i40e_pf *pf,
 			return -ENOMEM;
 		}
 
-		rte_memcpy(ethertype_filter, &check_filter,
+		memcpy(ethertype_filter, &check_filter,
 			   sizeof(check_filter));
 		ret = i40e_sw_ethertype_filter_insert(pf, ethertype_filter);
 		if (ret < 0)
@@ -10890,9 +10889,9 @@ i40e_vsi_config_tc(struct i40e_vsi *vsi, uint8_t tc_map)
 		goto out;
 	}
 	/* update the local VSI info with updated queue map */
-	rte_memcpy(&vsi->info.tc_mapping, &ctxt.info.tc_mapping,
+	memcpy(&vsi->info.tc_mapping, &ctxt.info.tc_mapping,
 					sizeof(vsi->info.tc_mapping));
-	rte_memcpy(&vsi->info.queue_mapping,
+	memcpy(&vsi->info.queue_mapping,
 			&ctxt.info.queue_mapping,
 		sizeof(vsi->info.queue_mapping));
 	vsi->info.mapping_flags = ctxt.info.mapping_flags;
@@ -11646,7 +11645,7 @@ i40e_tunnel_filter_restore(struct i40e_pf *pf)
 		cld_filter.element.flags = f->input.flags;
 		cld_filter.element.tenant_id = f->input.tenant_id;
 		cld_filter.element.queue_number = f->queue;
-		rte_memcpy(cld_filter.general_fields,
+		memcpy(cld_filter.general_fields,
 			   f->input.general_fields,
 			   sizeof(f->input.general_fields));
 
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 3b099d5a9e..ad256a5a11 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -464,9 +464,9 @@ fill_ip6_head(const struct i40e_fdir_input *fdir_input, unsigned char *raw_pkt,
 	 * need to be presented in a reversed order with respect
 	 * to the expected received packets.
 	 */
-	rte_memcpy(&ip6->src_addr, &fdir_input->flow.ipv6_flow.dst_ip,
+	memcpy(&ip6->src_addr, &fdir_input->flow.ipv6_flow.dst_ip,
 		IPV6_ADDR_LEN);
-	rte_memcpy(&ip6->dst_addr, &fdir_input->flow.ipv6_flow.src_ip,
+	memcpy(&ip6->dst_addr, &fdir_input->flow.ipv6_flow.src_ip,
 		IPV6_ADDR_LEN);
 	len += sizeof(struct rte_ipv6_hdr);
 
@@ -528,16 +528,16 @@ i40e_flow_fdir_fill_eth_ip_head(struct i40e_pf *pf,
 		[I40E_FILTER_PCTYPE_NONF_IPV6_OTHER] = IPPROTO_NONE,
 	};
 
-	rte_memcpy(raw_pkt, &fdir_input->flow.l2_flow.dst,
+	memcpy(raw_pkt, &fdir_input->flow.l2_flow.dst,
 		sizeof(struct rte_ether_addr));
-	rte_memcpy(raw_pkt + sizeof(struct rte_ether_addr),
+	memcpy(raw_pkt + sizeof(struct rte_ether_addr),
 		&fdir_input->flow.l2_flow.src,
 		sizeof(struct rte_ether_addr));
 	raw_pkt += 2 * sizeof(struct rte_ether_addr);
 
 	if (vlan && fdir_input->flow_ext.vlan_tci) {
-		rte_memcpy(raw_pkt, vlan_frame, sizeof(vlan_frame));
-		rte_memcpy(raw_pkt + sizeof(uint16_t),
+		memcpy(raw_pkt, vlan_frame, sizeof(vlan_frame));
+		memcpy(raw_pkt + sizeof(uint16_t),
 			   &fdir_input->flow_ext.vlan_tci,
 			   sizeof(uint16_t));
 		raw_pkt += sizeof(vlan_frame);
@@ -901,7 +901,7 @@ i40e_flow_fdir_construct_pkt(struct i40e_pf *pf,
 		dst = pf->fdir.flex_set[pit_idx].dst_offset * sizeof(uint16_t);
 		ptr = payload +
 		      pf->fdir.flex_set[pit_idx].src_offset * sizeof(uint16_t);
-		(void)rte_memcpy(ptr,
+		(void)memcpy(ptr,
 				 &fdir_input->flow_ext.flexbytes[dst],
 				 size * sizeof(uint16_t));
 	}
@@ -1001,7 +1001,7 @@ static int
 i40e_fdir_filter_convert(const struct i40e_fdir_filter_conf *input,
 			 struct i40e_fdir_filter *filter)
 {
-	rte_memcpy(&filter->fdir, input, sizeof(struct i40e_fdir_filter_conf));
+	memcpy(&filter->fdir, input, sizeof(struct i40e_fdir_filter_conf));
 	if (input->input.flow_ext.pkt_template) {
 		filter->fdir.input.flow.raw_flow.packet = NULL;
 		filter->fdir.input.flow.raw_flow.length =
@@ -1058,7 +1058,7 @@ i40e_sw_fdir_filter_insert(struct i40e_pf *pf, struct i40e_fdir_filter *filter)
 		return -1;
 
 	hash_filter = &fdir_info->fdir_filter_array[ret];
-	rte_memcpy(hash_filter, filter, sizeof(*filter));
+	memcpy(hash_filter, filter, sizeof(*filter));
 	fdir_info->hash_map[ret] = hash_filter;
 	TAILQ_INSERT_TAIL(&fdir_info->fdir_list, hash_filter, rules);
 
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 78191a2d22..1a1f864a22 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -1159,7 +1159,7 @@ i40e_pattern_skip_void_item(struct rte_flow_item *items,
 		pe = i40e_find_first_item(pb + 1, true);
 
 		cpy_count = pe - pb;
-		rte_memcpy(items, pb, sizeof(struct rte_flow_item) * cpy_count);
+		memcpy(items, pb, sizeof(struct rte_flow_item) * cpy_count);
 
 		items += cpy_count;
 
@@ -1171,7 +1171,7 @@ i40e_pattern_skip_void_item(struct rte_flow_item *items,
 		pb = pe + 1;
 	}
 	/* Copy the END item. */
-	rte_memcpy(items, pe, sizeof(struct rte_flow_item));
+	memcpy(items, pe, sizeof(struct rte_flow_item));
 }
 
 /* Check if the pattern matches a supported item type array */
@@ -2034,9 +2034,9 @@ i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
 				filter->input.flow_ext.oip_type =
 					I40E_FDIR_IPTYPE_IPV6;
 
-				rte_memcpy(filter->input.flow.ipv6_flow.src_ip,
+				memcpy(filter->input.flow.ipv6_flow.src_ip,
 					   &ipv6_spec->hdr.src_addr, 16);
-				rte_memcpy(filter->input.flow.ipv6_flow.dst_ip,
+				memcpy(filter->input.flow.ipv6_flow.dst_ip,
 					   &ipv6_spec->hdr.dst_addr, 16);
 
 				/* Check if it is fragment. */
@@ -2962,12 +2962,12 @@ i40e_flow_parse_vxlan_pattern(__rte_unused struct rte_eth_dev *dev,
 				}
 
 				if (!vxlan_flag) {
-					rte_memcpy(&filter->outer_mac,
+					memcpy(&filter->outer_mac,
 						   &eth_spec->hdr.dst_addr,
 						   RTE_ETHER_ADDR_LEN);
 					filter_type |= RTE_ETH_TUNNEL_FILTER_OMAC;
 				} else {
-					rte_memcpy(&filter->inner_mac,
+					memcpy(&filter->inner_mac,
 						   &eth_spec->hdr.dst_addr,
 						   RTE_ETHER_ADDR_LEN);
 					filter_type |= RTE_ETH_TUNNEL_FILTER_IMAC;
@@ -3062,7 +3062,7 @@ i40e_flow_parse_vxlan_pattern(__rte_unused struct rte_eth_dev *dev,
 					return -rte_errno;
 				}
 
-				rte_memcpy(((uint8_t *)&tenant_id_be + 1),
+				memcpy(((uint8_t *)&tenant_id_be + 1),
 					   vxlan_spec->hdr.vni, 3);
 				filter->tenant_id =
 					rte_be_to_cpu_32(tenant_id_be);
@@ -3191,12 +3191,12 @@ i40e_flow_parse_nvgre_pattern(__rte_unused struct rte_eth_dev *dev,
 				}
 
 				if (!nvgre_flag) {
-					rte_memcpy(&filter->outer_mac,
+					memcpy(&filter->outer_mac,
 						   &eth_spec->hdr.dst_addr,
 						   RTE_ETHER_ADDR_LEN);
 					filter_type |= RTE_ETH_TUNNEL_FILTER_OMAC;
 				} else {
-					rte_memcpy(&filter->inner_mac,
+					memcpy(&filter->inner_mac,
 						   &eth_spec->hdr.dst_addr,
 						   RTE_ETHER_ADDR_LEN);
 					filter_type |= RTE_ETH_TUNNEL_FILTER_IMAC;
@@ -3313,7 +3313,7 @@ i40e_flow_parse_nvgre_pattern(__rte_unused struct rte_eth_dev *dev,
 						   "Invalid NVGRE item");
 					return -rte_errno;
 				}
-				rte_memcpy(((uint8_t *)&tenant_id_be + 1),
+				memcpy(((uint8_t *)&tenant_id_be + 1),
 					   nvgre_spec->tni, 3);
 				filter->tenant_id =
 					rte_be_to_cpu_32(tenant_id_be);
@@ -3481,7 +3481,7 @@ i40e_flow_parse_mpls_pattern(__rte_unused struct rte_eth_dev *dev,
 						   "Invalid MPLS label mask");
 				return -rte_errno;
 			}
-			rte_memcpy(((uint8_t *)&label_be + 1),
+			memcpy(((uint8_t *)&label_be + 1),
 				   mpls_spec->label_tc_s, 3);
 			filter->tenant_id = rte_be_to_cpu_32(label_be) >> 4;
 			break;
@@ -4119,7 +4119,7 @@ i40e_flow_destroy_tunnel_filter(struct i40e_pf *pf,
 	cld_filter.element.flags = filter->input.flags;
 	cld_filter.element.tenant_id = filter->input.tenant_id;
 	cld_filter.element.queue_number = filter->queue;
-	rte_memcpy(cld_filter.general_fields,
+	memcpy(cld_filter.general_fields,
 		   filter->input.general_fields,
 		   sizeof(cld_filter.general_fields));
 
@@ -4339,7 +4339,7 @@ i40e_flow_query(struct rte_eth_dev *dev __rte_unused,
 						   "action not supported");
 				return -rte_errno;
 			}
-			rte_memcpy(rss_conf,
+			memcpy(rss_conf,
 				   &rss_rule->rss_filter_info.conf,
 				   sizeof(struct rte_flow_action_rss));
 			break;
diff --git a/drivers/net/intel/i40e/i40e_pf.c b/drivers/net/intel/i40e/i40e_pf.c
index 08cdd6bc4d..c76e035a42 100644
--- a/drivers/net/intel/i40e/i40e_pf.c
+++ b/drivers/net/intel/i40e/i40e_pf.c
@@ -16,7 +16,6 @@
 #include <rte_ether.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 
 #include "i40e_logs.h"
 #include "base/i40e_prototype.h"
@@ -857,7 +856,7 @@ i40e_pf_host_process_cmd_add_ether_address(struct i40e_pf_vf *vf,
 
 	for (i = 0; i < addr_list->num_elements; i++) {
 		mac = (struct rte_ether_addr *)(addr_list->list[i].addr);
-		rte_memcpy(&filter.mac_addr, mac, RTE_ETHER_ADDR_LEN);
+		memcpy(&filter.mac_addr, mac, RTE_ETHER_ADDR_LEN);
 		filter.filter_type = I40E_MACVLAN_PERFECT_MATCH;
 		if (rte_is_zero_ether_addr(mac) ||
 		    i40e_vsi_add_mac(vf->vsi, &filter)) {
diff --git a/drivers/net/intel/i40e/i40e_tm.c b/drivers/net/intel/i40e/i40e_tm.c
index 4c0940f355..6f7e8cc801 100644
--- a/drivers/net/intel/i40e/i40e_tm.c
+++ b/drivers/net/intel/i40e/i40e_tm.c
@@ -279,7 +279,7 @@ i40e_shaper_profile_add(struct rte_eth_dev *dev,
 	if (!shaper_profile)
 		return -ENOMEM;
 	shaper_profile->shaper_profile_id = shaper_profile_id;
-	rte_memcpy(&shaper_profile->profile, profile,
+	memcpy(&shaper_profile->profile, profile,
 			 sizeof(struct rte_tm_shaper_params));
 	TAILQ_INSERT_TAIL(&pf->tm_conf.shaper_profile_list,
 			  shaper_profile, node);
@@ -526,7 +526,7 @@ i40e_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 		tm_node->reference_count = 0;
 		tm_node->parent = NULL;
 		tm_node->shaper_profile = shaper_profile;
-		rte_memcpy(&tm_node->params, params,
+		memcpy(&tm_node->params, params,
 				 sizeof(struct rte_tm_node_params));
 		pf->tm_conf.root = tm_node;
 
@@ -600,7 +600,7 @@ i40e_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 	tm_node->reference_count = 0;
 	tm_node->parent = parent_node;
 	tm_node->shaper_profile = shaper_profile;
-	rte_memcpy(&tm_node->params, params,
+	memcpy(&tm_node->params, params,
 			 sizeof(struct rte_tm_node_params));
 	if (parent_node_type == I40E_TM_NODE_TYPE_PORT) {
 		TAILQ_INSERT_TAIL(&pf->tm_conf.tc_list,
diff --git a/drivers/net/intel/i40e/rte_pmd_i40e.c b/drivers/net/intel/i40e/rte_pmd_i40e.c
index 4fdef9464b..6049b77d6f 100644
--- a/drivers/net/intel/i40e/rte_pmd_i40e.c
+++ b/drivers/net/intel/i40e/rte_pmd_i40e.c
@@ -94,7 +94,7 @@ rte_pmd_i40e_set_vf_mac_anti_spoof(uint16_t port, uint16_t vf_id, uint8_t on)
 		vsi->info.sec_flags &= ~I40E_AQ_VSI_SEC_FLAG_ENABLE_MAC_CHK;
 
 	memset(&ctxt, 0, sizeof(ctxt));
-	rte_memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
+	memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
 	ctxt.seid = vsi->seid;
 
 	hw = I40E_VSI_TO_HW(vsi);
@@ -197,7 +197,7 @@ rte_pmd_i40e_set_vf_vlan_anti_spoof(uint16_t port, uint16_t vf_id, uint8_t on)
 		vsi->info.sec_flags &= ~I40E_AQ_VSI_SEC_FLAG_ENABLE_VLAN_CHK;
 
 	memset(&ctxt, 0, sizeof(ctxt));
-	rte_memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
+	memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
 	ctxt.seid = vsi->seid;
 
 	hw = I40E_VSI_TO_HW(vsi);
@@ -242,7 +242,7 @@ i40e_vsi_rm_mac_filter(struct i40e_vsi *vsi)
 
 		for (i = 0; i < vlan_num; i++) {
 			mv_f[i].filter_type = filter_type;
-			rte_memcpy(&mv_f[i].macaddr,
+			memcpy(&mv_f[i].macaddr,
 					 &f->mac_info.mac_addr,
 					 ETH_ADDR_LEN);
 		}
@@ -303,7 +303,7 @@ i40e_vsi_restore_mac_filter(struct i40e_vsi *vsi)
 
 		for (i = 0; i < vlan_num; i++) {
 			mv_f[i].filter_type = f->mac_info.filter_type;
-			rte_memcpy(&mv_f[i].macaddr,
+			memcpy(&mv_f[i].macaddr,
 					 &f->mac_info.mac_addr,
 					 ETH_ADDR_LEN);
 		}
@@ -385,7 +385,7 @@ i40e_vsi_set_tx_loopback(struct i40e_vsi *vsi, uint8_t on)
 		vsi->info.switch_id &= ~I40E_AQ_VSI_SW_ID_FLAG_ALLOW_LB;
 
 	memset(&ctxt, 0, sizeof(ctxt));
-	rte_memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
+	memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
 	ctxt.seid = vsi->seid;
 
 	ret = i40e_aq_update_vsi_params(hw, &ctxt, NULL);
@@ -716,7 +716,7 @@ int rte_pmd_i40e_set_vf_vlan_insert(uint16_t port, uint16_t vf_id,
 		vsi->info.port_vlan_flags &= ~I40E_AQ_VSI_PVLAN_INSERT_PVID;
 
 	memset(&ctxt, 0, sizeof(ctxt));
-	rte_memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
+	memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
 	ctxt.seid = vsi->seid;
 
 	hw = I40E_VSI_TO_HW(vsi);
@@ -779,7 +779,7 @@ int rte_pmd_i40e_set_vf_broadcast(uint16_t port, uint16_t vf_id,
 	}
 
 	if (on) {
-		rte_memcpy(&filter.mac_addr, &broadcast, RTE_ETHER_ADDR_LEN);
+		memcpy(&filter.mac_addr, &broadcast, RTE_ETHER_ADDR_LEN);
 		filter.filter_type = I40E_MACVLAN_PERFECT_MATCH;
 		ret = i40e_vsi_add_mac(vsi, &filter);
 	} else {
@@ -852,7 +852,7 @@ int rte_pmd_i40e_set_vf_vlan_tag(uint16_t port, uint16_t vf_id, uint8_t on)
 	}
 
 	memset(&ctxt, 0, sizeof(ctxt));
-	rte_memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
+	memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
 	ctxt.seid = vsi->seid;
 
 	hw = I40E_VSI_TO_HW(vsi);
@@ -2591,9 +2591,9 @@ i40e_vsi_update_queue_region_mapping(struct i40e_hw *hw,
 		return ret;
 	}
 	/* update the local VSI info with updated queue map */
-	rte_memcpy(&vsi->info.tc_mapping, &ctxt.info.tc_mapping,
+	memcpy(&vsi->info.tc_mapping, &ctxt.info.tc_mapping,
 					sizeof(vsi->info.tc_mapping));
-	rte_memcpy(&vsi->info.queue_mapping,
+	memcpy(&vsi->info.queue_mapping,
 			&ctxt.info.queue_mapping,
 			sizeof(vsi->info.queue_mapping));
 	vsi->info.mapping_flags = ctxt.info.mapping_flags;
-- 
2.51.0

