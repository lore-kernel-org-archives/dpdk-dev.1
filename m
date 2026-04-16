Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A63F433D9
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 03:06:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFE8040655;
	Thu, 16 Apr 2026 05:06:22 +0200 (CEST)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by mails.dpdk.org (Postfix) with ESMTP id 4024940297
 for <dev@dpdk.org>; Thu, 16 Apr 2026 05:06:18 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=dUPa57peJBxePlTJ1ISwDYO/a5T2xrOjgZrOWz1/1u0=;
 b=eNm8E8m6Gt8OSvUMLCZ4qgD7S9vJGplgOtjgvq+YMfClSPm8hX8LbYAtZsyRhL0NisgqjaFjd
 mxLND/YSyfdDurpFnnYME4vuoRHPbecKFNILlpUdUO7gviS6yC7tDFOtzlVAp7u+BV/uqvbf5xK
 2+boGxuJrG8cnxgqCoZRPhQ=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fx2ms3Kknz1K99S;
 Thu, 16 Apr 2026 10:59:57 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 04DE740571;
 Thu, 16 Apr 2026 11:06:14 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 11:06:13 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 16 Apr 2026 11:06:13 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 00/15] power: unify and improve lcore ID verification
Date: Thu, 16 Apr 2026 11:05:57 +0800
Message-ID: <20260416030612.2379407-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

This patch series reworks the lcore ID verification logic within the power
library to ensure consistency and improve maintainability. Currently, various
cpufreq drivers implement their own lcore ID checks, often relying on simple
range checks that do not account for whether a core is actually enabled in
the application.

Key Changes:
1. Replaces basic range checks with rte_lcore_is_enabled() across all
   cpufreq drivers (ACPI, AMD P-state, CPPC, Intel P-state, and KVM VM).
   This ensures the power library only operates on lcores assigned to the
   application.
2. Introduces a common macro in the power library's internal headers to
   standardize lcore ID verification.
3. Moves the verification logic from individual driver implementations up
   to the high-level framework API. This reduces duplication code and
   ensures that all drivers benefit from uniform validation.
4. Updates the power QoS and PMD Management libraries to use the new macro.

Huisong Li (15):
  power/kvm_vm: enforce enabled lcore ID check
  power/acpi_cpufreq: enforce enabled lcore ID check
  power/amd_pstate: enforce enabled lcore ID check
  power/cppc_cpufreq: enforce enabled lcore ID check
  power/intel_pstate: enforce enabled lcore ID check
  power: enforce enabled lcore ID check
  power: add a common macro to verify lcore ID
  power/pmd_mgmt: replace lcore ID verification with new macro
  power/qos: replace the lcore ID verification with new macro
  power/cpufreq: add the lcore ID verification to framework
  power/acpi_cpufreq: remove the verification of lcore ID
  power/amd_pstate: remove the verification of lcore ID
  power/cppc_cpufreq: remove the verification of lcore ID
  power/intel_pstate: remove the verification of lcore ID
  power/kvm_vm: remove the verification of lcore ID

 drivers/power/acpi/acpi_cpufreq.c             | 65 -------------------
 drivers/power/amd_pstate/amd_pstate_cpufreq.c | 65 -------------------
 drivers/power/cppc/cppc_cpufreq.c             | 65 -------------------
 .../power/intel_pstate/intel_pstate_cpufreq.c | 65 -------------------
 drivers/power/kvm_vm/kvm_vm.c                 | 10 ---
 lib/power/power_common.h                      |  7 ++
 lib/power/rte_power_cpufreq.c                 | 14 ++++
 lib/power/rte_power_pmd_mgmt.c                | 25 ++-----
 lib/power/rte_power_qos.c                     | 10 +--
 9 files changed, 30 insertions(+), 296 deletions(-)

-- 
2.33.0

