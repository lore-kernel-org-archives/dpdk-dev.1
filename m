Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B818BCC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:21:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 179B24064C;
	Thu, 15 Oct 2026 16:21:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6C22A400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:21:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792074071; x=1823610071;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=NAloR/LzDbE/s9OrCShYcgUswAmYNbAngsO42IzbicQ=;
 b=KqRI6JI0lmuGih7Po4gyVUaf5jxYU4aYNeahSkVa2m8vPInyQWDxI+uz
 h9XUQojnUYthQ67GXTAb68E2D1qfdeXAxdhB5oCbSwIG6u3EOQruWaLUa
 P09Mmy0HRwEyW4FPhZ5hzQ3vqFWMQn1ueYsI4BFKVyO1FdtNp8LT51Uru
 MdBaXnXfDdKTrvSxdeCvSDuINiDPW0ZlZHxwLEktKxa+BLcMaexqptj2c
 Mn7k0CETOhnS1L7LT80QbcmAj1/NTnCQLiIC5LhHDXsJCcIHFULJICec+
 w+LzlB6kr9nOZI3J3oAGLVXIjFgvWX9YaqWbVQWMzaJCZcEbMXO5UzY67 w==;
X-CSE-ConnectionGUID: byepW4JZTsa/+LaisSJ9lg==
X-CSE-MsgGUID: kGA3o++tSmi/awWuV0hCJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="845359"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="845359"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:21:10 -0700
X-CSE-ConnectionGUID: dlI5xkrXTJq+In05S/X9NA==
X-CSE-MsgGUID: Ktv0edrNTCeDTjTgI2BnEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1779222"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 15 Oct 2026 07:21:09 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 2/3] net/iavf: do not include private headers in testpmd
Date: Thu, 15 Oct 2026 15:21:03 +0100
Message-ID: <1e05a203951906eb042fcf1010d2b120c85bb4d2.1792074055.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <35d9aed797cb433296b1c0d53fbda4b45c38e833.1792074055.git.anatoly.burakov@intel.com>
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

Currently, the `iavf_testpmd.c` file includes headers that are only
available to driver itself, but should not be available to applications,
including testpmd.

Fix the testpmd file to not include private headers (they are unused).

Fixes: c702044ed909 ("net/iavf: remove Tx LLDP dynfield method")
Cc: ciara.loftus@intel.com

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_testpmd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_testpmd.c b/drivers/net/intel/iavf/iavf_testpmd.c
index f3b932da04..1146f534e3 100644
--- a/drivers/net/intel/iavf/iavf_testpmd.c
+++ b/drivers/net/intel/iavf/iavf_testpmd.c
@@ -9,9 +9,7 @@
 #include <cmdline_parse_num.h>
 #include <cmdline_parse_string.h>
 
-#include "iavf.h"
 #include "testpmd.h"
-#include "iavf_rxtx.h"
 
 struct cmd_reinit_result {
 	cmdline_fixed_string_t port;
-- 
2.52.0

