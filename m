Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79353C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:18:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F61B40A6E;
	Tue, 27 May 2025 15:17:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 1552A40669;
 Tue, 27 May 2025 15:17:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748351873; x=1779887873;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JOf6pbaaJmmIoq+AHA9lJxZS0iDrJhtsFyAvj4sLd9s=;
 b=ex0LUdF4ZTYWYIlGuQ64024jK107R4kpl4TKXHkotzULwDo4ss0sUFv7
 8lMTEA4ZX5L+d0Z/6m2y3epe8pE5pVeGp4ypeC5InFpKMn59JsKRk2h+X
 qbNiZKBuAK3GKtQMdAhZOUsJUb2YOfQXNSuViuKMkgtfmnH2gEW0VpRHb
 Cw3gAoNFssJ3w9yx6emLkzsLC/W1K2fD3da+k2Vme3mgs8a44E1ETh78u
 Gv7dJmFDVMCYmIvxixLsed3G0Rs8W9Cp1ROamZRJBcR6OoMYljMXxeKrw
 ilY2GZoVm4IPM7m7Stn0AKsshb/vQAFhzakeizl3PGQVB2zMt5UJp/Wmp g==;
X-CSE-ConnectionGUID: vhLTiESsRqG1rCdsuAybYg==
X-CSE-MsgGUID: jtcOIbIdSB2FJcI2DyQfyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="67884838"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="67884838"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 06:17:53 -0700
X-CSE-ConnectionGUID: 0JeOrYRBQFi22OzeoXPr0Q==
X-CSE-MsgGUID: LnA8ygopRim0MJE328hc5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="143150046"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa008.fm.intel.com with ESMTP; 27 May 2025 06:17:51 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
 Bruce Allan <bruce.w.allan@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
 Xiaolong Ye <xiaolong.ye@intel.com>
Cc: dev@dpdk.org, Lukasz Krakowiak <lukaszx.krakowiak@intel.com>,
 stable@dpdk.org, Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v3 03/10] net/ice/base: fix integer overflow issue
Date: Tue, 27 May 2025 13:17:22 +0000
Message-ID: <20250527131741.7606-4-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
References: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
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

From: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>

Fix issue related to INTEGER_OVERFLOW.

Fixes: f636f2888cec ("net/ice/base: move and add some help function and macros")
Cc: stable@dpdk.org
Signed-off-by: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>
Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
---
 drivers/net/intel/ice/base/ice_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/base/ice_type.h b/drivers/net/intel/ice/base/ice_type.h
index 297a5ea890..ae3b944d6e 100644
--- a/drivers/net/intel/ice/base/ice_type.h
+++ b/drivers/net/intel/ice/base/ice_type.h
@@ -25,7 +25,7 @@
  */
 static inline bool ice_is_pow2(u64 val)
 {
-	return (val && !(val & (val - 1)));
+	return val != 0 && (val & (val - 1)) == 0;
 }
 
 /**
-- 
2.43.0

