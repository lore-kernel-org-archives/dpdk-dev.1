Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E522C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:25:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCBF040E1E;
	Mon,  9 Jun 2025 12:25:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1771140E0B
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:25:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749464745; x=1781000745;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=KDv0daiP3gVmulvEN1CzUhSDtehFHJCefh018QxpEzA=;
 b=OPGzKQ5Xc/9V+ejNvTsojBHNFTf6cPj1tHgdhsa2UljULhasHdneW1YO
 6A0iAh+mO8NLKPx5tbYvcpIAvKmCIiLtUpCCsbjVykeTN9G7qTX/SM7As
 PHtQItHFefAStaRPcQTQpK486SiXXnyOi8Uqj8VMLeoMAH++HQCn+Ft4k
 0xaMxBpoF65xeoYaKTYpHJEmhpSt2s3lirX/USHCS7MR4xpMrpm+mJ68C
 fN1qW7gqxfuT6zf47zaAZokguu1MXaW55p6hIMedacfXiolisNKUW3/Vm
 yBU5E7JBCXSINO+w6weZFFc45YyoJYqrRkLAhphYSgs/OSqmNLqyQbnei g==;
X-CSE-ConnectionGUID: UDVFM2LOQjy80bFx9hprOg==
X-CSE-MsgGUID: uD8qPjWFQV2ws72YLelZyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="51448499"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="51448499"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:25:44 -0700
X-CSE-ConnectionGUID: /77DzCgaS06fc8f6Q2pXwg==
X-CSE-MsgGUID: 6uctwnTJTUiqG/bWIW+zBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="146356429"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa006.fm.intel.com with ESMTP; 09 Jun 2025 03:25:44 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 1/5] net/ixgbe: remove PTP by PHY cap
Date: Mon,  9 Jun 2025 11:25:34 +0100
Message-ID: <92ae703c9b3688c766dd02dd634bb413c897487a.1749464704.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749464704.git.anatoly.burakov@intel.com>
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

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Disable PTP by PHY capability support.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/base/ixgbe_e610.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ixgbe/base/ixgbe_e610.c b/drivers/net/intel/ixgbe/base/ixgbe_e610.c
index 7420c78d07..cf45db3bc4 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_e610.c
+++ b/drivers/net/intel/ixgbe/base/ixgbe_e610.c
@@ -752,7 +752,7 @@ ixgbe_parse_common_caps(struct ixgbe_hw *hw, struct ixgbe_hw_common_caps *caps,
 			  prefix, caps->next_cluster_id_support);
 		break;
 	case IXGBE_ACI_CAPS_PTP_BY_PHY:
-		caps->ptp_by_phy_support = (number == 1);
+		caps->ptp_by_phy_support = 0;
 		DEBUGOUT2("%s: ptp_by_phy_support = %d\n", prefix,
 			  caps->ptp_by_phy_support);
 		break;
-- 
2.47.1

