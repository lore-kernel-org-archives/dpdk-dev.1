Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CB2F53D80
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:29:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C86940677;
	Mon, 16 Mar 2026 18:28:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5937940687
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682089; x=1805218089;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=LZJE3XrU9Koa9BslWUXGru0idleOmcu1YxK2mTcm9kI=;
 b=E2J+0n/FBDvjbgKUSczDN99wSaODQd4DqVx37A00mCjf0xdhtHAj7jm1
 qjgwQqHOfGKhKUfxgHrhxg8CGu3z/CZqd+tHQCfxj5Rd5jtfSWsQ54/2H
 50j9If60vrLhKEgkr7clYka4pUXu2aU6ZVll3AjI5iXmLNbsM3h6Gm8Xa
 E5uwW8bDpHctOZV6GrtmLU2E5vCE3CEbvByrD6CX4KYZvF89NWUqYbqEm
 nDYiuDYPV08uMUaDRnWknH/E7syFXI/HPW/fNXY9MA5I1OQ7Ml9/yYGtv
 UIfXE8Xt5HZKK+jvA7ftrvqalq+UtySinW57Sy1w5Dj2ArZ38O6i8CChY g==;
X-CSE-ConnectionGUID: HalkRbm1SHuBycbyimxnIw==
X-CSE-MsgGUID: LmIJFl42QoaPnh08vxOb+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059630"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059630"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:07 -0700
X-CSE-ConnectionGUID: hXqDpJj4SeWoUcS4UsSuAw==
X-CSE-MsgGUID: +3vaeeMtREitaBr07x25wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228224"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:07 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC PATCH v1 08/21] net/ixgbe: reimplement ntuple parser
Date: Mon, 16 Mar 2026 17:27:36 +0000
Message-ID: <fd717bae0342aed50c3d552879971bd407f85f1f.1773681365.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773681363.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/ixgbe/ixgbe_flow.c        | 486 +-------------------
 drivers/net/intel/ixgbe/ixgbe_flow.h        |   2 +
 drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c | 483 +++++++++++++++++++
 drivers/net/intel/ixgbe/meson.build         |   1 +
 4 files changed, 487 insertions(+), 485 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 313af2362b..f509b47733 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -48,15 +48,8 @@
 #include "../common/flow_engine.h"
 #include "ixgbe_flow.h"
 
-#define IXGBE_MIN_N_TUPLE_PRIO 1
-#define IXGBE_MAX_N_TUPLE_PRIO 7
 #define IXGBE_MAX_FLX_SOURCE_OFF 62
 
-/* ntuple filter list structure */
-struct ixgbe_ntuple_filter_ele {
-	TAILQ_ENTRY(ixgbe_ntuple_filter_ele) entries;
-	struct rte_eth_ntuple_filter filter_info;
-};
 /* fdir filter list structure */
 struct ixgbe_fdir_rule_ele {
 	TAILQ_ENTRY(ixgbe_fdir_rule_ele) entries;
@@ -73,12 +66,10 @@ struct ixgbe_flow_mem {
 	struct rte_flow *flow;
 };
 
-TAILQ_HEAD(ixgbe_ntuple_filter_list, ixgbe_ntuple_filter_ele);
 TAILQ_HEAD(ixgbe_fdir_rule_filter_list, ixgbe_fdir_rule_ele);
 TAILQ_HEAD(ixgbe_rss_filter_list, ixgbe_rss_conf_ele);
 TAILQ_HEAD(ixgbe_flow_mem_list, ixgbe_flow_mem);
 
-static struct ixgbe_ntuple_filter_list filter_ntuple_list;
 static struct ixgbe_fdir_rule_filter_list filter_fdir_list;
 static struct ixgbe_rss_filter_list filter_rss_list;
 static struct ixgbe_flow_mem_list ixgbe_flow_list;
@@ -88,6 +79,7 @@ const struct ci_flow_engine_list ixgbe_flow_engine_list = {
 		&ixgbe_ethertype_flow_engine,
 		&ixgbe_syn_flow_engine,
 		&ixgbe_l2_tunnel_flow_engine,
+		&ixgbe_ntuple_flow_engine,
 	},
 };
 
@@ -165,364 +157,6 @@ ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
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
-		if ((item->spec || item->mask) &&
-			(memcmp(eth_spec, &eth_null,
-				sizeof(struct rte_flow_item_eth)) ||
-			 memcmp(eth_mask, &eth_null,
-				sizeof(struct rte_flow_item_eth)))) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
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
-		if ((item->spec || item->mask) &&
-			(memcmp(vlan_spec, &vlan_null,
-				sizeof(struct rte_flow_item_vlan)) ||
-			 memcmp(vlan_mask, &vlan_null,
-				sizeof(struct rte_flow_item_vlan)))) {
-
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
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
@@ -611,66 +245,6 @@ ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct rte_flow_attr
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
-		.driver_ctx = dev,
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
@@ -2178,7 +1752,6 @@ ixgbe_clear_rss_filter(struct rte_eth_dev *dev)
 void
 ixgbe_filterlist_init(void)
 {
-	TAILQ_INIT(&filter_ntuple_list);
 	TAILQ_INIT(&filter_fdir_list);
 	TAILQ_INIT(&filter_rss_list);
 	TAILQ_INIT(&ixgbe_flow_list);
@@ -2187,18 +1760,10 @@ ixgbe_filterlist_init(void)
 void
 ixgbe_filterlist_flush(void)
 {
-	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 
-	while ((ntuple_filter_ptr = TAILQ_FIRST(&filter_ntuple_list))) {
-		TAILQ_REMOVE(&filter_ntuple_list,
-				 ntuple_filter_ptr,
-				 entries);
-		rte_free(ntuple_filter_ptr);
-	}
-
 	while ((fdir_rule_ptr = TAILQ_FIRST(&filter_fdir_list))) {
 		TAILQ_REMOVE(&filter_fdir_list,
 				 fdir_rule_ptr,
@@ -2237,13 +1802,11 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 {
 	struct ixgbe_adapter *ad = dev->data->dev_private;
 	int ret;
-	struct rte_eth_ntuple_filter ntuple_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_hw_fdir_info *fdir_info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	struct rte_flow *flow = NULL;
-	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
@@ -2283,31 +1846,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		return flow;
 	}
 
-	memset(&ntuple_filter, 0, sizeof(struct rte_eth_ntuple_filter));
-	ret = ixgbe_parse_ntuple_filter(dev, attr, pattern,
-			actions, &ntuple_filter, error);
-
-	if (!ret) {
-		ret = ixgbe_add_del_ntuple_filter(dev, &ntuple_filter, TRUE);
-		if (!ret) {
-			ntuple_filter_ptr = rte_zmalloc("ixgbe_ntuple_filter",
-				sizeof(struct ixgbe_ntuple_filter_ele), 0);
-			if (!ntuple_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			rte_memcpy(&ntuple_filter_ptr->filter_info,
-				&ntuple_filter,
-				sizeof(struct rte_eth_ntuple_filter));
-			TAILQ_INSERT_TAIL(&filter_ntuple_list,
-				ntuple_filter_ptr, entries);
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
@@ -2429,7 +1967,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 		struct rte_flow_error *error)
 {
 	struct ixgbe_adapter *ad = dev->data->dev_private;
-	struct rte_eth_ntuple_filter ntuple_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	int ret;
@@ -2449,12 +1986,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
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
@@ -2478,9 +2009,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	int ret;
 	struct rte_flow *pmd_flow = flow;
 	enum rte_filter_type filter_type = pmd_flow->filter_type;
-	struct rte_eth_ntuple_filter ntuple_filter;
 	struct ixgbe_fdir_rule fdir_rule;
-	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
 	struct ixgbe_hw_fdir_info *fdir_info =
@@ -2503,19 +2032,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	}
 
 	switch (filter_type) {
-	case RTE_ETH_FILTER_NTUPLE:
-		ntuple_filter_ptr = (struct ixgbe_ntuple_filter_ele *)
-					pmd_flow->rule;
-		rte_memcpy(&ntuple_filter,
-			&ntuple_filter_ptr->filter_info,
-			sizeof(struct rte_eth_ntuple_filter));
-		ret = ixgbe_add_del_ntuple_filter(dev, &ntuple_filter, FALSE);
-		if (!ret) {
-			TAILQ_REMOVE(&filter_ntuple_list,
-			ntuple_filter_ptr, entries);
-			rte_free(ntuple_filter_ptr);
-		}
-		break;
 	case RTE_ETH_FILTER_FDIR:
 		fdir_rule_ptr = (struct ixgbe_fdir_rule_ele *)pmd_flow->rule;
 		rte_memcpy(&fdir_rule,
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index 4dabaca0ed..c1df74c0e7 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.h
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -12,6 +12,7 @@ enum ixgbe_flow_engine_type {
 	IXGBE_FLOW_ENGINE_TYPE_ETHERTYPE = 0,
 	IXGBE_FLOW_ENGINE_TYPE_SYN,
 	IXGBE_FLOW_ENGINE_TYPE_L2_TUNNEL,
+	IXGBE_FLOW_ENGINE_TYPE_NTUPLE,
 };
 
 int
@@ -24,5 +25,6 @@ extern const struct ci_flow_engine_list ixgbe_flow_engine_list;
 extern const struct ci_flow_engine ixgbe_ethertype_flow_engine;
 extern const struct ci_flow_engine ixgbe_syn_flow_engine;
 extern const struct ci_flow_engine ixgbe_l2_tunnel_flow_engine;
+extern const struct ci_flow_engine ixgbe_ntuple_flow_engine;
 
 #endif /*  _IXGBE_FLOW_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c b/drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c
new file mode 100644
index 0000000000..6c2b1cc9b1
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c
@@ -0,0 +1,483 @@
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
+const struct rte_flow_graph ixgbe_ntuple_graph = {
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
+		.driver_ctx = ctx->dev,
+		.check = ixgbe_flow_actions_check,
+		.max_actions = 1,
+	};
+	const struct rte_flow_action_queue *q_act;
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
+	ntuple_ctx->ntuple.priority = (uint16_t)attr->priority;
+
+	/* clamp priority */
+	/* TODO: check if weird clamping of >7 to 1 is a bug */
+	if (attr->priority < IXGBE_MIN_N_TUPLE_PRIO || attr->priority > IXGBE_MAX_N_TUPLE_PRIO)
+		ntuple_ctx->ntuple.priority = 1;
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
+	struct rte_eth_dev *dev = flow->dev;
+	int ret;
+
+	ret = ixgbe_add_del_ntuple_filter(dev, &ntuple_flow->ntuple, TRUE);
+	if (ret) {
+		return rte_flow_error_set(error, ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to add L2 tunnel filter");
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
+	struct rte_eth_dev *dev = flow->dev;
+	int ret;
+
+	ret = ixgbe_add_del_ntuple_filter(dev, &ntuple_flow->ntuple, FALSE);
+	if (ret) {
+		return rte_flow_error_set(error, ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to add L2 tunnel filter");
+	}
+
+	return 0;
+}
+
+static bool
+ixgbe_flow_ntuple_is_available(const struct ci_flow_engine *engine __rte_unused,
+		const struct rte_eth_dev *dev)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+
+	return hw->mac.type == ixgbe_mac_82599EB ||
+			hw->mac.type == ixgbe_mac_X540 ||
+			hw->mac.type == ixgbe_mac_X550 ||
+			hw->mac.type == ixgbe_mac_X550EM_x ||
+			hw->mac.type == ixgbe_mac_X550EM_a ||
+			hw->mac.type == ixgbe_mac_E610;
+}
+
+const struct ci_flow_engine_ops ixgbe_ntuple_ops = {
+	.is_available = ixgbe_flow_ntuple_is_available,
+	.ctx_parse = ixgbe_flow_ntuple_ctx_parse,
+	.ctx_to_flow = ixgbe_flow_ntuple_ctx_to_flow,
+	.flow_install = ixgbe_flow_ntuple_flow_install,
+	.flow_uninstall = ixgbe_flow_ntuple_flow_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_ntuple_flow_engine = {
+	.name = "ixgbe_ntuple",
+	.ctx_size = sizeof(struct ixgbe_ntuple_ctx),
+	.flow_size = sizeof(struct ixgbe_ntuple_flow),
+	.type = IXGBE_FLOW_ENGINE_TYPE_NTUPLE,
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
2.47.3

