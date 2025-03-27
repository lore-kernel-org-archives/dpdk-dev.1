Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B454C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 09:01:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9F574068E;
	Thu, 27 Mar 2025 10:01:22 +0100 (CET)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id 479E64066C
 for <dev@dpdk.org>; Thu, 27 Mar 2025 10:01:21 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZNcxh54jnzHrDL;
 Thu, 27 Mar 2025 16:58:00 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 5939018007F;
 Thu, 27 Mar 2025 17:01:18 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Mar 2025 17:01:17 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <honest.jiang@foxmail.com>, <fengchengwen@huawei.com>,
 <roretzla@linux.microsoft.com>, <lihuisong@huawei.com>, <haijie1@huawei.com>, 
 <liuyonglong@huawei.com>, <stephen@networkplumber.org>
Subject: [PATCH v2 0/2] fix the problem of dma-perf infinite loop
Date: Thu, 27 Mar 2025 17:01:14 +0800
Message-ID: <20250327090116.3357137-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250321040316.104126-1-huangdengdui@huawei.com>
References: <20250321040316.104126-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

After CPU isolation is configured, an infinite loop occurs when
dma-perf is executed using the default config file.

This patchset fix it.

Dengdui Huang (2):
  eal: fix uncheck worker ID
  app/dma-perf: fix infinite loop

 app/test-dma-perf/main.c           | 8 +++++++-
 lib/eal/common/eal_common_launch.c | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.33.0

