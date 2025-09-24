Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BE7CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 15:48:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89E5940A67;
	Wed, 24 Sep 2025 17:48:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id CF92640613
 for <dev@dpdk.org>; Wed, 24 Sep 2025 17:48:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758728908; x=1790264908;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=U8VlxegRu+nFYtoMI+Jyd2iZPHy4+NO1d1FZwFRIBws=;
 b=m8cckx8p92EsfEYnvgOrxODFxEk4Nn3Z4EPQHH2ZYntYvjw6TXAapaB5
 +rGHzrzNhXCynoT1Znty0uMtFZwCAaITmnGz3bshQ+vP/dNbKx2k4PMcV
 eORrSs8fslFy6SJMaoyiZW7S+//2f9sC19/+Jn1aEGRRobkFN0NPFBrUp
 i+ksXCb1BmOisPYaK1SLcZAJX4yZcOXffLGdwFqLFWvH0D1iGUOgky6HS
 yFh0JMVWtMShw30oTr/wd3x/kseaBzT1Qk+QU2FH/kLGktXhZNPF26HIr
 hFJ6CRZ+uhzNDTnn01MlF5JggZUVhOp2exhEPj9vZXFTweHmLIGCRsKqY w==;
X-CSE-ConnectionGUID: 542LqIg8SgaO5iTqKmmjew==
X-CSE-MsgGUID: l556I4jXTxmO6fe8H7aZ6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="78469191"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="78469191"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 08:48:27 -0700
X-CSE-ConnectionGUID: 4RIEEgz9RJ+a9P1mhhdMaQ==
X-CSE-MsgGUID: A0F0SPTGRTCob5zYed8Xwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="177460876"
Received: from silpixa00401385.ir.intel.com (HELO silpixa00401385..)
 ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 24 Sep 2025 08:48:25 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] hash: fix build error due to missing include
Date: Wed, 24 Sep 2025 16:48:21 +0100
Message-ID: <20250924154821.927083-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The file "rte_thash.c" uses the rte_cpu_get_flag_enabled() API but does
not include "rte_cpuflags.h". Add the include to fix build issues this
causes:

../lib/hash/rte_thash.c: In function ‘rte_thash_gfni_supported’:
../lib/hash/rte_thash.c:79:13: error: implicit declaration of function
‘rte_cpu_get_flag_enabled’ [-Wimplicit-function-declaration]
   79 |         if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_GFNI) &&
         |             ^~~~~~~~~~~~~~~~~~~~~~~~

Fixes: d8f0f514428e ("eal/x86: remove useless include from spinlock header")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/hash/rte_thash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
index 0f9ed20d0d..fcd41248b9 100644
--- a/lib/hash/rte_thash.c
+++ b/lib/hash/rte_thash.c
@@ -14,6 +14,7 @@
 #include <rte_eal_memconfig.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
+#include <rte_cpuflags.h>
 
 RTE_LOG_REGISTER_SUFFIX(thash_logtype, thash, INFO);
 #define RTE_LOGTYPE_HASH thash_logtype
-- 
2.48.1

