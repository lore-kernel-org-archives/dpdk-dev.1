Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D38CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 07:36:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FA84400D6;
	Mon, 10 Nov 2025 08:36:20 +0100 (CET)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id C1F2B40264
 for <dev@dpdk.org>; Mon, 10 Nov 2025 08:36:18 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=JiLmLTLaBxvHghTBuidRszAfLRKqv4PQZptamtDI21s=;
 b=4+XD+oZ7skXZaKjzmJvObgCXTUQf6Cjl+CCQ2EiennVxrTaY+ja0toTeMh2dtHRQQzx57c88e
 ZjuDdVPlff17/bmkS5YCWZumdttFkHMc9OxADb55FEmkSTMopPvwU6ieZV5v8EzTH1sCZSm2cSx
 cetF4Tj/05+T++CDyNMBDIY=
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d4hJ64c8Pzcb0X;
 Mon, 10 Nov 2025 15:34:30 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 50220180494;
 Mon, 10 Nov 2025 15:36:16 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 15:36:15 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <liuyonglong@huawei.com>,
 <yangxingui@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v5 0/2] two enhance for testpmd DCB test
Date: Mon, 10 Nov 2025 15:36:08 +0800
Message-ID: <20251110073610.14020-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251104040916.25864-1-fengchengwen@huawei.com>
References: <20251104040916.25864-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

This patchset contains two enhancement for testpmd DCB test.

Chengwen Feng (2):
  app/testpmd: support specify TCs when DCB forward
  app/testpmd: support multi-cores process one TC

---
Depends-on: series-2682 ("two bugfix for testpmd DCB")
---
v5: optimize naming and add line breaks for first commit.
    add second commit "support multi-cores process one TC".
v4: use direct assign of dcb-info according comment from Stephen.
    fix CI llvm compiler error.
v3: use new way to impl and fix comment from Stephen.
v2: introduce pause/resume lcore's forwarding.

 app/test-pmd/cmdline.c                      | 105 ++++++++++++++++
 app/test-pmd/config.c                       | 132 +++++++++++++++++---
 app/test-pmd/testpmd.c                      |  15 +++
 app/test-pmd/testpmd.h                      |   4 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  16 +++
 5 files changed, 254 insertions(+), 18 deletions(-)

-- 
2.17.1

