Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D48ECD6E7D
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 14:29:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50A1240615;
	Fri,  5 Jun 2026 16:29:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 32DA24026A
 for <dev@dpdk.org>; Fri,  5 Jun 2026 16:29:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780669769; x=1812205769;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=axL76nOTTAtGs3KEP5Gb500fFmd2kxIg4NOUmpzMUfM=;
 b=kc1bLHafZsfeYDBazmXC3fNubFv7ZjZJMBw/bKmc4vPt7K2AerLaryyd
 Rw9VN+/g6s6YnSVxh6vDgI510pm2Y2CHZgGNPLXdzvG6c6zV4ZjahypJG
 SDLR9f/Tj+Pk70aDipn9Wdz8KGJoQDCy33N1L8czgN/lfKYEGaMwKw0uh
 Is5A1LGmWIZSJZ0fTSny3PBbiw5Nci8C6G/k5UiA24qmMnPastEM1yNDi
 0FPmH99MUCmqTbOsOZAVVJmlxsHIEuQMnC/1xhhmMyoDInG4kr5nIqydm
 JG71d9Gnc0vYnWAxc284mVm45h/MtY2LTjfRyE2U19SDrOK9ti7vP1n1l Q==;
X-CSE-ConnectionGUID: 8w1dzZiNSJihGIWVr6oFbQ==
X-CSE-MsgGUID: nwOYKN3ARPyuoxp5jDhoMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81482615"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="81482615"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:29:28 -0700
X-CSE-ConnectionGUID: bNc3dj3PSDa5nOgB/cppFA==
X-CSE-MsgGUID: 4OsFdGQ5QLGpp+yNNAP/oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="242383076"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 05 Jun 2026 07:29:28 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v4 2/5] eal: fix async IPC callback not fired when no peers
Date: Fri,  5 Jun 2026 15:29:21 +0100
Message-ID: <a26007070f8eba7e568140a4a7276d545ca2878b.1780669755.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2bc77b94493d94b53a28ea535ed96d92a157a7c7.1780669755.git.anatoly.burakov@intel.com>
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
 lib/eal/common/eal_common_proc.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 799c6e81b0..2f4a939c68 100644
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
+				goto fail;
+			}
 		}
 
 		pthread_mutex_unlock(&pending_requests.lock);
@@ -1232,10 +1243,14 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
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

