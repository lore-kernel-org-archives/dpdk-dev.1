Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3A606A323
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=bSDQGVtp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1044740374;
	Wed, 25 Nov 2026 15:06:29 +0100 (CET)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTPS id 0953A4027A
 for <dev@dpdk.org>; Wed, 25 Nov 2026 15:06:26 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=crzSkhi/gjFqfviLWXNQChvoFocfYF8wJviuXjOVVjs=;
 b=bSDQGVtp62qr37k6Ya+XZl/r4eT2DxZF1/QqzjXOWo+wDOe6+Rj0YQQFDf47kyvo3jQlOSTD0
 yyL3v0DUOInnPjYY3/jstAb1w/AlD9Iteb/I2Bkb/1Gpu/CDFAAOS5+eIU2GvNBz7kf8CFFpuZp
 uJXnhKXuN0QvuZh8J7DGq3Y=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jZM0X1Pqwz1prPV
 for <dev@dpdk.org>; Wed, 25 Nov 2026 22:06:04 +0800 (CST)
Received: from dggpemr100003.china.huawei.com (unknown [7.185.36.150])
 by mail.maildlp.com (Postfix) with ESMTPS id 5E2754056E
 for <dev@dpdk.org>; Wed, 25 Nov 2026 22:06:21 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemr100003.china.huawei.com (7.185.36.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 22:06:20 +0800
From: Shuaisong Yang <yangshuaisong@h-partners.com>
To: 
CC: <dev@dpdk.org>, <yangshuaisong@h-partners.com>, <liuyonglong@huawei.com>, 
 <fengchengwen@huawei.com>, <yangxingui@h-partners.com>,
 <yangxingui@huawei.com>
Subject: [PATCH 0/9] support uncore power management on Hisilicon platforms
Date: Wed, 25 Nov 2026 22:06:06 +0800
Message-ID: <20261125140616.3965843-1-yangshuaisong@h-partners.com>
X-Mailer: git-send-email 2.33.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemr100003.china.huawei.com (7.185.36.150)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series reworks the uncore frequency handling of the l3fwd-power
sample and extends the power library with a Hisilicon uncore driver
and uncore frequency telemetry.

The first six patches restructure the power management code of
l3fwd-power: the uncore and cpufreq/QoS setup and cleanup paths are
extracted into dedicated helpers, the failure paths now roll back
the steps already taken, and the sample can set the frequency of a
specific package/die instead of applying the change to all of them.

The last three patches extend the power library:

- a detect callback is added to the uncore driver ops, letting a
  driver report by itself whether it can manage the platform;
- a new Hisilicon uncore driver is added on top of the devfreq
  sysfs interface of those platforms;
- the current uncore frequency is exposed through telemetry.

Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>

Huisong Li (9):
  examples/l3fwd-power: extract function to deinit uncore
  examples/l3fwd-power: extract functions for cpufreq library
  examples/l3fwd-power: extract functions for power QoS
  examples/l3fwd-power: add rollback in uncore init
  examples/l3fwd-power: add rollback and best-effort deinit
  examples/l3fwd-power: set freq for specific uncore
  power: add detect callback for uncore driver
  power/hisi_uncore: support Hisilicon uncore driver
  power: add uncore frequency telemetry

 MAINTAINERS                                   |   4 +
 doc/guides/prog_guide/power_man.rst           |  38 +
 doc/guides/rel_notes/release_26_11.rst        |  11 +
 .../sample_app_ug/l3_forward_power_man.rst    |  13 +
 drivers/power/hisi_uncore/hisi_uncore.c       | 693 ++++++++++++++++++
 drivers/power/hisi_uncore/hisi_uncore.h       |  39 +
 drivers/power/hisi_uncore/meson.build         |  17 +
 drivers/power/meson.build                     |   1 +
 examples/l3fwd-power/main.c                   | 567 ++++++++++----
 lib/power/meson.build                         |   3 +-
 lib/power/power_uncore_ops.h                  |  17 +
 lib/power/rte_power_telemetry.c               | 129 ++++
 lib/power/rte_power_uncore.c                  |  14 +-
 lib/power/rte_power_uncore.h                  |   3 +-
 14 files changed, 1401 insertions(+), 148 deletions(-)
 create mode 100644 drivers/power/hisi_uncore/hisi_uncore.c
 create mode 100644 drivers/power/hisi_uncore/hisi_uncore.h
 create mode 100644 drivers/power/hisi_uncore/meson.build
 create mode 100644 lib/power/rte_power_telemetry.c

-- 
2.33.0

