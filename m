Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BDCCA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 08:51:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76AD4402C4;
	Wed, 10 Sep 2025 10:51:07 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id C8D3F402E3
 for <dev@dpdk.org>; Wed, 10 Sep 2025 10:51:05 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cMDnG3PPSzRk2j;
 Wed, 10 Sep 2025 16:46:26 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 717F8140259;
 Wed, 10 Sep 2025 16:51:03 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Sep 2025 16:51:02 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>
Subject: [PATCH v3 0/4] add Hisilicon accelerator DMA driver
Date: Wed, 10 Sep 2025 16:50:58 +0800
Message-ID: <20250910085102.3563-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250827092729.10719-1-fengchengwen@huawei.com>
References: <20250827092729.10719-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
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

This patchset adds Hisilicon accelerator DMA driver which based on
UACCE bus.

Chengwen Feng (4):
  dma/acc: add probe and remove
  dma/acc: add control path ops
  dma/acc: add data path ops
  dma/acc: add doc

---
v3: fix remove wrong dmadev by add prefix match.
    use proper errcode when get avail queue fail and dmadev alloc fail.
v2: fix magic number.
    support clean write back field when submit request.

 MAINTAINERS                            |   5 +
 doc/guides/dmadevs/acc.rst             |  63 +++
 doc/guides/dmadevs/index.rst           |   1 +
 doc/guides/rel_notes/release_25_11.rst |   6 +
 drivers/dma/acc/acc_dmadev.c           | 731 +++++++++++++++++++++++++
 drivers/dma/acc/acc_dmadev.h           | 168 ++++++
 drivers/dma/acc/meson.build            |  21 +
 drivers/dma/meson.build                |   1 +
 8 files changed, 996 insertions(+)
 create mode 100644 doc/guides/dmadevs/acc.rst
 create mode 100644 drivers/dma/acc/acc_dmadev.c
 create mode 100644 drivers/dma/acc/acc_dmadev.h
 create mode 100644 drivers/dma/acc/meson.build

-- 
2.17.1

