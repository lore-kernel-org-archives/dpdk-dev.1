Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08562D111A8
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:45:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FB9B40658;
	Mon,  1 Dec 2025 12:45:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9443240608;
 Mon,  1 Dec 2025 12:45:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589509; x=1796125509;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DlneX4eom0O63J841PmWDO0BgyJpiYvGk4S3BM+gZSo=;
 b=hUeK+zH5/21bInV3axeRgXMu5BWTTo7HIqB1VpgDJ2Ti73LikSgGQgsd
 YMcBF0jsm2asduNhv2O8HZ5rmmIlTAmq50aJkSQvgFevgwtjJpNPBNfg2
 FAZZwUrgXfcHy3nGj4vKpyyfrky1w/DjX777zLZ3RO2G+o/VoxiR+y8rT
 9qvVmP/D7/LjOm+7o86pPlmegrpfJw474zV4Z0uq473zEWmb1+fzgAevp
 KM1eYolLueBKhJClEm6kA50RyNllZTFGJWPvLVAXj1Lo7/JD6xrQSffih
 xoebGNHm0hBLez1uSthGl2WQgKodC2c5P3s+dC6LYAnsz6XeXcBS0gaZ1 A==;
X-CSE-ConnectionGUID: kRQ/9t6TT7+tQxBzfIrNUw==
X-CSE-MsgGUID: 0IBB5upORPSFrhSAvfWxeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991702"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991702"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:08 -0800
X-CSE-ConnectionGUID: BmP/OwEvQaCgkXF60EX/Yg==
X-CSE-MsgGUID: cLYYY9EUQXipEFHYprYk5g==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:07 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 05/31] net: remove shadowed variable
Date: Mon,  1 Dec 2025 11:44:22 +0000
Message-ID: <20251201114448.1441377-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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

The "mask" local variable shadowed a global definition. The local var
was only used on two lines as a temporary value to pass the return value
of one function as a parameter to another. Therefore, we can remove the
shadowing issue by removing the variable.

Fixes: 17a937baed3e ("net: add CRC AVX512 implementation")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/net/net_crc_avx512.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/net/net_crc_avx512.c b/lib/net/net_crc_avx512.c
index d18eb96971..7cd681b1cd 100644
--- a/lib/net/net_crc_avx512.c
+++ b/lib/net/net_crc_avx512.c
@@ -180,7 +180,6 @@ crc32_eth_calc_vpclmulqdq(const uint8_t *data, uint32_t data_len, uint32_t crc,
 	__m512i temp, k;
 	__m512i qw0 = _mm512_set1_epi64(0), qw1, qw2, qw3;
 	__m512i fold0, fold1, fold2, fold3;
-	__mmask16 mask;
 	uint32_t n = 0;
 	int reduction = 0;
 
@@ -260,8 +259,7 @@ crc32_eth_calc_vpclmulqdq(const uint8_t *data, uint32_t data_len, uint32_t crc,
 			res = _mm_xor_si128(res, d);
 		} else {
 			res = _mm_cvtsi32_si128(crc);
-			mask = byte_len_to_mask_table[data_len];
-			d = _mm_maskz_loadu_epi8(mask, data);
+			d = _mm_maskz_loadu_epi8(byte_len_to_mask_table[data_len], data);
 			res = _mm_xor_si128(res, d);
 
 			if (data_len > 3) {
-- 
2.51.0

