Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3DDCFD376
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 03:42:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C192F40A71;
	Tue, 25 Nov 2025 04:42:13 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id E0EFB40678
 for <dev@dpdk.org>; Tue, 25 Nov 2025 04:42:12 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=EMB3QsJCL4pMf9tS4+oTJ3TyKsstV+085IjOSSelClo=;
 b=IUCuCkE1wVjTfe5o1wDL9im/kw27t0a/mOQq9Zw4LKblVqBRSyCK7sZz1J/apfPWQf1Tdncxr
 NAMK+/t/c+ntQkQsA6LjNlxDqwvNHqreZic+/C3HqQoecnmFprolIYUUQHqBUe1oamT0iVL4A27
 YpUcmY7uCKhOj12OCAW35fQ=
Received: from canpmsgout08.his.huawei.com (unknown [172.19.92.156])
 by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dFpQF5bBcz1BGJ2
 for <dev@dpdk.org>; Tue, 25 Nov 2025 11:41:25 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=EMB3QsJCL4pMf9tS4+oTJ3TyKsstV+085IjOSSelClo=;
 b=IUCuCkE1wVjTfe5o1wDL9im/kw27t0a/mOQq9Zw4LKblVqBRSyCK7sZz1J/apfPWQf1Tdncxr
 NAMK+/t/c+ntQkQsA6LjNlxDqwvNHqreZic+/C3HqQoecnmFprolIYUUQHqBUe1oamT0iVL4A27
 YpUcmY7uCKhOj12OCAW35fQ=
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dFpNw16vGzmV7Y;
 Tue, 25 Nov 2025 11:40:16 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 72D01140279;
 Tue, 25 Nov 2025 11:42:03 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Nov 2025 11:42:03 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: [PATCH 0/2] add two enhance for DCB
Date: Tue, 25 Nov 2025 11:41:56 +0800
Message-ID: <20251125034158.55192-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

The 25.11 version add two "set dcb fwd_xxx" command which enhance
DCB test. This patchset add two enhance for this serial.

Chengwen Feng (2):
  app/testpmd: support multi-cores process one TC help
  app/testpmd: support show DCB config

 app/test-pmd/cmdline.c                      | 25 ++++++++++++++++++---
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  4 +++-
 2 files changed, 25 insertions(+), 4 deletions(-)

-- 
2.17.1

