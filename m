Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62975606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 03:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=LhlM8F/v
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DE8A4025A;
	Fri, 30 Oct 2026 04:42:08 +0100 (CET)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTPS id 7CC8540151
 for <dev@dpdk.org>; Fri, 30 Oct 2026 04:42:07 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=xT0cG7a6BWE5M2GCddfS8crnX3BVt0xDxfFBtEbwcTI=;
 b=LhlM8F/vCUU2ZeNY03xYS4dighkHyRPZRPRIgCK1wZfvxgHlLsgypVk7x00xCVWIIHROnriHz
 rQwRd9oCuOxYJfFjHJRS4fwFh5edL3aiGlv+JgwinEnmCIhJVEdQ/XhRKyniSD/xtiSVXTSGw1Y
 AJTk+mxP0dbmZ/d+ZlWFCMo=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jG6NS6NBYz12LFH;
 Fri, 30 Oct 2026 11:42:00 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 1A0524056E;
 Fri, 30 Oct 2026 11:42:03 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 30 Oct 2026 11:42:02 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: [PATCH] ethdev/telemetry: fix hide_zero parameter being reset
Date: Fri, 30 Oct 2026 11:41:57 +0800
Message-ID: <20261030034157.49080-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the "hide_zero" parameter is parsed successfully in the ethdev
telemetry regs command, the else branch unconditionally resets
hide_zero back to false, discarding the parsed value. As a result the
hide_zero option is silently ignored.

Remove the unnecessary reset so the parsed hide_zero value is retained
and passed to eth_dev_get_port_regs().

Fixes: ba4d57bd849d ("ethdev: support hide zero in registers telemetry")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/ethdev/rte_ethdev_telemetry.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/ethdev/rte_ethdev_telemetry.c b/lib/ethdev/rte_ethdev_telemetry.c
index ca7f4681c9..caa7b33e1e 100644
--- a/lib/ethdev/rte_ethdev_telemetry.c
+++ b/lib/ethdev/rte_ethdev_telemetry.c
@@ -1515,13 +1515,11 @@ eth_dev_handle_port_regs(const char *cmd __rte_unused,
 		kvlist = rte_kvargs_parse(end_param, valid_keys);
 		filter_val = rte_kvargs_get(kvlist, "filter");
 		ret = rte_kvargs_process(kvlist, "hide_zero", eth_dev_parse_hide_zero, &hide_zero);
-		if (kvlist == NULL || (filter_val != NULL && strlen(filter_val) == 0) || ret != 0) {
+		if (kvlist == NULL || (filter_val != NULL && strlen(filter_val) == 0) || ret != 0)
 			RTE_ETHDEV_LOG_LINE(NOTICE,
 				"Unknown extra parameters passed to ethdev telemetry command, ignoring");
-		} else {
+		else
 			filter = (filter_val != NULL) ? strdup(filter_val) : NULL;
-			hide_zero = false;
-		}
 		rte_kvargs_free(kvlist);
 	}
 
-- 
2.17.1

