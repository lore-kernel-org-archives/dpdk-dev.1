Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1438CCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:16:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 973D340B9A;
	Thu, 30 Apr 2026 13:15:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 85B3440B91
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:15:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777547708; x=1809083708;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Wheih3Je7JMJt7imGCoql68HpT2GUY9e38ZldmdGMDI=;
 b=BM9qlXWjqbkpd0uBSONrJnH2BfkMDSyYXquC2+QaYpLG/nvxdOJKI8kH
 soZmcnksOi+50kzJQ0d4i39tArLxD2wWwA3NRW0LtuV1N3wZmmm8wAosT
 Tq7XpGvKsqUNThM4k/iNqDPDiB9WC/C1egeUaeXZ7Ex5dK3iFEto1tm4P
 NnspjqJr3/hXtmpuASF6jpq8N41RqENBh3WfWw7p5snAazs7wsMM6kIg6
 uIizKlP8hmFA0aNKlMayIpuU4ppIaD2kqHHe5wHILYNaIJStqy+8+OBR9
 XP0JLdHDnzsMBNXDVrC2oT5MtN0SusUcnFTaVbpPdjZfoCS0Yn8/gSUeP A==;
X-CSE-ConnectionGUID: 6REgS1mcT3uo0RPTM2vSBw==
X-CSE-MsgGUID: yT4rYsZfQ96Bddf894eqiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78482291"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78482291"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:15:08 -0700
X-CSE-ConnectionGUID: V5oFuPDySj2NFJ7IbEWqcQ==
X-CSE-MsgGUID: njbo8VLWRMeoBOxm3TQEYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="234444815"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 30 Apr 2026 04:15:08 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 12/15] net/ixgbe: support protocol-only TCP and UDP rules
Date: Thu, 30 Apr 2026 12:14:41 +0100
Message-ID: <c45d176a7a670dbb6d22906086f0c769d3d608ba.1777547413.git.anatoly.burakov@intel.com>
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

Currently, ixgbe `rte_flow` parsing requires a mask for TCP and UDP
items. This means TCP and UDP FDIR rules can only be programmed as
port-based matches, while protocol-only matches are rejected even though
they are supported in hardware.

Allow TCP and UDP items without a mask so `rte_flow` can express broad L4
matches that care about the protocol only. This makes TCP and UDP
handling consistent with SCTP.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 130 ++++++++++++++-------------
 1 file changed, 67 insertions(+), 63 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index a6fcfe7574..eae81462f6 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -2055,42 +2055,44 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 				item, "Not supported last point for range");
 			return -rte_errno;
 		}
-		/**
-		 * Only care about src & dst ports,
-		 * others should be masked.
-		 */
-		if (!item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		rule->b_mask = TRUE;
 		tcp_mask = item->mask;
-		if (tcp_mask->hdr.sent_seq ||
-		    tcp_mask->hdr.recv_ack ||
-		    tcp_mask->hdr.data_off ||
-		    tcp_mask->hdr.tcp_flags ||
-		    tcp_mask->hdr.rx_win ||
-		    tcp_mask->hdr.cksum ||
-		    tcp_mask->hdr.tcp_urp) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		rule->mask.src_port_mask = tcp_mask->hdr.src_port;
-		rule->mask.dst_port_mask = tcp_mask->hdr.dst_port;
+		if (tcp_mask != NULL) {
+			/**
+			 * Only care about src & dst ports,
+			 * others should be masked.
+			 */
+			rule->b_mask = TRUE;
+			if (tcp_mask->hdr.sent_seq ||
+			    tcp_mask->hdr.recv_ack ||
+			    tcp_mask->hdr.data_off ||
+			    tcp_mask->hdr.tcp_flags ||
+			    tcp_mask->hdr.rx_win ||
+			    tcp_mask->hdr.cksum ||
+			    tcp_mask->hdr.tcp_urp) {
+				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
+				rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					item, "Not supported by fdir filter");
+				return -rte_errno;
+			}
+			rule->mask.src_port_mask = tcp_mask->hdr.src_port;
+			rule->mask.dst_port_mask = tcp_mask->hdr.dst_port;
 
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			tcp_spec = item->spec;
-			rule->ixgbe_fdir.formatted.src_port =
-				tcp_spec->hdr.src_port;
-			rule->ixgbe_fdir.formatted.dst_port =
-				tcp_spec->hdr.dst_port;
+			if (item->spec) {
+				rule->b_spec = TRUE;
+				tcp_spec = item->spec;
+				rule->ixgbe_fdir.formatted.src_port =
+					tcp_spec->hdr.src_port;
+				rule->ixgbe_fdir.formatted.dst_port =
+					tcp_spec->hdr.dst_port;
+			}
+		} else if (item->spec != NULL) {
+			/* No port mask means protocol-only match; spec is invalid. */
+			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Not supported by fdir filter");
+			return -rte_errno;
 		}
 
 		item = next_no_fuzzy_pattern(pattern, item);
@@ -2120,37 +2122,39 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 				item, "Not supported last point for range");
 			return -rte_errno;
 		}
-		/**
-		 * Only care about src & dst ports,
-		 * others should be masked.
-		 */
-		if (!item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		rule->b_mask = TRUE;
 		udp_mask = item->mask;
-		if (udp_mask->hdr.dgram_len ||
-		    udp_mask->hdr.dgram_cksum) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		rule->mask.src_port_mask = udp_mask->hdr.src_port;
-		rule->mask.dst_port_mask = udp_mask->hdr.dst_port;
+		if (udp_mask != NULL) {
+			/**
+			 * Only care about src & dst ports,
+			 * others should be masked.
+			 */
+			rule->b_mask = TRUE;
+			if (udp_mask->hdr.dgram_len ||
+			    udp_mask->hdr.dgram_cksum) {
+				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
+				rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					item, "Not supported by fdir filter");
+				return -rte_errno;
+			}
+			rule->mask.src_port_mask = udp_mask->hdr.src_port;
+			rule->mask.dst_port_mask = udp_mask->hdr.dst_port;
 
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			udp_spec = item->spec;
-			rule->ixgbe_fdir.formatted.src_port =
-				udp_spec->hdr.src_port;
-			rule->ixgbe_fdir.formatted.dst_port =
-				udp_spec->hdr.dst_port;
+			if (item->spec) {
+				rule->b_spec = TRUE;
+				udp_spec = item->spec;
+				rule->ixgbe_fdir.formatted.src_port =
+					udp_spec->hdr.src_port;
+				rule->ixgbe_fdir.formatted.dst_port =
+					udp_spec->hdr.dst_port;
+			}
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

