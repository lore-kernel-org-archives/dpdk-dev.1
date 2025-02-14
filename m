Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A5BC021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 02:09:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59715402AD;
	Fri, 14 Feb 2025 03:09:01 +0100 (CET)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id D4C57402AD
 for <dev@dpdk.org>; Fri, 14 Feb 2025 03:08:59 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YvFkF3LHPz2FctR;
 Fri, 14 Feb 2025 10:05:09 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
 by mail.maildlp.com (Postfix) with ESMTPS id 6AF7F1402C3;
 Fri, 14 Feb 2025 10:08:57 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Feb 2025 10:08:56 +0800
From: Jie Hai <haijie1@huawei.com>
To: <dev@dpdk.org>, <thomas@monjalon.net>, <ferruh.yigit@amd.com>,
 <aman.deep.singh@intel.com>
CC: <lihuisong@huawei.com>, <fengchengwen@huawei.com>, <haijie1@huawei.com>,
 <huangdengdui@huawei.com>
Subject: [PATCH v3 0/2] app/testpmd: add ipv6 extension header parse
Date: Fri, 14 Feb 2025 09:56:36 +0800
Message-ID: <20250214015638.29983-1-haijie1@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20250108024632.12152-1-haijie1@huawei.com>
References: <20250108024632.12152-1-haijie1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.28.79.22]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500004.china.huawei.com (7.202.181.242)
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

This patch support parse ipv6 extension header, and
support TSO for ipv6tcp packets with extension header.

Jie Hai (2):
  net: add ptype parse for tunnel packets
  app/test-pmd: use ptype API parse packets

 app/test-pmd/csumonly.c | 522 ++++++++++------------------------------
 lib/net/rte_net.c       | 110 ++++++++-
 2 files changed, 230 insertions(+), 402 deletions(-)

-- 
2.22.0

