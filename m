Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF91C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 13:29:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 066314068A;
	Mon, 30 Jun 2025 15:29:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 778A540677
 for <dev@dpdk.org>; Mon, 30 Jun 2025 15:29:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751290163; x=1782826163;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+BfYkxQxFx6wtFIurFwyC8cYnw1SlA2lujnnFKSu+ig=;
 b=fH2wGEwipetVZqe1upbg3Jg9HJV5KJX0peIBqlwYRIEOgpWM+GTYDUb2
 jRluho0TThuZ5C8DWP/V60wH3sckgELdsG8/g98UhN1KWft+Qk8Uy6XWo
 leUw1fmAuIXViUJxNFlh78Up+QPBA5H9tcw0S7uJisbmLZmRmxkM6Qruf
 L2a04xbIjTxQQRyakQT4UsuCAJ34gXaTetR9B6JA3BEKl1W8QEtsCmmT+
 KaGRt0vuCyOvwRu7NjZm4dVn/QUK1CXh74oT7EGBGqvdpreV0pZexI+CM
 EBjtfALUnhJeg6AKsNryihhJXimfHAGlGCUSDnlYwOgR8WqUKiqR2b2XW w==;
X-CSE-ConnectionGUID: Eey4xVtFQTK3JrCVC4IGZg==
X-CSE-MsgGUID: TpFYUohERzKIRwGQFdRsmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64113120"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="64113120"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 06:29:23 -0700
X-CSE-ConnectionGUID: Fch7YNDYRMGtDl6wcZX6yg==
X-CSE-MsgGUID: TjLkl2YNT2eAw7BvOtjFMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="153764384"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by fmviesa009.fm.intel.com with ESMTP; 30 Jun 2025 06:29:22 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Jakub Grajciar <jgrajcia@cisco.com>
Subject: [PATCH 25.11 3/3] memif: : remove fallbacks for old Linux versions
Date: Mon, 30 Jun 2025 13:29:04 +0000
Message-ID: <20250630132904.1704901-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250630132904.1704901-1-bruce.richardson@intel.com>
References: <20250630132904.1704901-1-bruce.richardson@intel.com>
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

All supported linux versions support F_ADD_SEALS (Linux 3.17+) and
MFD_HUGETLB (Linux 4.14+), so no need to have #ifdefs and fallbacks to
support systems which do not support those features.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/memif/rte_eth_memif.h | 41 -------------------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.h b/drivers/net/memif/rte_eth_memif.h
index 8e45a3ab78..d4e625ab51 100644
--- a/drivers/net/memif/rte_eth_memif.h
+++ b/drivers/net/memif/rte_eth_memif.h
@@ -169,37 +169,6 @@ int memif_init_regions_and_queues(struct rte_eth_dev *dev);
  */
 const char *memif_version(void);
 
-#ifndef MFD_HUGETLB
-#ifndef __NR_memfd_create
-
-#if defined __x86_64__
-#define __NR_memfd_create 319
-#elif defined __x86_32__
-#define __NR_memfd_create 1073742143
-#elif defined __arm__
-#define __NR_memfd_create 385
-#elif defined __aarch64__
-#define __NR_memfd_create 279
-#elif defined __powerpc__
-#define __NR_memfd_create 360
-#elif defined __i386__
-#define __NR_memfd_create 356
-#elif defined __riscv
-#define __NR_memfd_create 279
-#elif defined __loongarch__
-#define __NR_memfd_create 279
-#else
-#error "__NR_memfd_create unknown for this architecture"
-#endif
-
-#endif				/* __NR_memfd_create */
-
-static inline int memfd_create(const char *name, unsigned int flags)
-{
-	return syscall(__NR_memfd_create, name, flags);
-}
-#endif				/* MFD_HUGETLB */
-
 #ifndef F_LINUX_SPECIFIC_BASE
 #define F_LINUX_SPECIFIC_BASE 1024
 #endif
@@ -208,14 +177,4 @@ static inline int memfd_create(const char *name, unsigned int flags)
 #define MFD_ALLOW_SEALING       0x0002U
 #endif
 
-#ifndef F_ADD_SEALS
-#define F_ADD_SEALS (F_LINUX_SPECIFIC_BASE + 9)
-#define F_GET_SEALS (F_LINUX_SPECIFIC_BASE + 10)
-
-#define F_SEAL_SEAL     0x0001	/* prevent further seals from being set */
-#define F_SEAL_SHRINK   0x0002	/* prevent file from shrinking */
-#define F_SEAL_GROW     0x0004	/* prevent file from growing */
-#define F_SEAL_WRITE    0x0008	/* prevent writes */
-#endif
-
 #endif				/* RTE_ETH_MEMIF_H */
-- 
2.48.1

