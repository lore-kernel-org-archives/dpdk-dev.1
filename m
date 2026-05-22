Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6DBCD5BAF
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 04:11:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC12C40664;
	Fri, 22 May 2026 06:11:19 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id CAB6D40287
 for <dev@dpdk.org>; Fri, 22 May 2026 06:11:15 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=a2gul2mEdt98C4+H1ZXjpVy7oawtj+rUQpGSWqRe+5A=;
 b=BLyzFJSwpmsCsZn5HganmuLSgo7XPulZi6D0rwo11w/f0YeJtVEEqPu7ZjjFQPZeuQRBc4Zfa
 32Nk/zWM2atNaagkATvwvzoJpZHK+O/NfgLE8pXgU95HZadSZHGt+mc1nnR05pRs2mTwWjEqXud
 OqbLcpIGC65IJlu7A3ah8vY=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gMBTB0pczz12LFT;
 Fri, 22 May 2026 12:03:10 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 3A3C940571;
 Fri, 22 May 2026 12:11:12 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 May 2026 12:11:12 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 22 May 2026 12:11:11 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v3 00/10] power: centralize lcore ID verification in cpufreq
 framework
Date: Fri, 22 May 2026 12:11:00 +0800
Message-ID: <20260522041110.2023062-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

This series centralizes the lcore ID verification in the power cpufreq
framework, replacing the per-driver range checks with a common validation
using the new EAL helper rte_lcore_is_eal_managed().

Background
----------
Currently, various cpufreq drivers implement their own lcore ID checks,
which are limited to simple range validation against RTE_MAX_LCORE and
involve significant code duplication across 12+ functions per driver.
The checks are duplicated across all drivers — any change requires
updating 5+ drivers identically. Moreover, these checks do not verify
whether the lcore is actually managed by the application (i.e., its
role is ROLE_RTE or ROLE_SERVICE).

The lcore ID validation requirements differ by power sub-component:

- For cpufreq-related APIs and power QoS APIs, although service cores
  do not typically invoke these APIs, they may operate in polling modes
  where power management is required. To maintain compatibility with
  applications using service cores, the validation logic now explicitly
  accepts both ROLE_RTE and ROLE_SERVICE, using the new
  rte_lcore_is_eal_managed() helper.

- For PMD power management APIs, the lcore must be ROLE_RTE because
  these are used together with the data plane of ethdev PMD. Hence,
  rte_lcore_is_enabled() is used for validation.

Key Changes:
------------
Patch 1: Add rte_lcore_is_eal_managed() in EAL to check whether a
         lcore is managed by EAL (ROLE_RTE or ROLE_SERVICE).

Patch 2: Add a common macro RTE_POWER_VALID_LCOREID_OR_ERR_RET()
         in power_common.h for use across the power library.

Patch 3: Add the centralized lcore ID verification to the cpufreq
         framework dispatch layer, so all driver ops are guarded.

Patches 4-8: Remove the now-redundant lcore_id >= RTE_MAX_LCORE
             checks from acpi, amd_pstate, cppc, intel_pstate, and
             kvm_vm drivers.

Patch 9: Update power QoS to use the new validation, allowing
         service cores to configure QoS parameters.

Patch 10: Add lcore validation to PMD management functions.

Note:
- Passed devtools/checkpatches.sh (9/10 valid, 1 acceptable
  MACRO_WITH_FLOW_CONTROL warning).

Changes:
-------
v3:
 - update release note.
 - add __rte_experimental for new helper function.
 - restructure this patch set to facilitate review.

v2:
 - allow the service cores to set power API.

--------

Huisong Li (10):
  eal: add interface to check if lcore is EAL managed
  power: add a common macro to verify lcore ID
  power/cpufreq: add the lcore ID verification to framework
  power/acpi: remove redundant lcore ID checks
  power/amd_pstate: remove redundant lcore ID checks
  power/cppc: remove redundant lcore ID checks
  power/intel_pstate: remove redundant lcore ID checks
  power/kvm_vm: remove redundant lcore ID checks
  power: allow the service core to config power QoS
  power: add lcore ID check for PMD mgmt

 doc/guides/rel_notes/release_26_07.rst        | 19 ++++++
 drivers/power/acpi/acpi_cpufreq.c             | 65 -------------------
 drivers/power/amd_pstate/amd_pstate_cpufreq.c | 65 -------------------
 drivers/power/cppc/cppc_cpufreq.c             | 65 -------------------
 .../power/intel_pstate/intel_pstate_cpufreq.c | 65 -------------------
 drivers/power/kvm_vm/guest_channel.c          | 22 -------
 drivers/power/kvm_vm/kvm_vm.c                 | 10 ---
 lib/eal/common/eal_common_lcore.c             | 11 ++++
 lib/eal/include/rte_lcore.h                   | 12 ++++
 lib/power/power_common.h                      |  7 ++
 lib/power/rte_power_cpufreq.c                 | 13 ++++
 lib/power/rte_power_pmd_mgmt.c                | 21 +++---
 lib/power/rte_power_qos.c                     | 10 +--
 13 files changed, 75 insertions(+), 310 deletions(-)

-- 
2.33.0

