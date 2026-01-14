Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB51D37E44
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:45:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B98440A89;
	Wed, 14 Jan 2026 16:45:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id CDC0940A80;
 Wed, 14 Jan 2026 16:45:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405510; x=1799941510;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DlneX4eom0O63J841PmWDO0BgyJpiYvGk4S3BM+gZSo=;
 b=H93L7UGvuRzVEmpp6dNw8ZFxDS5Z8yrorPIAEHALqXq+nfXhRiB3WENi
 JVGC57Sbyz9wp9sCiFak6F0W/o9WTSlNObwGV+RaEiEFUDl6Ydu0SjVED
 aPbHdQIgSLfrZsVwBT38daZdTVnF5hHAUQC3QM8TiVeIJQXB4J8mR/8Np
 E1xezdZJeEx1uwh0gxBvSvcUfYJ/EnnFA3AWM3gWClLff3liRri2RZZbX
 RzvTn8Wwh9S7T08Ur+uJyweoICfDep3CDbl46Xlv3jS9SpMj3IezGUSqV
 +5ted7SLFDlSdhcCh3tDMg91LZmOetscZMXirGgdDzKCw7tu0yo6MPUX8 g==;
X-CSE-ConnectionGUID: ej2lEoQpQhSwgMq1x6K29g==
X-CSE-MsgGUID: rylBjs02SWyrzHBj3QcZ/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870808"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870808"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:09 -0800
X-CSE-ConnectionGUID: g5wey54iRhO1YuGbS0Cskg==
X-CSE-MsgGUID: h28XU6khRwylHDYjVXNAUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203924962"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:06 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Jasvinder Singh <jasvinder.singh@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Mairtin o Loingsigh <mairtin.oloingsigh@intel.com>,
 David Coyle <david.coyle@intel.com>
Subject: [PATCH v4 05/31] net: remove shadowed variable
Date: Wed, 14 Jan 2026 15:44:19 +0000
Message-ID: <20260114154450.2969716-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
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

