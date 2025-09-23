Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E87CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 16:58:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77D4540615;
	Tue, 23 Sep 2025 18:58:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1B808402CB;
 Tue, 23 Sep 2025 18:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758646719; x=1790182719;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=k2ztdteinfFU0LkXoT9CATjuI3QSJClwG399uRYG9cM=;
 b=cg+kAItOKN+rkh+t/hf2ZNLUquommODXWFNVMyK7GHDWeO5E4Oohkhq5
 44FD88kZ6mCu7mBg6h561S2VQ311ex4ImctfPRSjicXsfkiJe+Lxnej6P
 EipR7GrXhSkiFYC1fDm0nTg1nTPMdyRKjXuzzYNce+Yu8qG7aDiBipaur
 WaoMxZkQ7pusnmle3uPL8118meMc/XlT4dOx4J057CTqqMK8R2F9Eu60s
 BQSOLy36/F3vpodPBl2nyfYmt7dehUxiRTW94s4KQn2TadR7TMyx4/y55
 3EEl7+JNqgRkkESIvHkgLqO8mJPO57OFT/U+Ilqsb2lnYR9lRKJAkvM1W A==;
X-CSE-ConnectionGUID: 1gC+pLIyTdGba3U0+oHUOw==
X-CSE-MsgGUID: d0SzbIY7SeaP6uipOvmjaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60857132"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="60857132"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 09:58:38 -0700
X-CSE-ConnectionGUID: 3aHdH7YQSamY/4DEss0i8w==
X-CSE-MsgGUID: +eYVMnwMTmevTl+J2NFmLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="181130215"
Received: from silpixa00401385.ir.intel.com (HELO silpixa00401385..)
 ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Sep 2025 09:58:37 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH] examples/l2fwd-cat: check compatibility of dependency lib
Date: Tue, 23 Sep 2025 17:58:30 +0100
Message-ID: <20250923165830.527416-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

The meson find_library() function can sometimes return incompatible
libraries which are unsuitable for linking. For example, after
installing the native x86 pqos library on my system, arm64 builds
started trying (and failing) to build the l2fwd-cat example app. Fix
this incorrect detection in our build files by checking that the found
pqos library can actually be used to link apps.

Fixes: dd25c80b4f48 ("examples/l2fwd-cat: make build dependent on pqos lib")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/l2fwd-cat/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/examples/l2fwd-cat/meson.build b/examples/l2fwd-cat/meson.build
index ebcc3f66f2..be29657ebb 100644
--- a/examples/l2fwd-cat/meson.build
+++ b/examples/l2fwd-cat/meson.build
@@ -7,7 +7,7 @@
 # DPDK instance, use 'make'
 
 pqos = cc.find_library('pqos', required: false)
-build = pqos.found()
+build = (pqos.found() and cc.links('int main(void) { return 0; }', dependencies: pqos))
 if not build
     subdir_done()
 endif
-- 
2.48.1

