Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E33CCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:02:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E57EB4064F;
	Fri, 16 Oct 2026 16:02:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id D92C1400D7
 for <dev@dpdk.org>; Fri, 16 Oct 2026 16:02:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792159347; x=1823695347;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ozVBchH1490vhNmk63QtD1NtMnYQT6GgLb4h5PT6DU8=;
 b=Uch67BGmf7/RLjrGxSa09nM3ABrjR6AqcXSKpVeJwa0GH2HunmDT/Q++
 D+9ghsATxRrlIWvYEx/N9VJIa6p3hvFOJR0pTN6Vf2JjfutNIJoOEcOcy
 cYo8fBe/jLZoA1SsBvEM/riDzI7w73euZ01Am2lvaTsMMasTzKGce04VP
 lL/2/Vr6fNK3sJCyebsCzDHYFrS7j188Ij/K5SsGUZPv6kQtK/5USvziN
 8eHYrs+uhOW/KSLWrmZ9uMjihy5utS28d2RZckcRhG79qUxoc65or0zBl
 DvVeB3wbHkPMvkyDx6L0zgd6Bl4jn73gQJd8lIfAKJ3qAaVpA/GOVl50j Q==;
X-CSE-ConnectionGUID: ee4Nz/cCQw60bMlblPiOtA==
X-CSE-MsgGUID: 32ngR4U7REyjHua5n9p+IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="1043667"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1043667"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 07:02:23 -0700
X-CSE-ConnectionGUID: jKtRKh9wQwue33LbKTSenw==
X-CSE-MsgGUID: fjoz/bokQdqgMBpHtXeIgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1951665"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 16 Oct 2026 07:02:22 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [27.03 RFC PATCH v1 3/8] dev: replace raw refcount with usage count
Date: Fri, 16 Oct 2026 15:02:10 +0100
Message-ID: <aecfa282d677ce3f22c028b2201a32e456f694b8.1792159157.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792159157.git.anatoly.burakov@intel.com>
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

Use EAL usage counter to track number of dev monitors.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/linux/eal_dev.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c
index 35223b6b26..1b33309baf 100644
--- a/lib/eal/linux/eal_dev.c
+++ b/lib/eal/linux/eal_dev.c
@@ -17,13 +17,14 @@
 #include <bus_driver.h>
 #include <rte_spinlock.h>
 #include <rte_errno.h>
+#include <rte_usage_count.h>
 
 #include <eal_export.h>
 #include "eal_private.h"
 
 static struct rte_intr_handle *intr_handle;
 static rte_rwlock_t monitor_lock = RTE_RWLOCK_INITIALIZER;
-static uint32_t monitor_refcount;
+static rte_usage_count_t monitor_refcount;
 static bool hotplug_handle;
 
 #define EAL_UEV_MSG_LEN 4096
@@ -342,10 +343,8 @@ rte_dev_event_monitor_start(void)
 
 	rte_rwlock_write_lock(&monitor_lock);
 
-	if (monitor_refcount) {
-		monitor_refcount++;
+	if (!rte_usage_count_claim(&monitor_refcount))
 		goto exit;
-	}
 
 	intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
 	if (intr_handle == NULL) {
@@ -370,12 +369,11 @@ rte_dev_event_monitor_start(void)
 		goto exit;
 	}
 
-	monitor_refcount++;
-
 exit:
 	if (ret) {
 		rte_intr_instance_free(intr_handle);
 		intr_handle = NULL;
+		rte_usage_count_release(&monitor_refcount);
 	}
 	rte_rwlock_write_unlock(&monitor_lock);
 	return ret;
@@ -389,14 +387,13 @@ rte_dev_event_monitor_stop(void)
 
 	rte_rwlock_write_lock(&monitor_lock);
 
-	if (!monitor_refcount) {
+	if (monitor_refcount == 0) {
 		EAL_LOG(ERR, "device event monitor already stopped");
 		goto exit;
 	}
 
-	if (monitor_refcount > 1) {
-		monitor_refcount--;
-		goto exit;
+	if (!rte_usage_count_is_last(&monitor_refcount)) {
+		goto release;
 	}
 
 	ret = rte_intr_callback_unregister(intr_handle, dev_uev_handler,
@@ -411,7 +408,8 @@ rte_dev_event_monitor_stop(void)
 	intr_handle = NULL;
 	ret = 0;
 
-	monitor_refcount--;
+release:
+	rte_usage_count_release(&monitor_refcount);
 
 exit:
 	rte_rwlock_write_unlock(&monitor_lock);
-- 
2.52.0

