Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89595CD342C
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 02:42:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 697B84064F;
	Thu,  7 May 2026 04:42:37 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id 4B40F400D7
 for <dev@dpdk.org>; Thu,  7 May 2026 04:42:34 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=jkA/5fNg3dotu11rZIapVUS2ZT8d5ouxzP4Et9IfsSw=;
 b=YGU0cWkWmVJR0OOHTpelAMiz/TUvQN+18u9s14T97h5I4UvocYWEr0ugZZOa6UzGoSqY8QlwI
 fEY4ainlgTM5obmJxaSuwzUqFlpsj+quHbhARsBCS1SR9JRwePCB0KylzTtr9dM4HsQ0ob8fBfC
 GGO7ajvH/2P+jisju2zBLwQ=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4g9xFV2xcszKm5J;
 Thu,  7 May 2026 10:35:58 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id E6F22402AB;
 Thu,  7 May 2026 10:42:31 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 10:42:31 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 10:42:31 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH V2 00/15] power: unify and improve lcore ID verification
Date: Thu, 7 May 2026 10:42:15 +0800
Message-ID: <20260507024230.1198111-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260416030612.2379407-1-lihuisong@huawei.com>
References: <20260416030612.2379407-1-lihuisong@huawei.com>
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

This patch series reworks the lcore ID verification logic within the
power library to ensure consistency and improve maintainability.

Currently, various cpufreq drivers implement their own lcore ID checks,
which are limited to simple range validation and involve significant
code duplication. Moreover, these checks do not account for whether the
core is actually managed by the application.

For the verification in cpufreq-related APIs and power QoS APIs, although
service cores do not typically invoke these APIs, they may operate in
polling modes where power management is required. To maintain compatibility
with applications using service cores, the validation logic now explicitly
allows both ROLE_RTE and ROLE_SERVICE.

But the lcore ID in the pmd_mgmt library must be ROLE_RTE because it is
mainly used together with the data plane of ethdev PMD. So use
rte_lcore_is_enabled to verify.

Key Changes:
1. Add lcore role verification to individual cpufreq drivers.
2. Introduces a unified macro in the power library to standardize lcore ID
   checks.
3. Moves verification logic from individualdrivers to the framework level.
   This reduces code duplication.
4. Allow the service cores to configure power QoS.
5. Use rte_lcore_is_enabled to verfify the lcore ID in pmd_mgmt.

---
v2:
 - Allow the service cores to set power API.

---

Huisong Li (15):
  eal: add interface to check if lcore is EAL managed
  power/kvm_vm: validate lcore role in cpufreq API
  power/acpi_cpufreq: validate lcore role in cpufreq API
  power/amd_pstate: validate lcore role in cpufreq API
  power/cppc_cpufreq: validate lcore role in cpufreq API
  power/intel_pstate: validate lcore role in cpufreq API
  power: add a common macro to verify lcore ID
  power/cpufreq: add the lcore ID verification to framework
  power/acpi_cpufreq: remove the verification of lcore ID
  power/amd_pstate: remove the verification of lcore ID
  power/cppc_cpufreq: remove the verification of lcore ID
  power/intel_pstate: remove the verification of lcore ID
  power/kvm_vm: remove the verification of lcore ID
  power: allow the service core to config power QoS
  power: add lcore ID check for PMD mgmt

 drivers/power/acpi/acpi_cpufreq.c             | 65 -------------------
 drivers/power/amd_pstate/amd_pstate_cpufreq.c | 65 -------------------
 drivers/power/cppc/cppc_cpufreq.c             | 65 -------------------
 .../power/intel_pstate/intel_pstate_cpufreq.c | 65 -------------------
 drivers/power/kvm_vm/kvm_vm.c                 | 10 ---
 lib/eal/common/eal_common_lcore.c             | 11 ++++
 lib/eal/include/rte_lcore.h                   | 11 ++++
 lib/power/power_common.h                      |  7 ++
 lib/power/rte_power_cpufreq.c                 | 14 +++-
 lib/power/rte_power_pmd_mgmt.c                | 21 +++---
 lib/power/rte_power_qos.c                     | 10 +--
 11 files changed, 55 insertions(+), 289 deletions(-)

-- 
2.33.0

