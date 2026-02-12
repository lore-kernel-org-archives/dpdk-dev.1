Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C2CEE3698
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 16:27:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1B774025F;
	Thu, 12 Feb 2026 17:27:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 3FCBE40041;
 Thu, 12 Feb 2026 17:27:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770913636; x=1802449636;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=x9nxbo9/LnFBiuaSYqKCjxQM731lbm1ekbER9ULsv44=;
 b=C5OgnntaWBpU3a8uC45+zqblfylMtDs+pbhtgip6sHHGZfR+YmDvWlZM
 dVoFCdnlEIyMeIdCqjwgQV3hek3uQBmfePlsZYhgykFzZb+wROC6SJHCf
 8PfRy0KzloYpw3E7fh/tBTXc1XWSrVpi/EjXnzeGse8hIYdz/63w3Ogeu
 4axE+Lbspe2rq+TOpywahSMfqUuzPdF1T75GgREPwuWfFPIeCLUj+T9yI
 xsLt/45rm2ppm66NTuI/1Lsmen0ny9O2zQ/OxscOKRnTjsDRd43/23UMp
 e/CjfbhT1KzztQIfURcjKOdHAn1o/h9ELS1FC4yRGhuFRMme3PsgIuC1t Q==;
X-CSE-ConnectionGUID: Lcowr+OvSCa/e3gFj+bqAw==
X-CSE-MsgGUID: O4BJ6aylQfKWArUSortuHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83184979"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="83184979"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 08:27:13 -0800
X-CSE-ConnectionGUID: AjcQTPzDQzSeDhkvqaZPNw==
X-CSE-MsgGUID: Z5DyRwabRFywzzM7Y2bRyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="211598482"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa007.fm.intel.com with ESMTP; 12 Feb 2026 08:27:12 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH] hash: fix maybe-uninitialized warnings on build
Date: Thu, 12 Feb 2026 16:27:05 +0000
Message-ID: <20260212162705.3923717-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Following recent changes to the test-meson-build.sh script[1] to use more
build-types warnings are seen in the hash library GFNI code about values
possibly being uninitialized.

In function ‘_mm512_mask_permutexvar_epi8’,
    inlined from ‘__rte_thash_gfni’ at ../lib/hash/rte_thash_x86_gfni.h:150:6:
/usr/lib/gcc/x86_64-linux-gnu/15/include/avx512vbmiintrin.h:97:20: error: ‘tuple_bytes_2’ may be used uninitialized [-Werror=maybe-uninitialized]

These all appear to be a false positive, but fix these by explicitly
zero-initializing the offending values.

[1] 177acaf5cf75 ("devtools: test different build types")

Fixes: 4fd8c4cb0de1 ("hash: add new Toeplitz hash implementation")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/hash/rte_thash_x86_gfni.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/hash/rte_thash_x86_gfni.h b/lib/hash/rte_thash_x86_gfni.h
index 99226b7592..69973503fd 100644
--- a/lib/hash/rte_thash_x86_gfni.h
+++ b/lib/hash/rte_thash_x86_gfni.h
@@ -89,9 +89,9 @@ __rte_thash_gfni(const uint64_t *mtrx, const uint8_t *tuple,
 	const __m512i shift_8 = _mm512_set1_epi8(8);
 	__m512i xor_acc = _mm512_setzero_si512();
 	__m512i perm_bytes = _mm512_setzero_si512();
-	__m512i vals, matrixes, tuple_bytes_2;
+	__m512i vals, matrixes, tuple_bytes_2 = _mm512_setzero_si512();
 	__m512i tuple_bytes = _mm512_setzero_si512();
-	__mmask64 load_mask, permute_mask_2;
+	__mmask64 load_mask, permute_mask_2 = 0;
 	__mmask64 permute_mask = 0;
 	int chunk_len = 0, i = 0;
 	uint8_t mtrx_msk;
-- 
2.51.0

