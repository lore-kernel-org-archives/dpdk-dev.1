Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86264CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Sat, 25 Oct 2025 09:42:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C7434021E;
	Sat, 25 Oct 2025 11:42:51 +0200 (CEST)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by mails.dpdk.org (Postfix) with ESMTP id 9E67F40156
 for <dev@dpdk.org>; Sat, 25 Oct 2025 11:42:49 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=X1PvFdOLRUVdsNKPIZGAO7iop0j+3aa4bOcaz8qbjak=;
 b=yksNx07Z15mBOe6xifLUoI4g1uJZwMFNkJQFwUEPQhGkUra/c1+QOVdtjC5IyuznD4OE9m/jB
 94b1RAaLzHw/9P3zkOvU+dJFdotvT5GlO8EWU4x4QLQugFBQUAawoEBpwXKxtk0ktNo9kpiQdvS
 juq936weQMv5w6VxD9jZs+k=
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4ctvv12vdWz1K97v;
 Sat, 25 Oct 2025 17:42:21 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 13AC41402C4;
 Sat, 25 Oct 2025 17:42:47 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 25 Oct 2025 17:42:46 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: [PATCH 0/2] enhance ethdev telemetry
Date: Sat, 25 Oct 2025 17:42:37 +0800
Message-ID: <20251025094239.4915-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

This patchset contains two commits which enhancing ethdev telemetry.

Chengwen Feng (2):
  ethdev: support telemetry RSS algorithm
  ethdev: support hide zero when telemetry regs

 lib/ethdev/rte_ethdev_telemetry.c | 56 ++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 16 deletions(-)

-- 
2.17.1

