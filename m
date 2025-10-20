Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43EFCCD193
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 04:11:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E974340E5A;
	Mon, 20 Oct 2025 06:11:15 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 16661400D5
 for <dev@dpdk.org>; Mon, 20 Oct 2025 06:11:13 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=oi+0snYJE3t3LFBaAmeBp42sYpD6oxCO3M+3wXqW3mQ=;
 b=rJDN+ZjNsvrf1kmQxPPeRY398rAdjy11gw9CBDpheudxqU9FYjuL4j4cttguLnapiL8NHpadg
 4OQ7tBHLGlmEqcEjCWQiLNL8JE/zIMruQamkAqYxCnUzwhJ+Bwp02RJ+deZgvSFVSBI6F9GCvBW
 bCHHLp5Sy+AlTgovmcxxND0=
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cqhmm4l2VzLlVc;
 Mon, 20 Oct 2025 12:10:48 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id DBF4D1A0188;
 Mon, 20 Oct 2025 12:11:11 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 12:11:11 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <vattunuru@marvell.com>
Subject: [PATCH v4 00/14] bugfix and refactor of dma-perf
Date: Mon, 20 Oct 2025 12:10:51 +0800
Message-ID: <20251020041105.1590-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250811105430.55791-1-fengchengwen@huawei.com>
References: <20250811105430.55791-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

Chengwen Feng (14):
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
  app/dma-perf: fix segment fault with large size
  app/dma-perf: fix on-flight DMA when verify data
  app/dma-perf: fix wrong stage to stop dmadev
  app/dma-perf: refactor benchmark function

---
v4: rebase to latest upstream.
    add one more refactor commit.
v3: add min/max desc when list DMA devices
    add three bugfix commit (11~13) that recently found
v2: fix global argv[0] not prog name.
    friendly remide if there are no dmadev when list-dma.
    add ack from Vamsi Attunuru.

 app/test-dma-perf/benchmark.c | 479 ++++++++++++++++-----------
 app/test-dma-perf/config.ini  |  36 +--
 app/test-dma-perf/main.c      | 594 ++++++++++++++++++----------------
 app/test-dma-perf/main.h      |  28 +-
 app/test-dma-perf/meson.build |   2 +-
 doc/guides/tools/dmaperf.rst  |  57 ++--
 6 files changed, 671 insertions(+), 525 deletions(-)

-- 
2.17.1

