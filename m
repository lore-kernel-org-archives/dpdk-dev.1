Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9844AC02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:14:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC491427C1;
	Tue,  4 Feb 2025 16:12:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id C99AA41148
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681913; x=1770217913;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AuAMtPDVpHRr5STIYaavE7s+hcOFKiKlGmFjPBKAKrc=;
 b=FF2XCvBJcXVhDaZll6NJ7TBn+BN5ERS/7kCSDhxoyYWdOsmvSjCs/txm
 aErKqTp2NYAtj/rQfXSFQEUOXzougoHRHzS2AQrKhHMGjkIsZdNsLDhAa
 nT01N2HzF4NA9AHP8REUALQAsRfVbIJVOs5gm6jPi5agHM9aAfi0QIhzy
 z6KZVbyjdMyQbdMDkW0dnBs+v2zZN2llTYQ9aClrJWgp9sR2CuQALKdk1
 MupLzGXqknZ/U5iR2/9q7AmmHX9FTnOjRZJIsuUYEspO+DiB8MYLb4Mr/
 1tRj14M3PG13WW0s3LxOoUg/kdY7g7isdeDw2+WvaR5QXAwDYPcEcpQAp Q==;
X-CSE-ConnectionGUID: lg4wIKgMSVOXZkMmnmLKyQ==
X-CSE-MsgGUID: 11Ao43i9SSOqGqR44FaRYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097124"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097124"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:52 -0800
X-CSE-ConnectionGUID: en2TZivKTfqOKY2Log0rWw==
X-CSE-MsgGUID: Ez6XWcqgSYavscRezOlOrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792644"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:50 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 19/54] net/e1000/base: fix bitwise op type mismatch
Date: Tue,  4 Feb 2025 15:10:25 +0000
Message-ID: <a35687381855925b26bf82aeea7773421edbbf98.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

From: Przemyslaw Ciesielski <przemyslaw.ciesielski@intel.com>

Static analysis has found type mismatch between mask and register value.
Fix the bitwise operation type to avoid potential issues.

Signed-off-by: Przemyslaw Ciesielski <przemyslaw.ciesielski@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i225.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index 18a4b38cba..b8b57b6628 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -351,7 +351,7 @@ void e1000_release_swfw_sync_i225(struct e1000_hw *hw, u16 mask)
 	}
 
 	swfw_sync = E1000_READ_REG(hw, E1000_SW_FW_SYNC);
-	swfw_sync &= ~mask;
+	swfw_sync &= ~(u32)mask;
 	E1000_WRITE_REG(hw, E1000_SW_FW_SYNC, swfw_sync);
 
 	e1000_put_hw_semaphore_generic(hw);
-- 
2.43.5

