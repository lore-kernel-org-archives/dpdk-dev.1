Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E8CCD343F
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 08:45:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80D16402AB;
	Sat,  9 May 2026 10:45:08 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id 5595B4026D
 for <dev@dpdk.org>; Sat,  9 May 2026 10:45:07 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Wy92CM0S6sterV9RhSqFQGz3XcKx7L13jnQdwSwDw5o=;
 b=BWv0gLyowfp8jXQhgtRO3UPk1QwPqxwQG+FTdid/WeB6DFgaeQMxIERBdlnqciZ3ke6j+NbdH
 FuOXFEdJ5S+K6ha5X12Vp6YF3Kcso0iMoBp0qzknlK+s/4iQieXQQ8yE9jS1W8dQufkaSC2Qy7D
 ca3A+t5Xh8c4Sv5wsvbxV7M=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gCK9j036vz1T4Jt;
 Sat,  9 May 2026 16:37:29 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id A62E840538;
 Sat,  9 May 2026 16:45:04 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 May 2026 16:45:04 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 9 May 2026 16:45:03 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH 0/3] power: some cleancode for cpufreq library
Date: Sat, 9 May 2026 16:45:00 +0800
Message-ID: <20260509084503.2917038-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)
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

Move some common definition to common header file.

Huisong Li (3):
  power: move power state structure to power cpufreq header
  power: unify decimal format macro for strtoul
  power: use common decimal macro definition

 drivers/power/acpi/acpi_cpufreq.c                 |  8 --------
 drivers/power/amd_pstate/amd_pstate_cpufreq.c     |  9 ---------
 drivers/power/cppc/cppc_cpufreq.c                 |  9 ---------
 drivers/power/intel_pstate/intel_pstate_cpufreq.c |  8 --------
 lib/power/power_common.c                          |  1 -
 lib/power/power_common.h                          |  2 ++
 lib/power/power_cpufreq.h                         | 10 ++++++++++
 lib/power/rte_power_qos.c                         |  2 +-
 8 files changed, 13 insertions(+), 36 deletions(-)

-- 
2.33.0

