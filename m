Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDA9CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:41:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 801E24064A;
	Thu, 15 Oct 2026 13:41:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7945E4064E
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:41:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792064461; x=1823600461;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NAloR/LzDbE/s9OrCShYcgUswAmYNbAngsO42IzbicQ=;
 b=YLBdyXOF6ekzuICoUkWfSuE83U2kspr8mpkSC7G9zUaBtjlSi80XMA9Z
 NXmz6wBq7NoZ7oBfwj5J74M5uCzJI45ST+ddJLkkE5TeQg+PsasV9BzFc
 TYQ5s3i/irK5papbegV2x/r3cyVsq+140B7XuMhYravcHW/Ljcr6Mr9hs
 V0Bf5oci8SkqvRq+DE3OHtKsFVQZ/Ab9BvIic/ogx1LdEZJQNuCv7J74a
 EkhB+KUYXahMOPcxj7Ard5HL+N20tndmspJ2L9QS0/9MrKbUz8A4RM2bz
 AqkmlGlvsoWsGgwAkwjH3DgnHLRfwBonZBgcWXW+NxfAlXChQfNXemU4l A==;
X-CSE-ConnectionGUID: mb6+cm0tRbydkXcWbBHPew==
X-CSE-MsgGUID: M5YmGiomSpeN8uc+tdfCIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="712177"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="712177"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 04:41:00 -0700
X-CSE-ConnectionGUID: HL2agZAGTL627qNdGmyaGw==
X-CSE-MsgGUID: giyhVp+FSt+aruwx/7z2pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="3428683"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 15 Oct 2026 04:41:00 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v1 1/2] net/iavf: do not include private headers in testpmd
Date: Thu, 15 Oct 2026 12:40:54 +0100
Message-ID: <816779271abc165ec8404edcfc243ef0e9f5fd65.1792064447.git.anatoly.burakov@intel.com>
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

