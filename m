Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA515C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 08:05:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BAA940150;
	Thu, 20 Aug 2026 10:05:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 80295400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 10:05:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787213154; x=1818749154;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=n1KuAToEVqteFvKcykPLLl29AD/p1KeaWMcnWhaWLO4=;
 b=PaotVuSuJrL7C+m3+d478FQAffauzmUFsfcNaifPYfcUQY9POsHJEiFa
 XTYFX3QxLQTJgmYQ4hWa3/dV9B3VHVMPqkVPds/AmHngQgQXI88AyiGry
 m9qjV1NK5EOYbsyw1p5qgNOulzI5+FE9gLKQ9gQGQOHZWg2tUQne0YNca
 1r2Ru7qcoRu8Lw8pXcsry+BtJfi69PxfYQ35Lenv4U5wNsIXMUuxd+eaa
 CRDhaeiGYXIHnb/l2H3yNU16ty171GIxaazGDyk9L0F0mHONI4lSenwqv
 hgdTp6IKmAP04riMG4dKipMAi9t8++/r/0CBa+alM+5yhf4zZtRTFSRVG Q==;
X-CSE-ConnectionGUID: IXNhaV/ARNiPz/Pr9cvo3A==
X-CSE-MsgGUID: 6M31rrTVRkCDOOlyoIuiDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="86858383"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="86858383"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 01:05:49 -0700
X-CSE-ConnectionGUID: wlqmPQtfSpKFbXps4Q+JGA==
X-CSE-MsgGUID: KGeGleDoQmiaRXP5W9kTKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="259746772"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa009.fm.intel.com with ESMTP; 20 Aug 2026 01:05:48 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH] net/cpfl: remove unused macro definition
Date: Thu, 20 Aug 2026 09:05:42 +0100
Message-ID: <20260820080542.3414447-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

The CC_AVX512_SUPPORT macro was never used in the cpfl source code
files, so there is need to define it in the meson.build file.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/cpfl/meson.build | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/intel/cpfl/meson.build b/drivers/net/intel/cpfl/meson.build
index 1f0269d50b..0da84f3538 100644
--- a/drivers/net/intel/cpfl/meson.build
+++ b/drivers/net/intel/cpfl/meson.build
@@ -22,10 +22,6 @@ sources = files(
         'cpfl_rules.c',
 )
 
-if arch_subdir == 'x86' and cc_has_avx512
-    cflags += ['-DCC_AVX512_SUPPORT']
-endif
-
 if dpdk_conf.has('RTE_HAS_JANSSON')
     sources += files(
             'cpfl_flow.c',
-- 
2.53.0

