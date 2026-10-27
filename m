Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31AC606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WjDvqVit
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3E7640608;
	Tue, 27 Oct 2026 11:56:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id A2670400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:56:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793098587; x=1824634587;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hRSa0FqZ5IqRRAeeeORxgTPz9HWHp5r11HPXOc1X15s=;
 b=WjDvqVitOC69G5BH4UdTmErsgutZ3uTfFc98o3OARxHGJZV5IiOhQD4Z
 qBfsfPmD1VsBLHUOI8iXfrhuvZV+xMzFXTbFTKJB74EZU3rfQ9zDRb5lM
 SogFX6jmwsnmL0s1rVvNjiyZDEKuK7DTsiRLSYetAjKn3IMEUO9HV4Fpk
 FJnskqYz4irt8NPMVYHYB4+RrwZkuvGVlAcOPYEN4cmYiOLTZp3Votq2W
 MuucAwkAFFnAqPU+kEPS8QSyitWQFSAXEBJ7zVl6KzJSBe/bB9+DgPwX1
 Y3ZW5aq46H5MlQr6n5y86bz3cqluad7zIQK91C9TOmy0o89No99zdn6sq g==;
X-CSE-ConnectionGUID: 7nN2BRBfQl6p5hxYBqdSYg==
X-CSE-MsgGUID: ehqU9Op9RXOY+2uiX1n57g==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1679295"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1679295"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 03:56:27 -0700
X-CSE-ConnectionGUID: Ep6qeyR4SHCus2x3RWBw5A==
X-CSE-MsgGUID: 5rcZjr0LQgyudT429ZrGJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4901459"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa009.fm.intel.com with ESMTP; 27 Oct 2026 03:56:26 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 1/7] net/ice: fix DDP package double free on init failure
Date: Tue, 27 Oct 2026 10:51:31 +0000
Message-Id: <ef12fc7f36b7aac2225a3fb649ede19c46b7c9d8.1793097896.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793097896.git.anurag.mandal@intel.com>
References: <cover.1793097896.git.anurag.mandal@intel.com>
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

When ice_init_hw_tbls() fails, ice_dev_init() frees the DDP package
copy but leaves hw->pkg_copy and hw->seg pointing into it. Without
safe mode, the error path then calls ice_deinit_hw(), which frees
the package copy again through ice_free_seg().

Use ice_free_seg(), which also clears these pointers.

Fixes: 9c4f15901ada ("net/ice: free memory with matching allocator")

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index b846555b97..dd3a4976ab 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -2785,7 +2785,7 @@ ice_dev_init(struct rte_eth_dev *dev)
 		ret = ice_init_hw_tbls(hw);
 		if (ret) {
 			PMD_INIT_LOG(ERR, "ice_init_hw_tbls failed: %d", ret);
-			ice_free(hw, hw->pkg_copy);
+			ice_free_seg(hw);
 		}
 	}
 
-- 
2.25.1

