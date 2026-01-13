Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9FAD2F32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:18:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 141EA40A81;
	Tue, 13 Jan 2026 16:15:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6A6AF40672
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317340; x=1799853340;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yCeKcb7Rv2Mw5Pw0L7NRxoNjii2yXBO2wRMUSoUa5Jo=;
 b=IRzOD4PeXjEYBQDCxK0XDPJZ8uWtdokzdQy9EID6H4L4qtRBfdNZYmfQ
 mkpqPOtl3+oiXOIMQzXNGoaW2UPeerNM3Zi081wzj1qTPZx31Ob7fqJFF
 /wBjoRpl0O1s3YZFQjTKeuSvFVf0rgtAf/BQKKKLfiNmuGgEZD0gsoArn
 Z+hPRPVJMpWSLjNy/TfJDAttfVaVFnqYEhiLhI/LFs40gRrdte5S6PoSw
 a8K/Xq+MkF/Hfdxpv4cyVnptCT7b9dz6bM7PXsi/Z7WPOB5F6GE6I2n0S
 6X0AJKvwhya6l2aPoAuGh2mVIBMcd7hpMzKA3txlYzGgYjX12mJa2TX9+ g==;
X-CSE-ConnectionGUID: pnyuJZoOQySqOnU5PAP8Gg==
X-CSE-MsgGUID: dsXtRAdGRWWT1v5KVVmZ2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969206"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969206"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:39 -0800
X-CSE-ConnectionGUID: k76l1OFURTW/KxqCJbiM3w==
X-CSE-MsgGUID: db17jfvdTwqz4J1c1DyQLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556628"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:38 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 20/36] eal: add macro for marking assumed alignment
Date: Tue, 13 Jan 2026 15:14:44 +0000
Message-ID: <20260113151505.1871271-21-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113151505.1871271-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260113151505.1871271-1-bruce.richardson@intel.com>
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
index 9e7d84f929..11d6f2bee1 100644
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

