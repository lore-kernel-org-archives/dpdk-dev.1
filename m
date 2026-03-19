Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3923C109024D
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 16:07:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 510F5402EF;
	Thu, 19 Mar 2026 17:07:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id BE95C4013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 17:07:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773936443; x=1805472443;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lwUJTM4vVY32rvXwtxBfLPGU7TDS/opuQn6BNY2MyZA=;
 b=Q+MXjSLhP1Z6g+bZ72BdgQQHRz3z7fNMevoo2o8o7PYth5c1RHvTbHKF
 ASJpqL3o9uGR/Y44i06jH51dAvBV3w7ij92e6SLLSr+bxCLTHsFOHxl4u
 UGtPTSyUetTdQemReAyzDW983bChMrleL0RG2/jsdhejvHS5xNlyWQi0A
 fquCFglbiL4F8Kfk/k5+Uvx6Vvh5M3xbgir2/+/21X6i/7BXFPMi71Vo9
 j+is1C1bJZGSzoHlXbE8xlPKTSAE44TKdME4lpNRF1ulCOjbnWd0Dv4gX
 QyWkSKBn1zE08NB4lHN0GnNz/+uQfiZbu4FbtFgina8hATezWTxdEFre0 A==;
X-CSE-ConnectionGUID: 2/p7wHyoRM6qPz/v/Z9fJg==
X-CSE-MsgGUID: pWgtdzq5RjCifqlGr0wPSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74900627"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="74900627"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 09:07:22 -0700
X-CSE-ConnectionGUID: aBv8BvyCRWidnWezdTDuHw==
X-CSE-MsgGUID: /Sr9B7mTSAakZRE+Vt3QYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="222987045"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 19 Mar 2026 09:07:22 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v1 2/5] eal: fix async IPC callback not fired when no peers
Date: Thu, 19 Mar 2026 16:07:14 +0000
Message-ID: <3f2bbfb6a1c849936514e2dca04ca48d565a6a9b.1773936429.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <740b39c5098b4d40cafb9881ad70865a3c889012.1773936429.git.anatoly.burakov@intel.com>
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

Currently, when rte_mp_request_async() is called and no peer processes
are connected (nb_sent == 0), the user callback is never invoked.

The original implementation used a dedicated background thread and
pthread_cond_signal() to wake it after queuing the dummy request. When
that thread was replaced with per-message alarms, no alarm was set for
the dummy request, silently breaking the nb_sent == 0 path.

This was not noticed because async requests are used while handling
secondary process requests, where peers are typically already present.

Fix it by setting a 1us alarm on the dummy request, so the callback path
immediately triggers and processes it.

Fixes: daf9bfca717e ("ipc: remove thread for async requests")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_proc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 799c6e81b0..0ec79336a5 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -1187,11 +1187,15 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
 		ret = mp_request_async(eal_mp_socket_path(), copy, param, ts);
 
-		/* if we didn't send anything, put dummy request on the queue */
+		/* if we didn't send anything, put dummy request on the queue
+		 * and set a minimum-delay alarm so the callback fires immediately.
+		 */
 		if (ret == 0 && reply->nb_sent == 0) {
 			TAILQ_INSERT_TAIL(&pending_requests.requests, dummy,
 					next);
 			dummy_used = true;
+			if (rte_eal_alarm_set(1, async_reply_handle, dummy) < 0)
+				EAL_LOG(ERR, "Fail to set alarm for dummy request");
 		}
 
 		pthread_mutex_unlock(&pending_requests.lock);
@@ -1232,10 +1236,14 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 		} else if (mp_request_async(path, copy, param, ts))
 			ret = -1;
 	}
-	/* if we didn't send anything, put dummy request on the queue */
+	/* if we didn't send anything, put dummy request on the queue
+	 * and set a minimum-delay alarm so the callback fires immediately.
+	 */
 	if (ret == 0 && reply->nb_sent == 0) {
 		TAILQ_INSERT_HEAD(&pending_requests.requests, dummy, next);
 		dummy_used = true;
+		if (rte_eal_alarm_set(1, async_reply_handle, dummy) < 0)
+			EAL_LOG(ERR, "Fail to set alarm for dummy request");
 	}
 
 	/* finally, unlock the queue */
-- 
2.47.3

