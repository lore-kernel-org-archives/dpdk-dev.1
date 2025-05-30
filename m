Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197F9C5B549
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 08:19:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D35A402E6;
	Fri, 30 May 2025 10:19:23 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id B9A7A40608;
 Fri, 30 May 2025 10:19:21 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b7x3S0fVyz6M4nT;
 Fri, 30 May 2025 16:19:16 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 649D61402FF;
 Fri, 30 May 2025 16:19:21 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 May 2025 10:19:21 +0200
From: Rui Ferreira <rui.ferreira1@h-partners.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v2 2/2] fix eal/freebsd: unregister alarm callback before free
Date: Fri, 30 May 2025 09:18:44 +0100
Message-ID: <20250530081845.64297-3-rui.ferreira1@h-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530081845.64297-1-rui.ferreira1@h-partners.com>
References: <dcbff1c1ee8c48598294306fe80167ef@h-partners.com>
 <20250530081845.64297-1-rui.ferreira1@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapeml500003.china.huawei.com (7.182.85.28) To
 frapeml500007.china.huawei.com (7.182.85.172)
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

Unregister callback on cleanup to avoid use after free from the
interrupt thread (eal_intr_thread_main).

To be more defensive, set ptr to NULL if we can unregister.

rte_intr_callback_unregister_sync may (optionally) use traces
so the alarm cleanup must happen before eal_trace_fini to avoid
accessing freed memory.

Bugzilla ID: 1683

Signed-off-by: Rui Ferreira <rui.ferreira1@h-partners.com>
---
 lib/eal/freebsd/eal.c       | 3 ++-
 lib/eal/freebsd/eal_alarm.c | 8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index d6fffa2170..21ce4e6b18 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -907,8 +907,9 @@ rte_eal_cleanup(void)
 	rte_mp_channel_cleanup();
 	eal_bus_cleanup();
 	rte_trace_save();
-	eal_trace_fini();
+	/* may use trace, must be called before eal_trace_fini */
 	rte_eal_alarm_cleanup();
+	eal_trace_fini();
 	/* after this point, any DPDK pointers will become dangling */
 	rte_eal_memory_detach();
 	eal_cleanup_config(internal_conf);
diff --git a/lib/eal/freebsd/eal_alarm.c b/lib/eal/freebsd/eal_alarm.c
index 28f285fdef..c03e281e67 100644
--- a/lib/eal/freebsd/eal_alarm.c
+++ b/lib/eal/freebsd/eal_alarm.c
@@ -50,7 +50,13 @@ static void eal_alarm_callback(void *arg);
 void
 rte_eal_alarm_cleanup(void)
 {
-	rte_intr_instance_free(intr_handle);
+	/* unregister callback using intr_handle in interrupt thread */
+	int ret = rte_intr_callback_unregister_sync(intr_handle,
+			eal_alarm_callback, (void *)-1);
+	if (ret >= 0) {
+		rte_intr_instance_free(intr_handle);
+		intr_handle = NULL;
+	}
 }
 
 int
-- 
2.43.0

