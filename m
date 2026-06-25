Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFBBCDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 14:02:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68C2B40DD0;
	Thu, 25 Jun 2026 16:02:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 6313240A89
 for <dev@dpdk.org>; Thu, 25 Jun 2026 16:01:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782396119; x=1813932119;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=eI3KJDcqCS+ks4id6pQ8JjOt6/S8GfsQoZk+NwACuVs=;
 b=GMwKe7bJ04efV94OLqO9wR12k8rk/n0CgsBxAIkZgx5RnypKF2etWB+y
 K0LqG9e4Mxu8WWudlu7vZxguzgSfoBqckdXZmPEGXjp/XgEmyHCXJ1btF
 u7rGN51pK0UyRYSrkE0OSmM0t1DPxBomXoDQQHLnaO5KRnHRPTGz+PCdE
 pCQauIOhV9ESYxqQz/1wxNhRXpQM4bQgzjFrRPnRNkTU+pP/5Xg3Fj1Sx
 QvxkIlF+AWAGxUnKexQWlbbk2LylfUhJ/6gcMopZj+NyfJG0T4RKImFFg
 uZLfZY/JKR/0sMToOgIkFh2Fysz81gQkQ5XypT8H5nYz90t25sUwemoGQ A==;
X-CSE-ConnectionGUID: WxymDyk8QrCvlMer5gsY7Q==
X-CSE-MsgGUID: OQCpWeTMQcqlxluZgtUGVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83225275"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="83225275"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 07:01:58 -0700
X-CSE-ConnectionGUID: LBTgdSaYRL2hzPg8MCyHdA==
X-CSE-MsgGUID: TQcFH0rYRqe1fOd/joKuww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="280908141"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 25 Jun 2026 07:01:57 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v6 6/6] eal: fix async IPC callback not fired when no peers
Date: Thu, 25 Jun 2026 15:01:48 +0100
Message-ID: <dfb9ecf6d00b3715369c0eb4b7b007c8d212965a.1782395581.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782395581.git.anatoly.burakov@intel.com>
 <cover.1782395581.git.anatoly.burakov@intel.com>
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

This was not noticed because async requests are usually used while handling
secondary process requests, where peers are typically already present.

Fix it by setting a 1us alarm on the dummy request, so the callback path
immediately triggers and processes it.

Fixes: daf9bfca717e ("ipc: remove thread for async requests")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_proc.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 235687ab84..2b8874e416 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -1197,11 +1197,22 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
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
+			if (rte_eal_alarm_set(1, async_reply_handle,
+					(void *)(uintptr_t)dummy->id) < 0) {
+				EAL_LOG(ERR, "Fail to set alarm for dummy request");
+				/* roll back the changes */
+				TAILQ_REMOVE(&pending_requests.requests, dummy, next);
+				dummy_used = false;
+				ret = -1;
+				goto unlock_fail;
+			}
 		}
 
 		pthread_mutex_unlock(&pending_requests.lock);
@@ -1275,6 +1286,16 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 	if (ret == 0 && reply->nb_sent == 0) {
 		TAILQ_INSERT_HEAD(&pending_requests.requests, dummy, next);
 		dummy_used = true;
+
+		if (rte_eal_alarm_set(1, async_reply_handle,
+				(void *)(uintptr_t)dummy->id) < 0) {
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

