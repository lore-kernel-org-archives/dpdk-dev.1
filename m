Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78875606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jWfgYHCr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 604C54060C;
	Sat, 24 Oct 2026 15:50:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 53224402EF
 for <dev@dpdk.org>; Sat, 24 Oct 2026 15:50:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792849850; x=1824385850;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=1j86D6xWsg3rNC1cneCy9m5moPc/pi5UGWmdbrg5Vdg=;
 b=jWfgYHCrg6BrPPPd8wOpDmXERcOfg5FbyId7hLCVIE7J2Xta6duQEKie
 6F+i/Uaq8ScprCpsK3f9gSbyDfX1fQgiO16ThrdR7TxlYB6CbJef5qW3d
 5ZUeY9WohdE/fZvg1Ds3W73vB4qk+Y9aQOcjUfFbbG0tzA9O5PH7j71nV
 cGpX+BTL8XE1YxCO50pkRFIzeYxM71BH5I1dm90/U6u0LWy1Pg3xpsC74
 PCeHz3TuK/SNvnnK8P8BQeHoweUk6Y6hko9Ck5qwBp9MZgvriBRCT00xi
 B80UYHEs+uU7aG/2KE3KHcBI2PNpjVjMhGO8L48+FxJoTJO9ln8WaswSV A==;
X-CSE-ConnectionGUID: cRwwwzO4SjGb6rkvY5Maaw==
X-CSE-MsgGUID: DIRn6B8IRBWBiKfEHZRvHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1600817"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1600817"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2026 06:50:50 -0700
X-CSE-ConnectionGUID: ZfIZY7SHSEigIYaF7Hd1lA==
X-CSE-MsgGUID: oRaS+qPLS2SLi2th38eTAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="4216674"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 24 Oct 2026 06:50:50 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 2/5] ethdev: fix missing MACsec flow item descriptor
Date: Sat, 24 Oct 2026 14:50:29 +0100
Message-ID: <c1524fc4107c9b8823350ca837d329b19d75658a.1792849824.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5698ccb3daeebd1d50346d5a3bd8471468056463.1792849824.git.anatoly.burakov@intel.com>
References: 
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
index 704ed663c5f..6e544f4bc91 100644
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

