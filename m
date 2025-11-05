Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D63CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 09:47:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3521640684;
	Wed,  5 Nov 2025 10:47:58 +0100 (CET)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id B43BB400D7
 for <dev@dpdk.org>; Wed,  5 Nov 2025 10:47:56 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=tj190dN0JajfWWQJ0u19t43F9LbPu3UBt8zzbk6MUwI=;
 b=hJ2J5gbw2LHKgNZOYgWmEtZerLSjDLgZE4sZ49HRZyeiCjtjDDZOrDUc/Ld4IcyoqSFwnkQD+
 7S7SJLy9cLMkWRtIz/PP3KY+rmluG9WrSfyZJMNKvhnBVdNvclyCTgiRJQTqdtzxxMzgx9AbPjl
 KQgd98BIRzGQGtBdTkK7XUw=
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d1gSV6TgLzKm4R;
 Wed,  5 Nov 2025 17:46:18 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B8A651A016C;
 Wed,  5 Nov 2025 17:47:54 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 17:47:54 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <liuyonglong@huawei.com>,
 <yangxingui@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 0/3] testpmd support pause/resume specify lcore's fwd
Date: Wed, 5 Nov 2025 17:47:45 +0800
Message-ID: <20251105094748.3269-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251104040916.25864-1-fengchengwen@huawei.com>
References: <20251104040916.25864-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

This patch support pause/resume specify lcore's forwarding for testpmd,
and also include two bugfix which found when test DCB function.

Chengwen Feng (3):
  app/testpmd: fix invalid txp when setup DCB forward
  app/testpmd: fix wrong Rx queues when setup DCB forward
  app/testpmd: support pause/resume specify lcore

 app/test-pmd/cmdline.c                      | 126 ++++++++++++++++++++
 app/test-pmd/config.c                       |   9 +-
 app/test-pmd/testpmd.c                      |   5 +
 app/test-pmd/testpmd.h                      |   2 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  14 +++
 5 files changed, 149 insertions(+), 7 deletions(-)

-- 
2.17.1

