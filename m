Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D77BCD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 09:38:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 561FE402EB;
	Wed, 20 May 2026 11:38:12 +0200 (CEST)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id 9197440276
 for <dev@dpdk.org>; Wed, 20 May 2026 11:38:11 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=hJwhlt/I7gUpIhNjg7MUD7xhAJ8bLd0loryR+tOjp1Q=;
 b=GjjTdZQKiOxjxut4DSxDkQxYs0j45UM1s4aRb0UcV+UwtR7LuY0LpQUFNZOeo976yPqQJDRWB
 YM5UmtY0961VotliIDelemPMoq9PTIdHDGk+0tkirKlHeKPMACoAZ6l6MRsXY/FeSkPZWaLCtMp
 POIl3EqenuLwK9WWlJ8HC1M=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gL5qn1z89z1cyPF;
 Wed, 20 May 2026 17:30:29 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 6896E4056E;
 Wed, 20 May 2026 17:38:09 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 May 2026 17:38:08 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <andrew.rybchenko@oktetlabs.ru>,
 <bruce.richardson@intel.com>, <mb@smartsharesystems.com>
Subject: [PATCH v2 0/2] Add list names telemetry endpoint
Date: Wed, 20 May 2026 17:38:02 +0800
Message-ID: <20260520093804.29102-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260520035641.50555-1-fengchengwen@huawei.com>
References: <20260520035641.50555-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
only integer IDs, making it hard to identify devices. This series add
list_names telemetry endpoint which output both IDs and its device's
name.

---
v2: Add new telemetry endpoint according Bruce's advise.

Chengwen Feng (2):
  dmadev: add telemetry endpoint for list names
  ethdev: add telemetry endpoint for list names

 lib/dmadev/rte_dmadev.c           | 23 +++++++++++++++++++++++
 lib/ethdev/rte_ethdev_telemetry.c | 21 +++++++++++++++++++++
 2 files changed, 44 insertions(+)

-- 
2.17.1

