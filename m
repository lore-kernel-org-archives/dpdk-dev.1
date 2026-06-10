Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548D2CD98C7
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 09:12:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A04540270;
	Wed, 10 Jun 2026 11:12:01 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 1F8AE4026D
 for <dev@dpdk.org>; Wed, 10 Jun 2026 11:11:59 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gb0Qf6bmhzHnGk1
 for <dev@dpdk.org>; Wed, 10 Jun 2026 17:11:54 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 14AC24058B
 for <dev@dpdk.org>; Wed, 10 Jun 2026 17:11:59 +0800 (CST)
Received: from localhost (10.220.239.45) by frapema500004.china.huawei.com
 (7.182.19.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 10 Jun
 2026 11:11:58 +0200
From: Eimear Morrissey <eimear.morrissey@huawei.com>
To: <dev@dpdk.org>
Subject: [PATCH 0/2] Pflock downgrade & stress tests for pflock/rwlock
 libraries
Date: Wed, 10 Jun 2026 10:11:45 +0100
Message-ID: <20260610091147.88412-1-eimear.morrissey@huawei.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100007.china.huawei.com (7.182.19.38) To
 frapema500004.china.huawei.com (7.182.19.21)
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

Add new downgrade option for pflock. Add stress tests for this &
by extension the rest of the pflock/rwlock libraries.

Eimear Morrissey (1):
  app/test: add stress tests for rwlock and pflock

Konstantin Ananyev (1):
  eal/pflock: add API to downgrade from wr to rd lock

 app/test/meson.build               |   2 +
 app/test/test_pflock_stress.c      |  76 ++++++
 app/test/test_rwlock_stress.c      |  59 +++++
 app/test/test_rwlock_stress_impl.h | 393 +++++++++++++++++++++++++++++
 lib/eal/include/rte_pflock.h       |  21 ++
 5 files changed, 551 insertions(+)
 create mode 100644 app/test/test_pflock_stress.c
 create mode 100644 app/test/test_rwlock_stress.c
 create mode 100644 app/test/test_rwlock_stress_impl.h

-- 
2.51.0

