Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402C0CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 10:50:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AA29410D4;
	Wed,  7 Oct 2026 12:50:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id B2B5C40144
 for <dev@dpdk.org>; Wed,  7 Oct 2026 12:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791370232; x=1822906232;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Khuv0igx3Hk4Yshnhl3kdjWkMtwhkjPt2qSQ2LPZl2Q=;
 b=cFp2NPsd9JoEoNyaTbsI8o7Njt89V1TMOcwJM4afGG6D+66GVTwcUxxS
 DKkEC9fL9WO3eHUf56bprDEtJba7BPhz/POZMQPz6BEVPqNypo8WXmMtK
 TtKvbfWqXKnw+a9uEOr/DLUhFp1ouL9wDkbOYfourxPgo2IhvpeUdUuae
 LdhZTBKU92e0whL3ugesU8/sbUy8R4vfPPisOxu7iQmBoIfBDYMiCaQdN
 EiLalU31SFWwl/1K4a1GvIbO5PN8Ss3i+5G+jgE34QbEn3hjcXSWNQSxX
 KR6NVgmXXJZmdO/+sJNqV6H0UKwrX9BvyQ1tOsORFgpqCZCV7PEPiGJFn g==;
X-CSE-ConnectionGUID: ChLmLpW0QX2CRxh+zhPOFA==
X-CSE-MsgGUID: Nb40uP7DSMm3cPULXh34iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="121796"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="121796"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 03:50:31 -0700
X-CSE-ConnectionGUID: YG71/tIGQKGXRySgsT2XWw==
X-CSE-MsgGUID: lIvswdfVRfeCrQ7ZsVRLOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="280652034"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 07 Oct 2026 03:50:30 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Ori Kam <orika@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v5 01/25] ethdev: add default mask query to flow
Date: Wed,  7 Oct 2026 11:49:56 +0100
Message-ID: <338aa9ecd08cbdaf39ec5696afa9b6c619d66e53.1791369980.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791369979.git.anatoly.burakov@intel.com>
 <cover.1791369979.git.anatoly.burakov@intel.com>
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

The rte_flow API defines that if the mask provided with the flow item is
NULL, a default mask should be used where applicable. There is no API to
get such mask, so add this API to rte_flow.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/guides/rel_notes/release_26_11.rst |   5 +
 lib/ethdev/rte_flow.c                  | 207 ++++++++++++++++++-------
 lib/ethdev/rte_flow.h                  |  15 ++
 3 files changed, 167 insertions(+), 60 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 3fb7eac25db..c1656895996 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -64,6 +64,11 @@ New Features
 
   Added ``rte_vlan_insert_tpid()`` to the net library.
 
+* **Added flow item default mask lookup.**
+
+  Added ``RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR`` conversion operation
+  to ``rte_flow_conv()`` to retrieve the default mask of a flow item type.
+
 * **Updated AF_XDP driver.**
 
   * Changed the default device plugin endpoint path used when
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 1056cfd2c55..0ebf59165d4 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -37,6 +37,7 @@ struct rte_flow_desc_data {
 	const char *name;
 	size_t size;
 	size_t (*desc_fn)(void *dst, const void *src, size_t size);
+	const void *default_mask; /* items only, NULL if none */
 };
 
 /**
@@ -101,81 +102,146 @@ rte_flow_item_flex_conv(void *buf, const void *data, size_t size)
 		.desc_fn = fn,               \
 	}
 
+#define MK_FLOW_ITEM_MASK(t, s, m) \
+	[RTE_FLOW_ITEM_TYPE_ ## t] = { \
+		.name = # t, \
+		.size = s, \
+		.desc_fn = NULL, \
+		.default_mask = &(m), \
+	}
+
 /** Information about known flow pattern items. */
 static const struct rte_flow_desc_data rte_flow_desc_item[] = {
 	MK_FLOW_ITEM(END, 0),
 	MK_FLOW_ITEM(VOID, 0),
 	MK_FLOW_ITEM(INVERT, 0),
-	MK_FLOW_ITEM(ANY, sizeof(struct rte_flow_item_any)),
-	MK_FLOW_ITEM(PORT_ID, sizeof(struct rte_flow_item_port_id)),
-	MK_FLOW_ITEM(RAW, sizeof(struct rte_flow_item_raw)),
-	MK_FLOW_ITEM(ETH, sizeof(struct rte_flow_item_eth)),
-	MK_FLOW_ITEM(VLAN, sizeof(struct rte_flow_item_vlan)),
-	MK_FLOW_ITEM(IPV4, sizeof(struct rte_flow_item_ipv4)),
-	MK_FLOW_ITEM(IPV6, sizeof(struct rte_flow_item_ipv6)),
-	MK_FLOW_ITEM(ICMP, sizeof(struct rte_flow_item_icmp)),
-	MK_FLOW_ITEM(UDP, sizeof(struct rte_flow_item_udp)),
-	MK_FLOW_ITEM(TCP, sizeof(struct rte_flow_item_tcp)),
-	MK_FLOW_ITEM(SCTP, sizeof(struct rte_flow_item_sctp)),
-	MK_FLOW_ITEM(VXLAN, sizeof(struct rte_flow_item_vxlan)),
-	MK_FLOW_ITEM(E_TAG, sizeof(struct rte_flow_item_e_tag)),
-	MK_FLOW_ITEM(NVGRE, sizeof(struct rte_flow_item_nvgre)),
-	MK_FLOW_ITEM(MPLS, sizeof(struct rte_flow_item_mpls)),
-	MK_FLOW_ITEM(GRE, sizeof(struct rte_flow_item_gre)),
-	MK_FLOW_ITEM(FUZZY, sizeof(struct rte_flow_item_fuzzy)),
-	MK_FLOW_ITEM(GTP, sizeof(struct rte_flow_item_gtp)),
-	MK_FLOW_ITEM(GTPC, sizeof(struct rte_flow_item_gtp)),
-	MK_FLOW_ITEM(GTPU, sizeof(struct rte_flow_item_gtp)),
-	MK_FLOW_ITEM(ESP, sizeof(struct rte_flow_item_esp)),
-	MK_FLOW_ITEM(GENEVE, sizeof(struct rte_flow_item_geneve)),
-	MK_FLOW_ITEM(VXLAN_GPE, sizeof(struct rte_flow_item_vxlan_gpe)),
-	MK_FLOW_ITEM(ARP_ETH_IPV4, sizeof(struct rte_flow_item_arp_eth_ipv4)),
-	MK_FLOW_ITEM(IPV6_EXT, sizeof(struct rte_flow_item_ipv6_ext)),
+	MK_FLOW_ITEM_MASK(ANY, sizeof(struct rte_flow_item_any),
+			rte_flow_item_any_mask),
+	MK_FLOW_ITEM_MASK(PORT_ID, sizeof(struct rte_flow_item_port_id),
+			rte_flow_item_port_id_mask),
+	MK_FLOW_ITEM_MASK(RAW, sizeof(struct rte_flow_item_raw),
+			rte_flow_item_raw_mask),
+	MK_FLOW_ITEM_MASK(ETH, sizeof(struct rte_flow_item_eth),
+			rte_flow_item_eth_mask),
+	MK_FLOW_ITEM_MASK(VLAN, sizeof(struct rte_flow_item_vlan),
+			rte_flow_item_vlan_mask),
+	MK_FLOW_ITEM_MASK(IPV4, sizeof(struct rte_flow_item_ipv4),
+			rte_flow_item_ipv4_mask),
+	MK_FLOW_ITEM_MASK(IPV6, sizeof(struct rte_flow_item_ipv6),
+			rte_flow_item_ipv6_mask),
+	MK_FLOW_ITEM_MASK(ICMP, sizeof(struct rte_flow_item_icmp),
+			rte_flow_item_icmp_mask),
+	MK_FLOW_ITEM_MASK(UDP, sizeof(struct rte_flow_item_udp),
+			rte_flow_item_udp_mask),
+	MK_FLOW_ITEM_MASK(TCP, sizeof(struct rte_flow_item_tcp),
+			rte_flow_item_tcp_mask),
+	MK_FLOW_ITEM_MASK(SCTP, sizeof(struct rte_flow_item_sctp),
+			rte_flow_item_sctp_mask),
+	MK_FLOW_ITEM_MASK(VXLAN, sizeof(struct rte_flow_item_vxlan),
+			rte_flow_item_vxlan_mask),
+	MK_FLOW_ITEM_MASK(E_TAG, sizeof(struct rte_flow_item_e_tag),
+			rte_flow_item_e_tag_mask),
+	MK_FLOW_ITEM_MASK(NVGRE, sizeof(struct rte_flow_item_nvgre),
+			rte_flow_item_nvgre_mask),
+	MK_FLOW_ITEM_MASK(MPLS, sizeof(struct rte_flow_item_mpls),
+			rte_flow_item_mpls_mask),
+	MK_FLOW_ITEM_MASK(GRE, sizeof(struct rte_flow_item_gre),
+			rte_flow_item_gre_mask),
+	MK_FLOW_ITEM_MASK(FUZZY, sizeof(struct rte_flow_item_fuzzy),
+			rte_flow_item_fuzzy_mask),
+	MK_FLOW_ITEM_MASK(GTP, sizeof(struct rte_flow_item_gtp),
+			rte_flow_item_gtp_mask),
+	MK_FLOW_ITEM_MASK(GTPC, sizeof(struct rte_flow_item_gtp),
+			rte_flow_item_gtp_mask),
+	MK_FLOW_ITEM_MASK(GTPU, sizeof(struct rte_flow_item_gtp),
+			rte_flow_item_gtp_mask),
+	MK_FLOW_ITEM_MASK(ESP, sizeof(struct rte_flow_item_esp),
+			rte_flow_item_esp_mask),
+	MK_FLOW_ITEM_MASK(GENEVE, sizeof(struct rte_flow_item_geneve),
+			rte_flow_item_geneve_mask),
+	MK_FLOW_ITEM_MASK(VXLAN_GPE, sizeof(struct rte_flow_item_vxlan_gpe),
+			rte_flow_item_vxlan_gpe_mask),
+	MK_FLOW_ITEM_MASK(ARP_ETH_IPV4, sizeof(struct rte_flow_item_arp_eth_ipv4),
+			rte_flow_item_arp_eth_ipv4_mask),
+	MK_FLOW_ITEM_MASK(IPV6_EXT, sizeof(struct rte_flow_item_ipv6_ext),
+			rte_flow_item_ipv6_ext_mask),
 	MK_FLOW_ITEM(IPV6_FRAG_EXT, sizeof(struct rte_flow_item_ipv6_frag_ext)),
-	MK_FLOW_ITEM(ICMP6, sizeof(struct rte_flow_item_icmp6)),
+	MK_FLOW_ITEM_MASK(ICMP6, sizeof(struct rte_flow_item_icmp6),
+			rte_flow_item_icmp6_mask),
 	MK_FLOW_ITEM(ICMP6_ECHO_REQUEST, sizeof(struct rte_flow_item_icmp6_echo)),
 	MK_FLOW_ITEM(ICMP6_ECHO_REPLY, sizeof(struct rte_flow_item_icmp6_echo)),
-	MK_FLOW_ITEM(ICMP6_ND_NS, sizeof(struct rte_flow_item_icmp6_nd_ns)),
-	MK_FLOW_ITEM(ICMP6_ND_NA, sizeof(struct rte_flow_item_icmp6_nd_na)),
-	MK_FLOW_ITEM(ICMP6_ND_OPT, sizeof(struct rte_flow_item_icmp6_nd_opt)),
-	MK_FLOW_ITEM(ICMP6_ND_OPT_SLA_ETH,
-		     sizeof(struct rte_flow_item_icmp6_nd_opt_sla_eth)),
-	MK_FLOW_ITEM(ICMP6_ND_OPT_TLA_ETH,
-		     sizeof(struct rte_flow_item_icmp6_nd_opt_tla_eth)),
-	MK_FLOW_ITEM(MARK, sizeof(struct rte_flow_item_mark)),
-	MK_FLOW_ITEM(META, sizeof(struct rte_flow_item_meta)),
-	MK_FLOW_ITEM(RANDOM, sizeof(struct rte_flow_item_random)),
-	MK_FLOW_ITEM(TAG, sizeof(struct rte_flow_item_tag)),
+	MK_FLOW_ITEM_MASK(ICMP6_ND_NS, sizeof(struct rte_flow_item_icmp6_nd_ns),
+			rte_flow_item_icmp6_nd_ns_mask),
+	MK_FLOW_ITEM_MASK(ICMP6_ND_NA, sizeof(struct rte_flow_item_icmp6_nd_na),
+			rte_flow_item_icmp6_nd_na_mask),
+	MK_FLOW_ITEM_MASK(ICMP6_ND_OPT, sizeof(struct rte_flow_item_icmp6_nd_opt),
+			rte_flow_item_icmp6_nd_opt_mask),
+	MK_FLOW_ITEM_MASK(ICMP6_ND_OPT_SLA_ETH,
+			sizeof(struct rte_flow_item_icmp6_nd_opt_sla_eth),
+			rte_flow_item_icmp6_nd_opt_sla_eth_mask),
+	MK_FLOW_ITEM_MASK(ICMP6_ND_OPT_TLA_ETH,
+			sizeof(struct rte_flow_item_icmp6_nd_opt_tla_eth),
+			rte_flow_item_icmp6_nd_opt_tla_eth_mask),
+	MK_FLOW_ITEM_MASK(MARK, sizeof(struct rte_flow_item_mark),
+			rte_flow_item_mark_mask),
+	MK_FLOW_ITEM_MASK(META, sizeof(struct rte_flow_item_meta),
+			rte_flow_item_meta_mask),
+	MK_FLOW_ITEM_MASK(RANDOM, sizeof(struct rte_flow_item_random),
+			rte_flow_item_random_mask),
+	MK_FLOW_ITEM_MASK(TAG, sizeof(struct rte_flow_item_tag),
+			rte_flow_item_tag_mask),
 	MK_FLOW_ITEM(GRE_KEY, sizeof(rte_be32_t)),
 	MK_FLOW_ITEM(GRE_OPTION, sizeof(struct rte_flow_item_gre_opt)),
-	MK_FLOW_ITEM(GTP_PSC, sizeof(struct rte_flow_item_gtp_psc)),
+	MK_FLOW_ITEM_MASK(GTP_PSC, sizeof(struct rte_flow_item_gtp_psc),
+			rte_flow_item_gtp_psc_mask),
 	MK_FLOW_ITEM(PPPOES, sizeof(struct rte_flow_item_pppoe)),
 	MK_FLOW_ITEM(PPPOED, sizeof(struct rte_flow_item_pppoe)),
-	MK_FLOW_ITEM(PPPOE_PROTO_ID,
-			sizeof(struct rte_flow_item_pppoe_proto_id)),
-	MK_FLOW_ITEM(NSH, sizeof(struct rte_flow_item_nsh)),
-	MK_FLOW_ITEM(IGMP, sizeof(struct rte_flow_item_igmp)),
-	MK_FLOW_ITEM(AH, sizeof(struct rte_flow_item_ah)),
-	MK_FLOW_ITEM(HIGIG2, sizeof(struct rte_flow_item_higig2_hdr)),
-	MK_FLOW_ITEM(L2TPV3OIP, sizeof(struct rte_flow_item_l2tpv3oip)),
-	MK_FLOW_ITEM(PFCP, sizeof(struct rte_flow_item_pfcp)),
-	MK_FLOW_ITEM(ECPRI, sizeof(struct rte_flow_item_ecpri)),
-	MK_FLOW_ITEM(GENEVE_OPT, sizeof(struct rte_flow_item_geneve_opt)),
-	MK_FLOW_ITEM(INTEGRITY, sizeof(struct rte_flow_item_integrity)),
-	MK_FLOW_ITEM(CONNTRACK, sizeof(uint32_t)),
-	MK_FLOW_ITEM(PORT_REPRESENTOR, sizeof(struct rte_flow_item_ethdev)),
-	MK_FLOW_ITEM(REPRESENTED_PORT, sizeof(struct rte_flow_item_ethdev)),
+	MK_FLOW_ITEM_MASK(PPPOE_PROTO_ID,
+			sizeof(struct rte_flow_item_pppoe_proto_id),
+			rte_flow_item_pppoe_proto_id_mask),
+	MK_FLOW_ITEM_MASK(NSH, sizeof(struct rte_flow_item_nsh),
+			rte_flow_item_nsh_mask),
+	MK_FLOW_ITEM_MASK(IGMP, sizeof(struct rte_flow_item_igmp),
+			rte_flow_item_igmp_mask),
+	MK_FLOW_ITEM_MASK(AH, sizeof(struct rte_flow_item_ah),
+			rte_flow_item_ah_mask),
+	MK_FLOW_ITEM_MASK(HIGIG2, sizeof(struct rte_flow_item_higig2_hdr),
+			rte_flow_item_higig2_hdr_mask),
+	MK_FLOW_ITEM_MASK(L2TPV3OIP, sizeof(struct rte_flow_item_l2tpv3oip),
+			rte_flow_item_l2tpv3oip_mask),
+	MK_FLOW_ITEM_MASK(PFCP, sizeof(struct rte_flow_item_pfcp),
+			rte_flow_item_pfcp_mask),
+	MK_FLOW_ITEM_MASK(ECPRI, sizeof(struct rte_flow_item_ecpri),
+			rte_flow_item_ecpri_mask),
+	MK_FLOW_ITEM_MASK(GENEVE_OPT, sizeof(struct rte_flow_item_geneve_opt),
+			rte_flow_item_geneve_opt_mask),
+	MK_FLOW_ITEM_MASK(INTEGRITY, sizeof(struct rte_flow_item_integrity),
+			rte_flow_item_integrity_mask),
+	MK_FLOW_ITEM_MASK(CONNTRACK, sizeof(uint32_t),
+			rte_flow_item_conntrack_mask),
+	MK_FLOW_ITEM_MASK(PORT_REPRESENTOR, sizeof(struct rte_flow_item_ethdev),
+			rte_flow_item_ethdev_mask),
+	MK_FLOW_ITEM_MASK(REPRESENTED_PORT, sizeof(struct rte_flow_item_ethdev),
+			rte_flow_item_ethdev_mask),
 	MK_FLOW_ITEM_FN(FLEX, sizeof(struct rte_flow_item_flex),
 			rte_flow_item_flex_conv),
-	MK_FLOW_ITEM(L2TPV2, sizeof(struct rte_flow_item_l2tpv2)),
-	MK_FLOW_ITEM(PPP, sizeof(struct rte_flow_item_ppp)),
-	MK_FLOW_ITEM(METER_COLOR, sizeof(struct rte_flow_item_meter_color)),
+	MK_FLOW_ITEM_MASK(L2TPV2, sizeof(struct rte_flow_item_l2tpv2),
+			rte_flow_item_l2tpv2_mask),
+	MK_FLOW_ITEM_MASK(PPP, sizeof(struct rte_flow_item_ppp),
+			rte_flow_item_ppp_mask),
+	MK_FLOW_ITEM_MASK(METER_COLOR, sizeof(struct rte_flow_item_meter_color),
+			rte_flow_item_meter_color_mask),
 	MK_FLOW_ITEM(IPV6_ROUTING_EXT, sizeof(struct rte_flow_item_ipv6_routing_ext)),
-	MK_FLOW_ITEM(QUOTA, sizeof(struct rte_flow_item_quota)),
-	MK_FLOW_ITEM(AGGR_AFFINITY, sizeof(struct rte_flow_item_aggr_affinity)),
-	MK_FLOW_ITEM(TX_QUEUE, sizeof(struct rte_flow_item_tx_queue)),
-	MK_FLOW_ITEM(IB_BTH, sizeof(struct rte_flow_item_ib_bth)),
-	MK_FLOW_ITEM(PTYPE, sizeof(struct rte_flow_item_ptype)),
+	MK_FLOW_ITEM_MASK(QUOTA, sizeof(struct rte_flow_item_quota),
+			rte_flow_item_quota_mask),
+	MK_FLOW_ITEM_MASK(AGGR_AFFINITY, sizeof(struct rte_flow_item_aggr_affinity),
+			rte_flow_item_aggr_affinity_mask),
+	MK_FLOW_ITEM_MASK(TX_QUEUE, sizeof(struct rte_flow_item_tx_queue),
+			rte_flow_item_tx_queue_mask),
+	MK_FLOW_ITEM_MASK(IB_BTH, sizeof(struct rte_flow_item_ib_bth),
+			rte_flow_item_ib_bth_mask),
+	MK_FLOW_ITEM_MASK(PTYPE, sizeof(struct rte_flow_item_ptype),
+			rte_flow_item_ptype_mask),
 	MK_FLOW_ITEM(COMPARE, sizeof(struct rte_flow_item_compare)),
 };
 
@@ -1118,6 +1184,24 @@ rte_flow_conv_name(int is_action,
 	return sizeof(const char **);
 }
 
+/** Retrieve the default mask pointer of a flow item type. */
+static int
+rte_flow_conv_item_default_mask(void *dst,
+				const size_t size,
+				const void *src,
+				struct rte_flow_error *error)
+{
+	unsigned int type = (uintptr_t)src;
+
+	if (type >= RTE_DIM(rte_flow_desc_item))
+		return rte_flow_error_set
+			(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			 "unknown item type to retrieve the default mask of");
+	if (size >= sizeof(const void **))
+		*((const void **)dst) = rte_flow_desc_item[type].default_mask;
+	return sizeof(const void **);
+}
+
 /** Helper function to convert flow API objects. */
 RTE_EXPORT_SYMBOL(rte_flow_conv)
 int
@@ -1179,6 +1263,9 @@ rte_flow_conv(enum rte_flow_conv_op op,
 	case RTE_FLOW_CONV_OP_ACTION_NAME_PTR:
 		ret = rte_flow_conv_name(1, 1, dst, size, src, error);
 		break;
+	case RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR:
+		ret = rte_flow_conv_item_default_mask(dst, size, src, error);
+		break;
 	default:
 		ret = rte_flow_error_set
 		(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index 1bfe1b3f619..df8101e4395 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -4411,6 +4411,21 @@ enum rte_flow_conv_op {
 	 *   @code const char ** @endcode
 	 */
 	RTE_FLOW_CONV_OP_ACTION_NAME_PTR,
+
+	/**
+	 * Convert item type to pointer to its default mask.
+	 *
+	 * Writes a pointer to rte_flow_item_{name}_mask to @p dst,
+	 * or NULL if the item type has no default mask. The mask itself is not
+	 * copied; instead, a unique pointer to an internal static constant
+	 * storage is written to @p dst.
+	 *
+	 * - @p src type:
+	 *   @code (const void *)enum rte_flow_item_type @endcode
+	 * - @p dst type:
+	 *   @code const void ** @endcode
+	 */
+	RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR,
 };
 
 /**
-- 
2.52.0

