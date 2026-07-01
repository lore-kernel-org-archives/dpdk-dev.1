Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94663C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 06:08:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7499A402E0;
	Wed,  1 Jul 2026 08:08:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id DADAB40278;
 Wed,  1 Jul 2026 08:07:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782886081; x=1814422081;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Tah7aCnXm0Lju2Jzgv/wsp+1/ltjHZZXvyUzAaCcf0w=;
 b=T051lidZ8Z1ZsxwEtv9oUCg0JPfsw2/C8mi4HQaPDw5oxDZb5rPkIpm4
 4v3NeTIoG3eLy0f7wPx87RrdSwXzlykgT9UG0H84ce1R5x3abQgibWPZh
 BleXZroAzn9s8K7BpiliYTT0/U0IuXQLVsNhAoYzn5VLVNOppAZv2eHUT
 gOsuNJkU5mhXGrCOI5+SyEro9Wid8v97aXUpAq0PZkSF1ZFpaVRwvvJ42
 zOuYOSbmd+5q+LpSfVancnrvvQDGd42JHeF7cLEaUz2xwp1LD/K+1MLwp
 P2phkG/vj5l0GCAeMkBhRl2f1JtssPBLXTSfaz4sRBRcJ96RT2ZMFe6zt w==;
X-CSE-ConnectionGUID: eOmt0D8tSS2CREwIV4w3Hg==
X-CSE-MsgGUID: 6M/J4lEGR7iwY0T5jT3c4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="93964462"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="93964462"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 23:07:59 -0700
X-CSE-ConnectionGUID: Sk/zj3+9T2CiOIE2JrFadQ==
X-CSE-MsgGUID: 47F17gyRSzKVs9+ya5TuHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="256390842"
Received: from smserver2row47.iind.intel.com ([10.138.138.56])
 by orviesa004.jf.intel.com with ESMTP; 30 Jun 2026 23:07:56 -0700
From: Pushpendra Kumar <pushpendra1x.kumar@intel.com>
To: dev@dpdk.org
Cc: pushpendra.kumar@tieto.com, reshma.pattan@intel.com,
 stephen@networkplumber.org, stable@dpdk.org,
 Pushpendra Kumar <pushpendra1x.kumar@intel.com>
Subject: [PATCH] pdump: fix request timeout on unresponsive secondary
Date: Wed,  1 Jul 2026 11:32:57 +0530
Message-ID: <20260701060257.562895-1-pushpendra1x.kumar@intel.com>
X-Mailer: git-send-email 2.43.0
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

When a primary handles a pdump enable/disable request from a secondary
(e.g. dpdk-dumpcap), it applies the callbacks locally and forwards the
request to the other secondaries before replying. The forward used
rte_mp_request_sync(), blocking up to MP_TIMEOUT_S for every secondary
to acknowledge.

A secondary that is attached but has not called rte_pdump_init() never
registers the mp_pdump action and silently drops the message (logging
only "Cannot find action: mp_pdump"). Commit c3ceb8742295 ("pdump:
forward callback enable to secondary process"), which added this
broadcast, appears to assume every secondary calls rte_pdump_init();
when one does not, the primary cannot tell it from a slow or dead peer
and blocks for the full timeout. That delay pushes the reply past the
requester's own timeout, so dpdk-dumpcap reports "Packet dump enable
... failed Connection timed out".

Forward the request asynchronously with rte_mp_request_async() so an
unresponsive secondary can no longer block the reply; a callback logs a
warning if not all secondaries acknowledge. The forward is still issued
before the requester reply, preserving the ordering from commit
928f43e3f9c1 ("pdump: fix race in disabling").

This slightly weakens the happens-before guarantee: the sync call was a
full-acknowledgement barrier, whereas the async path relies on AF_UNIX
SOCK_DGRAM FIFO ordering and the single mp_handle thread processing the
forward before the reply that triggers teardown. This suffices for the
disable race fixed by 928f43e3f9c1, but reviewers should confirm they
are comfortable with the weaker guarantee.

Fixes: c3ceb8742295 ("pdump: forward callback enable to secondary process")
Cc: stable@dpdk.org

Signed-off-by: Pushpendra Kumar <pushpendra1x.kumar@intel.com>
---
 .mailmap              |  1 +
 lib/pdump/rte_pdump.c | 23 ++++++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/.mailmap b/.mailmap
index c5bc728fae..c1313c7148 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1332,6 +1332,7 @@ Przemyslaw Gierszynski <przemyslaw.gierszynski@intel.com>
 Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
 Przemyslaw Zegan <przemyslawx.zegan@intel.com>
 Pu Xu <583493798@qq.com>
+Pushpendra Kumar <pushpendra1x.kumar@intel.com>
 Qi Fu <qi.fu@intel.com>
 Qi Zhang <qi.z.zhang@intel.com>
 Qian Hao <qi_an_hao@126.com>
diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index ac94efe7ff..f2d5b70111 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -477,11 +477,21 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 	return ret;
 }
 
+/* Async reply handler; warns if any secondary did not respond. */
+static int
+pdump_secondary_reply(const struct rte_mp_msg *request __rte_unused,
+		      const struct rte_mp_reply *reply)
+{
+	if (reply->nb_sent != reply->nb_received)
+		PDUMP_LOG_LINE(ERR, "not all secondary's replied (sent %u recv %u)",
+			       reply->nb_sent, reply->nb_received);
+	return 0;
+}
+
 static void
 pdump_request_to_secondary(const struct pdump_request *req)
 {
 	struct rte_mp_msg mp_req = { };
-	struct rte_mp_reply mp_reply;
 	struct timespec ts = {.tv_sec = MP_TIMEOUT_S, .tv_nsec = 0};
 
 	PDUMP_LOG_LINE(DEBUG, "forward req %s to secondary", pdump_opname(req->op));
@@ -490,14 +500,9 @@ pdump_request_to_secondary(const struct pdump_request *req)
 	strlcpy(mp_req.name, PDUMP_MP, sizeof(mp_req.name));
 	mp_req.len_param = sizeof(*req);
 
-	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) != 0)
-		PDUMP_LOG_LINE(ERR, "rte_mp_request_sync failed");
-
-	else if (mp_reply.nb_sent != mp_reply.nb_received)
-		PDUMP_LOG_LINE(ERR, "not all secondary's replied (sent %u recv %u)",
-			       mp_reply.nb_sent, mp_reply.nb_received);
-
-	free(mp_reply.msgs);
+	/* Forward asynchronously so an unresponsive secondary cannot block the requester reply. */
+	if (rte_mp_request_async(&mp_req, &ts, pdump_secondary_reply) != 0)
+		PDUMP_LOG_LINE(ERR, "rte_mp_request_async failed");
 }
 
 /* Allocate temporary storage for passing state to the alarm thread for deferred handling */
-- 
2.43.0

