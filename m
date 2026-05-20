Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E99CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 03:57:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDB1340672;
	Wed, 20 May 2026 05:56:54 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 54559402B0
 for <dev@dpdk.org>; Wed, 20 May 2026 05:56:50 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=v0295xqsEtMtiNH+q3OGxigiLhoHQ55nsjWgUTy0EPk=;
 b=tVfgVGhFKPLSGUIc6oFyilG/rA1zJ757qRETv/S9pobDjsUJ0PrfmDwds/A9v/CYexQ7tugm9
 0aD3wgddwlLWXmH35naTUGhxA+umrN482sQyCnQYGVfpGQKV8q8zi2rujJouxFVsuTf3LtG6peI
 LBSzVDrxwX4QmoF1/aJwNeI=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gKyG23JpqzcbSY;
 Wed, 20 May 2026 11:49:14 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 0213240538;
 Wed, 20 May 2026 11:56:48 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 May 2026 11:56:47 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: [PATCH 0/2] enhance telemetry list endpoint with device name
Date: Wed, 20 May 2026 11:56:39 +0800
Message-ID: <20260520035641.50555-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
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

Currently, the /dmadev/list and /ethdev/list telemetry endpoints return
only integer IDs, making it hard to identify devices. This series changes
both to output strings in "ID    NAME" format for better usability.

Chengwen Feng (2):
  dmadev: include device name in telemetry list output
  ethdev: include device name in telemetry list output

 lib/dmadev/rte_dmadev.c           | 17 ++++++++++++-----
 lib/ethdev/rte_ethdev_telemetry.c | 12 +++++++++---
 2 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.17.1
