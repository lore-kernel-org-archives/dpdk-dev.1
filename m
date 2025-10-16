Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695EFCCD185
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 02:53:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0486840A75;
	Thu, 16 Oct 2025 04:53:28 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id C890740269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 04:53:26 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=JbTE0Bkf7uAJWmxuyz9kLRWGmKUdxVDBURfK2yeorbk=;
 b=N7N/5nHR6VtSIJi7GX24aV0JqLPrNNu7/Swg5qpUTOJ/TF9K2znuppnANgpYIAOja/gcVxyvW
 BJ0Np+knkVftI5PcVIPhrRqhQVOc6oEeqV/k/GEWZ63WUHECzGigORlPCXKxHltaazhmKv+TxSx
 grNNI1bZ2/eXlLCiYUQ2Uwg=
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cnCDw2ZchzKm5G;
 Thu, 16 Oct 2025 10:53:04 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 011121A016C;
 Thu, 16 Oct 2025 10:53:25 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 10:53:24 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>
Subject: [PATCH v6 0/4] add Hisilicon accelerator DMA driver
Date: Thu, 16 Oct 2025 10:53:14 +0800
Message-ID: <20251016025318.14333-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250827092729.10719-1-fengchengwen@huawei.com>
References: <20250827092729.10719-1-fengchengwen@huawei.com>
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

This patchset adds Hisilicon accelerator DMA driver which based on
UACCE bus.

Chengwen Feng (4):
  dma/hisi_acc: add probe and remove
  dma/hisi_acc: add control path ops
  dma/hisi_acc: add data path ops
  dma/hisi_acc: add doc

---
v6: update rst file to reflect this driver correspond accelerator
    subsystem.
v5: rename driver name to hisi_acc.
v4: start/stop support detect sq/cq-status.
    add wait requests complete in stop.
v3: fix remove wrong dmadev by add prefix match.
    use proper errcode when get avail queue fail and dmadev alloc fail.
v2: fix magic number.
    support clean write back field when submit request.

 MAINTAINERS                            |   5 +
 doc/guides/dmadevs/hisi_acc.rst        |  62 ++
 doc/guides/dmadevs/index.rst           |   1 +
 doc/guides/rel_notes/release_25_11.rst |   6 +
 drivers/dma/hisi_acc/hisi_acc_dmadev.c | 774 +++++++++++++++++++++++++
 drivers/dma/hisi_acc/hisi_acc_dmadev.h | 169 ++++++
 drivers/dma/hisi_acc/meson.build       |  21 +
 drivers/dma/meson.build                |   1 +
 8 files changed, 1039 insertions(+)
 create mode 100644 doc/guides/dmadevs/hisi_acc.rst
 create mode 100644 drivers/dma/hisi_acc/hisi_acc_dmadev.c
 create mode 100644 drivers/dma/hisi_acc/hisi_acc_dmadev.h
 create mode 100644 drivers/dma/hisi_acc/meson.build

-- 
2.17.1

