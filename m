Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD09CD37B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 09:18:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58F9340653;
	Mon, 11 May 2026 11:17:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 5A44340609
 for <dev@dpdk.org>; Mon, 11 May 2026 11:17:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778491074; x=1810027074;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4MSHXFYJyxQel+Uv23S2h31wyj+xRE7fmW10dR61J0g=;
 b=lAIy6YRqnZyWWcevrpnW5WAFpuqupaKr/IZmXpGpHE6aPPTADDNuSX0v
 GmVC63Luf+2WGH6ooc4OCPCcMtWKoIZMJxP04so+BSjshVbPsajfOfFtm
 RAol8i1sIm2w5Z80xmJR1HOTfh6eoP08PCO5lDJN3ATca3q1UezBOwVwP
 bF6ZHUgRfjQusMmtLYvs8DXCbR13Bj5Zvaj8jKffiM2dhnDbiORgHf4gZ
 Modn/j9U6MDQN6By8NbpRWzZWmotIjU8pcRwTiZrjtpx22xsZ7UL5hkT8
 RR6yR212qAQhejS/5wzTzE+brtP+jmdLif7n8A50Eo8pGPBH8dskm0cxv A==;
X-CSE-ConnectionGUID: roR/PEvsTTWNR34mC50UTQ==
X-CSE-MsgGUID: dHGSeCQyQg2ig5m1HqLAPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="96937061"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="96937061"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 02:17:52 -0700
X-CSE-ConnectionGUID: hl4dcUF6Qi6GXV1/z2c6Cw==
X-CSE-MsgGUID: rKJVPqEkQo6Tm15xcHulyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="234739679"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa008.fm.intel.com with ESMTP; 11 May 2026 02:17:51 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH 2/6] net/idpf: fix DD bit byte offset in split queue AVX2 Rx
Date: Mon, 11 May 2026 14:39:31 +0530
Message-ID: <20260511090935.2288837-3-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511090935.2288837-1-shaiq.wani@intel.com>
References: <20260511090935.2288837-1-shaiq.wani@intel.com>
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

The split queue completion descriptor (virtchnl2_rx_flex_desc_adv_nic_3)
has two distinct status fields: status_err0_qw0 at byte offset 1 and
status_err0_qw1 at byte offset 8.  The DD (descriptor done) bit lives
in status_err0_qw1 (byte 8), not status_err0_qw0 (byte 1).

Byte 1 (status_err0_qw0) bit 0 is the LPBK (loopback) indicator, so
reading DD from byte 1 checks the wrong field entirely.

Fix the _mm_extract_epi8 index from 1 to 8 so the code reads the DD
bit from its correct location in the writeback descriptor.

Fixes: 1f065f9d75ff ("net/idpf: add AVX2 Rx path for split queue config")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/idpf/idpf_common_rxtx_avx2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index cd10c27a30..28d4246134 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -587,11 +587,11 @@ idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_
 		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 2]->rearm_data, rearm2);
 		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 3]->rearm_data, rearm3);
 
-		/* Extract DD and generation bits from the already-loaded descriptor data (d0-d3) */
-		stat0 = (uint8_t)_mm_extract_epi8(d0, 1);
-		stat1 = (uint8_t)_mm_extract_epi8(d1, 1);
-		stat2 = (uint8_t)_mm_extract_epi8(d2, 1);
-		stat3 = (uint8_t)_mm_extract_epi8(d3, 1);
+		/* Extract DD bit from status_err0_qw1 (byte 8 of descriptor) */
+		stat0 = (uint8_t)_mm_extract_epi8(d0, 8);
+		stat1 = (uint8_t)_mm_extract_epi8(d1, 8);
+		stat2 = (uint8_t)_mm_extract_epi8(d2, 8);
+		stat3 = (uint8_t)_mm_extract_epi8(d3, 8);
 
 		pktlen_gen0 = (uint16_t)_mm_extract_epi16(d0, 2);
 		pktlen_gen1 = (uint16_t)_mm_extract_epi16(d1, 2);
-- 
2.34.1

