Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4410CE6BF04
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:44:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF10A40B9C;
	Fri, 30 Jan 2026 12:42:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id D2A9240A84
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:42:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769773364; x=1801309364;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8WvFBFwmSuXZM2fGcP/qqNMRxQ6Un9dLsGYThlromUg=;
 b=Q8mUQ6b39kb5fg3cw/Nb557IQrXMJce+suNaQyxl0fH/hEjhQZ9fuSeQ
 lcFrwNdkPwTSlu2j2EGFUngIYmz2RFxSgk74+bH8qADFfhQvwF07tQ1CE
 Ss6CyG60dfU3DoHBvLYkABSRzc6mWjqAnXnqrbA/DdLJqsx2h8gZg+2gW
 wxA2U1AlBFqeHTCXbCQCT25aqhI2edNjBcXvqRfKeeLoPnAc0mfXYVDL/
 V8kxPzCT2pKCH9gl1NrlOZLtptI63oLlH/OShKy0WgoxqUKCAB8X3x5kx
 iKo66oioCDnkE2SFkqf1CO2myKb8GdUlGKM0rBJfkY3N+GijixFPbFOKT g==;
X-CSE-ConnectionGUID: /KfbnGg4QeuXZNXE4pIN9A==
X-CSE-MsgGUID: QNLkZeL/Sz+tKantvMfKpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82392316"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="82392316"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 03:42:43 -0800
X-CSE-ConnectionGUID: YJ7VJYHWSF6OFj6lEZoJUA==
X-CSE-MsgGUID: G4z/cnEBRcajvtrmyPX8xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="209190527"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jan 2026 03:42:43 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 20/36] eal: add macro for marking assumed alignment
Date: Fri, 30 Jan 2026 11:41:47 +0000
Message-ID: <20260130114207.1126032-21-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130114207.1126032-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
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

Provide a common DPDK macro for the gcc/clang builtin
__rte_assume_aligned to mark pointers as pointing to something with
known minimum alignment.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/include/rte_common.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 573bf4f2ce..51a2eaf8b4 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -121,6 +121,12 @@ extern "C" {
 #define __rte_aligned(a) __attribute__((__aligned__(a)))
 #endif
 
+#ifdef RTE_TOOLCHAIN_MSVC
+#define __rte_assume_aligned(ptr, align) (ptr)
+#else
+#define __rte_assume_aligned __builtin_assume_aligned
+#endif
+
 #ifdef RTE_ARCH_STRICT_ALIGN
 typedef uint64_t unaligned_uint64_t __rte_aligned(1);
 typedef uint32_t unaligned_uint32_t __rte_aligned(1);
-- 
2.51.0

