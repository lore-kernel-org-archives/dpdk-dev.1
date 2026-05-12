Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3365FCD37BE
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 02:35:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7221A40615;
	Tue, 12 May 2026 04:35:19 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 97AA240278
 for <dev@dpdk.org>; Tue, 12 May 2026 04:35:17 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=qwF6kvJRFONaozQMKkareYI8/uJ/0LxV6G8HLI48qUY=;
 b=M8QcCRhREklSLNH+xFq//eDHvrKRC7oS+bSFKXwqzWQ6aDr2tX71LuTkjbwyiKQSj14v7Ab3g
 FS4qCaBPS3885aqVqlJU0DErgSSG2kYp5fYAh1CW0yoy9oRQVStP0TnyeLtHwb/MC4BiEZyrOuV
 wuKyMq/UDAvGYHto3tNiqv8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gF0qb61x4zS0dH;
 Tue, 12 May 2026 10:27:39 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id CFAF9201E9;
 Tue, 12 May 2026 10:35:15 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 May 2026 10:35:15 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 12 May 2026 10:35:15 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v1 2/7] examples/l3fwd-power: support to set power QoS on any
 mode
Date: Tue, 12 May 2026 10:35:08 +0800
Message-ID: <20260512023513.460169-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260512023513.460169-1-lihuisong@huawei.com>
References: <20260512023513.460169-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)
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
index 1122aeb930..ba2be5bf32 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -2295,7 +2295,7 @@ init_power_library(void)
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

