Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5D0C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 13:06:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C954402DA;
	Wed,  9 Jul 2025 15:06:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 11452402A9
 for <dev@dpdk.org>; Wed,  9 Jul 2025 15:06:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752066393; x=1783602393;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MwWwkc+StcpVgK6lfT8yFCrUVm8AwvYEdSxN/FzzIzc=;
 b=Gp2cOzWDAZIR+QpjuKxUTGnC2Jl7XVebj8ljF6+aKIu9xOnd4hZgdETJ
 LRx1e6EwviyxBxm+BfGdm4ByT7vy4gLqgDcN5U0IA3ecayI8qL0/eRPAG
 7sNS8sNxCfPdujovjW4uNjedSHqRWoh5ulD7vKD/d/RVJ2G+TYyShXMBR
 OzydcsBaHblxc2oJmwIo4uAE/bAcA+JWONTpR5Ml9g7V5Q93WegQd2sAq
 D7RUTKAt16jmjDq9gCLHbnlMWwZDKnTN7s9mb/dWPpIfcOo6fbma2IXw+
 kXgJYJWYyI/EngabrvV5xMoAt0FwNzj1sYbSGI0RSD4M0S8oTgKZBj4gy A==;
X-CSE-ConnectionGUID: GBEJRyGQRFeiblSwQimJCw==
X-CSE-MsgGUID: Aw66irzpRN2nXFphjQ6Ykw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="58090762"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="58090762"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 06:06:32 -0700
X-CSE-ConnectionGUID: kZrLM27UTtW1RRxG7Djpmg==
X-CSE-MsgGUID: 1aerrzSWTbWw8qhLocD0JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="179456230"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa002.fm.intel.com with ESMTP; 09 Jul 2025 06:06:31 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 1/1] net/iavf: fix order of inclusion in vector code
Date: Wed,  9 Jul 2025 14:06:29 +0100
Message-ID: <552f8241f4f65fce0c8b43797612a97dec5d9ebc.1752066381.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
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

IAVF driver does not support 16-byte descriptors (because there is no PF
that can support a VF using 16-byte descriptor), but if IAVF is built with
a flag that enables 16-byte descriptors, this flag is then propagated
through the inclusion chain in certain cases, because IAVF includes common
vector code before IAVF-specific common code (which in turn includes
`iavf_rxtx.h` which disables 16-byte descriptor support).

Fix the inclusion order to include IAVF-specific vector header first, which
will fix the compilation error due to correctly disabling 16-byte Rx
descriptor support.

Bugzilla ID: 1749

Fixes: 11276ec5e042 ("net/iavf: use common Rx rearm")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 2 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 73a6ae5c41..9344dcc725 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -2,8 +2,8 @@
  * Copyright(c) 2019 Intel Corporation
  */
 
-#include "../common/rx_vec_x86.h"
 #include "iavf_rxtx_vec_common.h"
+#include "../common/rx_vec_x86.h"
 
 #include <rte_vect.h>
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 9a029ecbe0..b29e3ac0f1 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -2,8 +2,8 @@
  * Copyright(c) 2020 Intel Corporation
  */
 
-#include "../common/rx_vec_x86.h"
 #include "iavf_rxtx_vec_common.h"
+#include "../common/rx_vec_x86.h"
 
 #include <rte_vect.h>
 
-- 
2.47.1

