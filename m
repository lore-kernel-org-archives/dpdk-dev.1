Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0618C5B56A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 09:53:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C34E1406FF;
	Wed, 12 Aug 2026 11:53:09 +0200 (CEST)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id 05F1E406B6
 for <dev@dpdk.org>; Wed, 12 Aug 2026 11:53:07 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=afKTR6BUja3a51KGoKL6PBIuuxaQyizcQyMhxeTnbHw=;
 b=E2juRF0bQR3B9MDBEQ2l9dWcHaYHlPxXxRjdHnUxTJ2brTw//EeYjSB3OT2oVqXZaTx229035
 TAjDtXBEDWtHH4YgfzKAszjiqWXRLFY/a05FI4JsS2Pe9ejIs+MeWaOnZrlxktFxfXPL4jYu3gU
 XVMKJKRPX6KNpRiod7whmaQ=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hKk6s6SkTz1cyPY;
 Wed, 12 Aug 2026 17:42:29 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id 26D234058E;
 Wed, 12 Aug 2026 17:53:06 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 12 Aug 2026 17:53:05 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v5 2/6] examples/l3fwd-power: enable power QoS for all modes
Date: Wed, 12 Aug 2026 17:49:52 +0800
Message-ID: <20260812094956.3356537-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20260812094956.3356537-1-lihuisong@huawei.com>
References: <20260812094956.3356537-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo100005.china.huawei.com (7.202.195.212)
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

Power QoS feature doesn't depend on app mode, here open it for all.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 examples/l3fwd-power/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 4b0128eeaa..3af10c629a 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -2294,7 +2294,7 @@ init_power_library(void)
 		}
 	}
 
-	if (app_mode == APP_MODE_LEGACY && cpu_resume_latency != -1) {
+	if (cpu_resume_latency != -1) {
 		RTE_LCORE_FOREACH(lcore_id) {
 			/* Back old CPU resume latency. */
 			ret = rte_power_qos_get_cpu_resume_latency(lcore_id);
@@ -2365,7 +2365,7 @@ deinit_power_library(void)
 		}
 	}
 
-	if (app_mode == APP_MODE_LEGACY && cpu_resume_latency != -1) {
+	if (cpu_resume_latency != -1) {
 		RTE_LCORE_FOREACH(lcore_id) {
 			/* Restore the original value. */
 			rte_power_qos_set_cpu_resume_latency(lcore_id,
-- 
2.33.0

