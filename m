Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2925C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:03:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A712B42EC2;
	Fri, 31 Jan 2025 14:00:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7FDCF42E8F;
 Fri, 31 Jan 2025 14:00:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328409; x=1769864409;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eGnW4oL7/dqj0BdR+q6XHd0tPcHZZryuCc/sc/dEdTg=;
 b=Y3lDgDSFgHd0neHZCN60685MUGJE9GViVU1fG4DwlItZFPAdgWyli3Tj
 2BvEdbIiomVvkr57ZzIH2BWqusJH+vIeevjJDax15tMrU0N452XgoF4aI
 36uZ/i3Ti96U0Yvy19kylDiC/aDgDMAKKjfzHb/PKgg0NOlorIFaaIDau
 75sEKXnemgkBMfcpUjNHMB/eadLSXPQxdUIK9OePEanlR+0QqjP2x9T60
 pQnP1LCY9Y3i85awHuwzIEE4yw2uc1NEPQeu8QgnZIVHiWMhP6/2M5a3B
 guQYN/n3J/brQdgg97ejPt0sOPzvSqVbtqGR4wW1ChcHkaJbmTHEHjG8E g==;
X-CSE-ConnectionGUID: zSoFA0zYRhKuEQIcGIdSQQ==
X-CSE-MsgGUID: 8gEexGyxTo6j3vXqbGuXsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315681"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315681"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 05:00:08 -0800
X-CSE-ConnectionGUID: lU+qP/ndTcyOYb9AW+VINQ==
X-CSE-MsgGUID: l7EdZBlrRki7JYFz8QAtwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503493"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 05:00:07 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Wenzhuo Lu <wenzhuo.lu@intel.com>
Cc: stable@dpdk.org
Subject: [PATCH v1 39/42] net/e1000/base: fix unchecked return
Date: Fri, 31 Jan 2025 12:58:52 +0000
Message-ID: <f15a88a376b9fb6ccbc569207e1141665bd6c749.1738328108.git.anatoly.burakov@intel.com>
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

Static analysis has detected a write that is not checked for errors,
leading to ignored error return value. Add a check.

Fixes: edcdb3c5f71b ("e1000/base: fix link flap on 82579")
Cc: stable@dpdk.org

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index c3449a3f45..6b7eb245a6 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -989,6 +989,8 @@ s32 e1000_set_eee_pchlan(struct e1000_hw *hw)
 		data &= ~I82579_LPI_100_PLL_SHUT;
 		ret_val = e1000_write_emi_reg_locked(hw, I82579_LPI_PLL_SHUT,
 						     data);
+		if (ret_val)
+			goto release;
 	}
 
 	/* R/Clr IEEE MMD 3.1 bits 11:10 - Tx/Rx LPI Received */
-- 
2.43.5

