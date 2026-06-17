Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5CFCD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 10:31:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4F9A40289;
	Wed, 17 Jun 2026 12:31:07 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 48E0F4027A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 12:31:06 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=bfW63LgLw/QMj9CRJsVDrbl9xRgVvxLwHsOvc+446s8=;
 b=JKFlVXqpN6ADOB0SGx+FS/ovNkxcVwLYm+D7yKwuFWYaEKCz785AW8etbojjlqb8BjsS2R1Y6
 +Yd5aO2fnZt+H69WyII4/vScl8pz75lHM9fRFw5+/d32gNLQDaKdYH6l3h7ZygrDR4Rn8sfT1Fb
 TXS2BgnM1n0GcaqS9InVYMg=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4ggKfX56Ltz12LGK;
 Wed, 17 Jun 2026 18:22:12 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id B3A3840576;
 Wed, 17 Jun 2026 18:31:03 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 18:31:03 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <thomas@monjalon.net>
CC: <mb@smartsharesystems.com>, <andrew.rybchenko@oktetlabs.ru>,
 <dev@dpdk.org>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 0/5] prefix lcore role enum values
Date: Wed, 17 Jun 2026 18:28:29 +0800
Message-ID: <20260617102834.2343356-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo100005.china.huawei.com (7.202.195.212)
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

Add the RTE_LCORE_ prefix to the lcore role enum values in rte_lcore_role_t
to follow DPDK naming conventions.

- ROLE_RTE      -> RTE_LCORE_ROLE_RTE
- ROLE_OFF      -> RTE_LCORE_ROLE_OFF
- ROLE_SERVICE  -> RTE_LCORE_ROLE_SERVICE
- ROLE_NON_EAL  -> RTE_LCORE_ROLE_NON_EAL

Old names are kept as macros aliasing to the new names to preserve
backward compatibility.

Huisong Li (5):
  eal: prefix lcore role enum values
  eal: use new lcore role enum names
  graph: use new lcore role enum names
  net/softnic: use new lcore role enum names
  test: use new lcore role enum names

 app/test/test_lcores.c                       |  2 +-
 app/test/test_mempool.c                      |  2 +-
 drivers/net/softnic/rte_eth_softnic_thread.c |  4 +--
 lib/eal/common/eal_common_lcore.c            | 34 ++++++++++----------
 lib/eal/common/eal_common_options.c          | 28 ++++++++--------
 lib/eal/common/eal_private.h                 |  4 +--
 lib/eal/common/rte_service.c                 | 12 +++----
 lib/eal/include/rte_lcore.h                  | 17 +++++++---
 lib/graph/graph.c                            |  2 +-
 9 files changed, 56 insertions(+), 49 deletions(-)

-- 
2.33.0

