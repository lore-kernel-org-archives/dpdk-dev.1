Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FC5606A32C
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q+ihbv6T
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60F6140E32;
	Mon,  2 Nov 2026 09:15:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 5F3EB4003C;
 Mon,  2 Nov 2026 09:15:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793607335; x=1825143335;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ssk9s5SXIZpEHGyrrgO8HNaVIWk7e4iB29Xao9YDnTE=;
 b=Q+ihbv6TMErunkmrhtsNBuw3Cddgc27NrEmqtSqE0dv+J3Bo8D6EJCAK
 Koh7qiHRwA/8rHUXiMSYZ7tRqFA/HEjPWXLJlQMpCx7UKwwVlDIPR1pjy
 Ywo56+GFpqflp/SMBSevubYUZ/D/XsO6f67D9uCKkRCj5HnK++WXIxg3y
 ujGOwCt1zX+O/z6nMdf10u2NExii5s3zAX7lhmWw9v6Ga4FYHY63eBOGj
 tAMr1RT7i/uHxIB0FNd4cRnYIGyhdyvcgTFcP3tc5Rn0zB24+10E7VTid
 9F+4ZDUXHTi2vkLhUme3wlFa7S6mqCL0GpIPwQyn8Pw/ysv5jWNaTRpDL w==;
X-CSE-ConnectionGUID: y7kaTXFsT/OXLGrrxYJusA==
X-CSE-MsgGUID: 9wcIEAObSg6Ecr2Vn540fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2283629"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2283629"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 00:15:35 -0800
X-CSE-ConnectionGUID: vY5Gj8BMTLmJrEiqpqvajA==
X-CSE-MsgGUID: IYEDsDu0RFaGJ5Whbt+xxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7818592"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa012.fm.intel.com with ESMTP; 02 Nov 2026 00:15:33 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v2 1/7] net/ice: fix DDP package double free on init failure
Date: Mon,  2 Nov 2026 08:10:31 +0000
Message-Id: <5e161b80a142253efe517b810a195d2812a6d3d0.1793605752.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793605751.git.anurag.mandal@intel.com>
References: <cover.1793605751.git.anurag.mandal@intel.com>
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

When ice_init_hw_tbls() fails, ice_dev_init() frees the DDP package
copy but leaves hw->pkg_copy and hw->seg pointing into it. Without
safe mode, the error path then calls ice_deinit_hw(), which frees
the package copy again through ice_free_seg().

Use ice_free_seg(), which also clears these pointers.

Fixes: 9c4f15901ada ("net/ice: free memory with matching allocator")
Fixes: 7f7cbf80bdb7 ("net/ice: factorize firmware loading")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index d2ba64efb6..4c21356736 100644
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

