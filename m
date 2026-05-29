Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB493CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:26:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A3E240615;
	Fri, 29 May 2026 17:26:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id D001C400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 17:26:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780068396; x=1811604396;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lwUJTM4vVY32rvXwtxBfLPGU7TDS/opuQn6BNY2MyZA=;
 b=aS3uOm7Ib7d/z0g3WYLgziSoyj1UoNxf4GS7cCMPisbCFVTm1vkxQR/Z
 fh3sWjO156pR8thXGJoQQUqnSZKuHbW0NvfeNB0V+P/OXmTPEPHbEMmLZ
 U/s5tkB7JQXTepgoRher7o2b3Za7Jtaot1SNfcdamlBM4jytQM4rWhIT2
 nqgvER0z9BE9B6mMdwLCwwD5a+JEHL9hAikEsPsvrot49SVySZjxxCr6j
 CflQgRPOIlqx+4aQAJzKoBd1kMutETlYJXcRLBhIRmqMiYrBCjClXPeuS
 Yj//rUafe8yYeZANT6xGj3UJrESqMHUJGfz5ie9lHkPQYj1kF3pRk82+X Q==;
X-CSE-ConnectionGUID: 6UbSiOjFR262zg4Pr/D5Cg==
X-CSE-MsgGUID: a4qKS70cQTi6D1Q4GIAUfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91231661"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="91231661"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:26:35 -0700
X-CSE-ConnectionGUID: 4hyKbE81QFSTL3MAozAmhw==
X-CSE-MsgGUID: I1yJMxM5TImQWt40H0xgtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="236520610"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa009.fm.intel.com with ESMTP; 29 May 2026 08:26:34 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v2 2/5] eal: fix async IPC callback not fired when no peers
Date: Fri, 29 May 2026 16:26:28 +0100
Message-ID: <1ad014dd239fa1e8ea62aab7e56a7bf7264c04ff.1780068382.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <d7204c81e2494027fe467b8e3f5744888059fcbd.1780068382.git.anatoly.burakov@intel.com>
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

