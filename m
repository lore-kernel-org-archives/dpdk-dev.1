Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DF5EB491F
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:54:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63DB44069D;
	Thu, 12 Feb 2026 13:53:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id A09C64066F
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:53:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770900833; x=1802436833;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=v4cdLClosJm4qDBW4Ip2xWQZxXTXyKxuky+fEEPi+IQ=;
 b=Nq1V/87NfsSvL7UNMV636VMb4EFLCWdGbIZjKNGBm6sfctQGdf2wwasJ
 OSEzkTVlGs676aVCGw3bsRNgbiyA7Dcl5LYGLZxLVIRy5TtiQe2GdHJO1
 9VZsD3Nl9lkIb20HelYpAG0o5LOSli/oO5HXQ1ziMm5idD+8WZUPen3Pp
 PVyeaxZBS8sT37a9Z07lzii0g+E/d3u8B43Tnj8DSCQD6Wz1motmRHvMr
 KAHogDt3o/aUWC6DCSfHtaz4jn9b/Qr2e3tOoTShGm5vy9V2NgVwOpX7M
 pkcek9GbB3n5c0snSo5rM93RbC1FxTNnLXdGLayOhrRY1wVwQM5UuQhQl Q==;
X-CSE-ConnectionGUID: vcojmVHwQyWcTfPPWWRgTQ==
X-CSE-MsgGUID: o7HFcCXiSw2T3mdsfSIDyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71785491"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71785491"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:53:53 -0800
X-CSE-ConnectionGUID: teU0K68xTLSg0wGhb1TTtQ==
X-CSE-MsgGUID: +xOg+V3vSUm/FyTk4+MWcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="243179165"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 12 Feb 2026 04:53:51 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Beilei Xing <beilei.xing@intel.com>, Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v5 07/12] net/i40e: fix IPv6 GTPU handling
Date: Thu, 12 Feb 2026 12:53:30 +0000
Message-ID: <7c031c8a54d72c58bc564b1596824ebd15b0fb9c.1770900758.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770900757.git.anatoly.burakov@intel.com>
 <cover.1770900757.git.anatoly.burakov@intel.com>
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

GTP tunnel code declares support for IPv6 GTPU flows but does not actually
handle IPv6 flow pattern item, resulting in incorrect parsing for IPv6
GTPU flows. Add IPv6 flow item handling.

Fixes: 47ba0398da3f ("net/i40e: add cloud filter parsing function for GTP")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 193b1b6725..2374b9bbca 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -3580,6 +3580,19 @@ i40e_flow_parse_gtp_pattern(struct rte_eth_dev *dev,
 				return -rte_errno;
 			}
 			break;
+		case RTE_FLOW_ITEM_TYPE_IPV6:
+			filter->ip_type = I40E_TUNNEL_IPTYPE_IPV6;
+			/* IPv6 is used to describe protocol,
+			 * spec and mask should be NULL.
+			 */
+			if (item->spec || item->mask) {
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   item,
+						   "Invalid IPv6 item");
+				return -rte_errno;
+			}
+			break;
 		case RTE_FLOW_ITEM_TYPE_UDP:
 			if (item->spec || item->mask) {
 				rte_flow_error_set(error, EINVAL,
-- 
2.47.3

