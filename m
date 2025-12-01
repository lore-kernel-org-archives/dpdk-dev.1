Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27511D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:48:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE93040E20;
	Mon,  1 Dec 2025 12:45:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id B718740DDC
 for <dev@dpdk.org>; Mon,  1 Dec 2025 12:45:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589532; x=1796125532;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IahgOJz7gfEVmDhoJEn1VjsMWHwF/krOA3JZZYLbcFc=;
 b=fnccKVXceq2fTIcIWLZyrLDM7FYXd3Cbu3/vcSEKXgCwAgrKrBdQWGQk
 Pj22HmtFJ7128GJZ4IMkGxrbWH0yN+JobUGrAp3HWnU/uChsaWCszomj8
 vd20SZnINUp+LaXZyQW6+NXc8vr+wQVivRvvRJlN3LzWPu+iy9DKVvXnb
 YHpPxT1in9n3jf9vytLmwhn3oOZZ+tGNoF3e7wU50GwTzI0pbxb+P/Uxv
 kMGNMua8Kj9tPg8gpJsbtLbiw1IHWGswbWPxxotkjpwGNE1/4YKEod37b
 7C/OSQRg/QBKlnsV0CvJzMlFYwHRy4+/azEcpyWekm6nbqvP+ei52R65f A==;
X-CSE-ConnectionGUID: zP5cHdLDR9i1BY+Ti1R6Vw==
X-CSE-MsgGUID: tJVp5kbKT9mPHW/dpAzpdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991772"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991772"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:31 -0800
X-CSE-ConnectionGUID: RCumfv6xSQG15qO7XUYAoQ==
X-CSE-MsgGUID: 5LWh2/iDQMK1PxNDH3GUew==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:31 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 27/31] app/test-pipeline: remove unnecessary variable
Date: Mon,  1 Dec 2025 11:44:44 +0000
Message-ID: <20251201114448.1441377-28-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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

The second definition of a variable called "ret" in the main function is
unnecessary and causes variable shadowing warnings, so just eliminate
it.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pipeline/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/app/test-pipeline/main.c b/app/test-pipeline/main.c
index 4cc098d7ac..e5efafdf28 100644
--- a/app/test-pipeline/main.c
+++ b/app/test-pipeline/main.c
@@ -89,7 +89,6 @@ main(int argc, char **argv)
 	/* Close ports */
 	for (i = 0; i < app.n_ports; i++) {
 		uint16_t port;
-		int ret;
 
 		port = app.ports[i];
 		printf("Closing port %d...", port);
-- 
2.51.0

