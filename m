Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF420C7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 09:10:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 256E140647;
	Tue,  1 Jul 2025 11:10:09 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 7E94E400D7
 for <dev@dpdk.org>; Tue,  1 Jul 2025 11:10:07 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bWcdJ2PKBz2TSq4;
 Tue,  1 Jul 2025 17:08:20 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 4E8C0140276;
 Tue,  1 Jul 2025 17:10:05 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Jul 2025 17:10:04 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <fengchengwen@huawei.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH v3 0/6] net/hns3: VF support multi-TCs
Date: Tue, 1 Jul 2025 17:09:58 +0800
Message-ID: <20250701091004.531704-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250611081900.3658421-1-huangdengdui@huawei.com>
References: <20250611081900.3658421-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

---
v2:
Use the macros __rte_packed_begin and __rte_packed_end instead of #pragma pack().

v3:
Fix checkpatch warnings: line length of 102 exceeds 100 columns.

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
 drivers/net/hns3/hns3_mbx.h       |  48 ++++-
 drivers/net/hns3/hns3_rss.c       |   8 +-
 drivers/net/hns3/hns3_rxtx.c      |  26 ++-
 drivers/net/hns3/hns3_tm.c        |   6 +-
 12 files changed, 537 insertions(+), 183 deletions(-)

-- 
2.33.0

