Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703BBC87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:54:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5527406B7;
	Mon, 11 Aug 2025 12:54:34 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 2D8E24042E
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:54:33 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c0s1l0mRfztTBn;
 Mon, 11 Aug 2025 18:53:31 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 9FEDC18007F;
 Mon, 11 Aug 2025 18:54:31 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 18:54:31 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>
Subject: [PATCH 0/9] bugfix and refactor of dma-perf
Date: Mon, 11 Aug 2025 18:54:21 +0800
Message-ID: <20250811105430.55791-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

This patchset contain one bugfix and eight refactor commit for
test-dma-perf application.

Chengwen Feng (9):
  app/dma-perf: fix use-after-free
  app/dma-perf: add global section for config file
  app/dma-perf: use argparse lib to parse argument
  app/dma-perf: refactor output csv
  app/dma-perf: support list DMA devices
  app/dma-perf: add more global config
  app/dma-perf: remove invalid or redundant field
  app/dma-perf: refactor load config function
  app/dma-perf: refactor benchmark function

 app/test-dma-perf/benchmark.c | 182 +++++------
 app/test-dma-perf/config.ini  |  33 +-
 app/test-dma-perf/main.c      | 549 +++++++++++++++++++---------------
 app/test-dma-perf/main.h      |  28 +-
 app/test-dma-perf/meson.build |   2 +-
 doc/guides/tools/dmaperf.rst  |  47 +--
 6 files changed, 454 insertions(+), 387 deletions(-)

-- 
2.17.1

