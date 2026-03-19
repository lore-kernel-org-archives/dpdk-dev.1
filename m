Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A41109025C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 17:14:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87A124066C;
	Thu, 19 Mar 2026 18:14:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id EF7C7402C5;
 Thu, 19 Mar 2026 18:13:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773940438; x=1805476438;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0dWZYww4QMxcTL6+xpkQE8dS8+4MupkBDlaiCO8Hsq4=;
 b=O/suUK9foS7SdwUzAur1WcAe0NsakgeM2CqrYfkUlngTbn5X2nC0tqKu
 HKOBiF/UpZjh52gGmTLBWgrCy49HNzXmujMdw8a0OjdgWqBXnshc66stE
 7EXwPq1P8uiqe9QkuePrQSG5b0138UqQdXwIAL2ece0hhcCe8DWufdyJf
 11aBJ203Rh8/AFFOyUgDG+f7hp9DadR+KbyaOHAbxpipx6JWo4PGa557Q
 bsJHZwu64bM7bazZa8WjCnGzm2hmlpAeI4qjmkRdBvdpjHMect1QxJl5k
 u1oRTkr+kWpaz7uIM1Xu6wwAGLPIiljGE7yaUXvoPHqSMXkuB0jB33+LF w==;
X-CSE-ConnectionGUID: UvlqkWMSTceubfWdrLpeYg==
X-CSE-MsgGUID: WFv1zOrpSg2LwWAfRiKLZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85648055"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="85648055"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 10:13:48 -0700
X-CSE-ConnectionGUID: NwAhqDmMTp6yPdyFZyyM/g==
X-CSE-MsgGUID: CEmV/1mdSaa+MtiPn1oz8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="227979639"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 19 Mar 2026 10:13:47 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: lylavoie@iol.unh.edu, probb@iol.unh.edu, david.marchand@redhat.com,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH 6/7] test/interrupts: skip test on FreeBSD
Date: Thu, 19 Mar 2026 17:11:40 +0000
Message-ID: <20260319171334.1151425-7-bruce.richardson@intel.com>
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

FreeBSD does not have interrupt support for DPDK, so skip the test
associated with that functionality.

Bugzilla ID: 761 (partial fix)
Fixes: 764bf26873b9 ("add FreeBSD support")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_interrupts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_interrupts.c b/app/test/test_interrupts.c
index 2eb876e65a..3a5be92cd7 100644
--- a/app/test/test_interrupts.c
+++ b/app/test/test_interrupts.c
@@ -429,7 +429,7 @@ test_interrupt(void)
 	int ret = -1;
 	struct rte_intr_handle *test_intr_handle;
 
-	if (RTE_EXEC_ENV_IS_WINDOWS)
+	if (RTE_EXEC_ENV_IS_WINDOWS || RTE_EXEC_ENV_IS_FREEBSD)
 		return TEST_SKIPPED;
 
 	if (test_interrupt_init() < 0) {
-- 
2.51.0

