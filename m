Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123A9C35FF3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 04:03:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F7B340276;
	Fri, 21 Mar 2025 05:03:24 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 26C7140268
 for <dev@dpdk.org>; Fri, 21 Mar 2025 05:03:22 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZJph83Rbtz13Kp6;
 Fri, 21 Mar 2025 12:03:04 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 68EB61800E4;
 Fri, 21 Mar 2025 12:03:20 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Mar 2025 12:03:19 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <honest.jiang@foxmail.com>, <fengchengwen@huawei.com>,
 <roretzla@linux.microsoft.com>, <lihuisong@huawei.com>, <haijie1@huawei.com>, 
 <liuyonglong@huawei.com>, <stephen@networkplumber.org>
Subject: [PATCH 1/2] eal: fix wake a incorrect lcore
Date: Fri, 21 Mar 2025 12:03:15 +0800
Message-ID: <20250321040316.104126-2-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250321040316.104126-1-huangdengdui@huawei.com>
References: <20250321040316.104126-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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

If the core is not used in the rte, we can't wake it up to work.
The worker_id may come from user input. So it is necessary to
verify it.

Fixes: a95d70547c57 ("eal: factorize lcore main loop")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 lib/eal/unix/eal_unix_thread.c | 3 +++
 lib/eal/windows/eal_thread.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/lib/eal/unix/eal_unix_thread.c b/lib/eal/unix/eal_unix_thread.c
index ef6cbff0ee..103571cabf 100644
--- a/lib/eal/unix/eal_unix_thread.c
+++ b/lib/eal/unix/eal_unix_thread.c
@@ -17,6 +17,9 @@ eal_thread_wake_worker(unsigned int worker_id)
 	char c = 0;
 	int n;
 
+	if (m2w == 0 || w2m == 0)
+		return -EINVAL;
+
 	do {
 		n = write(m2w, &c, 1);
 	} while (n == 0 || (n < 0 && errno == EINTR));
diff --git a/lib/eal/windows/eal_thread.c b/lib/eal/windows/eal_thread.c
index 9e3df200b9..82bb974868 100644
--- a/lib/eal/windows/eal_thread.c
+++ b/lib/eal/windows/eal_thread.c
@@ -24,6 +24,9 @@ eal_thread_wake_worker(unsigned int worker_id)
 	char c = 0;
 	int n;
 
+	if (m2w == 0 || w2m == 0)
+		return -EINVAL;
+
 	do {
 		n = _write(m2w, &c, 1);
 	} while (n == 0 || (n < 0 && errno == EINTR));
-- 
2.33.0

