Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2831CE81BCB
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 14:14:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2755640687;
	Mon,  9 Feb 2026 15:14:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id D19724065C
 for <dev@dpdk.org>; Mon,  9 Feb 2026 15:14:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770646443; x=1802182443;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=U1Iid4ky+lrfeibH46deRcPt6BdGUWdQWF0hyft1jWc=;
 b=cK86RGALDanWHACRFPSMsolzyOcXok66Emn+b5brKsgCMuPhTDS5tSn9
 TfBHSsipeSgsy4I8YGhjdpIFVRpteF+DWW73mdR46lkniMdWzQsN78Kj7
 /yh7HueCV4kcdzuRwXRO2rw7azaWt2/vuj7PrIOz0Xa4xWfxeUgMiIFwV
 Va+tZk7L2TRmEyPjPyCSxy7VQLGo6LkOhdE8qIozGlhwCTdPkVWc1FR9w
 HHrlhWPt+SevNSQre+ME2ABpOtI3stG3lcGt0YSqfYaAhq36GoFz8O6si
 9MPNtqk4GF7kXCYPW7KdBhIkb+yQrRHcLFHe6C5Anh3kNIP4cxNv7tcdh w==;
X-CSE-ConnectionGUID: Cg0lrrZwR4W6kYpFFJNw4Q==
X-CSE-MsgGUID: yAxdzodgTW+nuEnjXD5/dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71658486"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71658486"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 06:14:02 -0800
X-CSE-ConnectionGUID: 1c+f/wqFSGKaDE6+qE2HOw==
X-CSE-MsgGUID: Hkgr26IfREWW2lINcCpXdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="242215985"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 09 Feb 2026 06:14:02 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 05/12] net/i40e: use stack allocations for tunnel set
Date: Mon,  9 Feb 2026 14:13:41 +0000
Message-ID: <fe7f0fcdb712cb1932a3bd360a705af6d5395039.1770646012.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770646012.git.anatoly.burakov@intel.com>
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

Currently, the tunnel "set" function is using rte_zmalloc to allocate a
temporary variable. It is actually not needed in this context and can be
avoided entirely and replaced with stack allocation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 124 ++++++++++++---------------
 1 file changed, 53 insertions(+), 71 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index c8153f3351..f327a3927f 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -8511,38 +8511,27 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 	struct i40e_pf_vf *vf = NULL;
 	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
 	struct i40e_vsi *vsi;
-	struct i40e_aqc_cloud_filters_element_bb *cld_filter;
-	struct i40e_aqc_cloud_filters_element_bb *pfilter;
+	struct i40e_aqc_cloud_filters_element_bb cld_filter = {0};
 	struct i40e_tunnel_rule *tunnel_rule = &pf->tunnel;
-	struct i40e_tunnel_filter *tunnel, *node;
+	struct i40e_tunnel_filter *node;
 	struct i40e_tunnel_filter check_filter; /* Check if filter exists */
 	uint32_t teid_le;
 	bool big_buffer = 0;
 
-	cld_filter = rte_zmalloc("tunnel_filter",
-			 sizeof(struct i40e_aqc_add_rm_cloud_filt_elem_ext),
-			 0);
-
-	if (cld_filter == NULL) {
-		PMD_DRV_LOG(ERR, "Failed to alloc memory.");
-		return -ENOMEM;
-	}
-	pfilter = cld_filter;
-
 	rte_ether_addr_copy(&tunnel_filter->outer_mac,
-			(struct rte_ether_addr *)&pfilter->element.outer_mac);
+			(struct rte_ether_addr *)&cld_filter.element.outer_mac);
 	rte_ether_addr_copy(&tunnel_filter->inner_mac,
-			(struct rte_ether_addr *)&pfilter->element.inner_mac);
+			(struct rte_ether_addr *)&cld_filter.element.inner_mac);
 
-	pfilter->element.inner_vlan =
+	cld_filter.element.inner_vlan =
 		rte_cpu_to_le_16(tunnel_filter->inner_vlan);
 	if (tunnel_filter->ip_type == I40E_TUNNEL_IPTYPE_IPV4) {
 		ip_type = I40E_AQC_ADD_CLOUD_FLAGS_IPV4;
 		ipv4_addr = rte_be_to_cpu_32(tunnel_filter->ip_addr.ipv4_addr);
 		ipv4_addr_le = rte_cpu_to_le_32(ipv4_addr);
-		rte_memcpy(&pfilter->element.ipaddr.v4.data,
+		rte_memcpy(&cld_filter.element.ipaddr.v4.data,
 				&ipv4_addr_le,
-				sizeof(pfilter->element.ipaddr.v4.data));
+				sizeof(cld_filter.element.ipaddr.v4.data));
 	} else {
 		ip_type = I40E_AQC_ADD_CLOUD_FLAGS_IPV6;
 		for (i = 0; i < 4; i++) {
@@ -8550,9 +8539,9 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 			rte_cpu_to_le_32(rte_be_to_cpu_32(
 					 tunnel_filter->ip_addr.ipv6_addr[i]));
 		}
-		rte_memcpy(&pfilter->element.ipaddr.v6.data,
+		rte_memcpy(&cld_filter.element.ipaddr.v6.data,
 			   &convert_ipv6,
-			   sizeof(pfilter->element.ipaddr.v6.data));
+			   sizeof(cld_filter.element.ipaddr.v6.data));
 	}
 
 	/* check tunneled type */
@@ -8573,11 +8562,11 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 			pf->mpls_replace_flag = 1;
 		}
 		teid_le = rte_cpu_to_le_32(tunnel_filter->tenant_id);
-		pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD0] =
+		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD0] =
 			teid_le >> 4;
-		pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
+		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
 			(teid_le & 0xF) << 12;
-		pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD2] =
+		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD2] =
 			0x40;
 		big_buffer = 1;
 		tun_type = I40E_AQC_ADD_CLOUD_TNL_TYPE_MPLSOUDP;
@@ -8589,11 +8578,11 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 			pf->mpls_replace_flag = 1;
 		}
 		teid_le = rte_cpu_to_le_32(tunnel_filter->tenant_id);
-		pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD0] =
+		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD0] =
 			teid_le >> 4;
-		pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
+		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
 			(teid_le & 0xF) << 12;
-		pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD2] =
+		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD2] =
 			0x0;
 		big_buffer = 1;
 		tun_type = I40E_AQC_ADD_CLOUD_TNL_TYPE_MPLSOGRE;
@@ -8605,11 +8594,11 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 			pf->gtp_replace_flag = 1;
 		}
 		teid_le = rte_cpu_to_le_32(tunnel_filter->tenant_id);
-		pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X12_WORD0] =
+		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X12_WORD0] =
 			(teid_le >> 16) & 0xFFFF;
-		pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X12_WORD1] =
+		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X12_WORD1] =
 			teid_le & 0xFFFF;
-		pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X12_WORD2] =
+		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X12_WORD2] =
 			0x0;
 		big_buffer = 1;
 		break;
@@ -8620,11 +8609,11 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 			pf->gtp_replace_flag = 1;
 		}
 		teid_le = rte_cpu_to_le_32(tunnel_filter->tenant_id);
-		pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X13_WORD0] =
+		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X13_WORD0] =
 			(teid_le >> 16) & 0xFFFF;
-		pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X13_WORD1] =
+		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X13_WORD1] =
 			teid_le & 0xFFFF;
-		pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X13_WORD2] =
+		cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X13_WORD2] =
 			0x0;
 		big_buffer = 1;
 		break;
@@ -8641,8 +8630,8 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 		 *	Big Buffer should be set, see changes in
 		 *	i40e_aq_add_cloud_filters
 		 */
-		pfilter->general_fields[0] = tunnel_filter->inner_vlan;
-		pfilter->general_fields[1] = tunnel_filter->outer_vlan;
+		cld_filter.general_fields[0] = tunnel_filter->inner_vlan;
+		cld_filter.general_fields[1] = tunnel_filter->outer_vlan;
 		big_buffer = 1;
 		break;
 	case I40E_CLOUD_TYPE_UDP:
@@ -8657,20 +8646,20 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 				pf->sport_replace_flag = 1;
 			}
 			teid_le = rte_cpu_to_le_32(tunnel_filter->tenant_id);
-			pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD0] =
+			cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD0] =
 				I40E_DIRECTION_INGRESS_KEY;
 
 			if (tunnel_filter->tunnel_type == I40E_CLOUD_TYPE_UDP)
-				pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
+				cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
 					I40E_TR_L4_TYPE_UDP;
 			else if (tunnel_filter->tunnel_type == I40E_CLOUD_TYPE_TCP)
-				pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
+				cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
 					I40E_TR_L4_TYPE_TCP;
 			else
-				pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
+				cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD1] =
 					I40E_TR_L4_TYPE_SCTP;
 
-			pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD2] =
+			cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X11_WORD2] =
 				(teid_le >> 16) & 0xFFFF;
 			big_buffer = 1;
 		} else {
@@ -8682,20 +8671,20 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 				pf->dport_replace_flag = 1;
 			}
 			teid_le = rte_cpu_to_le_32(tunnel_filter->tenant_id);
-			pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD0] =
+			cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD0] =
 				I40E_DIRECTION_INGRESS_KEY;
 
 			if (tunnel_filter->tunnel_type == I40E_CLOUD_TYPE_UDP)
-				pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD1] =
+				cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD1] =
 					I40E_TR_L4_TYPE_UDP;
 			else if (tunnel_filter->tunnel_type == I40E_CLOUD_TYPE_TCP)
-				pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD1] =
+				cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD1] =
 					I40E_TR_L4_TYPE_TCP;
 			else
-				pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD1] =
+				cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD1] =
 					I40E_TR_L4_TYPE_SCTP;
 
-			pfilter->general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD2] =
+			cld_filter.general_fields[I40E_AQC_ADD_CLOUD_FV_FLU_0X10_WORD2] =
 				(teid_le >> 16) & 0xFFFF;
 			big_buffer = 1;
 		}
@@ -8704,48 +8693,46 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 	default:
 		/* Other tunnel types is not supported. */
 		PMD_DRV_LOG(ERR, "tunnel type is not supported.");
-		rte_free(cld_filter);
 		return -EINVAL;
 	}
 
 	if (tunnel_filter->tunnel_type == I40E_TUNNEL_TYPE_MPLSoUDP)
-		pfilter->element.flags =
+		cld_filter.element.flags =
 			I40E_AQC_ADD_CLOUD_FILTER_0X11;
 	else if (tunnel_filter->tunnel_type == I40E_TUNNEL_TYPE_MPLSoGRE)
-		pfilter->element.flags =
+		cld_filter.element.flags =
 			I40E_AQC_ADD_CLOUD_FILTER_0X12;
 	else if (tunnel_filter->tunnel_type == I40E_TUNNEL_TYPE_GTPC)
-		pfilter->element.flags =
+		cld_filter.element.flags =
 			I40E_AQC_ADD_CLOUD_FILTER_0X11;
 	else if (tunnel_filter->tunnel_type == I40E_TUNNEL_TYPE_GTPU)
-		pfilter->element.flags =
+		cld_filter.element.flags =
 			I40E_AQC_ADD_CLOUD_FILTER_0X12;
 	else if (tunnel_filter->tunnel_type == I40E_TUNNEL_TYPE_QINQ)
-		pfilter->element.flags |=
+		cld_filter.element.flags |=
 			I40E_AQC_ADD_CLOUD_FILTER_0X10;
 	else if (tunnel_filter->tunnel_type == I40E_CLOUD_TYPE_UDP ||
 		 tunnel_filter->tunnel_type == I40E_CLOUD_TYPE_TCP ||
 		 tunnel_filter->tunnel_type == I40E_CLOUD_TYPE_SCTP) {
 		if (tunnel_filter->l4_port_type == I40E_L4_PORT_TYPE_SRC)
-			pfilter->element.flags |=
+			cld_filter.element.flags |=
 				I40E_AQC_ADD_CLOUD_FILTER_0X11;
 		else
-			pfilter->element.flags |=
+			cld_filter.element.flags |=
 				I40E_AQC_ADD_CLOUD_FILTER_0X10;
 	} else {
 		val = i40e_dev_get_filter_type(tunnel_filter->filter_type,
-						&pfilter->element.flags);
+						&cld_filter.element.flags);
 		if (val < 0) {
-			rte_free(cld_filter);
 			return -EINVAL;
 		}
 	}
 
-	pfilter->element.flags |= rte_cpu_to_le_16(
-		I40E_AQC_ADD_CLOUD_FLAGS_TO_QUEUE |
-		ip_type | (tun_type << I40E_AQC_ADD_CLOUD_TNL_TYPE_SHIFT));
-	pfilter->element.tenant_id = rte_cpu_to_le_32(tunnel_filter->tenant_id);
-	pfilter->element.queue_number =
+	cld_filter.element.flags |=
+			rte_cpu_to_le_16(I40E_AQC_ADD_CLOUD_FLAGS_TO_QUEUE | ip_type |
+				(tun_type << I40E_AQC_ADD_CLOUD_TNL_TYPE_SHIFT));
+	cld_filter.element.tenant_id = rte_cpu_to_le_32(tunnel_filter->tenant_id);
+	cld_filter.element.queue_number =
 		rte_cpu_to_le_16(tunnel_filter->queue_id);
 
 	if (!tunnel_filter->is_to_vf)
@@ -8753,7 +8740,6 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 	else {
 		if (tunnel_filter->vf_id >= pf->vf_num) {
 			PMD_DRV_LOG(ERR, "Invalid argument.");
-			rte_free(cld_filter);
 			return -EINVAL;
 		}
 		vf = &pf->vfs[tunnel_filter->vf_id];
@@ -8762,38 +8748,36 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 
 	/* Check if there is the filter in SW list */
 	memset(&check_filter, 0, sizeof(check_filter));
-	i40e_tunnel_filter_convert(cld_filter, &check_filter);
+	i40e_tunnel_filter_convert(&cld_filter, &check_filter);
 	check_filter.is_to_vf = tunnel_filter->is_to_vf;
 	check_filter.vf_id = tunnel_filter->vf_id;
 	node = i40e_sw_tunnel_filter_lookup(tunnel_rule, &check_filter.input);
 	if (add && node) {
 		PMD_DRV_LOG(ERR, "Conflict with existing tunnel rules!");
-		rte_free(cld_filter);
 		return -EINVAL;
 	}
 
 	if (!add && !node) {
 		PMD_DRV_LOG(ERR, "There's no corresponding tunnel filter!");
-		rte_free(cld_filter);
 		return -EINVAL;
 	}
 
 	if (add) {
+		struct i40e_tunnel_filter *tunnel;
+
 		if (big_buffer)
 			ret = i40e_aq_add_cloud_filters_bb(hw,
-						   vsi->seid, cld_filter, 1);
+						   vsi->seid, &cld_filter, 1);
 		else
 			ret = i40e_aq_add_cloud_filters(hw,
-					vsi->seid, &cld_filter->element, 1);
+					vsi->seid, &cld_filter.element, 1);
 		if (ret < 0) {
 			PMD_DRV_LOG(ERR, "Failed to add a tunnel filter.");
-			rte_free(cld_filter);
 			return -ENOTSUP;
 		}
 		tunnel = rte_zmalloc("tunnel_filter", sizeof(*tunnel), 0);
 		if (tunnel == NULL) {
 			PMD_DRV_LOG(ERR, "Failed to alloc memory.");
-			rte_free(cld_filter);
 			return -ENOMEM;
 		}
 
@@ -8804,19 +8788,17 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 	} else {
 		if (big_buffer)
 			ret = i40e_aq_rem_cloud_filters_bb(
-				hw, vsi->seid, cld_filter, 1);
+				hw, vsi->seid, &cld_filter, 1);
 		else
 			ret = i40e_aq_rem_cloud_filters(hw, vsi->seid,
-						&cld_filter->element, 1);
+						&cld_filter.element, 1);
 		if (ret < 0) {
 			PMD_DRV_LOG(ERR, "Failed to delete a tunnel filter.");
-			rte_free(cld_filter);
 			return -ENOTSUP;
 		}
 		ret = i40e_sw_tunnel_filter_del(pf, &node->input);
 	}
 
-	rte_free(cld_filter);
 	return ret;
 }
 
-- 
2.47.3

