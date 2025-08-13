Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8912CCA0EC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 07:33:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E8CA406BA;
	Wed, 13 Aug 2025 09:33:23 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id AEB77402AC
 for <dev@dpdk.org>; Wed, 13 Aug 2025 09:33:20 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c20N26bk0z14MVj;
 Wed, 13 Aug 2025 15:28:18 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 46C71180B54;
 Wed, 13 Aug 2025 15:33:18 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 15:33:17 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 0/3] net/hns3: bugfix for hns3
Date: Wed, 13 Aug 2025 15:33:14 +0800
Message-ID: <20250813073317.1352274-1-huangdengdui@huawei.com>
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

This patchset fixes some bugs.

Chengwen Feng (1):
  net/hns3: fix overwrite mbuf in vector path

Dengdui Huang (2):
  net/hns3: fix inconsistent lock
  net/hns3: fix unrelease VLAN resource when init fail

 drivers/net/hns3/hns3_ethdev.c   | 31 +++++++++++------
 drivers/net/hns3/hns3_ethdev.h   |  1 -
 drivers/net/hns3/hns3_fdir.c     | 13 --------
 drivers/net/hns3/hns3_flow.c     | 57 ++++++++++++--------------------
 drivers/net/hns3/hns3_rxtx_vec.h |  4 +++
 5 files changed, 46 insertions(+), 60 deletions(-)

-- 
2.33.0

