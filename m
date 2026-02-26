Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85588FCE08E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:22:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBC034065C;
	Thu, 26 Feb 2026 15:22:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 896C24026F;
 Thu, 26 Feb 2026 15:22:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772115743; x=1803651743;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kEoj2A0lyUq1Q06LjJWqFjNVbxaaq0YqhNAcQ1Xcx9g=;
 b=kAr6Z4OtCI22oInymUx9RQR4TbssmzOMVbmTI1b4fDtZscjCOR5Uoov2
 vhOOi2YBDfMYyCxOJlfgNEbmPhR8eTIvdneYxgv7+cPMEVaj8ehaiZC90
 u9K29gc3tcNxJ+pb6nA1IWEg3VhzmTEbq4sqAYVHQjpQpexThCfmFKpiZ
 5KZugYs6m1evIx/6MlNPceyx0uCoDA1ueSpxCPci0csYp4w8j4WpFaOF7
 BRMTOFAX/+add+mhLG1lLDa2FrzgoTCrPaKqJTOoun1eTzEEQvlFu+Bw1
 ss+0vfVzwLeCWhN9JZNCQOLtGtAoaQ0V4CEtvhuwXCJGpysYa+tIiZ09x A==;
X-CSE-ConnectionGUID: Z8FWPZEvRnma+YtUNvin7Q==
X-CSE-MsgGUID: FhGO26FRShuvO53aJ3gJSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="95794196"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="95794196"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 06:22:22 -0800
X-CSE-ConnectionGUID: 9SwKkM32S+uCTvDymHAOCw==
X-CSE-MsgGUID: u5pMQlafSL+nY6kQ9II2jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="244147358"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa001.fm.intel.com with ESMTP; 26 Feb 2026 06:22:20 -0800
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, stable@dpdk.org,
 stephen@networkplumber.org, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Yerden Zhumabekov <e_zhumabekov@sts.kz>
Subject: [PATCH] hash: fix pointer alignment
Date: Thu, 26 Feb 2026 14:22:06 +0000
Message-ID: <20260226142206.860737-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
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

rte_hash_crc assumes input pointer address is 8 byte aligned
which may not be always the case.
This fix aligns the input pointer before proceeding to process it
in 8 byte chunks.

Fixes: 504a29af13a7 ("hash: fix strict-aliasing for CRC")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 lib/hash/rte_hash_crc.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/hash/rte_hash_crc.h b/lib/hash/rte_hash_crc.h
index fa07c97685..66f11fafcd 100644
--- a/lib/hash/rte_hash_crc.h
+++ b/lib/hash/rte_hash_crc.h
@@ -127,6 +127,24 @@ rte_hash_crc(const void *data, uint32_t data_len, uint32_t init_val)
 	unsigned i;
 	uintptr_t pd = (uintptr_t) data;
 
+	/* align input to 8 byte boundary if needed */
+	if ((pd & 0x7) && data_len >= 8) {
+		uintptr_t unaligned_bytes = 8 - (pd & 0x7);
+		data_len -= unaligned_bytes;
+		if (unaligned_bytes & 0x4) {
+			init_val = rte_hash_crc_4byte(*(const uint32_t *)pd, init_val);
+			pd += 4;
+		}
+		if (unaligned_bytes & 0x2) {
+			init_val = rte_hash_crc_2byte(*(const uint16_t *)pd, init_val);
+			pd += 2;
+		}
+		if (unaligned_bytes & 0x1) {
+			init_val = rte_hash_crc_1byte(*(const uint8_t *)pd, init_val);
+			pd += 1;
+		}
+	}
+
 	for (i = 0; i < data_len / 8; i++) {
 		init_val = rte_hash_crc_8byte(*(const uint64_t *)pd, init_val);
 		pd += 8;
-- 
2.52.0

