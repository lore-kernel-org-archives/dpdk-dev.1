Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B47CC54E65
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 15:08:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6702C406BA;
	Tue, 20 May 2025 17:08:22 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 22B62402AE
 for <dev@dpdk.org>; Tue, 20 May 2025 17:08:20 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1yVT684lz6M4w5;
 Tue, 20 May 2025 23:03:29 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id EB36F140447;
 Tue, 20 May 2025 23:08:19 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 May 2025 17:08:19 +0200
From: Rui Ferreira <rui.ferreira1@h-partners.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [PATCH] eal/linux: unregister alarm callback before free ptr
Date: Tue, 20 May 2025 12:01:50 -0400
Message-ID: <20250520160150.50401-1-rui.ferreira1@h-partners.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapeml500002.china.huawei.com (7.182.85.205) To
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
thread, and the interrupt thread can dereference the ptr after free
is called when the main thread cleans up (from the alarm callback).

The interrupt thread never terminates (eal_intr_thread_main) so
use rte_intr_callback_unregister_sync during cleanup to
ensure the callback is removed before freeing the ptr.

To be more defensive clear out the pointer and registration
variable if we can unregister.

Bugzilla ID: 1683

Signed-off-by: Rui Ferreira <rui.ferreira1@h-partners.com>
---
 .mailmap                  | 1 +
 lib/eal/linux/eal_alarm.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

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
2.35.3

