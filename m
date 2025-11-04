Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6778CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 04:09:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCCFA40430;
	Tue,  4 Nov 2025 05:09:27 +0100 (CET)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id 19F4A402B1
 for <dev@dpdk.org>; Tue,  4 Nov 2025 05:09:25 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=g7TBw2SNLrHfkr61ILx3ual9TB8uT1STkXNUNc6Aftk=;
 b=akEcjpUKkRIlRSgbQpa4A/h5KktnDqRzTPfqUKOTMffcqk3b8iEVzz1Iu2fv3ybSGlZMbWZ9t
 HPtdyMHoXQ+FZh3TmSczWbPOwDidoX7QMXwQHDG+2zwtEdet4XAwf17kIXN9y4uuBIjt4rQw2S4
 rq0eaM5yi2cnAQUfWrbKcnc=
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d0w0N1Njtz1cyPb;
 Tue,  4 Nov 2025 12:07:48 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 056DB180043;
 Tue,  4 Nov 2025 12:09:23 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 12:09:22 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <liuyonglong@huawei.com>,
 <yangxingui@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 0/3] testpmd support stop specify lcore
Date: Tue, 4 Nov 2025 12:09:13 +0800
Message-ID: <20251104040916.25864-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

This patch support stop specify lcore for testpmd, and also include
two bugfix which found when test DCB function.

Chengwen Feng (3):
  app/testpmd: fix invalid txp when setup DCB forward
  app/testpmd: fix wrong Rx queues when setup DCB forward
  app/testpmd: support stop specify lcore

 app/test-pmd/cmdline.c                      | 63 +++++++++++++++++++++
 app/test-pmd/config.c                       |  9 +--
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  7 +++
 3 files changed, 73 insertions(+), 6 deletions(-)

-- 
2.17.1

