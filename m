Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A132C28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 12:25:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AB6A40615;
	Wed,  2 Apr 2025 14:25:04 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 57A9140275
 for <dev@dpdk.org>; Wed,  2 Apr 2025 14:25:00 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZSP9q5PLwz2CdVY;
 Wed,  2 Apr 2025 20:21:35 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id D8C6E18005F;
 Wed,  2 Apr 2025 20:24:55 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 20:24:55 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, <lihuisong@huawei.com>, <haijie1@huawei.com>,
 <liuyonglong@huawei.com>, <roretzla@linux.microsoft.com>,
 <dmitry.kozliuk@gmail.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>, <mb@smartsharesystems.com>
Subject: [PATCH v3 0/3] fix the problem of dma-perf infinite loop
Date: Wed, 2 Apr 2025 20:24:51 +0800
Message-ID: <20250402122454.2148612-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250321040316.104126-1-huangdengdui@huawei.com>
References: <20250321040316.104126-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

This patchset fix it by adding lcore ID checks and pipe checks.

Dengdui Huang (3):
  eal: fix uncheck lcore ID
  eal: fix unckeck pipe
  app/dma-perf: fix infinite loop

 app/test-dma-perf/main.c           | 8 +++++++-
 lib/eal/common/eal_common_launch.c | 9 +++++++++
 lib/eal/unix/eal_unix_thread.c     | 3 +++
 lib/eal/windows/eal_thread.c       | 3 +++
 4 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.33.0

