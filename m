Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D09CA0EE8
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 09:17:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3308D4065B;
	Wed, 17 Sep 2025 11:17:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 19CB140144
 for <dev@dpdk.org>; Wed, 17 Sep 2025 11:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758100659; x=1789636659;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7Dz8xJ8/98zMnMxzMTQA9gx+pcFaNn+96QWQFmFRK0I=;
 b=Tfb2sguxAfHmoYBtduan3rkOnzDrL+HFo9T7SmMW4pkgP060psJntq3e
 d9ejSzYPqXCo43u+tfVyuujZUOUli2SLJfJro1wAlwYsu/emrCmsAThM/
 UuhjfOY9lTGsXi2z/xgVaEIBp2aasTnj6vzSsSoneorWCI01v55tNbnuI
 b5dttSL1p59kJgvn8GfQtkJaafo0nFmEaHEBN4puwDcfSogXcKz5+iOQf
 PGlnRARWK8uZSjauWYvazsI8rszM5QDMBbvjxGA7hbidpFX7kNan4TWn2
 SRQpwr0pnkhq6IEj68JAwAoOSPOBezWagFtnUaTggYw9aOlVHWrRAVqz2 w==;
X-CSE-ConnectionGUID: fiejjDgtTJGIU1ITrz7sCQ==
X-CSE-MsgGUID: fKjucV4cSASW8MxaZDALqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60464524"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="60464524"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2025 02:17:38 -0700
X-CSE-ConnectionGUID: rZvwWQBfSPiqnMhUDLW4vA==
X-CSE-MsgGUID: As4nKhbZT2eIN/fJloHsKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="174760540"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa009.jf.intel.com with ESMTP; 17 Sep 2025 02:17:37 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 1/5] net/intel: add AVX512DQ flag to AVX-512 checks
Date: Wed, 17 Sep 2025 09:17:27 +0000
Message-Id: <20250917091731.3632520-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917091731.3632520-1-ciara.loftus@intel.com>
References: <20250911143145.3355960-1-ciara.loftus@intel.com>
 <20250917091731.3632520-1-ciara.loftus@intel.com>
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

Add a check for the AVX512DQ cpu flag to the x86 vector capability
function. This flag is required by the idpf and cpfl drivers which will
soon use this function during their rx path selection process.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/rx_vec_x86.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/common/rx_vec_x86.h b/drivers/net/intel/common/rx_vec_x86.h
index 32dd5ce189..6a11b7f568 100644
--- a/drivers/net/intel/common/rx_vec_x86.h
+++ b/drivers/net/intel/common/rx_vec_x86.h
@@ -359,7 +359,8 @@ ci_get_x86_max_simd_bitwidth(void)
 	int simd = X86_MAX_SIMD_BITWIDTH;
 
 	if (simd >= 512 && rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
-			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
+			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1 &&
+			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512DQ) == 1)
 		ret = RTE_VECT_SIMD_512;
 	else if (simd >= 256 && (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1))
 		ret = RTE_VECT_SIMD_256;
-- 
2.34.1

