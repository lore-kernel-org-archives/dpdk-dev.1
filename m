Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A6ECD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 13:13:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CB4C4065B;
	Mon,  8 Jun 2026 15:13:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 2621440265
 for <dev@dpdk.org>; Mon,  8 Jun 2026 15:13:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780924411; x=1812460411;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=o4Igg1AU38OsivBMSnwpQsoeSRpzaYB6F/+x2eSdHSE=;
 b=ZhZCv5sFMoZVY8Y8ZvkeKsmH0lHvOcZQA84rxEzVa5yb5faGjjLUophl
 TByhjm4IdNV/E8Ps0wyCQenKRSEiIzyiGlWHmetnysAJuH9I/IoqV4fFY
 vxEHCbt4r4+HTIRJSvchWt2USZmuK5Op/HrP94mUMZthPgl1Y/04kk7/t
 FUyVJmHMnvpLVCAPLUncie9BcbvXBPiwNa7f3650pkLzELSdC/NN7dHNz
 Qj2x21PdXWZLGSj7Krbzshbkl17GtohtpaeDY3vKFyy/3qEpObwz0Q8HF
 Y71dWQ5mu5PI6ChHrMJBr2eQz33dosxUaRMCqCQmpHUZVzZhFUDmVQXcp A==;
X-CSE-ConnectionGUID: xppIP3NVQTGGEScZcAPXVw==
X-CSE-MsgGUID: dEm+hIedR7q+MKJOUSjRsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81656719"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="81656719"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 06:13:25 -0700
X-CSE-ConnectionGUID: 5HnR4F2aQ3eFZMTrrDpErw==
X-CSE-MsgGUID: 365lPoO1QBWAZe9eG/ZuZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="245635479"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 08 Jun 2026 06:13:25 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v5 2/5] eal: fix async IPC callback not fired when no peers
Date: Mon,  8 Jun 2026 14:13:18 +0100
Message-ID: <dd5ac200051b3d446ace6645039b5098ea3baf1c.1780924381.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2bc77b94493d94b53a28ea535ed96d92a157a7c7.1780924381.git.anatoly.burakov@intel.com>
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
 lib/eal/common/eal_common_proc.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 799c6e81b0..2a99162a21 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -1187,11 +1187,22 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
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
+
+			if (rte_eal_alarm_set(1, async_reply_handle, dummy) < 0) {
+				EAL_LOG(ERR, "Fail to set alarm for dummy request");
+				/* roll back the changes */
+				TAILQ_REMOVE(&pending_requests.requests, dummy, next);
+				dummy_used = false;
+				ret = -1;
+				goto unlock_fail;
+			}
 		}
 
 		pthread_mutex_unlock(&pending_requests.lock);
@@ -1232,10 +1243,21 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
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
+
+		if (rte_eal_alarm_set(1, async_reply_handle, dummy) < 0) {
+			EAL_LOG(ERR, "Fail to set alarm for dummy request");
+			/* roll back the changes */
+			TAILQ_REMOVE(&pending_requests.requests, dummy, next);
+			dummy_used = false;
+			ret = -1;
+			goto closedir_fail;
+		}
 	}
 
 	/* finally, unlock the queue */
-- 
2.47.3

