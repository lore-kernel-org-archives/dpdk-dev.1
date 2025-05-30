Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7840BC5B543
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 13:58:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91515409FA;
	Fri, 30 May 2025 15:57:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id B0BA740674
 for <dev@dpdk.org>; Fri, 30 May 2025 15:57:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748613474; x=1780149474;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5F4d9cMnWHlOyRKS4X0pWXDgbU1nROXEsw/PAuI3dGk=;
 b=ccs+OCYY9cmI+BiJWE8VwUpOlouxLnYVtRhUyc8D1gyldsiEt+3NAZ3z
 spufsdNpXW/iPQC+deeaTigpWl795605pgdVM97q9kTT+mtC5EVLjB03Y
 SivnY1uEN3ARVY4c9obA+8z2AWPdyxLmvfrSclRk17rdrDaUGBAH+zbp0
 CAMYJVx9piZmH/Ue1ztTvvvZRt+UjXb0P7itsub5wGz79D6w7kuzb6wQb
 YAQukFe236wQvCqw6+8np4wVkTfRPUaeBfb5IQx6z+bNc8yNdnPeLuDDM
 NOvoCvkAf7dWKgxsRBwVTsghys7LAc9Q79BdGQa1CJ9JmLCZlwdgERVDb A==;
X-CSE-ConnectionGUID: mwxyQlpWSsyAIeVa9OH1dw==
X-CSE-MsgGUID: Y9qIzFyEQYCr0ztEkyJSkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50809378"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="50809378"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 06:57:53 -0700
X-CSE-ConnectionGUID: qYXRmB6tQWKdLUmYZNOolg==
X-CSE-MsgGUID: k0PC5QbfQsGkkNKhk3JLNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="174887448"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa002.jf.intel.com with ESMTP; 30 May 2025 06:57:52 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v4 10/25] net/ixgbe: replace always-true check
Date: Fri, 30 May 2025 14:57:06 +0100
Message-ID: <68fd21f49d489deb96300f3fd488f8162eaf79b3.1748612803.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
References: 
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

There is an option `RTE_PMD_PACKET_PREFETCH` in `rte_config.h` that is
always set to 1 by default, and that controls some prefetch behavior in the
driver. However, there's another prefetch behavior that is controlled by
`RTE_PMD_USE_PREFETCH`, which is always defined unconditionally (literally
using `#if 1` construct).

Replace the check to also use `RTE_PMD_PACKET_PREFETCH` to allow turning it
off at build time.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v3 -> v4:
    - Add this commit

 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index f5fd50584a..3b49ef9fbb 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -74,11 +74,7 @@
 #define IXGBE_TX_OFFLOAD_NOTSUP_MASK \
 		(RTE_MBUF_F_TX_OFFLOAD_MASK ^ IXGBE_TX_OFFLOAD_MASK)
 
-#if 1
-#define RTE_PMD_USE_PREFETCH
-#endif
-
-#ifdef RTE_PMD_USE_PREFETCH
+#ifdef RTE_PMD_PACKET_PREFETCH
 /*
  * Prefetch a cache line into all cache levels.
  */
-- 
2.47.1

