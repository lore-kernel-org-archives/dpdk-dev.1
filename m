Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBEC109025C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 17:14:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF2E440666;
	Thu, 19 Mar 2026 18:14:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id BE5BA40608;
 Thu, 19 Mar 2026 18:13:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773940438; x=1805476438;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=if6ELpwTNUzAsFyC3aWkqRtj667K+gZxGejiyzBo5fQ=;
 b=bijz1pTlve5AopmGOj8nkr3xeeynzqu5zgtwfzB0/7igxIckmvzSFcxv
 /Cz8IHstyG6Ohu2SrOikRzSnUyCE0SXdcbAFxRAFKTJHnlWwCsoduVJHN
 4hB8ZshCdsJfp7/2VstXgce3HyYI3bZ6H5DwRI6RETTBrwRnExLHm8ZhH
 8f2mWoVYd9dgSBcaI37kdrpW6phT8KPkvkpgugKkcUSoHvxJ30cYQ/FHs
 DRp0WfsJtJz+jbze6oJEKWZ40P+sffk4m4Uy7R7Uu60WLyojOTh1IoLYv
 JRkKCm7srnF9TrF75jU0Cu3yqKtzllTl4SB1+rSr+xfEI693KL9ObCF+8 w==;
X-CSE-ConnectionGUID: X5uP6I3tQuKK2TC1uSDG9Q==
X-CSE-MsgGUID: 4JX48bqNSeOgwfglR9kBug==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85648046"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="85648046"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 10:13:46 -0700
X-CSE-ConnectionGUID: AeZzERujQ066VSU/O5r1dA==
X-CSE-MsgGUID: uNbWjpowRQ2s+w6oEbiqeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="227979636"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 19 Mar 2026 10:13:46 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: lylavoie@iol.unh.edu, probb@iol.unh.edu, david.marchand@redhat.com,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH 5/7] test/external_memory: skip test on FreeBSD
Date: Thu, 19 Mar 2026 17:11:39 +0000
Message-ID: <20260319171334.1151425-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319171334.1151425-1-bruce.richardson@intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
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

FreeBSD doesn't support external memory, so skip the test.

Bugzilla ID: 761 (partial fix)
Fixes: b270daa43b3d ("test: support external memory")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_external_mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test/test_external_mem.c b/app/test/test_external_mem.c
index 1c977b749b..53300983ed 100644
--- a/app/test/test_external_mem.c
+++ b/app/test/test_external_mem.c
@@ -10,11 +10,11 @@
 #include <string.h>
 #include <fcntl.h>
 
-#ifdef RTE_EXEC_ENV_WINDOWS
+#ifndef RTE_EXEC_ENV_LINUX
 static int
 test_external_mem(void)
 {
-	printf("external_mem not supported on Windows, skipping test\n");
+	printf("external_mem only supported on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 
-- 
2.51.0

