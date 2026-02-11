Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FF7E9E302
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:04:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9B8A40666;
	Wed, 11 Feb 2026 14:04:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id E49D34026A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:04:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770815053; x=1802351053;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=g8+Y92jbPKrVPW+9DiqNFrdDFFq/EA8SNrP5i/FGp60=;
 b=c42ZTck/UUMMhnISJYB+ijIHpv+lQj1KPkqAQY+Gd45fpLJ4VIxnnqHr
 T3PT/enPk2xiRzt6c/HhTPsIbEkbcTkhQXmRwfDxtzZ4EmKosP/Yk9sI/
 hMdXuvdHL5q+7MdO/p17TVzarYxHpPZl3036IHHV2PFIDTVHQaJTyEDKA
 U8kJ1vpQ7BGd/CWWxK+TY7iyQCSS+lM8f9CipI00Rn6jJj2g7LnxztBev
 JA07bCAJuJK4kTd9bvZM3U6SdzpskU6K3sBo1bkX/r+QD5yJUXmjuA1rF
 7gNsOTuUvMUCzQhc0hj+ioIiHLtZnf9FlLgygLtOPpI+rcZXtTzgocAgw Q==;
X-CSE-ConnectionGUID: jlnZ/NVRSZix0sG69ZQzcA==
X-CSE-MsgGUID: 3kGWGrthQnGzmJdxnbakLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="59529074"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="59529074"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:04:13 -0800
X-CSE-ConnectionGUID: 6lK5j2QxT6i0CCDDGReV8w==
X-CSE-MsgGUID: RIsRfnHXTiWmo3x/cD9lGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="217206410"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 11 Feb 2026 05:04:12 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Beilei Xing <beilei.xing@intel.com>
Subject: [PATCH v3 5/8] net/i40e: fix IPv6 GTPU handling
Date: Wed, 11 Feb 2026 13:03:50 +0000
Message-ID: <70fc490a915d60748461ee5a8fd3a4dcd7a0b04b.1770814868.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770814868.git.anatoly.burakov@intel.com>
 <cover.1770814868.git.anatoly.burakov@intel.com>
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

