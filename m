Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83DFCCA471
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 11:03:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4818340677;
	Fri,  3 Oct 2025 13:02:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id ACB8E402E0
 for <dev@dpdk.org>; Fri,  3 Oct 2025 13:02:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759489354; x=1791025354;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cZDGHGsFBSU9no9g6v1srbIUV8gC2uXakFBVcjqWlns=;
 b=GK/Vek5SPT7pEXwu93cETJ+OTUr1I5VTEiohBMnDASULhmiuZgZO60QU
 y6mLL8FBZKfZpl8cno06K/Zsqxo9oBq9UJ4VmU64BqBI2D9GdDFYwLHt2
 U1yo7qGAEX4UHgOKAXv4SmvB38JaySLEA0RIE2ioNk4yUvG9wy9J1jYot
 HkH0vbC2d2AnzmYyJFZ3DPBTTF6jVVXDkH12PRNZCx38W/vwkMUXdYHRP
 0wO+0K2g8iT6W66lvcoq7AaJrnx74sNQX6mTNSEps4PUO1UJcDDA0y34A
 qWvlQLKesqDRfYkrrJFU/KodiRNZT3KHWfx4pRB/6AJJU/j8nnSaVCf4Y w==;
X-CSE-ConnectionGUID: 7KmoSFhvSUak2JIbeZJiZQ==
X-CSE-MsgGUID: uGIA5PSPSuKgZpxSjJwcQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="72873505"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="72873505"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 04:02:25 -0700
X-CSE-ConnectionGUID: VNm0RiG4QJuST7rNV9mZPA==
X-CSE-MsgGUID: tQpOeTC4RdKPGCRiffhovA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="179077689"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 03 Oct 2025 04:02:24 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, thomas@monjalon.net,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 7/7] ethdev: deprecate queue stats mapping functions
Date: Fri,  3 Oct 2025 12:02:01 +0100
Message-ID: <20251003110201.1541183-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251003110201.1541183-1-bruce.richardson@intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20251003110201.1541183-1-bruce.richardson@intel.com>
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

Deprecate the queue stats mapping functions in the ethdev API, since we
no longer have queue stats in the main device statistics. As part of the
deprecation, rather than allowing test-pmd to use the deprecated
functions just remove the mapping functionality from testpmd itself.
Without the queue stats, the ability to test queue mappings is
pointless.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-pmd/cmdline.c               | 57 ----------------------------
 app/test-pmd/config.c                | 30 ---------------
 doc/guides/rel_notes/deprecation.rst |  6 +++
 lib/ethdev/rte_ethdev.h              |  2 +
 4 files changed, 8 insertions(+), 87 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 3731fba370..35f466185f 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -8032,62 +8032,6 @@ static cmdline_parse_inst_t cmd_set_fwd_eth_peer = {
 	},
 };
 
-/* *** CONFIGURE QUEUE STATS COUNTER MAPPINGS *** */
-struct cmd_set_qmap_result {
-	cmdline_fixed_string_t set;
-	cmdline_fixed_string_t qmap;
-	cmdline_fixed_string_t what;
-	portid_t port_id;
-	uint16_t queue_id;
-	uint8_t map_value;
-};
-
-static void
-cmd_set_qmap_parsed(void *parsed_result,
-		       __rte_unused struct cmdline *cl,
-		       __rte_unused void *data)
-{
-	struct cmd_set_qmap_result *res = parsed_result;
-	int is_rx = (strcmp(res->what, "tx") == 0) ? 0 : 1;
-
-	set_qmap(res->port_id, (uint8_t)is_rx, res->queue_id, res->map_value);
-}
-
-static cmdline_parse_token_string_t cmd_setqmap_set =
-	TOKEN_STRING_INITIALIZER(struct cmd_set_qmap_result,
-				 set, "set");
-static cmdline_parse_token_string_t cmd_setqmap_qmap =
-	TOKEN_STRING_INITIALIZER(struct cmd_set_qmap_result,
-				 qmap, "stat_qmap");
-static cmdline_parse_token_string_t cmd_setqmap_what =
-	TOKEN_STRING_INITIALIZER(struct cmd_set_qmap_result,
-				 what, "tx#rx");
-static cmdline_parse_token_num_t cmd_setqmap_portid =
-	TOKEN_NUM_INITIALIZER(struct cmd_set_qmap_result,
-			      port_id, RTE_UINT16);
-static cmdline_parse_token_num_t cmd_setqmap_queueid =
-	TOKEN_NUM_INITIALIZER(struct cmd_set_qmap_result,
-			      queue_id, RTE_UINT16);
-static cmdline_parse_token_num_t cmd_setqmap_mapvalue =
-	TOKEN_NUM_INITIALIZER(struct cmd_set_qmap_result,
-			      map_value, RTE_UINT8);
-
-static cmdline_parse_inst_t cmd_set_qmap = {
-	.f = cmd_set_qmap_parsed,
-	.data = NULL,
-	.help_str = "set stat_qmap rx|tx <port_id> <queue_id> <map_value>: "
-		"Set statistics mapping value on tx|rx queue_id of port_id",
-	.tokens = {
-		(void *)&cmd_setqmap_set,
-		(void *)&cmd_setqmap_qmap,
-		(void *)&cmd_setqmap_what,
-		(void *)&cmd_setqmap_portid,
-		(void *)&cmd_setqmap_queueid,
-		(void *)&cmd_setqmap_mapvalue,
-		NULL,
-	},
-};
-
 /* *** SET OPTION TO HIDE ZERO VALUES FOR XSTATS  DISPLAY *** */
 struct cmd_set_xstats_hide_zero_result {
 	cmdline_fixed_string_t keyword;
@@ -13949,7 +13893,6 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_stop,
 	&cmd_mac_addr,
 	&cmd_set_fwd_eth_peer,
-	&cmd_set_qmap,
 	&cmd_set_xstats_hide_zero,
 	&cmd_set_xstats_show_state,
 	&cmd_set_xstats_hide_disabled,
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index ff170159a1..3fd82c1325 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -6716,36 +6716,6 @@ tx_vlan_pvid_set(portid_t port_id, uint16_t vlan_id, int on)
 	rte_eth_dev_set_vlan_pvid(port_id, vlan_id, on);
 }
 
-void
-set_qmap(portid_t port_id, uint8_t is_rx, uint16_t queue_id, uint8_t map_value)
-{
-	int ret;
-
-	if (port_id_is_invalid(port_id, ENABLED_WARN))
-		return;
-
-	if (is_rx ? (rx_queue_id_is_invalid(queue_id)) : (tx_queue_id_is_invalid(queue_id)))
-		return;
-
-	if (!is_rx) { /* tx */
-		ret = rte_eth_dev_set_tx_queue_stats_mapping(port_id, queue_id,
-							     map_value);
-		if (ret) {
-			fprintf(stderr,
-				"failed to set tx queue stats mapping.\n");
-			return;
-		}
-	} else { /* rx */
-		ret = rte_eth_dev_set_rx_queue_stats_mapping(port_id, queue_id,
-							     map_value);
-		if (ret) {
-			fprintf(stderr,
-				"failed to set rx queue stats mapping.\n");
-			return;
-		}
-	}
-}
-
 void
 set_xstats_hide_zero(uint8_t on_off)
 {
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 4b9da99484..4df0e83de2 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -68,6 +68,12 @@ Deprecation Notices
   and the header struct ``rte_vxlan_gpe_hdr`` with the macro ``RTE_ETHER_VXLAN_GPE_HLEN``
   will be removed in DPDK 25.11.
 
+* ethdev: The queue stats mapping functions
+  ``rte_eth_dev_set_tx_queue_stats_mapping`` and ``rte_eth_dev_set_rx_queue_stats_mapping``
+  are deprecated and will be removed in a future release.
+  Following the removal of queue statistics from the main ethdev statistics struture,
+  these functions are no longer needed.
+
 * ethdev: The flow API matching pattern structures, ``struct rte_flow_item_*``,
   should start with relevant protocol header structure from lib/net/.
   The individual protocol header fields and the protocol header struct
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 4cfc940000..a122df4e8e 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -3445,6 +3445,7 @@ int rte_eth_xstats_reset(uint16_t port_id);
  * @return
  *   Zero if successful. Non-zero otherwise.
  */
+__rte_deprecated
 int rte_eth_dev_set_tx_queue_stats_mapping(uint16_t port_id,
 		uint16_t tx_queue_id, uint8_t stat_idx);
 
@@ -3466,6 +3467,7 @@ int rte_eth_dev_set_tx_queue_stats_mapping(uint16_t port_id,
  * @return
  *   Zero if successful. Non-zero otherwise.
  */
+__rte_deprecated
 int rte_eth_dev_set_rx_queue_stats_mapping(uint16_t port_id,
 					   uint16_t rx_queue_id,
 					   uint8_t stat_idx);
-- 
2.48.1

