Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E9CC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:02:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ECDB40B9A;
	Thu, 20 Aug 2026 16:02:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 34B9B40A84
 for <dev@dpdk.org>; Thu, 20 Aug 2026 16:01:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787234518; x=1818770518;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=MWmaAa903FdtNPOZxfaNJD5dHe+7AJJOM4RjHDkIkZE=;
 b=b1ndfA/sblGbXzkhVvhRa8MdecucN7NS6VNr6Yonh5rM9ucuvyLLBgvq
 v3WQHoFJNbOvjkkbGC5Plh1l4RI4dqpFfT+0Yrpp3s238DUPPToqazYQE
 TUko1035En6vKBzBOxI9+iyV9x9HwTq2N0Hpiqf5hzIBRqtK40EnK8AD8
 2HT4M/LsiKO5Yr6VoyMt+NMkZ0syFrjkovJONcA4gEO8nA3lG1dkBgWws
 U+RGS2lccktapfiaNH62QFNfz3s03OK9mk/UfWOiv5mDX8YIvRr7NfZdL
 9F/prAKwKaKSjbpUQckDQIYWfWKK3sypRJ+BCW3tEtrKaibbQdAdx/9yd A==;
X-CSE-ConnectionGUID: HFSdXDfQR7qjOmVbcjfaMg==
X-CSE-MsgGUID: P7Xv8X9VQQWEIebf5Vhekw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="75300326"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="75300326"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:01:55 -0700
X-CSE-ConnectionGUID: WoEGhsUvS86Wr8xtNrrgpA==
X-CSE-MsgGUID: y5ZllzuFTBWd8etaAYyg2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="264719704"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Aug 2026 07:01:54 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 08/21] net/ixgbe: reimplement ntuple parser
Date: Thu, 20 Aug 2026 15:00:53 +0100
Message-ID: <0f4716cde2d7b40be1f33a44e732d5e74db8f83a.1787233988.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787233986.git.anatoly.burakov@intel.com>
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
flow parser for ntuple.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c        | 461 +-----------------
 drivers/net/intel/ixgbe/ixgbe_flow.h        |   1 +
 drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c | 493 ++++++++++++++++++++
 drivers/net/intel/ixgbe/meson.build         |   1 +
 4 files changed, 496 insertions(+), 460 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index ddcc7aa83c..a77c7694b3 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -51,19 +51,12 @@
 #include "../common/flow_engine.h"
 #include "ixgbe_flow.h"
 
-#define IXGBE_MIN_N_TUPLE_PRIO 1
-#define IXGBE_MAX_N_TUPLE_PRIO 7
 #define IXGBE_MAX_FLX_SOURCE_OFF 62
 
 struct ixgbe_filter_ele_base {
 	TAILQ_ENTRY(ixgbe_filter_ele_base) entries;
 };
 
-/* ntuple filter list structure */
-struct ixgbe_ntuple_filter_ele {
-	struct ixgbe_filter_ele_base base;
-	struct rte_eth_ntuple_filter filter_info;
-};
 /* fdir filter list structure */
 struct ixgbe_fdir_rule_ele {
 	struct ixgbe_filter_ele_base base;
@@ -85,6 +78,7 @@ const struct ci_flow_engine_list ixgbe_flow_engine_list = {
 		&ixgbe_ethertype_flow_engine,
 		&ixgbe_syn_flow_engine,
 		&ixgbe_l2_tunnel_flow_engine,
+		&ixgbe_ntuple_flow_engine,
 	},
 };
 
@@ -162,355 +156,6 @@ ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
  * normally the packets should use network order.
  */
 
-/**
- * Parse the rule to see if it is a n-tuple rule.
- * And get the n-tuple filter info BTW.
- * pattern:
- * The first not void item can be ETH or IPV4.
- * The second not void item must be IPV4 if the first one is ETH.
- * The third not void item must be UDP or TCP.
- * The next not void item must be END.
- * action:
- * The first not void action should be QUEUE.
- * The next not void action should be END.
- * pattern example:
- * ITEM		Spec			Mask
- * ETH		NULL			NULL
- * IPV4		src_addr 192.168.1.20	0xFFFFFFFF
- *		dst_addr 192.167.3.50	0xFFFFFFFF
- *		next_proto_id	17	0xFF
- * UDP/TCP/	src_port	80	0xFFFF
- * SCTP		dst_port	80	0xFFFF
- * END
- * other members in mask and spec should set to 0x00.
- * item->last should be NULL.
- *
- * Special case for flow action type RTE_FLOW_ACTION_TYPE_SECURITY.
- *
- */
-static int
-cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
-			 const struct rte_flow_item pattern[],
-			 const struct rte_flow_action_queue *q_act,
-			 struct rte_eth_ntuple_filter *filter,
-			 struct rte_flow_error *error)
-{
-	const struct rte_flow_item *item;
-	const struct rte_flow_item_ipv4 *ipv4_spec;
-	const struct rte_flow_item_ipv4 *ipv4_mask;
-	const struct rte_flow_item_tcp *tcp_spec;
-	const struct rte_flow_item_tcp *tcp_mask;
-	const struct rte_flow_item_udp *udp_spec;
-	const struct rte_flow_item_udp *udp_mask;
-	const struct rte_flow_item_sctp *sctp_spec;
-	const struct rte_flow_item_sctp *sctp_mask;
-	const struct rte_flow_item_eth *eth_spec;
-	const struct rte_flow_item_eth *eth_mask;
-	const struct rte_flow_item_vlan *vlan_spec;
-	const struct rte_flow_item_vlan *vlan_mask;
-	struct rte_flow_item_eth eth_null;
-	struct rte_flow_item_vlan vlan_null;
-
-	/* Priority must be 16-bit */
-	if (attr->priority > UINT16_MAX) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY, attr,
-				"Priority must be 16-bit");
-	}
-
-	memset(&eth_null, 0, sizeof(struct rte_flow_item_eth));
-	memset(&vlan_null, 0, sizeof(struct rte_flow_item_vlan));
-
-	/* the first not void item can be MAC or IPv4 */
-	item = next_no_void_pattern(pattern, NULL);
-
-	if (item->type != RTE_FLOW_ITEM_TYPE_ETH &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV4) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by ntuple filter");
-		return -rte_errno;
-	}
-	/* Skip Ethernet */
-	if (item->type == RTE_FLOW_ITEM_TYPE_ETH) {
-		eth_spec = item->spec;
-		eth_mask = item->mask;
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error,
-			  EINVAL,
-			  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			  item, "Not supported last point for range");
-			return -rte_errno;
-
-		}
-		/* if the first item is MAC, the content should be NULL */
-		if ((item->spec != NULL && memcmp(eth_spec, &eth_null, sizeof(eth_null)) != 0) ||
-		    (item->mask != NULL && memcmp(eth_mask, &eth_null, sizeof(eth_null)) != 0)) {
-			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM, item,
-					"Not supported by ntuple filter");
-			return -rte_errno;
-		}
-		/* check if the next not void item is IPv4 or Vlan */
-		item = next_no_void_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-			item->type != RTE_FLOW_ITEM_TYPE_VLAN) {
-			rte_flow_error_set(error,
-			  EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
-			  item, "Not supported by ntuple filter");
-			  return -rte_errno;
-		}
-	}
-
-	if (item->type == RTE_FLOW_ITEM_TYPE_VLAN) {
-		vlan_spec = item->spec;
-		vlan_mask = item->mask;
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error,
-			  EINVAL,
-			  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			  item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		/* the content should be NULL */
-		if ((item->spec != NULL && memcmp(vlan_spec, &vlan_null, sizeof(vlan_null)) != 0) ||
-		    (item->mask != NULL && memcmp(vlan_mask, &vlan_null, sizeof(vlan_null)) != 0)) {
-			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM, item,
-					"Not supported by ntuple filter");
-			return -rte_errno;
-		}
-		/* check if the next not void item is IPv4 */
-		item = next_no_void_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_IPV4) {
-			rte_flow_error_set(error,
-			  EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
-			  item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-	}
-
-	if (item->mask) {
-		/* get the IPv4 info */
-		if (!item->spec || !item->mask) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Invalid ntuple mask");
-			return -rte_errno;
-		}
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		ipv4_mask = item->mask;
-		/**
-		 * Only support src & dst addresses, protocol,
-		 * others should be masked.
-		 */
-		if (ipv4_mask->hdr.version_ihl ||
-		    ipv4_mask->hdr.type_of_service ||
-		    ipv4_mask->hdr.total_length ||
-		    ipv4_mask->hdr.packet_id ||
-		    ipv4_mask->hdr.fragment_offset ||
-		    ipv4_mask->hdr.time_to_live ||
-		    ipv4_mask->hdr.hdr_checksum) {
-			rte_flow_error_set(error,
-				EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-		if ((ipv4_mask->hdr.src_addr != 0 &&
-			ipv4_mask->hdr.src_addr != UINT32_MAX) ||
-			(ipv4_mask->hdr.dst_addr != 0 &&
-			ipv4_mask->hdr.dst_addr != UINT32_MAX) ||
-			(ipv4_mask->hdr.next_proto_id != UINT8_MAX &&
-			ipv4_mask->hdr.next_proto_id != 0)) {
-			rte_flow_error_set(error,
-				EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-
-		filter->dst_ip_mask = ipv4_mask->hdr.dst_addr;
-		filter->src_ip_mask = ipv4_mask->hdr.src_addr;
-		filter->proto_mask  = ipv4_mask->hdr.next_proto_id;
-
-		ipv4_spec = item->spec;
-		filter->dst_ip = ipv4_spec->hdr.dst_addr;
-		filter->src_ip = ipv4_spec->hdr.src_addr;
-		filter->proto  = ipv4_spec->hdr.next_proto_id;
-	}
-
-	/* check if the next not void item is TCP or UDP */
-	item = next_no_void_pattern(pattern, item);
-	if (item->type != RTE_FLOW_ITEM_TYPE_TCP &&
-	    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-	    item->type != RTE_FLOW_ITEM_TYPE_SCTP &&
-	    item->type != RTE_FLOW_ITEM_TYPE_END) {
-		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by ntuple filter");
-		return -rte_errno;
-	}
-
-	if ((item->type != RTE_FLOW_ITEM_TYPE_END) &&
-		(!item->spec && !item->mask)) {
-		goto action;
-	}
-
-	/* get the TCP/UDP/SCTP info */
-	if (item->type != RTE_FLOW_ITEM_TYPE_END &&
-		(!item->spec || !item->mask)) {
-		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Invalid ntuple mask");
-		return -rte_errno;
-	}
-
-	/*Not supported last point for range*/
-	if (item->last) {
-		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			item, "Not supported last point for range");
-		return -rte_errno;
-
-	}
-
-	if (item->type == RTE_FLOW_ITEM_TYPE_TCP) {
-		tcp_mask = item->mask;
-
-		/**
-		 * Only support src & dst ports, tcp flags,
-		 * others should be masked.
-		 */
-		if (tcp_mask->hdr.sent_seq ||
-		    tcp_mask->hdr.recv_ack ||
-		    tcp_mask->hdr.data_off ||
-		    tcp_mask->hdr.rx_win ||
-		    tcp_mask->hdr.cksum ||
-		    tcp_mask->hdr.tcp_urp) {
-			memset(filter, 0,
-				sizeof(struct rte_eth_ntuple_filter));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-		if ((tcp_mask->hdr.src_port != 0 &&
-			tcp_mask->hdr.src_port != UINT16_MAX) ||
-			(tcp_mask->hdr.dst_port != 0 &&
-			tcp_mask->hdr.dst_port != UINT16_MAX)) {
-			rte_flow_error_set(error,
-				EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-
-		filter->dst_port_mask  = tcp_mask->hdr.dst_port;
-		filter->src_port_mask  = tcp_mask->hdr.src_port;
-		if (tcp_mask->hdr.tcp_flags == 0xFF) {
-			filter->flags |= RTE_NTUPLE_FLAGS_TCP_FLAG;
-		} else if (!tcp_mask->hdr.tcp_flags) {
-			filter->flags &= ~RTE_NTUPLE_FLAGS_TCP_FLAG;
-		} else {
-			memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-
-		tcp_spec = item->spec;
-		filter->dst_port  = tcp_spec->hdr.dst_port;
-		filter->src_port  = tcp_spec->hdr.src_port;
-		filter->tcp_flags = tcp_spec->hdr.tcp_flags;
-	} else if (item->type == RTE_FLOW_ITEM_TYPE_UDP) {
-		udp_mask = item->mask;
-
-		/**
-		 * Only support src & dst ports,
-		 * others should be masked.
-		 */
-		if (udp_mask->hdr.dgram_len ||
-		    udp_mask->hdr.dgram_cksum) {
-			memset(filter, 0,
-				sizeof(struct rte_eth_ntuple_filter));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-		if ((udp_mask->hdr.src_port != 0 &&
-			udp_mask->hdr.src_port != UINT16_MAX) ||
-			(udp_mask->hdr.dst_port != 0 &&
-			udp_mask->hdr.dst_port != UINT16_MAX)) {
-			rte_flow_error_set(error,
-				EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-
-		filter->dst_port_mask = udp_mask->hdr.dst_port;
-		filter->src_port_mask = udp_mask->hdr.src_port;
-
-		udp_spec = item->spec;
-		filter->dst_port = udp_spec->hdr.dst_port;
-		filter->src_port = udp_spec->hdr.src_port;
-	} else if (item->type == RTE_FLOW_ITEM_TYPE_SCTP) {
-		sctp_mask = item->mask;
-
-		/**
-		 * Only support src & dst ports,
-		 * others should be masked.
-		 */
-		if (sctp_mask->hdr.tag ||
-		    sctp_mask->hdr.cksum) {
-			memset(filter, 0,
-				sizeof(struct rte_eth_ntuple_filter));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-
-		filter->dst_port_mask = sctp_mask->hdr.dst_port;
-		filter->src_port_mask = sctp_mask->hdr.src_port;
-
-		sctp_spec = item->spec;
-		filter->dst_port = sctp_spec->hdr.dst_port;
-		filter->src_port = sctp_spec->hdr.src_port;
-	} else {
-		goto action;
-	}
-
-	/* check if the next not void item is END */
-	item = next_no_void_pattern(pattern, item);
-	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by ntuple filter");
-		return -rte_errno;
-	}
-
-action:
-
-	filter->queue = q_act->index;
-
-	filter->priority = (uint16_t)attr->priority;
-	if (attr->priority < IXGBE_MIN_N_TUPLE_PRIO || attr->priority > IXGBE_MAX_N_TUPLE_PRIO)
-		filter->priority = 1;
-
-	return 0;
-}
-
 static int
 ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
 		const struct rte_flow_item pattern[], const struct rte_flow_action actions[],
@@ -599,66 +244,6 @@ ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct rte_flow_attr
 	return 0;
 }
 
-/* a specific function for ixgbe because the flags is specific */
-static int
-ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
-			  const struct rte_flow_attr *attr,
-			  const struct rte_flow_item pattern[],
-			  const struct rte_flow_action actions[],
-			  struct rte_eth_ntuple_filter *filter,
-			  struct rte_flow_error *error)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ci_flow_attr_check_param attr_param = {
-		.allow_priority = true,
-	};
-	struct ci_flow_actions parsed_actions;
-	struct ci_flow_actions_check_param ap_param = {
-		.allowed_types = (const enum rte_flow_action_type[]){
-			/* only queue is allowed here */
-			RTE_FLOW_ACTION_TYPE_QUEUE,
-			RTE_FLOW_ACTION_TYPE_END
-		},
-		.driver_ctx = dev->data,
-		.check = ixgbe_flow_actions_check,
-		.max_actions = 1,
-	};
-	const struct rte_flow_action *action;
-	int ret;
-
-	if (hw->mac.type != ixgbe_mac_82599EB &&
-			hw->mac.type != ixgbe_mac_X540)
-		return -ENOTSUP;
-
-	/* validate attributes */
-	ret = ci_flow_check_attr(attr, &attr_param, error);
-	if (ret)
-		return ret;
-
-	/* parse requested actions */
-	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
-	if (ret)
-		return ret;
-	action = parsed_actions.actions[0];
-
-	ret = cons_parse_ntuple_filter(attr, pattern, action->conf, filter, error);
-	if (ret)
-		return ret;
-
-	/* Ixgbe doesn't support tcp flags. */
-	if (filter->flags & RTE_NTUPLE_FLAGS_TCP_FLAG) {
-		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ITEM,
-				   NULL, "Not supported by ntuple filter");
-		return -rte_errno;
-	}
-
-	/* fixed value for ixgbe */
-	filter->flags = RTE_5TUPLE_FLAGS;
-	return 0;
-}
-
 /* search next no void pattern and skip fuzzy */
 static inline
 const struct rte_flow_item *next_no_fuzzy_pattern(
@@ -2289,13 +1874,11 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	int ret;
 	struct ixgbe_adapter *adapter =
 		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct rte_eth_ntuple_filter ntuple_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_hw_fdir_info *fdir_info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	struct rte_flow *flow = NULL;
-	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
@@ -2332,29 +1915,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		return flow;
 	}
 
-	memset(&ntuple_filter, 0, sizeof(struct rte_eth_ntuple_filter));
-	ret = ixgbe_parse_ntuple_filter(dev, attr, pattern,
-			actions, &ntuple_filter, error);
-
-	if (!ret) {
-		ret = ixgbe_add_del_ntuple_filter(adapter, &ntuple_filter, TRUE);
-		if (!ret) {
-			ntuple_filter_ptr = rte_zmalloc("ixgbe_ntuple_filter",
-				sizeof(struct ixgbe_ntuple_filter_ele), 0);
-			if (!ntuple_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			memcpy(&ntuple_filter_ptr->filter_info,
-				&ntuple_filter,
-				sizeof(struct rte_eth_ntuple_filter));
-			flow->rule = ntuple_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_NTUPLE;
-			return flow;
-		}
-		goto out;
-	}
-
 	memset(&fdir_rule, 0, sizeof(struct ixgbe_fdir_rule));
 	ret = ixgbe_parse_fdir_filter(dev, attr, pattern,
 				actions, &fdir_rule, error);
@@ -2434,7 +1994,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 		struct rte_flow_error *error)
 {
 	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct rte_eth_ntuple_filter ntuple_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	int ret;
@@ -2453,12 +2012,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 	if (!ret)
 		return 0;
 
-	memset(&ntuple_filter, 0, sizeof(struct rte_eth_ntuple_filter));
-	ret = ixgbe_parse_ntuple_filter(dev, attr, pattern,
-				actions, &ntuple_filter, error);
-	if (!ret)
-		return 0;
-
 	memset(&fdir_rule, 0, sizeof(struct ixgbe_fdir_rule));
 	ret = ixgbe_parse_fdir_filter(dev, attr, pattern,
 				actions, &fdir_rule, error);
@@ -2483,9 +2036,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_flow *pmd_flow = flow;
 	enum rte_filter_type filter_type = pmd_flow->filter_type;
-	struct rte_eth_ntuple_filter ntuple_filter;
 	struct ixgbe_fdir_rule fdir_rule;
-	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_filter_ele_base *flow_mem_base;
 	struct ixgbe_hw_fdir_info *fdir_info =
@@ -2521,16 +2072,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	}
 
 	switch (filter_type) {
-	case RTE_ETH_FILTER_NTUPLE:
-		ntuple_filter_ptr = (struct ixgbe_ntuple_filter_ele *)
-					pmd_flow->rule;
-		memcpy(&ntuple_filter,
-			&ntuple_filter_ptr->filter_info,
-			sizeof(struct rte_eth_ntuple_filter));
-		ret = ixgbe_add_del_ntuple_filter(adapter, &ntuple_filter, FALSE);
-		if (!ret)
-			rte_free(ntuple_filter_ptr);
-		break;
 	case RTE_ETH_FILTER_FDIR:
 		fdir_rule_ptr = (struct ixgbe_fdir_rule_ele *)pmd_flow->rule;
 		memcpy(&fdir_rule,
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index ba0486b2c0..6f082e9402 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.h
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -18,5 +18,6 @@ extern const struct ci_flow_engine_list ixgbe_flow_engine_list;
 extern const struct ci_flow_engine ixgbe_ethertype_flow_engine;
 extern const struct ci_flow_engine ixgbe_syn_flow_engine;
 extern const struct ci_flow_engine ixgbe_l2_tunnel_flow_engine;
+extern const struct ci_flow_engine ixgbe_ntuple_flow_engine;
 
 #endif /*  _IXGBE_FLOW_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c b/drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c
new file mode 100644
index 0000000000..bddadba9f8
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c
@@ -0,0 +1,493 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <rte_flow.h>
+#include <rte_flow_graph.h>
+#include <rte_ether.h>
+
+#include "ixgbe_ethdev.h"
+#include "ixgbe_flow.h"
+#include "../common/flow_check.h"
+#include "../common/flow_util.h"
+#include "../common/flow_engine.h"
+
+#define IXGBE_MIN_N_TUPLE_PRIO 1
+#define IXGBE_MAX_N_TUPLE_PRIO 7
+
+struct ixgbe_ntuple_flow {
+	struct rte_flow flow;
+	struct rte_eth_ntuple_filter ntuple;
+};
+
+struct ixgbe_ntuple_ctx {
+	struct ci_flow_engine_ctx base;
+	struct rte_eth_ntuple_filter ntuple;
+};
+
+/**
+ * Ntuple filter graph implementation
+ * Pattern: START -> [ETH] -> [VLAN] -> IPV4 -> [TCP|UDP|SCTP] -> END
+ */
+
+enum ixgbe_ntuple_node_id {
+	IXGBE_NTUPLE_NODE_START = RTE_FLOW_NODE_FIRST,
+	IXGBE_NTUPLE_NODE_ETH,
+	IXGBE_NTUPLE_NODE_VLAN,
+	IXGBE_NTUPLE_NODE_IPV4,
+	IXGBE_NTUPLE_NODE_TCP,
+	IXGBE_NTUPLE_NODE_UDP,
+	IXGBE_NTUPLE_NODE_SCTP,
+	IXGBE_NTUPLE_NODE_END,
+	IXGBE_NTUPLE_NODE_MAX,
+};
+
+static int
+ixgbe_validate_ntuple_ipv4(const void *ctx __rte_unused,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error)
+{
+	const struct rte_flow_item_ipv4 *ipv4_mask;
+
+	ipv4_mask = item->mask;
+
+	/* Only src/dst addresses and protocol supported */
+	if (ipv4_mask->hdr.version_ihl ||
+	    ipv4_mask->hdr.type_of_service ||
+	    ipv4_mask->hdr.total_length ||
+	    ipv4_mask->hdr.packet_id ||
+	    ipv4_mask->hdr.fragment_offset ||
+	    ipv4_mask->hdr.time_to_live ||
+	    ipv4_mask->hdr.hdr_checksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst IP and protocol supported");
+	}
+
+	/* Masks must be 0 or all-ones */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&ipv4_mask->hdr.src_addr) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&ipv4_mask->hdr.dst_addr) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&ipv4_mask->hdr.next_proto_id)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial masks not supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_ntuple_ipv4(void *ctx,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_ntuple_ctx *ntuple_ctx = ctx;
+	const struct rte_flow_item_ipv4 *ipv4_spec = item->spec;
+	const struct rte_flow_item_ipv4 *ipv4_mask = item->mask;
+
+	ntuple_ctx->ntuple.dst_ip = ipv4_spec->hdr.dst_addr;
+	ntuple_ctx->ntuple.src_ip = ipv4_spec->hdr.src_addr;
+	ntuple_ctx->ntuple.proto = ipv4_spec->hdr.next_proto_id;
+
+	ntuple_ctx->ntuple.dst_ip_mask = ipv4_mask->hdr.dst_addr;
+	ntuple_ctx->ntuple.src_ip_mask = ipv4_mask->hdr.src_addr;
+	ntuple_ctx->ntuple.proto_mask = ipv4_mask->hdr.next_proto_id;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_ntuple_tcp(const void *ctx __rte_unused,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error)
+{
+	const struct rte_flow_item_tcp *tcp_mask;
+
+	tcp_mask = item->mask;
+
+	/* Only src/dst ports and tcp_flags supported */
+	if (tcp_mask->hdr.sent_seq ||
+	    tcp_mask->hdr.recv_ack ||
+	    tcp_mask->hdr.data_off ||
+	    tcp_mask->hdr.rx_win ||
+	    tcp_mask->hdr.cksum ||
+	    tcp_mask->hdr.tcp_urp) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst ports and flags supported");
+	}
+
+	/* Port masks must be 0 or all-ones */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&tcp_mask->hdr.src_port) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&tcp_mask->hdr.dst_port)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial port masks not supported");
+	}
+
+	/* TCP flags not supported by hardware */
+	if (!CI_FIELD_IS_ZERO(&tcp_mask->hdr.tcp_flags)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"TCP flags filtering not supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_ntuple_tcp(void *ctx,
+			 const struct rte_flow_item *item,
+			 struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_ntuple_ctx *ntuple_ctx = ctx;
+	const struct rte_flow_item_tcp *tcp_spec = item->spec;
+	const struct rte_flow_item_tcp *tcp_mask = item->mask;
+
+	ntuple_ctx->ntuple.dst_port = tcp_spec->hdr.dst_port;
+	ntuple_ctx->ntuple.src_port = tcp_spec->hdr.src_port;
+
+	ntuple_ctx->ntuple.dst_port_mask = tcp_mask->hdr.dst_port;
+	ntuple_ctx->ntuple.src_port_mask = tcp_mask->hdr.src_port;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_ntuple_udp(const void *ctx __rte_unused,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error)
+{
+	const struct rte_flow_item_udp *udp_mask;
+
+	udp_mask = item->mask;
+
+	/* Only src/dst ports supported */
+	if (udp_mask->hdr.dgram_len ||
+	    udp_mask->hdr.dgram_cksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst ports supported");
+	}
+
+	/* Port masks must be 0 or all-ones */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&udp_mask->hdr.src_port) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&udp_mask->hdr.dst_port)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial port masks not supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_ntuple_udp(void *ctx,
+			 const struct rte_flow_item *item,
+			 struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_ntuple_ctx *ntuple_ctx = ctx;
+	const struct rte_flow_item_udp *udp_spec = item->spec;
+	const struct rte_flow_item_udp *udp_mask = item->mask;
+
+	ntuple_ctx->ntuple.dst_port = udp_spec->hdr.dst_port;
+	ntuple_ctx->ntuple.src_port = udp_spec->hdr.src_port;
+
+	ntuple_ctx->ntuple.dst_port_mask = udp_mask->hdr.dst_port;
+	ntuple_ctx->ntuple.src_port_mask = udp_mask->hdr.src_port;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_ntuple_sctp(const void *ctx __rte_unused,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error)
+{
+	const struct rte_flow_item_sctp *sctp_mask;
+
+	sctp_mask = item->mask;
+
+	/* Only src/dst ports supported */
+	if (sctp_mask->hdr.tag ||
+	    sctp_mask->hdr.cksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst ports supported");
+	}
+
+	/* Port masks must be 0 or all-ones */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&sctp_mask->hdr.src_port) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&sctp_mask->hdr.dst_port)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial port masks not supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_ntuple_sctp(void *ctx,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_ntuple_ctx *ntuple_ctx = ctx;
+	const struct rte_flow_item_sctp *sctp_spec = item->spec;
+	const struct rte_flow_item_sctp *sctp_mask = item->mask;
+
+	ntuple_ctx->ntuple.dst_port = sctp_spec->hdr.dst_port;
+	ntuple_ctx->ntuple.src_port = sctp_spec->hdr.src_port;
+
+	ntuple_ctx->ntuple.dst_port_mask = sctp_mask->hdr.dst_port;
+	ntuple_ctx->ntuple.src_port_mask = sctp_mask->hdr.src_port;
+
+	return 0;
+}
+
+static const struct rte_flow_graph ixgbe_ntuple_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[IXGBE_NTUPLE_NODE_START] = {
+			.name = "START",
+		},
+		[IXGBE_NTUPLE_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_NTUPLE_NODE_VLAN] = {
+			.name = "VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_NTUPLE_NODE_IPV4] = {
+			.name = "IPV4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = ixgbe_validate_ntuple_ipv4,
+			.process = ixgbe_process_ntuple_ipv4,
+		},
+		[IXGBE_NTUPLE_NODE_TCP] = {
+			.name = "TCP",
+			.type = RTE_FLOW_ITEM_TYPE_TCP,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = ixgbe_validate_ntuple_tcp,
+			.process = ixgbe_process_ntuple_tcp,
+		},
+		[IXGBE_NTUPLE_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = ixgbe_validate_ntuple_udp,
+			.process = ixgbe_process_ntuple_udp,
+		},
+		[IXGBE_NTUPLE_NODE_SCTP] = {
+			.name = "SCTP",
+			.type = RTE_FLOW_ITEM_TYPE_SCTP,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = ixgbe_validate_ntuple_sctp,
+			.process = ixgbe_process_ntuple_sctp,
+		},
+		[IXGBE_NTUPLE_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct rte_flow_graph_edge[]) {
+		[IXGBE_NTUPLE_NODE_START] = {
+			.next = (const size_t[]) {
+				IXGBE_NTUPLE_NODE_ETH,
+				IXGBE_NTUPLE_NODE_IPV4,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_NTUPLE_NODE_ETH] = {
+			.next = (const size_t[]) {
+				IXGBE_NTUPLE_NODE_VLAN,
+				IXGBE_NTUPLE_NODE_IPV4,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_NTUPLE_NODE_VLAN] = {
+			.next = (const size_t[]) {
+				IXGBE_NTUPLE_NODE_IPV4,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_NTUPLE_NODE_IPV4] = {
+			.next = (const size_t[]) {
+				IXGBE_NTUPLE_NODE_TCP,
+				IXGBE_NTUPLE_NODE_UDP,
+				IXGBE_NTUPLE_NODE_SCTP,
+				IXGBE_NTUPLE_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_NTUPLE_NODE_TCP] = {
+			.next = (const size_t[]) {
+				IXGBE_NTUPLE_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_NTUPLE_NODE_UDP] = {
+			.next = (const size_t[]) {
+				IXGBE_NTUPLE_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_NTUPLE_NODE_SCTP] = {
+			.next = (const size_t[]) {
+				IXGBE_NTUPLE_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static int
+ixgbe_flow_ntuple_ctx_parse(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_ntuple_ctx *ntuple_ctx = (struct ixgbe_ntuple_ctx *)ctx;
+	struct ci_flow_attr_check_param attr_param = {
+		.allow_priority = true,
+	};
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* only queue is allowed here */
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.driver_ctx = ctx->dev_data,
+		.check = ixgbe_flow_actions_check,
+		.max_actions = 1,
+	};
+	const struct rte_flow_action_queue *q_act;
+	uint16_t priority;
+	int ret;
+
+	/* validate attributes */
+	ret = ci_flow_check_attr(attr, &attr_param, error);
+	if (ret)
+		return ret;
+
+	/* Priority must be 16-bit */
+	if (attr->priority > UINT16_MAX) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY, attr,
+				"Priority must be 16-bit");
+	}
+
+	/* parse requested actions */
+	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
+	q_act = (const struct rte_flow_action_queue *)parsed_actions.actions[0]->conf;
+
+	ntuple_ctx->ntuple.queue = q_act->index;
+
+	/*
+	* rte_flow priority: 0 through UINT32_MAX, 0 is highest
+	*
+	 * ntuple priority: 001b through 111b, 111b is highest
+	 *
+	 * which means we need to transform priority from rte_flow to ntuple:
+	 *
+	 * 1) clamp max value
+	 * 2) reverse
+	 * 3) add min value
+	 */
+	priority = RTE_MIN(IXGBE_MAX_N_TUPLE_PRIO - 1, (uint16_t)attr->priority);
+	priority = IXGBE_MAX_N_TUPLE_PRIO - 1 - priority;
+	priority += IXGBE_MIN_N_TUPLE_PRIO;
+	ntuple_ctx->ntuple.priority = priority;
+
+	/* fixed value for ixgbe */
+	ntuple_ctx->ntuple.flags = RTE_5TUPLE_FLAGS;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ntuple_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct ixgbe_ntuple_ctx *ntuple_ctx = (const struct ixgbe_ntuple_ctx *)ctx;
+	struct ixgbe_ntuple_flow *ntuple_flow = (struct ixgbe_ntuple_flow *)flow;
+
+	ntuple_flow->ntuple = ntuple_ctx->ntuple;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ntuple_flow_install(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_ntuple_flow *ntuple_flow = (struct ixgbe_ntuple_flow *)flow;
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(flow->dev_data->dev_private);
+	int ret;
+
+	ret = ixgbe_add_del_ntuple_filter(adapter, &ntuple_flow->ntuple, TRUE);
+	if (ret) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to add ntuple filter");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ntuple_flow_uninstall(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_ntuple_flow *ntuple_flow = (struct ixgbe_ntuple_flow *)flow;
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(flow->dev_data->dev_private);
+	int ret;
+
+	ret = ixgbe_add_del_ntuple_filter(adapter, &ntuple_flow->ntuple, FALSE);
+	if (ret) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to delete ntuple filter");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ntuple_engine_init(const struct ci_flow_engine *engine __rte_unused,
+		struct rte_eth_dev_data *dev_data,
+		void *priv __rte_unused)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev_data->dev_private);
+
+	/* only 82599 and X540 have L3/L4 5-tuple (ntuple) filters */
+	if (hw->mac.type == ixgbe_mac_82599EB ||
+			hw->mac.type == ixgbe_mac_X540)
+		return 0;
+
+	return -ENOTSUP;
+}
+
+static const struct ci_flow_engine_ops ixgbe_ntuple_ops = {
+	.engine_init = ixgbe_flow_ntuple_engine_init,
+	.ctx_parse = ixgbe_flow_ntuple_ctx_parse,
+	.ctx_to_flow = ixgbe_flow_ntuple_ctx_to_flow,
+	.flow_install = ixgbe_flow_ntuple_flow_install,
+	.flow_uninstall = ixgbe_flow_ntuple_flow_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_ntuple_flow_engine = {
+	.name = "ntuple",
+	.ctx_size = sizeof(struct ixgbe_ntuple_ctx),
+	.flow_size = sizeof(struct ixgbe_ntuple_flow),
+	.ops = &ixgbe_ntuple_ops,
+	.graph = &ixgbe_ntuple_graph,
+};
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 0aaeb82a36..f3052daf4f 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -14,6 +14,7 @@ sources += files(
         'ixgbe_flow_ethertype.c',
         'ixgbe_flow_syn.c',
         'ixgbe_flow_l2tun.c',
+        'ixgbe_flow_ntuple.c',
         'ixgbe_ipsec.c',
         'ixgbe_pf.c',
         'ixgbe_rxtx.c',
-- 
2.52.0

