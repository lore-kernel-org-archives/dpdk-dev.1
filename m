Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF341CAC598
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 03:34:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA98F402DE;
	Wed, 17 Sep 2025 05:34:01 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id C085B4027A
 for <dev@dpdk.org>; Wed, 17 Sep 2025 05:33:59 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cRPW91pV7z14MZj;
 Wed, 17 Sep 2025 11:33:41 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 8678C180064;
 Wed, 17 Sep 2025 11:33:57 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Sep 2025 11:33:57 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <vattunuru@marvell.com>
Subject: [PATCH v2 00/10] bugfix and refactor of dma-perf
Date: Wed, 17 Sep 2025 11:33:46 +0800
Message-ID: <20250917033356.13358-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250811105430.55791-1-fengchengwen@huawei.com>
References: <20250811105430.55791-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
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

This patchset contain one bugfix and refactor commits for
test-dma-perf application.

Chengwen Feng (10):
  app/dma-perf: fix use-after-free
  app/dma-perf: add global section for config file
  app/dma-perf: use argparse lib to parse argument
  app/dma-perf: refactor output csv
  app/dma-perf: support list DMA devices
  app/dma-perf: add more global config
  app/dma-perf: remove invalid or redundant field
  app/dma-perf: refactor load config function
  app/dma-perf: refactor benchmark function
  app/dma-perf: support specific error info

---
v2: fix global argv[0] not prog name.
    friendly remide if there are no dmadev when list-dma.
    add ack from Vamsi Attunuru.

 app/test-dma-perf/benchmark.c | 182 ++++++-----
 app/test-dma-perf/config.ini  |  35 +-
 app/test-dma-perf/main.c      | 581 ++++++++++++++++++----------------
 app/test-dma-perf/main.h      |  28 +-
 app/test-dma-perf/meson.build |   2 +-
 doc/guides/tools/dmaperf.rst  |  50 +--
 6 files changed, 470 insertions(+), 408 deletions(-)

-- 
2.17.1

