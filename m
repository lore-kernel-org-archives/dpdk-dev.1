Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB025109025C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 17:14:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D436402B9;
	Thu, 19 Mar 2026 18:13:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id DB89D402B9;
 Thu, 19 Mar 2026 18:13:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773940437; x=1805476437;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FYs5yxEpS+AAlfxB6VS0SFDSaJnO9rF1Yh0Sb+oHhEY=;
 b=Bt3aeAMGZjYY8ZcoVasMTtj4Fo6BhLLs5LNLethPxHqID89mW4X72ltM
 RmIfX4Pbyf1U0NWIE87pmq9hAQpYhp7FEZQtRpU1AAiI/wW0+oLpJYPWb
 WJpymw0TdM/aKbNNIlfOvbdkPfKDgmhpIKbSEIlKCI6hDd/UFM/o8z9se
 BhvOHzYrlUz+iL49viQJV9vMEjeDiwTcvQoT4EPmosPbBnrBA3kr9Hlyu
 p4vIywVbuLlR6R8FVze9HWVfZIAtboZkduQ/L5MYvusgLwJAx85amZCSW
 PzDC3PUYX6X9tbn2w+e7H3j92anxzRw6s/gWxKkEqp+Mlv4hBTsr68KwF A==;
X-CSE-ConnectionGUID: 01vLMnb1R52lixawD7CvaQ==
X-CSE-MsgGUID: vqWBG+bSQlSlwCP6iCGSJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85648037"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="85648037"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 10:13:43 -0700
X-CSE-ConnectionGUID: kn7/Qa3oQ/6k049JEj8Rgw==
X-CSE-MsgGUID: uI0lMTnzT9eLTc2XiYrBzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="227979629"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 19 Mar 2026 10:13:43 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: lylavoie@iol.unh.edu, probb@iol.unh.edu, david.marchand@redhat.com,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH 3/7] test/pdump: skip test on FreeBSD
Date: Thu, 19 Mar 2026 17:11:37 +0000
Message-ID: <20260319171334.1151425-4-bruce.richardson@intel.com>
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

FreeBSD doesn't support multiprocess so skip the pdump unit test which
requires multi-process support.

Bugzilla ID: 761 (partial fix)
Fixes: 086eb64db39e ("test/pdump: add unit test for pdump library")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_pdump.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/app/test/test_pdump.c b/app/test/test_pdump.c
index 824caef2d4..9d1175b4b0 100644
--- a/app/test/test_pdump.c
+++ b/app/test/test_pdump.c
@@ -5,6 +5,7 @@
 #include <unistd.h>
 #include <stdint.h>
 #include <limits.h>
+#include <sys/utsname.h>
 
 #include <ethdev_driver.h>
 #include <rte_pdump.h>
@@ -197,7 +198,12 @@ run_pdump_server_tests(void)
 int
 test_pdump(void)
 {
+	struct utsname name;
 	int ret = 0;
+
+	if (uname(&name) < 0 || strcmp(name.sysname, "FreeBSD") == 0)
+		return TEST_SKIPPED;
+
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		printf("IN PRIMARY PROCESS\n");
 		ret = run_pdump_server_tests();
-- 
2.51.0

