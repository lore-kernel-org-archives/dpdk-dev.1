Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFF9CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:10:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 725F340674;
	Thu,  6 Nov 2025 15:10:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 51F2840431;
 Thu,  6 Nov 2025 15:10:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762438208; x=1793974208;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y1dL3iiKSpSB+vUlxN0fMaUKxW6+KK9GzedXA+IN190=;
 b=ZNrbGDQIvrH44GChNhWDhYKekY9Gad9ESO/siR0FQ6K6EbJL3ATBp+5p
 Fgt/BAHsZ3dDhCjdtVnlX95+FsSC3hQ0jImreA6FP1vbi0YdQxqQ78xju
 nKC8esEN4S8vCD8xcoQbFTdJCRVK0pHHRJ6vYEHCK+XbcUQ2gT9rfj3ny
 7dxnUutEHkq3kW81EQ5fOloK7ljT1Q++4Uhd7onlmhgxadv0vJSgfNOAa
 5Y/ihuRx9H52uyMWgV+bjaFp4jQsgi7egF91MRRRuUZ555uD4Qzlf//Lh
 a7xaYLMQa7nXzmMcE3apDOSyU7Nq1Xp5/716Se5/RgBcuwXddeGVKVqEw A==;
X-CSE-ConnectionGUID: UOhutHN1TVGlc4jJ5QD+jQ==
X-CSE-MsgGUID: fbAbWbyESmiQR2RW66eyNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67185297"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="67185297"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 06:10:07 -0800
X-CSE-ConnectionGUID: jauMlKX8TxKU3PNXjP1sjw==
X-CSE-MsgGUID: NjLvKKKCQi+oqqJzQ6tOiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187054713"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 06 Nov 2025 06:10:06 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [RFC PATCH 04/19] net: remove shadowed variable
Date: Thu,  6 Nov 2025 14:09:33 +0000
Message-ID: <20251106140948.2894678-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106140948.2894678-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
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
2.48.1

