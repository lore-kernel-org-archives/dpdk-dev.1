Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5D9C3ABB2
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 08:19:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FFB0402D6;
	Fri, 30 May 2025 10:19:15 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id A23D8402D1;
 Fri, 30 May 2025 10:19:13 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b7x3H6sDvz6M4pc;
 Fri, 30 May 2025 16:19:07 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 455B01402FF;
 Fri, 30 May 2025 16:19:13 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 May 2025 10:19:12 +0200
From: Rui Ferreira <rui.ferreira1@h-partners.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v2 1/2] fix eal/linux: unregister alarm callback before free
Date: Fri, 30 May 2025 09:18:43 +0100
Message-ID: <20250530081845.64297-2-rui.ferreira1@h-partners.com>
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

This was flagged by Address sanitizer as a use after free. The
intr_handle ptr is shared between the main thread and the interrupt
thread. The interrupt thread can dereference the ptr after free (from
the alarm callback). free is called when the main thread cleans up.

The interrupt thread never terminates (eal_intr_thread_main) so
use rte_intr_callback_unregister_sync during cleanup to
ensure the callback is removed before freeing the ptr.

To be more defensive clear out the pointer and registration
variable if we can unregister.

rte_intr_callback_unregister_sync may (optionally) use traces
so the alarm cleanup must happen before eal_trace_fini to avoid
accessing freed memory.

Bugzilla ID: 1683

Signed-off-by: Rui Ferreira <rui.ferreira1@h-partners.com>
---
 .mailmap                  | 1 +
 lib/eal/linux/eal.c       | 3 ++-
 lib/eal/linux/eal_alarm.c | 9 ++++++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index d8439b79ce..907c5ea967 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1332,6 +1332,7 @@ Rosen Xu <rosen.xu@altera.com> <rosen.xu@intel.com>
 Roy Franz <roy.franz@cavium.com>
 Roy Pledge <roy.pledge@nxp.com>
 Roy Shterman <roy.shterman@vastdata.com>
+Rui Ferreira <rui.ferreira1@h-partners.com>
 Ruifeng Wang <ruifeng.wang@arm.com>
 Rushil Gupta <rushilg@google.com>
 Ryan E Hall <ryan.e.hall@intel.com>
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 20f777b8b0..b448db1392 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -1329,9 +1329,10 @@ rte_eal_cleanup(void)
 	rte_mp_channel_cleanup();
 	eal_bus_cleanup();
 	rte_trace_save();
+	/* may use trace, must be called before eal_trace_fini */
+	rte_eal_alarm_cleanup();
 	eal_trace_fini();
 	eal_mp_dev_hotplug_cleanup();
-	rte_eal_alarm_cleanup();
 	/* after this point, any DPDK pointers will become dangling */
 	rte_eal_memory_detach();
 	rte_eal_malloc_heap_cleanup();
diff --git a/lib/eal/linux/eal_alarm.c b/lib/eal/linux/eal_alarm.c
index b216a007a3..eb6a21d4f0 100644
--- a/lib/eal/linux/eal_alarm.c
+++ b/lib/eal/linux/eal_alarm.c
@@ -57,7 +57,14 @@ static void eal_alarm_callback(void *arg);
 void
 rte_eal_alarm_cleanup(void)
 {
-	rte_intr_instance_free(intr_handle);
+	/* unregister callback using intr_handle in interrupt thread */
+	int ret = rte_intr_callback_unregister_sync(intr_handle,
+						eal_alarm_callback, (void *)-1);
+	if (ret >= 0) {
+		rte_intr_instance_free(intr_handle);
+		intr_handle = NULL;
+		handler_registered = 0;
+	}
 }
 
 int
-- 
2.43.0

