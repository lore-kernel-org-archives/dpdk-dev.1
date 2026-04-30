Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3743FCCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:15:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A039406B6;
	Thu, 30 Apr 2026 13:14:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 9BE824067C
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:14:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777547697; x=1809083697;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lrKenKSR/3mpNOMa3YJdfdtwft+5MSA9pUd/xkFnR+c=;
 b=TBE7fWlGgAw6ulxC8jEOc4O5WqyrUxlVX+EjD4qOd80eQd2GvS7kiAgG
 C21o962rvXmcmpdpzcz6KK7XKl4zO7PsKfDt3NX5RuRiS8Lt52spRbpim
 bqjP4r74DV0TzVWVKgzu967RZwWFG1TzXDRKyXpgNbhEvYBOAQx0NwA5U
 ReWcOA+XQ4zwA1VfM4AesDshJh3Y1WzcLTsa7YmFsZqpO0IzwaIx3NL70
 mXXy63mqdFuqkKEI4pRrEmMdqNNWgI1eeNPgHJrVlpS5pwnoBMead14tp
 KtD4w26ZqiBGmkPCu8IrDdxK9LXAN7ciMkUbDPyvWhnokbC7F5jyPY134 g==;
X-CSE-ConnectionGUID: yjFUAS7qQEqeFB1Yh/UfKg==
X-CSE-MsgGUID: ryKxy/+dQmO+UWWVw5wEqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78482267"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78482267"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:14:56 -0700
X-CSE-ConnectionGUID: 8ZYavKm9Qm2yx5wucyiSCQ==
X-CSE-MsgGUID: xUVWiiUIR4qRYXCCZSxMtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="234444712"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 30 Apr 2026 04:14:56 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v1 04/15] net/ixgbe: fix SCTP protocol-only flow parsing
Date: Thu, 30 Apr 2026 12:14:33 +0100
Message-ID: <dee7cafad6b4cd6ba408fa296a38dbd071b224f6.1777547413.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777547413.git.anatoly.burakov@intel.com>
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

Currently, `ixgbe_parse_fdir_filter_normal()` checks the MAC type before
checking whether the `RTE_FLOW_ITEM_TYPE_SCTP` item carries a mask. On
`ixgbe_mac_X550`, `ixgbe_mac_X550EM_x`, `ixgbe_mac_X550EM_a` and
`ixgbe_mac_E610`, this makes `item->mask` mandatory and rejects
protocol-only SCTP patterns.

These devices can still match SCTP by protocol without L4 port masks.
Only SCTP port masking is MAC type dependent, but the current check order
makes the protocol-only path available only on older MAC types.

Fix this by checking whether a mask is present first. Keep the MAC type
check only for SCTP port masks, and accept protocol-only SCTP matching on
X550 and E610 as well.

Fixes: 86e19565f5e2 ("net/ixgbe: fix SCTP port support")
Cc: qi.z.zhang@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 86 ++++++++++++++--------------
 1 file changed, 42 insertions(+), 44 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index c3abba4a90..71da5ac72e 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -2180,57 +2180,55 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 			return -rte_errno;
 		}
 
-		/* only some mac types support sctp port */
-		if (hw->mac.type == ixgbe_mac_X550 ||
-		    hw->mac.type == ixgbe_mac_X550EM_x ||
-		    hw->mac.type == ixgbe_mac_X550EM_a ||
-		    hw->mac.type == ixgbe_mac_E610) {
-			/**
-			 * Only care about src & dst ports,
-			 * others should be masked.
-			 */
-			if (!item->mask) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-			rule->b_mask = TRUE;
-			sctp_mask = item->mask;
-			if (sctp_mask->hdr.tag ||
-				sctp_mask->hdr.cksum) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-			rule->mask.src_port_mask = sctp_mask->hdr.src_port;
-			rule->mask.dst_port_mask = sctp_mask->hdr.dst_port;
+		sctp_mask = item->mask;
+		if (sctp_mask != NULL) {
+			/* only some mac types support sctp port masking */
+			if (hw->mac.type == ixgbe_mac_X550 ||
+			    hw->mac.type == ixgbe_mac_X550EM_x ||
+			    hw->mac.type == ixgbe_mac_X550EM_a ||
+			    hw->mac.type == ixgbe_mac_E610) {
+				/**
+				 * Only care about src & dst ports,
+				 * others should be masked.
+				 */
+				rule->b_mask = TRUE;
+				if (sctp_mask->hdr.tag ||
+				    sctp_mask->hdr.cksum) {
+					memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
+					rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ITEM,
+						item, "Not supported by fdir filter");
+					return -rte_errno;
+				}
+				rule->mask.src_port_mask = sctp_mask->hdr.src_port;
+				rule->mask.dst_port_mask = sctp_mask->hdr.dst_port;
 
-			if (item->spec) {
-				rule->b_spec = TRUE;
-				sctp_spec = item->spec;
-				rule->ixgbe_fdir.formatted.src_port =
-					sctp_spec->hdr.src_port;
-				rule->ixgbe_fdir.formatted.dst_port =
-					sctp_spec->hdr.dst_port;
-			}
-		/* others even sctp port is not supported */
-		} else {
-			sctp_mask = item->mask;
-			if (sctp_mask &&
-				(sctp_mask->hdr.src_port ||
-				 sctp_mask->hdr.dst_port ||
-				 sctp_mask->hdr.tag ||
-				 sctp_mask->hdr.cksum)) {
+				if (item->spec) {
+					rule->b_spec = TRUE;
+					sctp_spec = item->spec;
+					rule->ixgbe_fdir.formatted.src_port =
+						sctp_spec->hdr.src_port;
+					rule->ixgbe_fdir.formatted.dst_port =
+						sctp_spec->hdr.dst_port;
+				}
+			/* others even sctp port masking is not supported */
+			} else if (sctp_mask->hdr.src_port ||
+				   sctp_mask->hdr.dst_port ||
+				   sctp_mask->hdr.tag ||
+				   sctp_mask->hdr.cksum) {
 				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
 				rte_flow_error_set(error, EINVAL,
 					RTE_FLOW_ERROR_TYPE_ITEM,
 					item, "Not supported by fdir filter");
 				return -rte_errno;
 			}
+		} else if (item->spec != NULL) {
+			/* No port mask means protocol-only match; spec is invalid. */
+			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Not supported by fdir filter");
+			return -rte_errno;
 		}
 
 		item = next_no_fuzzy_pattern(pattern, item);
-- 
2.47.3

