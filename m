Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18578606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A4KuYYdJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70DEC4064F;
	Tue, 27 Oct 2026 10:50:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 3960B400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 10:50:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793094638; x=1824630638;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=1j86D6xWsg3rNC1cneCy9m5moPc/pi5UGWmdbrg5Vdg=;
 b=A4KuYYdJT5ZUA/N7q9bKenrj0fN+YEWD1I5kLmp+ovVDYsHPqi1vKmnP
 fGb4H5+r6qp6x6qBTB2KI+SxBlPU835hAKULq0kXIBz9BG5nd2zRMo8gK
 RKMhwzXb97VlbkOVNW6Ridht7FFiMhLenhe5/j/R8iF9cQ5QICOKHCdh5
 EOqNZKYlWMKUADNJZHF4LLEn589sX6ULbCWE00Um5Cr3V4KczQ88IlIYP
 jTYlp9tExyGwcR+sh/JLFQhzffdUisAl4TsQJt81bJYyTKrOqIOZ5b6Vf
 H5yPObjBqMnI/clPmyB/9jAYA86/yQhpIkFHxiBGx04oPIWrYVS+aL6A6 g==;
X-CSE-ConnectionGUID: QxSZ7jYBSPqM08b4pCnpKg==
X-CSE-MsgGUID: Gvmj9JFvSiai4hGnNNYnbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1674903"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1674903"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 02:50:35 -0700
X-CSE-ConnectionGUID: 31bdDOJwR968Xa89WVcWdA==
X-CSE-MsgGUID: gfaEZP7QQBKBmRSnoJ6HCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6250866"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 27 Oct 2026 02:50:18 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Ori Kam <orika@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH v4 2/6] ethdev: fix missing MACsec flow item descriptor
Date: Tue, 27 Oct 2026 09:50:09 +0000
Message-ID: <c1524fc4107c9b8823350ca837d329b19d75658a.1793094529.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5698ccb3daeebd1d50346d5a3bd8471468056463.1793094528.git.anatoly.burakov@intel.com>
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

