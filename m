Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7311FEDF023
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 09:11:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 281674065D;
	Fri, 13 Feb 2026 10:10:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5B89340664
 for <dev@dpdk.org>; Fri, 13 Feb 2026 10:10:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770973833; x=1802509833;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=v4cdLClosJm4qDBW4Ip2xWQZxXTXyKxuky+fEEPi+IQ=;
 b=EMiMek5jmRiAcRB/vLc8nPUxvBlkJ86a2bOgjq7fPKDEPzAJy+suZCxI
 sfDlVCGqt6we3OnKcVwc9kc0km07Z1s64bxYAs/jr2LuD6RerhfH2SPP9
 EV48t/3tMmv3GPQ3YSdHyKSZ9cTKrSzt/r6PydznZQOndV2iwB34c21iW
 7JlxVvxp1NrkvjMQtbXdN3fgAbmhNODg73+fhjBGQDvJj0F+fNx6ozI1+
 l4uMx5dw2elcijuCTM4Vn1+K2/FLDxMDqr85ttlo+EcjK3VRdwrHB++UU
 VEfCPEG86prKnxqX3iFyNISgwa5rbFJ0JrdfJ+0LUvfgoiRH5lugFbHAv Q==;
X-CSE-ConnectionGUID: qvhs3ptrTnmlRSGoQQakyg==
X-CSE-MsgGUID: 2NKEMUOiTLaszu5m/AqTIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89567877"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="89567877"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 01:10:32 -0800
X-CSE-ConnectionGUID: mBdUcO5FTy6N1oXMobCpWg==
X-CSE-MsgGUID: cpzfO5hTRiOQohy336CBnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="211966081"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa006.jf.intel.com with ESMTP; 13 Feb 2026 01:10:31 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Beilei Xing <beilei.xing@intel.com>, Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v6 07/12] net/i40e: fix IPv6 GTPU handling
Date: Fri, 13 Feb 2026 09:10:09 +0000
Message-ID: <4685b908a463bb61c081ca73995ecb9bc82d0a9a.1770973745.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770973745.git.anatoly.burakov@intel.com>
 <cover.1770973745.git.anatoly.burakov@intel.com>
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

