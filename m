Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE44CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 09:27:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 241A340666;
	Wed, 27 Aug 2025 11:27:38 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 465E4402EA
 for <dev@dpdk.org>; Wed, 27 Aug 2025 11:27:33 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cBfHh73cFz24hy0;
 Wed, 27 Aug 2025 17:24:32 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 87535140109;
 Wed, 27 Aug 2025 17:27:30 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 17:27:30 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <liuyonglong@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH 0/4] add Hisilicon accelerator DMA driver
Date: Wed, 27 Aug 2025 17:27:25 +0800
Message-ID: <20250827092729.10719-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

This patchset adds Hisilicon accelerator DMA driver which based on
UACCE bus.

Chengwen Feng (4):
  dma/acc: add probe and remove
  dma/acc: add control path ops
  dma/acc: add data path ops
  dma/acc: add doc

 MAINTAINERS                            |   5 +
 doc/guides/dmadevs/acc.rst             |  63 +++
 doc/guides/dmadevs/index.rst           |   1 +
 doc/guides/rel_notes/release_25_11.rst |   6 +
 drivers/dma/acc/acc_dmadev.c           | 721 +++++++++++++++++++++++++
 drivers/dma/acc/acc_dmadev.h           | 156 ++++++
 drivers/dma/acc/meson.build            |  21 +
 drivers/dma/meson.build                |   1 +
 8 files changed, 974 insertions(+)
 create mode 100644 doc/guides/dmadevs/acc.rst
 create mode 100644 drivers/dma/acc/acc_dmadev.c
 create mode 100644 drivers/dma/acc/acc_dmadev.h
 create mode 100644 drivers/dma/acc/meson.build

-- 
2.17.1

