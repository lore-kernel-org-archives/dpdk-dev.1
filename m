Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8F3C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:03:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57D3D42EA2;
	Fri, 31 Jan 2025 14:00:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id EE4E542E65;
 Fri, 31 Jan 2025 14:00:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328403; x=1769864403;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hg1NlXt1k+QBIrbsHHfpCabUFZYxrAOXB+g49PxJITA=;
 b=UJonl/hnmPKevoHIGBKdk9aV0X4nZdShq7Zi3KXJUOhw6ms24tdwsSco
 Loin1kDPfXZi9KRQSOCH/Ef8CyjxJHDNx+wk1zp/0vo3DCm4yNqGnb9UB
 yD4hxE0JPKEGnPdZva34r0QYKWBHv0YbgKWae37py3A8FzCBXFxQzdCM/
 K220Sw+BnkOXZzUgfk8CSrcuyUrlmepMy6Ow0y0I4zmxNv1wJgLT5RulG
 R0t7Xpr5aAyopr57f0oArTPCsU9yfYIpl98CCQRyIkSvyDpAsVKwMeW03
 Cx/N0+4o4r2AZqdXUrtIISCt/ysVKv7GOGX/IFJLpwr2msFkhqCh+ZxxQ Q==;
X-CSE-ConnectionGUID: IwZZTfL8R4+19w1iZUKMsg==
X-CSE-MsgGUID: d3k+mJSjSLGAtA58BzkKMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315668"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315668"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 05:00:02 -0800
X-CSE-ConnectionGUID: X7eQmyn8T2uqnnhLYXhQvw==
X-CSE-MsgGUID: n2fqLRxeQjaus82DkaYuqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503453"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 05:00:01 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v1 34/42] net/e1000/base: fix iterator type
Date: Fri, 31 Jan 2025 12:58:47 +0000
Message-ID: <c93385556fc09104e50a69d3f2757856cbc137b3.1738328108.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
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

From: Amir Avivi <amir.avivi@intel.com>

Fix static analysis warning about comparison between types of
incompatible width, which might lead to an infinite loop due to overflow.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Amir Avivi <amir.avivi@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_phy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index e9df7ec873..1fc7eb375e 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -2442,7 +2442,8 @@ s32 e1000_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
 			       u32 usec_interval, bool *success)
 {
 	s32 ret_val = E1000_SUCCESS;
-	u16 i, phy_status;
+	u16 phy_status;
+	u32 i;
 
 	DEBUGFUNC("e1000_phy_has_link_generic");
 
-- 
2.43.5

