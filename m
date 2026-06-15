Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EDDCD98C5
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 07:33:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9480436BB;
	Mon, 15 Jun 2026 09:33:24 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id BBCE943660
 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:33:22 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=3Hv5uL0c8MZHBk5c2DICMoSfGVj5VrD5TMf2/ktXX7E=;
 b=QoNKxhYIGS+y25eDwWFi91WzoY7zS3yfIcMDlsfqvVeAmnzsvRQqwOMBlqCsdEE1FEF9pOyWp
 FoFFcLicz+O8VXq9GXXAmaaIkHOl8wICD+qwTeLDz8BbRXiseRGQvd96igMPHLxa917j/SKpERj
 gTzQPDe+UML/tlN+RrdJ+ZA=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gf1px6mmyzcb3m;
 Mon, 15 Jun 2026 15:24:57 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id D716F40576;
 Mon, 15 Jun 2026 15:33:18 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 15 Jun 2026 15:33:18 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <thomas@monjalon.net>, <anatoly.burakov@intel.com>,
 <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <stephen@networkplumber.org>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v4 0/9] power: centralize lcore ID validation
Date: Mon, 15 Jun 2026 15:30:41 +0800
Message-ID: <20260615073050.1996063-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo100005.china.huawei.com (7.202.195.212)
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
framework, replacing the per-driver range checks with a common validation.

Background
----------
Currently, various cpufreq drivers implement their own lcore ID checks,
which are limited to simple range validation against RTE_MAX_LCORE and
involve significant code duplication across 12+ functions per driver.
The checks are duplicated across all drivers — any change requires
updating 5+ drivers identically. Moreover, these checks do not verify
whether the lcore is actually managed by the application. So it is better
to verify lcore ID in cpufreq core.

For cpufreq-related APIs, although service cores do not typically invoke
these APIs, they may operate in polling modes where power management is
required. To maintain compatibility with applications using service cores,
the validation logic now explicitly accepts both ROLE_RTE and ROLE_SERVICE.

The usage of power QoS APIs are similar to that of cpufreq. They also can
accepts ROLE_RTE and ROLE_SERVICE.

For PMD power management APIs, the lcore must be ROLE_RTE because these
are used together with the data plane of ethdev PMD. Hence,
rte_lcore_is_enabled() is used for validation.

Key Changes:
------------
Patch 1: Adds a common macro (RTE_POWER_VALID_LCOREID_OR_ERR_RET)
         that accepts both roles.
Patch 2: Adds the validation to the cpufreq framework layer.
Patches 3-7: Remove the now-redundant per-driver RTE_MAX_LCORE checks.
Patch 8: Update power QoS to use the new validation, allowing
         service cores to configure QoS parameters.
Patch 9: Add lcore validation to PMD management functions.

Changes:
--------
v4: remove the patch that add the helper function rte_lcore_is_eal_managed.

v3:
 - update release note.
 - add __rte_experimental for new helper function.
 - restructure this patch set to facilitate review.

v2:
 - allow the service cores to set power API.

----

Huisong Li (9):
  power: add a common macro to verify lcore ID
  power/cpufreq: add the lcore ID verification to framework
  power/acpi: remove redundant lcore ID checks
  power/amd_pstate: remove redundant lcore ID checks
  power/cppc: remove redundant lcore ID checks
  power/intel_pstate: remove redundant lcore ID checks
  power/kvm_vm: remove redundant lcore ID checks
  power: allow the service core to config power QoS
  power: add lcore ID check for PMD mgmt

 doc/guides/rel_notes/release_26_07.rst        |  7 ++
 drivers/power/acpi/acpi_cpufreq.c             | 65 -------------------
 drivers/power/amd_pstate/amd_pstate_cpufreq.c | 65 -------------------
 drivers/power/cppc/cppc_cpufreq.c             | 65 -------------------
 .../power/intel_pstate/intel_pstate_cpufreq.c | 65 -------------------
 drivers/power/kvm_vm/guest_channel.c          | 22 -------
 drivers/power/kvm_vm/kvm_vm.c                 | 10 ---
 lib/power/power_common.h                      |  8 +++
 lib/power/rte_power_cpufreq.c                 | 13 ++++
 lib/power/rte_power_pmd_mgmt.c                | 21 +++---
 lib/power/rte_power_qos.c                     | 10 +--
 11 files changed, 41 insertions(+), 310 deletions(-)

-- 
2.33.0

