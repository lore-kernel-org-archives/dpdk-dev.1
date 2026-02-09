Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602FBE81BC0
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 13:15:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 995D4402C6;
	Mon,  9 Feb 2026 14:15:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 00691402B0
 for <dev@dpdk.org>; Mon,  9 Feb 2026 14:15:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770642912; x=1802178912;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=g8+Y92jbPKrVPW+9DiqNFrdDFFq/EA8SNrP5i/FGp60=;
 b=U+eiiO/tzfUYvQNZwvEEb1OCv7a1B0Co97MK5n61GqKB3e0/itRVXI2G
 rXvzNkCmJWMTnIbx1qMYall6obDlYmtb2Ca4MiCr3yl/9veigDeCPifWP
 9MmNSWyzli1Kdb6xiKJA7bGDQGZyoV9umkML1mifnhyjib6jll4O371D1
 nPzivZmAPW5+kbp+X1Wyo2K8XKIp4QwSjJWjYaXyeMDxybL3jglnUduor
 INKEEpTJAeOzXNqctcuejbmhqYAe8qpm+8mlCYRFP0Qi4fo7yBvj0aTF9
 AdDwCKISFzFVQHZbDJLD7LSpze6NHkb9v67GOsbnIl+sJjZHlAXBviBmu Q==;
X-CSE-ConnectionGUID: nC+TFOu/SLGxT9R2qZ68Mw==
X-CSE-MsgGUID: /pxwpZjmR9Sspm6MXWHbVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71853558"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71853558"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 05:15:11 -0800
X-CSE-ConnectionGUID: yBqpQxMzSr+jpKp6Jbjm6Q==
X-CSE-MsgGUID: CZ1wt7h1RSK3ajVgB/rExg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="216547358"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 09 Feb 2026 05:15:09 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Beilei Xing <beilei.xing@intel.com>, Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v1 1/1] net/i40e: fix IPv6 GTPU handling
Date: Mon,  9 Feb 2026 13:15:08 +0000
Message-ID: <ab4f8d8cf24dcd18f0dd6da3359266083f31d789.1770642901.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

