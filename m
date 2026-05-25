Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C75CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 17:13:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61F524042F;
	Mon, 25 May 2026 19:13:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id B4ED9402D0;
 Mon, 25 May 2026 19:13:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779729229; x=1811265229;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fnvj+4HpAlpvww1ARlwujef18xNm16dNYQcTSfBUjXM=;
 b=VKjhurW40rD0xyWH3FWSso8FY1szQz6qEH/mCZ8oLHtNZ4u9ekyNzt8M
 ww4CNby1laDMM57vgG0j0CdEn7FaBRP8S3vo1GRYoHXNzn8lm+GZttgc6
 rlWX41AWjrwG8mE5ui53IsAw3BC9e3xXYvxgiQ+UF0DsNprC3uUosggLv
 X7nxqWdxv3SQrNEcU6810T2w8XJ68saACiPcC05fdA+SDnd3kXd4WWNxu
 8RvazjVfwfn1oPDfyghgy11cGMPn/e2Pd/x0r1V5gwRO5uQ/WObPUH+Z+
 WpuW2f3zgYIcZuiyZNzr+IJn2Rb4hBMFaaCObXoM5KZMwoYRuskburXCf Q==;
X-CSE-ConnectionGUID: BpOyS/hqSP+MSYnwakRRfw==
X-CSE-MsgGUID: vIXgNpLeSCi1egb4lPS+fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80607457"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; d="scan'208";a="80607457"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 10:13:48 -0700
X-CSE-ConnectionGUID: CJV3cDPmQrOx91D06WzoNw==
X-CSE-MsgGUID: FzdeaFt4QKqMowfErkoIhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; d="scan'208";a="241506550"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 25 May 2026 10:13:48 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH 1/2] eal/freebsd: fix memseg addresses in EAL VA mode
Date: Mon, 25 May 2026 18:13:39 +0100
Message-ID: <20260525171340.1701509-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525171340.1701509-1-bruce.richardson@intel.com>
References: <20260525171340.1701509-1-bruce.richardson@intel.com>
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

In BSD, when mapping the contigmem segments, the iova is unconditionally
set to the physical address, irrespective of the actual IOVA mode.
Change this to use virtual addresses when iova mode is IOVA_AS_VA.

Fixes: 764bf26873b9 ("add FreeBSD support")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/freebsd/eal_memory.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index cd608db9f9..e56d149a22 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -214,7 +214,10 @@ rte_eal_hugepage_init(void)
 			}
 
 			seg->addr = addr;
-			seg->iova = physaddr;
+			if (rte_eal_iova_mode() == RTE_IOVA_VA)
+				seg->iova = (uintptr_t)addr;
+			else
+				seg->iova = physaddr;
 			seg->hugepage_sz = page_sz;
 			seg->len = page_sz;
 			seg->nchannel = mcfg->nchannel;
-- 
2.53.0

