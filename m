Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37403606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gZLN2TGn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 617B14066C;
	Thu, 22 Oct 2026 18:52:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6550A4003C;
 Thu, 22 Oct 2026 18:52:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792687932; x=1824223932;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G1QKQ5GlFnXe13Q2GS7JqIx43rO8GDRq1g9UqsYpcF8=;
 b=gZLN2TGnh0nsMP3qXMxaRgk1aRLl6T511d0qJ1AnTKn1fAugaBrN1cND
 PPFOFdG83VOlGnbMSzr2TX6DliHzh7j7jujxZBxPbYT4M3Cg2VmkiKn4t
 7EcSOiznNI7P/6eo+saepuq+cqyBs77K3mpeRDETGXcW0T8rLRBQq1e6T
 2Gomar9+nueTKmqfYQzvpjy6c0HXUUxDG84gq5iyWNhFMpc9aGDCDKkXx
 tPA+8DCsqoQKOPIQuL2w6hzyOfeaX8bg92SgYWRe03m7ZPgpZHCWxk4h5
 YwNE3LHAottN0KSo+Ajj5gz+Fwhrl2qfX51xiw1aWLiO5JEVFhML4kzfg w==;
X-CSE-ConnectionGUID: gqntYMSfSlunUQVo/qbDIg==
X-CSE-MsgGUID: BSyB89RNS2CaulwJJLk11A==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1341024"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1341024"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:52:11 -0700
X-CSE-ConnectionGUID: kQM4XSupRHujK3BDbNbyJQ==
X-CSE-MsgGUID: Ikbrc5s7TKOfoB0XzGHQbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3507807"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa003.fm.intel.com with ESMTP; 22 Oct 2026 09:52:09 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Deepthi Kavalur <deepthi.kavalur@intel.com>, stable@dpdk.org
Subject: [PATCH 1/9] net/ice/base: fix loop counter type in recipe creation
Date: Thu, 22 Oct 2026 16:51:57 +0000
Message-ID: <20261022165205.1830735-2-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
References: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Deepthi Kavalur <deepthi.kavalur@intel.com>

The lookup loop in ice_add_adv_recipe() uses a u8 counter, while the
number of lookups is u16. Use a u16 counter, so it cannot wrap around
before reaching the bound.

Fixes: fed0c5ca5f19 ("net/ice/base: support programming a new switch recipe")
Cc: stable@dpdk.org

Signed-off-by: Deepthi Kavalur <deepthi.kavalur@intel.com>
Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/base/ice_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/base/ice_switch.c b/drivers/net/intel/ice/base/ice_switch.c
index 94099c5215..cba3ca05fc 100644
--- a/drivers/net/intel/ice/base/ice_switch.c
+++ b/drivers/net/intel/ice/base/ice_switch.c
@@ -8254,7 +8254,7 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	struct ice_recp_grp_entry *r_tmp;
 	struct ice_sw_fv_list_entry *tmp;
 	struct ice_sw_recipe *rm;
-	u8 i;
+	u16 i;
 	int status = ICE_SUCCESS;
 
 	if (!ice_is_prof_rule(rinfo->tun_type) && !lkups_cnt)
-- 
2.43.0

