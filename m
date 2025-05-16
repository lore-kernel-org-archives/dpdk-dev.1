Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD93C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 07:15:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B9AB400EF;
	Fri, 16 May 2025 09:15:23 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 644AC40041
 for <dev@dpdk.org>; Fri, 16 May 2025 09:15:22 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZzJGR3LnLzxWtF;
 Fri, 16 May 2025 15:13:51 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 23323140202;
 Fri, 16 May 2025 15:15:20 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 May 2025 15:15:19 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <stephen@networkplumber.org>
Subject: [PATCH v5 0/2] bugfix about KEEP CRC offload
Date: Fri, 16 May 2025 15:15:17 +0800
Message-ID: <20250516071519.3190805-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241127100807.683461-1-haijie1@huawei.com>
References: <20241127100807.683461-1-haijie1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

This patchset fixes two bugs related to the keep_crc feature in hns3.

Additionally, as previously discussed, the pkt_len field in mbuf does
not include the length of the CRC data, which is also consistent with
the behavior of most drivers.

Dengdui Huang (2):
  net/hns3: fix cannot look the CRC data
  net/hns3: fix Rx packet without CRC data

 drivers/net/hns3/hns3_ethdev.c        |   2 +
 drivers/net/hns3/hns3_ethdev.h        |  23 +++++
 drivers/net/hns3/hns3_rxtx.c          | 140 ++++++++++++++++++++------
 drivers/net/hns3/hns3_rxtx.h          |   6 ++
 drivers/net/hns3/hns3_rxtx_vec.c      |   3 +-
 drivers/net/hns3/hns3_rxtx_vec_neon.h |  19 ----
 drivers/net/hns3/hns3_rxtx_vec_sve.c  |   3 +-
 7 files changed, 145 insertions(+), 51 deletions(-)

-- 
2.33.0

