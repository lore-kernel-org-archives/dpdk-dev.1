Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BB1C43458
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Jul 2026 20:24:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E4A340274;
	Sat, 11 Jul 2026 22:24:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 317D34026F;
 Sat, 11 Jul 2026 22:24:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783801490; x=1815337490;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5wXJGCIgKj03RMnQkIE6PJuoQZq7TNgB4u5yvrcC9uY=;
 b=fo+BuPQ7zUVLDWwF7y7zq3N02N4xuqiAKjZblnMW3CyOJKDGpOXv2qV8
 ytElJPHZRuRVpSAONmiY4G2XxJCdsr0m9C9VC7aF+x6bg+oTK6+ylWa7s
 dqCEJnFv5wLJJSlV6W14CoLkWGlXBiV2nhhlVCB6b1WKQwzH1zAohXaPo
 4uito76/jan+dJEYnbdE1SYpILdjVDATr6ZUM6VKfvY+UsEhRWHNvH25y
 ifkqKTM9yDUKIkkey2OL2huw/xofw7lc4iLQKu8D7YPgKGkKwRHErvF5k
 ZnVPKkolnvNY3tAAhGe1HCQ59h+Lwv2+haiZZ7DmWq2AMJM0mpZONfNgz Q==;
X-CSE-ConnectionGUID: 8aVc4XnaQHqiSkiY8HKzwg==
X-CSE-MsgGUID: EdlOMu4ZRXS2A8xJYmyQsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="87013615"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="87013615"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2026 13:24:48 -0700
X-CSE-ConnectionGUID: b2WVKP01RYOUbMK+SV0SIQ==
X-CSE-MsgGUID: hEi7ny7lQ82xQBJwIDvDVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="279587263"
Received: from unknown (HELO localhost.localdomain.iind.intel.com)
 ([10.49.105.104])
 by fmviesa001.fm.intel.com with ESMTP; 11 Jul 2026 13:24:46 -0700
From: sandeep.penigalapati@intel.com
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH] net/ice: fix missing return on unsupported range in FDIR
Date: Sat, 11 Jul 2026 23:26:47 -0400
Message-Id: <20260712032647.196461-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.27.0
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

From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>

In ice_fdir_parse_pattern(), a flow item that specifies a 'last'
member (a range) is only allowed for IPV4 and IPV6_FRAG_EXT item
types.  For other item types the code set an rte_flow error but did
not return, so parsing continued from an inconsistent state.

Add the missing return so an unsupported range aborts parsing.

Fixes: b7e8781de768 ("net/ice: support flow director for IP fragment packet")
Cc: stable@dpdk.org

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index fc848a33db..d7ddd32f90 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1929,6 +1929,7 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 			rte_flow_error_set(error, EINVAL,
 					   RTE_FLOW_ERROR_TYPE_ITEM, item,
 					   "Not support range");
+			return -rte_errno;
 		}
 
 		input_set = (tunnel_type && !is_outer) ?
-- 
2.27.0

