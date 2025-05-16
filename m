Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF284C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 09:28:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC79E402F0;
	Fri, 16 May 2025 11:28:47 +0200 (CEST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mails.dpdk.org (Postfix) with ESMTP id 85B86402B3
 for <dev@dpdk.org>; Fri, 16 May 2025 11:28:44 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZzMF66pvhzsSh0;
 Fri, 16 May 2025 17:27:54 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 91350140109;
 Fri, 16 May 2025 17:28:41 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 May 2025 17:28:41 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>
Subject: [PATCH v3 0/4] bugfix about parse tunnel packet with UDP
Date: Fri, 16 May 2025 17:28:36 +0800
Message-ID: <20250516092840.2061252-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250417123739.2291519-1-huangdengdui@huawei.com>
References: <20250417123739.2291519-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Currently, there are some issues with testpmd and get ptype API in parsing tunnel packets,
and this patchset is fix it.

Dengdui Huang (4):
  net: fix GTP packet parsing
  net: fix parse the tunnel length of tunnel packet with UDP
  net: fix GENEVE packet parsing
  app/testpmd: fix obtain inner info of tunnel packet

 app/test-pmd/csumonly.c |  6 +++---
 lib/net/rte_net.c       | 14 ++++++++++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.33.0

