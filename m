Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1295EC3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 08:31:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 532C740ED4;
	Tue,  8 Apr 2025 10:31:08 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 85BE540E5E
 for <dev@dpdk.org>; Tue,  8 Apr 2025 10:31:04 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZWzhj1lCQzCs7J;
 Tue,  8 Apr 2025 16:27:17 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id DD23A180104;
 Tue,  8 Apr 2025 16:31:01 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 16:31:01 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <haijie1@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 0/7] net/hns3: bugfix for hns3
Date: Tue, 8 Apr 2025 16:30:53 +0800
Message-ID: <20250408083100.2845040-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
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

This patchset fixes some bugs.

Dengdui Huang (7):
  net/hns3: fix variable overflow
  net/hns3: fix memory leakage in failure path
  net/hns3: fix extra waiting for link up
  net/hns3: fix memory leakage for indirect action
  net/hns3: fix incorrect failed rollback
  net/hns3: fix divide by zero
  net/hns3: fix unrelease some resources on reset case

 drivers/net/hns3/hns3_common.c |  4 +--
 drivers/net/hns3/hns3_ethdev.c | 45 ++++++++++++++++++++++------------
 drivers/net/hns3/hns3_flow.c   | 41 ++++++++++++++-----------------
 drivers/net/hns3/hns3_flow.h   |  9 +++++--
 drivers/net/hns3/hns3_regs.c   |  5 ++--
 5 files changed, 60 insertions(+), 44 deletions(-)

-- 
2.33.0

