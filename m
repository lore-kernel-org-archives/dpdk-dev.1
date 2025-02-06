Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666A7C02198
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:09:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 205AA40ECF;
	Thu,  6 Feb 2025 17:09:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 5FBB840E72
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858149; x=1770394149;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ygZopxf56w9FNMeCDmenh5JT4IJ/qyRLt/pMyK0taLI=;
 b=krp6fwNfdoXHNchmih4sGOTNG4wif8Rt2RgdylhD9FJfCRYiY5FGSa6Q
 dj4m3pL4qTTZ6ys5m8tDBRWvxGgvlpW2sKPd42v5nJDmUutF/Ig0rXhVq
 4JiWERXZ0ENJ6s96JEq/1lVLF2amzKHi/ahFDYoxIbUdSjXJ/TWdApB3E
 yTGU1QOiKHlFENu111Leq6lQz+8YP+7Eu+RPm6/AMw2WEvH8eQQC4Fmol
 ED8dDHfzXfaJnjK2HnBvVgBC7HnNgyGu8+I0fsvGx+b0avZ/vK8Ik4p2M
 NA0ySVQxvfqByX/ytFOrrAzYTroxGcXMKgIUjc1l71Oh31azXzkrf92MM A==;
X-CSE-ConnectionGUID: g18JQzA5RoGLDynmyo6u1Q==
X-CSE-MsgGUID: N2yq5aM6RDCcU+dSfKU7lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860714"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860714"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:06 -0800
X-CSE-ConnectionGUID: DdbUvRRGSPyhAbSpcYJdaQ==
X-CSE-MsgGUID: S+vti9r5Qem2hb+rEpgHUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166640"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:03 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Ferruh Yigit <ferruh.yigit@intel.com>,
 Alvin Zhang <alvinx.zhang@intel.com>
Subject: [PATCH v1 03/24] net/igc/base: fix bitwise op type mismatch
Date: Thu,  6 Feb 2025 16:08:26 +0000
Message-ID: <7d0d5ba85d3bbf68cc08be40c7208437607f7e6b.1738858026.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738858026.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738858026.git.anatoly.burakov@intel.com>
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

Fixes: 8cb7c57d9b3c ("net/igc: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Przemyslaw Ciesielski <przemyslaw.ciesielski@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/igc/base/igc_i225.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/igc/base/igc_i225.c b/drivers/net/intel/igc/base/igc_i225.c
index 8f01f8d918..1277f59885 100644
--- a/drivers/net/intel/igc/base/igc_i225.c
+++ b/drivers/net/intel/igc/base/igc_i225.c
@@ -344,7 +344,7 @@ void igc_release_swfw_sync_i225(struct igc_hw *hw, u16 mask)
 	}
 
 	swfw_sync = IGC_READ_REG(hw, IGC_SW_FW_SYNC);
-	swfw_sync &= ~mask;
+	swfw_sync &= ~(u32)mask;
 	IGC_WRITE_REG(hw, IGC_SW_FW_SYNC, swfw_sync);
 
 	igc_put_hw_semaphore_generic(hw);
-- 
2.43.5

