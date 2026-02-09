Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B8BE7E0BC
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:48:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C4F740E13;
	Mon,  9 Feb 2026 17:46:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id E099040B9B
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:46:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770655565; x=1802191565;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8WvFBFwmSuXZM2fGcP/qqNMRxQ6Un9dLsGYThlromUg=;
 b=b35At2BvERm1wja6VNoIyJNAM5jkwmYM5EllSm47fTkQiwKYdpDmkBIJ
 +K2vCOjkhKKE3SYiurh/gxTxoCy+EmInVn3rdFQVHo2iQLRTJEfgssWT4
 factYWBqDyNi5OSP5hjtLIf+yHH7YQ12E9rqWgRPEBBW7ZxmNZ9+YOvJu
 XdXl6IknYRnv9TOZgs8G4oImgf3NLEG8HqnOS5CKg+vzGOFp7X9p3TgRZ
 O+rX7vvzcqFOtIYo4ELEL2HHafs/geqnVqckt9fjK1NW+SeX6pdeI/nrF
 NKxJhQlH7Axl3XutQ9RdcoT2+xaUXWWqi0PDcUCC96LINdIKKSH5lrOLb g==;
X-CSE-ConnectionGUID: 2+OAh9JnQ7aepWBdhuY3PA==
X-CSE-MsgGUID: unrzJf/ESL+UWv6sxGFiYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71663467"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71663467"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:46:04 -0800
X-CSE-ConnectionGUID: IERLX/nnQriQNqEqu6683A==
X-CSE-MsgGUID: pcPUec1UR6S2Ki3QWBGdDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210789161"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 08:46:04 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 19/35] eal: add macro for marking assumed alignment
Date: Mon,  9 Feb 2026 16:45:17 +0000
Message-ID: <20260209164538.1428499-20-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209164538.1428499-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
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

