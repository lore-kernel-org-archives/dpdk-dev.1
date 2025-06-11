Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C50C61CE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 08:19:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4076D40655;
	Wed, 11 Jun 2025 10:19:08 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id B3C594060F
 for <dev@dpdk.org>; Wed, 11 Jun 2025 10:19:04 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bHJNm54vqzRk72;
 Wed, 11 Jun 2025 16:14:48 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id DCB0C180B61;
 Wed, 11 Jun 2025 16:19:01 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Jun 2025 16:19:01 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 0/6] net/hns3: VF support multi-TCs
Date: Wed, 11 Jun 2025 16:18:54 +0800
Message-ID: <20250611081900.3658421-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

This patchset adds the VF multi-TCs feature.

Chengwen Feng (6):
  net/hns3: fix VF fail to config queue TC
  net/hns3: remove duplicate struct field
  net/hns3: refactor DCB module code
  net/hns3: VF support parse max TC number
  net/hns3: VF support discover multi-TCs capability
  net/hns3: VF support multi-TCs configure

 drivers/net/hns3/hns3_cmd.c       |   5 +-
 drivers/net/hns3/hns3_cmd.h       |  10 +
 drivers/net/hns3/hns3_dcb.c       | 161 ++++++++++++----
 drivers/net/hns3/hns3_dcb.h       |   4 +
 drivers/net/hns3/hns3_dump.c      |  11 +-
 drivers/net/hns3/hns3_ethdev.c    | 132 ++-----------
 drivers/net/hns3/hns3_ethdev.h    |  12 +-
 drivers/net/hns3/hns3_ethdev_vf.c | 297 ++++++++++++++++++++++++++++--
 drivers/net/hns3/hns3_mbx.h       |  50 ++++-
 drivers/net/hns3/hns3_rss.c       |   8 +-
 drivers/net/hns3/hns3_rxtx.c      |  26 ++-
 drivers/net/hns3/hns3_tm.c        |   6 +-
 12 files changed, 539 insertions(+), 183 deletions(-)

-- 
2.33.0

