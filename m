Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CFDC61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:34:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F172440E21;
	Tue,  1 Sep 2026 22:34:05 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 8DF9B40E8A
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:34:04 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8520161fdb9so378046b3a.3
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294844;
 x=1788899644; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KhyecZhVYmTdu1o55e9+cedeW2zYqLCTLkDxk2N+SjE=;
 b=mww1WkzzguOikdw2fBS9KwC1AsmmXxHytPfQKBxzCwTiaoAfzmYtLQsYhsktN8q/1z
 p0r6aZW7OyNJqmTguhVBFCb/QhfEQ9CvLIxOqxvds0IvkYRTXLG06gqP/Y2xDS/oFpS+
 v0ZbmyP8x2WEWoyjG1TLqJdrS/STthpXA2Dyjpk81KLyz839wG9PjL+EGBjYPMNyyORU
 VuoxWfWcDRNVLBUxVzpWPFT4xjW+uP6jqYu5H4R44JPOSSEUXCs9LNiSHsW6eOIk/iic
 dc+zDJDaLE5+0RMYVBza+JZVSUSfZz1eXfK50Ec6NLzgiOCRmvbWwt7COKCH/KeMPzg7
 WQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294844; x=1788899644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KhyecZhVYmTdu1o55e9+cedeW2zYqLCTLkDxk2N+SjE=;
 b=cZfdfhEM4z1IjHZXqNbYviuBrLJB8wgztcDdVkfzLP2J7+cARuQXhGQNdX+JR3Znm6
 iPFfiRFNUVsn0o/M9Yau+PCYwsX0tFO3M68i7zZTl9BMmOh8wbklqsMXBMEv7Irhz6/6
 NK2cM8tg1x0aoMLRP5vXCjjJ9Z2J9KaVqrnlnRKXaENFdBm7KsMNvANwD7ZIkHNK9VM2
 lZVLVixWG1FvU/o3MOM6/R+K14pwLapyvZa/zHXuooQwM/QJV2iJK+CmdZCXARbcYNrb
 iFv/oJ4cAeFH1z/9LN/kEA1IH6FdtOWCNUESWN+ac7324O86Dg+KfW14t1PXFRRmGEtS
 FjVw==
X-Gm-Message-State: AFuF++kpsgEYwf3AVPjV1qyFPq3aXRCMRRtF0Rk0tOkUXwjKtwvkY5gG
 dvcy0BghZzvsm1rS//kfP/XrJZFY6mASv+vI4/sZtohwQ56AuSexeVfoSxQmTuHiy62N4QxdDDR
 yVxVw
X-Gm-Gg: AR+sD134ob6BN8djGRYezN3cOtYoXAi7Ntv/hihP90dvXHCVm9ZKMjb16+PmjX8qQtr
 Qlhm9LML0sUfKRZj5tUaa9+xmHH0/Mt29sU7HbScQs46pRL1IYqOi3i9rBIJujbqabKghK+khBM
 JQyhUppESff9F8a9rqkGb/zWXXoDVfPVAIXjaxNd0r52kDoxtT/oe32hSzOFa9W3Q96bK+H/8F+
 3ORiANVj5iEIms9vSbG9T65JtoaKVJ6/yoPNtS2UoQIZGqDaGovUGwHu71Z7QgS4y4dB0bAvDLi
 vCws4dAQ1iSrAN6flFsbs6JXCEWAxMUP/BbPX9x5oGXGEEjD6051ADgfnVrh60GqFym5bztfaJd
 Dkejksw01fCcDcqxXp7s4x02SCgWniBxbjjJScf83/55+5n+IK9kFJRjz6z2A4fM1fWUVFUKrjI
 0ZCNGeEHdvzY7/tLETkOvwusXtaHPxtp6cekXLGhslVb6bjsYlYnPTCm/A3o2M/ediWvwKsORkP
 UY+VuFSrF8P9cHpMPySUVDSDhE=
X-Received: by 2002:a05:6a00:2d9f:b0:848:2c2e:c7a3 with SMTP id
 d2e1a72fcca58-85ed398aae1mr621382b3a.16.1788294843611; 
 Tue, 01 Sep 2026 13:34:03 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:34:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ori Kam <orika@nvidia.com>
Subject: [PATCH 22/22] ethdev: promote experimental structures to stable
Date: Tue,  1 Sep 2026 13:23:21 -0700
Message-ID: <20260901203217.1485915-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901203217.1485915-1-stephen@networkplumber.org>
References: <20260901203217.1485915-1-stephen@networkplumber.org>
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

The doxygen EXPERIMENTAL warnings on structures and enumerations were
never cleaned up along with the functions that use them.  All of the
remaining ones in ethdev are at least two years old:

  21.05  rte_eth_rxseg_split, rte_eth_rxseg, rte_eth_rxseg_capa
  22.11  rte_eth_err_handle_mode

and in rte_flow every remaining item, action, template and async
operation structure, the oldest from 21.05 and the newest
rte_flow_action_jump_to_table_index from 24.11.

These are only documentation comments; the structures themselves are
already part of the ABI because they are embedded in stable API
signatures.

Two flex item structures had no description other than the warning
itself, so give them one instead of leaving an empty comment block.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |   4 +
 lib/ethdev/rte_ethdev.h                |  12 --
 lib/ethdev/rte_flow.h                  | 169 +------------------------
 3 files changed, 9 insertions(+), 176 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index bf31d0dc6d..760f49c496 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -157,6 +157,10 @@ API Changes
     ``rte_eth_timesync_adjust_freq`` and ``rte_tm_node_query``
   * fast path inline funcs:
     ``rte_eth_recycle_mbufs`` and ``rte_eth_tx_queue_count``
+  * buffer split and error handling types:
+    ``rte_eth_rxseg_split``, ``rte_eth_rxseg``, ``rte_eth_rxseg_capa``
+    and ``rte_eth_err_handle_mode``
+  * all remaining ``rte_flow`` item, action and async operation structures
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ed350ae1bd..a1b0eebbe2 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -1061,9 +1061,6 @@ struct rte_eth_txmode {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * A structure used to configure an Rx packet segment to split.
  *
  * If RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT flag is set in offloads field,
@@ -1149,9 +1146,6 @@ struct rte_eth_rxseg_split {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * A common structure used to describe Rx packet segment properties.
  */
 union rte_eth_rxseg {
@@ -1740,9 +1734,6 @@ struct rte_eth_switch_info {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * Ethernet device Rx buffer segmentation capabilities.
  *
  * @see rte_eth_rxseg_split
@@ -1772,9 +1763,6 @@ enum rte_eth_representor_type {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this enumeration may change without prior notice.
- *
  * Ethernet device error handling mode.
  */
 enum rte_eth_err_handle_mode {
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index f7523bdf8f..1bfe1b3f61 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -727,9 +727,6 @@ enum rte_flow_item_type {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * QUOTA state.
  *
  * @see struct rte_flow_item_quota
@@ -1012,9 +1009,6 @@ static const struct rte_flow_item_ipv6 rte_flow_item_ipv6_mask = {
 #endif
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * RTE_FLOW_ITEM_TYPE_IPV6_ROUTING_EXT.
  *
  * Matches an IPv6 routing extension header.
@@ -1687,9 +1681,6 @@ rte_flow_item_pppoe_proto_id_mask = {
 #endif
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ITEM_TYPE_TAG
  *
  * Matches a specified tag value at the specified index.
@@ -1725,9 +1716,6 @@ static const struct rte_flow_item_l2tpv3oip rte_flow_item_l2tpv3oip_mask = {
 
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ITEM_TYPE_MARK
  *
  * Matches an arbitrary integer value which was set using the ``MARK`` action
@@ -1754,9 +1742,6 @@ static const struct rte_flow_item_mark rte_flow_item_mark_mask = {
 #endif
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ITEM_TYPE_NSH
  *
  * Match network service header (NSH), RFC 8300
@@ -1785,9 +1770,6 @@ static const struct rte_flow_item_nsh rte_flow_item_nsh_mask = {
 #endif
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ITEM_TYPE_IGMP
  *
  * Match Internet Group Management Protocol (IGMP), RFC 2236
@@ -1807,9 +1789,6 @@ static const struct rte_flow_item_igmp rte_flow_item_igmp_mask = {
 #endif
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ITEM_TYPE_AH
  *
  * Match IP Authentication Header (AH), RFC 4302
@@ -1830,9 +1809,6 @@ static const struct rte_flow_item_ah rte_flow_item_ah_mask = {
 #endif
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ITEM_TYPE_PFCP
  *
  * Match PFCP Header
@@ -1853,9 +1829,6 @@ static const struct rte_flow_item_pfcp rte_flow_item_pfcp_mask = {
 #endif
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ITEM_TYPE_ECPRI
  *
  * Match eCPRI Header
@@ -1896,9 +1869,6 @@ rte_flow_item_geneve_opt_mask = {
 #endif
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ITEM_TYPE_INTEGRITY
  *
  * Match on packet integrity check result.
@@ -1966,9 +1936,6 @@ rte_flow_item_integrity_mask = {
 #define RTE_FLOW_CONNTRACK_PKT_STATE_BAD RTE_BIT32(4)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ITEM_TYPE_CONNTRACK
  *
  * Matches the state of a packet after it passed the connection tracking
@@ -2003,9 +1970,6 @@ static const struct rte_flow_item_ethdev rte_flow_item_ethdev_mask = {
 #endif
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ITEM_TYPE_L2TPV2
  *
  * Matches L2TPv2 Header
@@ -2031,9 +1995,6 @@ static const struct rte_flow_item_l2tpv2 rte_flow_item_l2tpv2_mask = {
 #endif
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ITEM_TYPE_PPP
  *
  * Matches PPP Header
@@ -2073,9 +2034,6 @@ static const struct rte_flow_item_ib_bth rte_flow_item_ib_bth_mask = {
 #endif
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * RTE_FLOW_ITEM_TYPE_RANDOM
  *
  * Matches a random value.
@@ -2132,9 +2090,6 @@ struct rte_flow_item {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ITEM_TYPE_FLEX
  *
  * Matches a specified set of fields within the network protocol
@@ -2217,9 +2172,7 @@ enum rte_flow_item_flex_tunnel_mode {
 };
 
 /**
- *
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
+ * Description of a single field of a flex item.
  */
 __extension__
 struct rte_flow_item_flex_field {
@@ -2235,8 +2188,7 @@ struct rte_flow_item_flex_field {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
+ * Description of a link between a flex item and its neighbour headers.
  */
 struct rte_flow_item_flex_link {
 	/**
@@ -2252,6 +2204,9 @@ struct rte_flow_item_flex_link {
 	uint32_t next;
 };
 
+/**
+ * Flex item configuration: field descriptions and neighbour links.
+ */
 struct rte_flow_item_flex_conf {
 	/**
 	 * Specifies the flex item and tunnel relations and tells the PMD
@@ -2315,9 +2270,6 @@ static const struct rte_flow_item_meter_color rte_flow_item_meter_color_mask = {
 #endif
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ITEM_TYPE_AGGR_AFFINITY
  *
  * For multiple ports aggregated to a single DPDK port,
@@ -2436,9 +2388,6 @@ enum rte_flow_field_id {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * Packet header field descriptions, used by RTE_FLOW_ACTION_TYPE_MODIFY_FIELD
  * and RTE_FLOW_ITEM_TYPE_COMPARE.
  */
@@ -3262,9 +3211,6 @@ enum rte_flow_action_type {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * QUOTA operational mode.
  *
  * @see struct rte_flow_action_quota
@@ -3276,9 +3222,6 @@ enum rte_flow_quota_mode {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Create QUOTA action.
  *
  * @see RTE_FLOW_ACTION_TYPE_QUOTA
@@ -3289,9 +3232,6 @@ struct rte_flow_action_quota {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Query indirect QUOTA action.
  *
  * @see RTE_FLOW_ACTION_TYPE_QUOTA
@@ -3301,9 +3241,6 @@ struct rte_flow_query_quota {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Indirect QUOTA update operations.
  *
  * @see struct rte_flow_update_quota
@@ -3314,9 +3251,6 @@ enum rte_flow_update_quota_op {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * @see RTE_FLOW_ACTION_TYPE_QUOTA
  *
  * Update indirect QUOTA action.
@@ -3341,9 +3275,6 @@ struct rte_flow_action_mark {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_JUMP
  *
  * Redirects packets to a group on the current device.
@@ -3366,9 +3297,6 @@ struct rte_flow_action_queue {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_AGE
  *
  * Report flow as aged-out if timeout passed without any matching
@@ -3400,9 +3328,6 @@ struct rte_flow_query_age {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_AGE
  *
  * Update indirect AGE action attributes:
@@ -3427,9 +3352,6 @@ struct rte_flow_update_age {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_COUNT
  *
  * Adds a counter action to a matched flow.
@@ -3606,9 +3528,6 @@ enum rte_flow_nat64_type {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * RTE_FLOW_ACTION_TYPE_NAT64
  *
  * Specify the NAT64 translation type.
@@ -3668,9 +3587,6 @@ struct rte_flow_action_of_push_mpls {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_VXLAN_ENCAP
  *
  * VXLAN tunnel end-point encapsulation data definition
@@ -3702,9 +3618,6 @@ struct rte_flow_action_vxlan_encap {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_NVGRE_ENCAP
  *
  * NVGRE tunnel end-point encapsulation data definition
@@ -3735,9 +3648,6 @@ struct rte_flow_action_nvgre_encap {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_RAW_ENCAP
  *
  * Raw tunnel end-point encapsulation data definition.
@@ -3760,9 +3670,6 @@ struct rte_flow_action_raw_encap {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_RAW_DECAP
  *
  * Raw tunnel end-point decapsulation data definition.
@@ -3780,9 +3687,6 @@ struct rte_flow_action_raw_decap {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_SET_IPV4_SRC
  * RTE_FLOW_ACTION_TYPE_SET_IPV4_DST
  *
@@ -3795,9 +3699,6 @@ struct rte_flow_action_set_ipv4 {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_SET_IPV6_SRC
  * RTE_FLOW_ACTION_TYPE_SET_IPV6_DST
  *
@@ -3810,9 +3711,6 @@ struct rte_flow_action_set_ipv6 {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * RTE_FLOW_ACTION_TYPE_IPV6_EXT_PUSH
  *
  * Valid flow definition for RTE_FLOW_ACTION_TYPE_IPV6_EXT_PUSH include:
@@ -3828,9 +3726,6 @@ struct rte_flow_action_ipv6_ext_push {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * RTE_FLOW_ACTION_TYPE_IPV6_EXT_REMOVE
  *
  * Valid flow definition for RTE_FLOW_ACTION_TYPE_IPV6_EXT_REMOVE include:
@@ -3842,9 +3737,6 @@ struct rte_flow_action_ipv6_ext_remove {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_SET_TP_SRC
  * RTE_FLOW_ACTION_TYPE_SET_TP_DST
  *
@@ -3875,9 +3767,6 @@ struct rte_flow_action_set_mac {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_SET_TAG
  *
  * Set a tag which is a transient data used during flow matching. This is not
@@ -3890,9 +3779,6 @@ struct rte_flow_action_set_tag {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_SET_META
  *
  * Set metadata. Metadata set by mbuf metadata dynamic field with
@@ -3925,9 +3811,6 @@ struct rte_flow_action_set_dscp {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_INDIRECT
  *
  * Opaque type returned after successfully creating an indirect action object.
@@ -3974,9 +3857,6 @@ enum rte_flow_conntrack_tcp_last_index {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * Configuration parameters for each direction of a TCP connection.
  * All fields should be in host byte order.
  * If needed, driver should convert all fields to network byte order
@@ -4011,9 +3891,6 @@ struct rte_flow_tcp_dir_param {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_CONNTRACK
  *
  * Configuration and initial state for the connection tracking module.
@@ -4092,9 +3969,6 @@ struct rte_flow_modify_conntrack {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_METER_COLOR
  *
  * The meter color should be set in the packet meta-data
@@ -4123,9 +3997,6 @@ enum rte_flow_modify_op {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_MODIFY_FIELD
  *
  * Modify a destination header field according to the specified
@@ -4194,9 +4065,6 @@ struct rte_flow_indirect_update_flow_meter_mark {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * Program action argument configuration parameters.
  *
  * For each action argument, its *size* must be non-zero and its *value* must
@@ -4214,9 +4082,6 @@ struct rte_flow_action_prog_argument {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * RTE_FLOW_ACTION_TYPE_PROG
  *
  * Program action configuration parameters.
@@ -4262,9 +4127,6 @@ rte_flow_dynf_metadata_set(struct rte_mbuf *m, uint32_t v)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_JUMP_TO_TABLE_INDEX
  *
  * Redirects packets to a particular index in a flow table.
@@ -4309,9 +4171,6 @@ struct rte_flow_meter_profile;
 struct rte_flow_meter_policy;
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- *
  * RTE_FLOW_ACTION_TYPE_SAMPLE
  *
  * Adds a sample action to a matched flow.
@@ -5615,9 +5474,6 @@ rte_flow_configure(uint16_t port_id,
 struct rte_flow_pattern_template;
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Flow pattern template attributes.
  */
 __extension__
@@ -5701,9 +5557,6 @@ rte_flow_pattern_template_destroy(uint16_t port_id,
 struct rte_flow_actions_template;
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Flow actions template attributes.
  */
 __extension__
@@ -5987,9 +5840,6 @@ rte_flow_group_set_miss_actions(uint16_t port_id,
 				struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Asynchronous operation attributes.
  */
 __extension__
@@ -6228,9 +6078,6 @@ rte_flow_push(uint16_t port_id,
 	      struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Asynchronous operation status.
  */
 enum rte_flow_op_status {
@@ -6245,9 +6092,6 @@ enum rte_flow_op_status {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Asynchronous operation result.
  */
 __extension__
@@ -6521,9 +6365,6 @@ rte_flow_async_action_handle_query_update(uint16_t port_id, uint32_t queue_id,
 struct rte_flow_action_list_handle;
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Configure INDIRECT_LIST flow action.
  *
  * @see RTE_FLOW_ACTION_TYPE_INDIRECT_LIST
-- 
2.53.0

