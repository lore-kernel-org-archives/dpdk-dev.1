Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8136AC02198
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:10:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8141410EA;
	Thu,  6 Feb 2025 17:09:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 880C1410DF
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858159; x=1770394159;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vJQt4keHron1t+4dgwI3U2e+HLPw2sLxU21rMIJbkss=;
 b=GL/84nqwIsQ1FCMbs9DaZiZos5UlFYPKj/DrMijnN4rHV7SVlaQZppLr
 SsF9+GOVhgeYv13fFFzBUR1pFcO+4nZbuMq85FpSzXDXy+onTeez33a+e
 LFSkrdEIQ/OCgLwgUSoneAxdePX9tdU4QmhArazVIdFdGZNpPOJHWkh89
 sYGPjXCMenvPW+h7szsOlXqe9zj1FZJj0TvK7r3vOMysPbik8bzach4AT
 +LRrDCa/IfcXlPZtoSKqsfpkC7GlHHNAS8R4C1T7asx8P0BU+AAUiCRJe
 zprEios7QWlukvPEhOCLzsfMaWN/Qf8r1qdt3XbqpKG5mPD/59iAjzkt4 g==;
X-CSE-ConnectionGUID: rTlCc1FLSsKcrCv9fO9Viw==
X-CSE-MsgGUID: dRJ1Tz8jTS+0OCCk4/qsdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860744"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860744"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:18 -0800
X-CSE-ConnectionGUID: 6EpI5PsUSzOgDm6ATKzXIg==
X-CSE-MsgGUID: B/Q9BWoARpmUeoiloN9Cug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166758"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:16 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Alvin Zhang <alvinx.zhang@intel.com>,
 Ferruh Yigit <ferruh.yigit@intel.com>
Subject: [PATCH v1 12/24] net/igc/base: fix data type in MAC hash
Date: Thu,  6 Feb 2025 16:08:35 +0000
Message-ID: <eec0394f3f3bae43ee30216839cb4760836640cf.1738858026.git.anatoly.burakov@intel.com>
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

From: Barbara Skobiej <barbara.skobiej@intel.com>

One of the bit shifts in MAC hash calculation triggers a static analysis
warning about a potential overflow. Fix the data type to avoid this.

Fixes: 8cb7c57d9b3c ("net/igc: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Barbara Skobiej <barbara.skobiej@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/igc/base/igc_mac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/igc/base/igc_mac.c b/drivers/net/intel/igc/base/igc_mac.c
index c69f8ac73b..cfb74a6443 100644
--- a/drivers/net/intel/igc/base/igc_mac.c
+++ b/drivers/net/intel/igc/base/igc_mac.c
@@ -539,8 +539,10 @@ u32 igc_hash_mc_addr_generic(struct igc_hw *hw, u8 *mc_addr)
 		break;
 	}
 
-	hash_value = hash_mask & (((mc_addr[4] >> (8 - bit_shift)) |
-				  (((u16)mc_addr[5]) << bit_shift)));
+	hash_value = (u32)mc_addr[4];
+	hash_value = hash_value >> (8 - bit_shift);
+	hash_value |= (((u32)mc_addr[5]) << bit_shift);
+	hash_value &= hash_mask;
 
 	return hash_value;
 }
-- 
2.43.5

