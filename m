Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD92D606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AJ2IaScD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9342B402B0;
	Sat, 24 Oct 2026 14:04:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id DDE3C4021F
 for <dev@dpdk.org>; Sat, 24 Oct 2026 14:04:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792843461; x=1824379461;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=EONec5t6CiA/AQFi3VClVjW3+T4B9dMhn0gPrzijG4Q=;
 b=AJ2IaScD0LCRMjGnB++VnLgsnvqWs/lc3BO4T1lEHbDzlqlCf4XaVUum
 KuLieAhf8nog/rd05f9S9y3sptJJMiyBWhR1YS3UwIZrEr0SPpr1G1eGJ
 P39fLLCimTvqGa9+njLtLWxOcKsNdjTC/gWqXY+5N5FAefH29uMc81rRf
 SDzhlVCUbZJqfuiDm3j8O8WsiExROnOc2MCXL5PqN7qbjVs2nnnOy6/aC
 wo2k0nlJL8tDxN2EEhQSRRn/tESBxixOqRfpozox/v6+nb/9tOkVB3QrS
 Rpzr1n4iX76Cw7xN9MNpuxsGrYoGmAbq4dOOImudOFwcNne7uTgU/enBf w==;
X-CSE-ConnectionGUID: EPnqXlC9R6++1w6ucUiy0A==
X-CSE-MsgGUID: /cKgZHySS9GK/UftJ2l8AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1569156"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1569156"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2026 05:04:20 -0700
X-CSE-ConnectionGUID: Uw9EPZTRTsqeHTEk3x2CPQ==
X-CSE-MsgGUID: GcM4CTsqTO2681SLtzpWZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="4203811"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 24 Oct 2026 05:04:18 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Ori Kam <orika@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH v2 1/4] ethdev: fix missing MACsec flow item descriptor
Date: Sat, 24 Oct 2026 13:04:07 +0100
Message-ID: <8ccaee11fc265b812abd75ef7defdfdd47e65c3d.1792843432.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <8fa05595f3596e9355dd90df7fc278b104beb20b.1792757739.git.anatoly.burakov@intel.com>
References: <8fa05595f3596e9355dd90df7fc278b104beb20b.1792757739.git.anatoly.burakov@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RTE_FLOW_ITEM_TYPE_MACSEC was never added to rte_flow_desc_item[].
The table uses designated initializers, so the MACSEC slot is zero
filled: its name is NULL and its size is zero.

As a result, RTE_FLOW_CONV_OP_ITEM_NAME on MACSEC passes a NULL
source to strlcpy(), and rte_flow_copy() as well as the pattern
conversion operations reject any pattern containing a MACSEC item
as an unknown item type.

Add the missing descriptor entry.

Fixes: 0aaf097585a6 ("ethdev: add MACsec flow item")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/ethdev/rte_flow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 0ebf59165d4..eeab79aa5d9 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -229,6 +229,7 @@ static const struct rte_flow_desc_data rte_flow_desc_item[] = {
 			rte_flow_item_l2tpv2_mask),
 	MK_FLOW_ITEM_MASK(PPP, sizeof(struct rte_flow_item_ppp),
 			rte_flow_item_ppp_mask),
+	MK_FLOW_ITEM(MACSEC, sizeof(struct rte_flow_item_macsec)),
 	MK_FLOW_ITEM_MASK(METER_COLOR, sizeof(struct rte_flow_item_meter_color),
 			rte_flow_item_meter_color_mask),
 	MK_FLOW_ITEM(IPV6_ROUTING_EXT, sizeof(struct rte_flow_item_ipv6_routing_ext)),
-- 
2.52.0

