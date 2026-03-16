Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DD6F53D80
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:30:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E87CF40B9D;
	Mon, 16 Mar 2026 18:28:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7B18A40DD1
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682104; x=1805218104;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JBScAqFJfJK4JFmZpZ7AselZkhaVqTQ2+emmKRmFsOE=;
 b=OKgJpqbY1GNljk2cG4a7jbfKlv1g0WXFQK/RAgYAMJNAvo+LrSgAtc7R
 BZuPyvSTzLWelJuxhlRoW+oLl3A2T+PFwfRwzUJ8Y7TNYI5m84IgV+9xA
 Ts9W1of2SAnuziROiROL4wERDYHw5SddcCWp+D27Dda9PqGUen0ob9RDj
 x8poBoWHV9EaiiH3DuFuu2+b63Qd4rca8DkFhUocF9K+zVRhEdTIVex36
 /oWVAWJ5hUFpqxc0VCH6uSrMbh7f4Ahz6lVOWeXYD8xmtHpxWW1jbmHao
 RiD1ZLcTGs1NqtSJ9VnMGq1lHu1pZxqFfmHAv+e1BSujkXzGucJ+WXMKQ Q==;
X-CSE-ConnectionGUID: 4pm68LnfSwGi1/lj4R0LZw==
X-CSE-MsgGUID: W8/1JczZQLKPF23noqqF1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059673"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059673"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:22 -0700
X-CSE-ConnectionGUID: IaRYy6doSz6RZWBRZq/dDw==
X-CSE-MsgGUID: w5nSESpGRx+wnBPILMJrIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228314"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:22 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH v1 20/21] net/i40e: reimplement L4 cloud parser
Date: Mon, 16 Mar 2026 17:27:48 +0000
Message-ID: <167b05a636f057162208a136500b6abf3661d06f.1773681366.git.anatoly.burakov@intel.com>
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
flow parser for L4 tunnels.

In addition to using the new graph infrastructure, some of the checks were
made more stringent and/or more correct. In particular:

- old code did not check for whether fields other than ports are masked
  (they are now rejected)
- old code did not check for whether src/ports are fully masked (masks
  other than full are now rejected)
- old code used spec to decide which port to copy (as a result, it was not
  possible to match port 0 - this is now allowed)

Because the old parsing infrastructure is no longer needed (hash parser has
always worked outside of it), it has been removed.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.h      |  15 +-
 drivers/net/intel/i40e/i40e_flow.c        | 617 +---------------------
 drivers/net/intel/i40e/i40e_flow.h        |   3 +-
 drivers/net/intel/i40e/i40e_flow_tunnel.c | 305 +++++++++++
 4 files changed, 310 insertions(+), 630 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 7c4786bec0..2503830f22 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1292,23 +1292,10 @@ struct i40e_vf_representor {
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
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 3fff01755e..2b4a4dd12c 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -38,6 +38,7 @@ const struct ci_flow_engine_list i40e_flow_engine_list = {
 		&i40e_flow_engine_tunnel_nvgre,
 		&i40e_flow_engine_tunnel_mpls,
 		&i40e_flow_engine_tunnel_gtp,
+		&i40e_flow_engine_tunnel_l4,
 	}
 };
 
@@ -60,19 +61,7 @@ static int i40e_flow_query(struct rte_eth_dev *dev,
 			   struct rte_flow *flow,
 			   const struct rte_flow_action *actions,
 			   void *data, struct rte_flow_error *error);
-static int i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
-				 const struct rte_flow_action *actions,
-				 struct rte_flow_error *error,
-				 struct i40e_tunnel_filter_conf *filter);
-static int i40e_flow_destroy_tunnel_filter(struct i40e_pf *pf,
-					   struct i40e_tunnel_filter *filter);
-static int i40e_flow_flush_tunnel_filter(struct i40e_pf *pf);
 
-static int i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
-					   const struct rte_flow_item pattern[],
-					   const struct rte_flow_action actions[],
-					   struct rte_flow_error *error,
-					   struct i40e_filter_ctx *filter);
 const struct rte_flow_ops i40e_flow_ops = {
 	.validate = i40e_flow_validate,
 	.create = i40e_flow_create,
@@ -81,148 +70,6 @@ const struct rte_flow_ops i40e_flow_ops = {
 	.query = i40e_flow_query,
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
-static struct i40e_valid_pattern i40e_supported_patterns[] = {
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
-		rte_memcpy(items, pb, sizeof(struct rte_flow_item) * cpy_count);
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
-	rte_memcpy(items, pe, sizeof(struct rte_flow_item));
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
 int
 i40e_get_outer_vlan(struct rte_eth_dev *dev, uint16_t *tpid)
 {
@@ -317,309 +164,6 @@ i40e_flow_fdir_get_pctype_value(struct i40e_pf *pf,
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
-int
-i40e_check_tunnel_filter_type(uint8_t filter_type)
-{
-	const uint16_t i40e_supported_tunnel_filter_types[] = {
-		RTE_ETH_TUNNEL_FILTER_IMAC | RTE_ETH_TUNNEL_FILTER_TENID |
-		RTE_ETH_TUNNEL_FILTER_IVLAN,
-		RTE_ETH_TUNNEL_FILTER_IMAC | RTE_ETH_TUNNEL_FILTER_IVLAN,
-		RTE_ETH_TUNNEL_FILTER_IMAC | RTE_ETH_TUNNEL_FILTER_TENID,
-		RTE_ETH_TUNNEL_FILTER_OMAC | RTE_ETH_TUNNEL_FILTER_TENID |
-		RTE_ETH_TUNNEL_FILTER_IMAC,
-		RTE_ETH_TUNNEL_FILTER_IMAC,
-	};
-	uint8_t i;
-
-	for (i = 0; i < RTE_DIM(i40e_supported_tunnel_filter_types); i++) {
-		if (filter_type == i40e_supported_tunnel_filter_types[i])
-			return 0;
-	}
-	return -1;
-}
-
-
 static int
 i40e_flow_check(struct rte_eth_dev *dev,
 		   const struct rte_flow_attr *attr,
@@ -628,11 +172,6 @@ i40e_flow_check(struct rte_eth_dev *dev,
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
@@ -656,52 +195,7 @@ i40e_flow_check(struct rte_eth_dev *dev,
 
 	/* try parsing as RSS */
 	filter_ctx->type = RTE_ETH_FILTER_HASH;
-	ret = i40e_hash_parse(dev, pattern, actions, &filter_ctx->rss_conf, error);
-	if (!ret) {
-		return ret;
-	}
-
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
@@ -756,14 +250,6 @@ i40e_flow_create(struct rte_eth_dev *dev,
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
@@ -805,10 +291,6 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 		return 0;
 
 	switch (filter_type) {
-	case RTE_ETH_FILTER_TUNNEL:
-		ret = i40e_flow_destroy_tunnel_filter(pf,
-			      (struct i40e_tunnel_filter *)flow->rule);
-		break;
 	case RTE_ETH_FILTER_HASH:
 		ret = i40e_hash_filter_destroy(pf, flow->rule);
 		break;
@@ -831,65 +313,6 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
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
-	rte_memcpy(cld_filter.general_fields,
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
@@ -901,14 +324,6 @@ i40e_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
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
@@ -917,34 +332,6 @@ i40e_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
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
index 95eec07373..24683dcff9 100644
--- a/drivers/net/intel/i40e/i40e_flow.h
+++ b/drivers/net/intel/i40e/i40e_flow.h
@@ -12,7 +12,6 @@ uint8_t
 i40e_flow_fdir_get_pctype_value(struct i40e_pf *pf,
 		enum rte_flow_item_type item_type,
 		struct i40e_fdir_filter_conf *filter);
-int i40e_check_tunnel_filter_type(uint8_t filter_type);
 
 enum i40e_flow_engine_type {
 	I40E_FLOW_ENGINE_TYPE_ETHERTYPE = 0,
@@ -22,6 +21,7 @@ enum i40e_flow_engine_type {
 	I40E_FLOW_ENGINE_TYPE_TUNNEL_NVGRE,
 	I40E_FLOW_ENGINE_TYPE_TUNNEL_MPLS,
 	I40E_FLOW_ENGINE_TYPE_TUNNEL_GTP,
+	I40E_FLOW_ENGINE_TYPE_TUNNEL_L4,
 };
 
 extern const struct ci_flow_engine_list i40e_flow_engine_list;
@@ -33,5 +33,6 @@ extern const struct ci_flow_engine i40e_flow_engine_tunnel_vxlan;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_nvgre;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_mpls;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_gtp;
+extern const struct ci_flow_engine i40e_flow_engine_tunnel_l4;
 
 #endif /* _I40E_FLOW_H_ */
diff --git a/drivers/net/intel/i40e/i40e_flow_tunnel.c b/drivers/net/intel/i40e/i40e_flow_tunnel.c
index 1159c4a713..1aa8677f14 100644
--- a/drivers/net/intel/i40e/i40e_flow_tunnel.c
+++ b/drivers/net/intel/i40e/i40e_flow_tunnel.c
@@ -19,6 +19,27 @@ struct i40e_tunnel_flow {
 	struct i40e_tunnel_filter_conf filter;
 };
 
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
 /**
  * QinQ tunnel filter graph implementation
  * Pattern: START -> ETH -> OUTER_VLAN -> INNER_VLAN -> END
@@ -997,6 +1018,281 @@ const struct rte_flow_graph i40e_tunnel_gtp_graph = {
 	},
 };
 
+/**
+ * L4 tunnel filter graph implementation
+ * Pattern: START -> ETH -> (IPv4 | IPv6) -> (TCP | UDP | SCTP) -> END
+ */
+enum i40e_tunnel_l4_node_id {
+	I40E_TUNNEL_L4_NODE_START  = RTE_FLOW_NODE_FIRST,
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
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&tcp_mask->hdr.src_port) !=
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
+i40e_tunnel_node_udp_process(void *ctx, const struct rte_flow_item *item __rte_unused,
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
+i40e_tunnel_node_sctp_process(void *ctx, const struct rte_flow_item *item __rte_unused,
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
+const struct rte_flow_graph i40e_tunnel_l4_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[I40E_TUNNEL_L4_NODE_START] = {
+			.name = "START",
+		},
+		[I40E_TUNNEL_L4_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[I40E_TUNNEL_L4_NODE_IPV4] = {
+			.name = "IPv4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv4_process,
+		},
+		[I40E_TUNNEL_L4_NODE_IPV6] = {
+			.name = "IPv6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv6_process,
+		},
+		[I40E_TUNNEL_L4_NODE_TCP] = {
+			.name = "TCP",
+			.type = RTE_FLOW_ITEM_TYPE_TCP,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_tcp_validate,
+			.process = i40e_tunnel_node_tcp_process,
+		},
+		[I40E_TUNNEL_L4_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_udp_validate,
+			.process = i40e_tunnel_node_udp_process,
+		},
+		[I40E_TUNNEL_L4_NODE_SCTP] = {
+			.name = "SCTP",
+			.type = RTE_FLOW_ITEM_TYPE_SCTP,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_sctp_validate,
+			.process = i40e_tunnel_node_sctp_process,
+		},
+		[I40E_TUNNEL_L4_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct rte_flow_graph_edge[]) {
+		[I40E_TUNNEL_L4_NODE_START] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_L4_NODE_ETH,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_L4_NODE_ETH] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_L4_NODE_IPV4,
+				I40E_TUNNEL_L4_NODE_IPV6,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_L4_NODE_IPV4] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_L4_NODE_TCP,
+				I40E_TUNNEL_L4_NODE_UDP,
+				I40E_TUNNEL_L4_NODE_SCTP,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_L4_NODE_IPV6] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_L4_NODE_TCP,
+				I40E_TUNNEL_L4_NODE_UDP,
+				I40E_TUNNEL_L4_NODE_SCTP,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_L4_NODE_TCP] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_L4_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_L4_NODE_UDP] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_L4_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_L4_NODE_SCTP] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_L4_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+	},
+};
+
 static int
 i40e_tunnel_action_check(const struct ci_flow_actions *actions,
 		const struct ci_flow_actions_check_param *param,
@@ -1195,6 +1491,15 @@ const struct ci_flow_engine i40e_flow_engine_tunnel_gtp = {
 	.graph = &i40e_tunnel_gtp_graph,
 };
 
+const struct ci_flow_engine i40e_flow_engine_tunnel_l4 = {
+	.name = "i40e_tunnel_l4",
+	.type = I40E_FLOW_ENGINE_TYPE_TUNNEL_L4,
+	.ops = &i40e_flow_engine_tunnel_ops,
+	.ctx_size = sizeof(struct i40e_tunnel_ctx),
+	.flow_size = sizeof(struct i40e_tunnel_flow),
+	.graph = &i40e_tunnel_l4_graph,
+};
+
 const struct ci_flow_engine i40e_flow_engine_tunnel_qinq = {
 	.name = "i40e_tunnel_qinq",
 	.type = I40E_FLOW_ENGINE_TYPE_TUNNEL_QINQ,
-- 
2.47.3

