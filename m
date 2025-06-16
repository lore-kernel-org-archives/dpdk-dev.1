Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92037C71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 08:27:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F0144067B;
	Mon, 16 Jun 2025 10:27:23 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 564F140662
 for <dev@dpdk.org>; Mon, 16 Jun 2025 10:27:13 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bLNPD4KFLztSbn;
 Mon, 16 Jun 2025 16:25:52 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 4BAD0180B34;
 Mon, 16 Jun 2025 16:27:03 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Jun 2025 16:27:02 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <thomas@monjalon.net>, <jasvinder.singh@intel.com>,
 <stephen@networkplumber.org>, <aman.deep.singh@intel.com>,
 <lihuisong@huawei.com>, <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 0/2] fix parse tunnel packet ptyoe
Date: Mon, 16 Jun 2025 16:27:00 +0800
Message-ID: <20250616082702.3422034-1-huangdengdui@huawei.com>
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

Dengdui Huang (2):
  net: fix parse the tunnel length of tunnel with UDP
  app/testpmd: fix obtain inner info of tunnel packet

 app/test-pmd/csumonly.c | 6 +++---
 lib/net/rte_net.c       | 4 ++++
 lib/net/rte_net.h       | 2 ++
 3 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.33.0

