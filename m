Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00A2CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 08:17:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A7D640262;
	Tue, 28 Oct 2025 09:17:43 +0100 (CET)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id EFE1F4021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 09:17:40 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=n+T00/zKXlcGJNLUnAkcDlHMuxlaQ55ZoA/EwhtKdRs=;
 b=MCK/cp2l/ettIkUj75VCHrGCHYVNuwq7cy4aaNd6L2eXQPyu6YdBNC6O9jE3l0LJpJSA5Gjpc
 TH4oiQAX6NlHUgrjo/iZIdF9DmPBsTVd/EnEB8r7RRsXTv9fa99cHARtuAob6h4bxxtQ05FdOno
 0mMR04EHiDfgSAFpnEIhx8E=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cwjrh2F1Qz1T4Fg;
 Tue, 28 Oct 2025 16:16:36 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B395B140277;
 Tue, 28 Oct 2025 16:17:38 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Oct 2025 16:17:38 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <reshma.pattan@intel.com>
Subject: [PATCH] app/procinfo: fix warning of deprecated coremask
Date: Tue, 28 Oct 2025 16:17:33 +0800
Message-ID: <20251028081733.38583-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

When launch proc-info:
  EAL: '-c <coremask>' option is deprecated, and will be removed in a future release
  EAL: 	Use '-l <corelist>' or '--lcores=<corelist>' option instead

This commit fix it by use -l0 other than -c1.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/proc-info/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index 1b9979b7c8..b09c03ab35 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -2121,7 +2121,7 @@ main(int argc, char **argv)
 {
 	int ret;
 	int i;
-	char c_flag[] = "-c1";
+	char c_flag[] = "-l0";
 	char n_flag[] = "-n4";
 	char mp_flag[] = "--proc-type=secondary";
 	char log_flag[] = "--log-level=6";
-- 
2.17.1

